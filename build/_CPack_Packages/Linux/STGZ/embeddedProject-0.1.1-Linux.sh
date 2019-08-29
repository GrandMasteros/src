#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the embeddedProject-0.1.1-Linux subdirectory
  --exclude-subdir  exclude the embeddedProject-0.1.1-Linux subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "embeddedProject Installer Version: 0.1.1, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage 
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version 
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
LICENSE
=======

This is an installer created using CPack (https://cmake.org). No license provided.


____cpack__here_doc____
    echo
    echo "Do you accept the license? [yN]: "
    read line leftover
    case ${line} in
      y* | Y*)
        cpack_license_accepted=TRUE;;
      *)
        echo "License not accepted. Exiting ..."
        exit 1;;
    esac
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the embeddedProject will be installed in:"
    echo "  \"${toplevel}/embeddedProject-0.1.1-Linux\""
    echo "Do you want to include the subdirectory embeddedProject-0.1.1-Linux?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/embeddedProject-0.1.1-Linux"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +152 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the embeddedProject-0.1.1-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;

� �g] �}|[ŕ�d'�I-Ch�bT�!8��bJ�Ȳ���&i	U�:�%W�JbBJ�m=a6���ҥ���ݷt��}���xm	h�-����v�ץP�Bv��;g����?B�W�_bI�{�33g�̝;s&߱N:ŗ��^��"çg}���,\����ɳ�����*�=M�n�$��j���f�HT�f���H::"�[�>�G��]r%��!c���3����{�r������×J�w6DG#�ԓ$ʣ��YX��M��������dw����*��$����/��դ��hjL�1.�z��++��u��}��f�ǻ�o |� ����P��\+������R_)���Dv�u]�Ao0���k	o��Uk�[N����j���RM�@b}%1��X*�����D�!���K�|�W%�w]90���&�G�RiM�'Ԇ� ��mE���<��*�R�dj�����p*=���j:O%*3�V��r���o`0��YY˞z�؟NijT�#;#�dF�G�	->�P�x2��"���xtDޓ�&b�p$� @MʑDZ���i.Q��I�r$$����h*�꺄)E�:O���"�7����1PL����+!{j$:b�#�&�hu��~o�lN/��������oP�t�4&�%
�1s$BN@���'+�z��L�U���y�rm	���Zd�MZ֐�_K�{%5%���Ѿ~�Ҫ�M'댆L+g�,�-]E(5��u;���L��'�#�'���32�m����h�Ԫc���mIf?T��T���X)�Qt@�y+Aɋ�]T��A�e5��lϐ��XKC�P��{��~��_wN� �ߒ�Q5�i,�T� �V^���+�U.�r�����w0���������]4�b䤥�5�v���Y��WX�`P�&�F�L%x�0�vґ�x�Ɂ�A�@���u��N�rh��ҩ15���K�?����C�Q!y8��u�Ý��o�o �[�uq�1�*���z����>��.�����6�Afh0�7xr�2���E�n!��vu���J�;I����2������	���謘uB�F�P1�&b[�BY�bҺ�`�F�����&w�b����W^�Pk��eZ,�P�$�b�s��o�h/	5�̎ɚ�v!�	5C���Z���S�S�W2L��4�N<><m:th��r$�e�v<�}�q��S���a��	�Q�BްB͔$��.�������
}�+2)Ad ���Ni��V[཭Lj<-2���"�mL���Jt��$�R��YI�d�?���w�d�,Ym��\�,�=���
z�B4'��7
�NN�9U�HE��].{��2�4�d?�G�Xz�X<F�A�D�r&��d��P;T�b���r"G`�5N��^��Kg��6-ڇ
��q��PY�W�1�(��Bw�P��,�*5/bʃ��Sǀ:��K����r$�[;TM��06�tj�d1��~#O1��eG�}�Ep��u�E#��x
d�Kœ@2BF��Xɐyqce�#W��'�wօ���?�m��*�?�{Z[�����i��O�ǽ��Z����<]S�N.��%��ExSS��[�jI�=�����z��@�Ñ��>��'���Zw��H�#�H`��Jh;����-�C��{��a��I$��ûݐb��$L<��u[��FKT�0��w'w���p�D1�,��u��X�j,T��J�SCtl�!��r���^T��L�Z�v�1~���]v��`16��faIw����A�^$]Hh�H:Ir��j��L�y�/����M���υ���@������kHɽ<{������oL<;�_�|��Ux�7�*���(�P�x���D���ߏo�n;rh��2]N��V�o��!�.ꐆ�M��}���N��������$��!��;8�L��L�F�)��ԑD���a&q:�rKe�fW���5U~|��<�	0u8�p�>|�}�����c�$ѻ{oT�~�l���cJ�S�ZkbJ�.�9�ޜxX�s���}��]��\/:�?>��-�*��ֳ_&t���ӛ�r���}s����P�������枣�tD��z4�7�zG�A(>r����YW�s,#�t_�v��c����[�*��g���x|Z��m:>���9�D�_�jm*��K/����.���{�>l/��C�1�����K��#uE�	}���I��1
Ú�u�"%3�x������`8
C�]H�I�ȩA*�,���e�'����6�uC;�I-+�ohnp_�ɒ_��{����z'�kh2�M�mo���++A�B�{�׃6VU�nשׁ���U%O����骪�XU���n�.+�0^(�Ei�?����j���p��z¾��m��������}���PP����U2 ^�Oתy��F��n��CZi��!�!�����Zv���{x� w
�3�Y|� ?G��'��/�t���=��-���(�U�9��\��q� w�2^.�W�`K�g�~z��jQ~� ����oV���l�Q_��NF�����-�?-���@��(>F��������n�����m��5�����1�_��)��,��
���_
�x�ݺ</�c�~��Zn��3h��&�?a)�n��2��yp���[�!�s�F��)���H���`���+�z7�axL�꘴'׬N�#�He���K��?��2��ѿ9:���K8.�⩨���6�ԱFw8VG�@��:�@�#;U?G�q�{�15��S�~�+�#	2���սQug�H:�Ӕ�QA|n�ө����-���@�*BI��H��x2��5܂g��ptdW_WR��jR�d<�]�% ��Fv�w{<��{"�Ʉ��15���E>�����g���c�m5�R��Q2�f}5o�Q�O{}N��8���8�X�NX������\����}5�?"��c��e�,��q�6����l��9|3�q�t���1�������r����Oq�Wr�_Pui���s|�q�9>n�_���9z�_���9>gq����F����_�φ@�7r�*o��5v��j������d�������]/}E�[�C|��������V�����px��8\���Ѯ��Z���vm���8<a�g�,���I=�M�����&����4ѳ�2�Zd|ji�s�}÷���W�b-"5��d����(��aߺ]
o#O���g[����B|���/�S��<"��2�`���Hu�����SMB9%S����;t%�)'uz�t�;ө,���v��$˧�������>ا(�B?Y���[��~�B~�ҳy ^~�ҳ�~>�����E��,�#O��'���kz45��/��:L�v��\�0���&+O�.���O�Y?�<A��<O4��bfr��q��>���^��/�g���2�P�	���"��ݔ��4�{��������{����$Z���4!{����J����R��#������(�#J��@�{��̏��gY��[��{���b�D��@��T�vN��8������Z�������3���s,���|���g���&�l����6��j�)�ڨͺ�V��O�ps�?j��_#4���o���Ri��d�u�ʿ���/H��W�Y��t��G&����)H_G�<4S�ȷ�������)����͍--��?N����ӥu0�T#�$� Y`����X���������������:=�(��Ѣ�r�ng���]��Zh!���,�+��ٶ|WLwХ�.�5��U��� 4$��~o�_/X�����3>�@�氱9����v�Ca�Q��m�Z[���G��K���a�ʤh��պB���y�U�H��T��4�|�[��{������O�X��v7{��������������-��{�����Y�����oy����S��|L��?v�a��[x�_鈻0�����c���{�p�Zt��pF��=͵oak`qZ2�6x�d��Elllhk�4��]�:�w�6Ac"cy�����=�om� q,T�t�i �������\G��/��ʣ+�����6{���^o��T�\�Z�@���P�(��	��G��OT.�:�t�eN��=y'��^�|b�B�.Hh�|>愱�����D�5����=,�-
�Mm��x�r�P��Ȩu��B����fT:7p<��^�.�|��ηBw���0��H�O�d���o}k�����ۊ����/�����D��z�ڛ�Q�,�������������J�V}���i���}"�
���ݩ]j:�Z�,���z<�}f��ڽ��j
��j����$]xryw����;ٌ��BYϩ)�ۺ�n������m�T=*t�iZ�<�
���՝0DU�A��T������6�M�@���%ʰ�n�kiU�Z�X$�lYDjȞ���LT�d�@�� 2@ T����t$�B�i�&&+�L�TB!ȓ���_����6�F���=,D�Քf,�qWX��Id�Xq`�huK\�̲Nu�4�C���<�i-<#�0<Y~,�è�h4��X�R�w 
�<aQ7�&���6`Y�@n��N�3���h�w<?�b�|+�����n	�YXG�Oc$#� e������HZ����&@�6���H"�Z�.9&D+�����4Y`�%G�hllY�J�.62�X���A�^%m ���,�b�w�|�W9��~Ǖ|JƎ�ĝ#l%�e�W~����Oܑ��~�]4�;.�sK�J`\������w#P�~(�y~���a������`>U��[r���0�zL��_R�_U���k��X�r��%c֝���j��cv �}�]Jn�KV��W���㝮�ag�0%\��i̞���,��8�>�_��
�
"�s$�ŷ�:e�'�E�%\��/Bvn�Ԙ��	y�s�r� >
�2R�9�!+*�s��ΧgjN�͵�w����;�>�
�4�V��an�>J~8ݨ�̽�iz͇�B�G���(�O�`N7�ƜS�3��uNM8tv&���55���{�cw�ή�Y?��EΩ�ǯ��$@e�y\�qG�^�o��<s�ub��']��w�L%��`�%%�(�p�P��;e�+䮒{A����e�J����z��iT���x�f�X���������O�)Mk���vN��o}��}xo�~�>2|���Ϣ�z���6݈�UO=��D���+i���K�$�4�G�<$V�AW���7��0v
��7�Hk@`��7f�G�+�+��0���OI7="=��J���F�ۑ\�\�H��|8r�Zros�:Qֺ5f��6��cl�t����
�!i0I0xJ�L����R�5Wu0��w�G�#37�	2������~����1ߏ�ʁm����aQ�u�e:���
�%&3���<�$��|�F�U-8�K�l'����`^O��uff^'ʳH8*˗�#�_�M�ݪ!%'y�f�����`ނ��x1�f�Q��hE�y��=���ڝ�7�'u�o��ֽ�C!e�7mE�y����7Vwlv�������a�B%�}%�����=�|�)_��L {Pa��=�3����o�+�h�w�oh+�H��88"scm�3;����@~����y&�����>ٚ�������n���r��;�~�~��x^8;�1�J��_��+Zu`�fW��U����9�]F{	�^��С��J�y_?���5PF�?���Qj�/��O0�`�Y=��~�/��81|Q�4�ި+�^�L<��y!�W�\ǆ]r��O����a"~F�hf��ٟ�v8D.�)�=P�[�E���v��x�[��v�)ԦKY�Lw��g?��������������韟d��4�2��i|���z���^������{q����B#�oޫ�|c��9^;�|�����'h�C��`#��!�&��@�������:q��Ko)􏻉X0\� r�=�d�I�pNıo�P�v�%W��r�*�T7�J~�\�2��F��X���WS�*����������#J~�V�1dڔ�}u���{\wT�rz�V����u�}~SR�>�oL�r�G�շ�gH>gv��~׻�s+��[9Z��`��G�+l�/ԝx ;q�赱z���C>��:@ˮ��''΀Kj��cJ�̵{=��`~���V5��@�C�-�dІ��h��O���}V�x�Bi_���m��Lָ��q ^�pUk$tX`����i�c��t⑚�QM�u�l �3�le�HM �$�K��l�]sUhm�:���<Z3{&M��@���=�5��9��&�z�6��@��z4=��l����_�+�=/�t�dovq���H[�t�U�,�DV�>�sW5��.4 3�<�%7;{T�'X���SwAΊ�����k�K鲏&n���n�G�&�~�9��))곍2��s�7D�Qο�odgg�|���|�9tw�w��a��;T�DG����έ`��)7�|���tw]���y�(�z�1yX���g�&���H*Db�ܫ����p4E��s��8��lSr�UrO�:�na��;HT�)r����<����Zņ^��^��Y�⳷�*Ω�6ή�h|�=��P�V�a��� �'�/���Vx7�ə���:���E����|ЛA������9@���n�����h
�Z���0���Jn&�{����IZ60}K]0��wnK-��8'��6s	��|w)$5������r޷Q��yۺ�~�S�)���6n������c�S[I(�_��Q����+����(�����-�R_(�Rp䗓��ɒ�����l���	�_��?fO��q���2����C��D[Y�����'��i���ZeZ�oo��kGw�+߰i�|�τ�ytdDv���"9Z�\h9p��ق�����U���ϭ��Yi>�������,�X%�p |g��{+��Q��J��g�\%�t����t��7+�	?g��5�����8��:����a+��Cz�V~k��I{�e���ϖI�#Y����e������΢Р���&��_٣�vH�����r�
w�6�1����Mz�Vn�6ޅ�&]�h�}m��x��Y�?I绷+�7V`WS��΢�����72i��f�ob\�O�/�p�칺�5������j����t��ͬE3K���5hKnx�����!��~fum�!k,��z�ς?.�?)�/��m_w�V]�3���̥��?uNv̱�A/�o�2���G��Vr/R7��ze�4뜓��9�p��e��]�H�src1R휜�!�I��O�5=S�;'�ɜ�
?��/I�k���+4��>�5���{jXG�ד�C�W�ԟa�漞ܫ�Gяph��؏@W�	�+��r
Y���D|.�(����	@�tMT��P�FgCI�\�80;V�o �/	L�/J�B!qt�3O���_0�|��^�����@�;ȧN�/��j���8OM���d����g�y�:��u>JԩL|>6���Etz��M�R�� �o�a�F^
٤���-����M�9�`�QW`�女B������Sa�s�m�&���s򟁠�y���r�`�hگ:'���+]p�����|d4��FrN�%�׺^v~�̥���p�]1�8?~T���,��8o{R��d��%�d�I�s������Mf�ʐ�����>��D��_�]M�R'i�5�����m^���m��hCt9��0[3\�_���&j��f�����_���0�9��s�>/zw��������������Wr/=�K:���I��?�8��M��^0��!����;H�ռm����>�1�o���[����g��X���M�(�5.��}�LXo�c46���y5�����դ�#�<�m�c|돳Wx�B��
��	Zŕ���݃5�4~L%�~�(�����=ܼ��\����sz��z8'5�F0�ٿ�ߞ�̌���pPֿ��՘���nv�����H[�Xj4���;SZjOd�<��I͌'"�Ɗ/:��&B�ȼ�{�������,��F6.�[����:�oߞ�c�)��I�ȌLX���'bl]��3:��;Ff�#*.*R3N���g�ˍ��d�XUs���J�.�XUw{yg���ު���=U��?�WV�y��ު��U2�n$��}�w;���9k+�т_g�vG�͒]ߪ�%�]�?�2~l+��ZΘc�Z���[K_~^�(��/���u�
�;IGy3嗰S~ު��0��������u�CX{Y~�D�5;/? ʏ���u~���&���'�R��k�nSx�t��BNwU�=l)�{��a��]r�sU'�]�,��x�WrCYe���,��	�����!/�����Y.F&w�P0��2~���v��J��RM@�l�﫬��(�,���'A�7WU����e��L~�"~��W1|���E�E�/���	p�C{�s8ȏS�6�����X�<����	�:~� �B�_)��C�8H�5+����QyE14�k�[Z/7���ro%Kc9=M%X�m��q�ގH�:.:)��}��N����J?��]6�?�<�_�pa��lQd�3��/�[��Kp��\L?�+���|n��ô�*(ðsV.�5���I�o��Z��a������|ҡ��?�4�}G� B~�7��e����+�75�mj�,�:2���_
������"L�WnM���?������:_��x5m�lL�z�5y�5�U?D�깔��X�F�����+u>�R>/��ݲҚ^�����&��*z
�	�� ��q�-��m�OU�}�8�tOp�gi�y���;�\s7�w6:��8�~�~���~������d��p�A8���O���l��x2��e�-%+�[N�΄w���s-�,��ت�w�>�d���_dT�-�9����ï�Q��(L�U�{MB����!S�i����-$�#�ћfc{�ݤ�<���D$Uw҆��P�����zo
;P�����*����t���u���vphi�Y�f�NsL%���z�@��Gc%e�U:O�nzz���d8Ѣ#I�������=�h
Yn�����"��'l*�ބ3���N4��t���p*�"�4/�(���H$�#q-��A_0{P"e���n(��p�fp�	іҾ[��y:��X�� U"���(x@O2f3�d$��Dҫ<�ʐ�j@/�+8�b\��p,�
���I��L!M��N�1=K���{�U��x��a�����p�ĸ҉��r&wR��r�U�;����G���Z��p�Wsx���?�������r������g��2k�[ˬ��Z@�}[��_��8�/���G����������������?��Nw�4p?�q8_>����0�� �8��@���)�_��Ua�o����>�8���0�7q��3��9|�9|���r����r�����痣���o9������{9�>��F�!G���?�V��k��Jk�gW������p�_�p^���g�5~@��� �+�VY��O�kV[�C� ��v����!�=G����8z�d��1�sx�{>��8�z�������.������>C~N�A����*k��M��	�����9�o����m�"����ǫ��p�J��>�N��B����(�G8<�����@�'9�/����g=��75f��ހ }�"���s8/7���_��m6k�K�?$�w������G��T���w	��S��� �� J��N�_(O�	pU��"��$��/p��g'���9����8�M�5��vk�oe��㿝�ټ8�O"~>�g�_,�9�?��&on��N">,Y�����;9:�dG�%j��Q�'��<���>����F�.s8�%���?�֞�Ͽ���[��B�Â�|�d3��o��߆�8�?qs����9������9�{~���{���p��Nм�����j��R��&��=�L���Wۋ������������L��=�^���w8����� �#��)�!={�����	/j�K>��S��Ɛ{
Đ��S+'\��I�e��A�z���O�>'e����Bȋ����ug8�NG�O����F����?�h��������1�O�vzG3����/��-�_[`�O�����_g�0��I����z1����~�Kߵ���z1�����|�Ŗ����|u	�?m!�ҳq/d	�ﱐ�ҳ@��]KH�U����?f��q	��^>��IӲd}��3�3oZ��ؓ��G?Qaȷ:�Wt��.��C�?陥7ӛ���W��f������j�)H��W���J��g>)�>h�g,?��~�K �n*��b�D���C�3?��N��b�>��a*��&���;i�5�YS����۬����� ����y��tb�2�a���&�����l��,�_`��/]J�r��ح�o����﷐��������R]ل���x��.�4}�	7���������E��5��"��GCs��>�X_���sV ���Xʯ�������r��_�u<ѝ�?S��������a]�#T�|�B�N����T�yGMI��?r~���1��wR�y�Sg���P��p�=�N��Ӌ��7�����
�?\f-�E*߼�,��Z~�W���ɿ�B~N ���ɟ�?h!�����|�N�*�loզ��rk��/�ַdgK���Ǽ�z��YO����V*���7�[��>i�լ���ܺ�=H�?cr���o*����d�Y���J�������b�F�q��H/:���z��a�Zdο���N�s�iK�9}a��F^(�p�{}#�`��X�{�N���=,i�<ؼ���Sڻ�&���9C�`>Y�*�8'q��JW�J�Ǖ�k��djW9�]A?I����c��Rl���V)��JnWu ��<V�B����Ur�0B�=D(��Z�I&����>ȅ7��t�����,�J� f�t�?�f��~�tu(��J��"����z�@;��?Io�fy3�kJ���*�#4@Q �Bt�G���r\�2%���Vڿ��v�gS꿩�?����/�必Հӱ&�_�wޗ��}u�O$�Dt@�٪�}�2}�1L?�)�q9	�Q�m��<\�Ǖ�O	�
�3����=���-���}�&}�&Y�%��"��"���s����>���������=��L���9g�2�O�AI�N����>��oV8'��x_y�L���D�x�y�q�A�䜔��^�9������9�;�zN�!��Cv6M�us/s�B��=�L�W���sN5�J����9�����OA��`T��I|��f���k� �$��L�{��e�3��R����`�q��;���=4�Pr��e�og"or�c��]ە��%���cJ�cJ�)�����21g��K"Z����&�u:uX{�B������p�\h{!९���3�P_��h���W�����-0�}�tY����ݞ`�K��G*=�P����t����_+�/a�������nf�<�>�1���Z�ʦ髟�$.p.d	$�_T�w�=Tд�%�ld�{�����D��!*a���.�M ��o:q��`���r>�RNs�F�s͐�3_}������?��\|	cyM'β+��7��q޶n���^`6u��w���F��̟��0�<��PL���~ƈ5�:�5��s���Ǻ`�5|lu������==hjS8W��f�(�>���4�`���~$s�)b�S��9.ד������`���{Ly�	���d7�K; ���!��X ���S���&H�}E9Z�"����y|�9�,=����h�/=������\�m���Z��ԓ��E��ɽѓ�\�3�s$6���u0�#�q�~~�k������G�t/?[A}wP����)�b��@=f-�[횹~Έ��]��`UAbU��f6�߄v
��k�,��AY�����ͼ�(E�)��Sh���K������1m\��?�U�����ٰ߰E�;ٖ�FW�O�����߰K_�א�ug>l�Iҫ�7��R��J�=ӧ �	��[J�!.���a�?܎�nØ+��Gl�BHط� �*��&��V����bil����A���X#�!y�[T|{���f�48F��^rR��/�9a5:};��/~O�>wX*w�-�G�◎Lq��,�|��g��hR\�z����ƯC�[�'�����7����Al����ϕ6�<�h9�6���(�E� s�����/(�j��(����=�{cO�6�;?M�پF�#'Av��ti��!��=-�dLM'R{pGP��@�ܤ���� ~��0�v��l�<y���r�f��R$�K;�'��!�EBM��F�b�����=ί�5m����r�����.�?&�/������W��0Y�==��?Dq\�w.�wq|j8���s�������_��pk�|q8_>_�����8�l�5��k>�Y�c[�5}\@��Z�/�6no���c�5��˳u�5�GVX�=��|��p�<g|޻Қ�"n/�*wq��.�ͅ�nI*^kȏ2>���4ѳ{7p8���c�g��WM8�?1�a��զ����X��8~�G�읻�D��A��	�{%��ž3gk5�LC�ž3gk�!�_O��;��C�E�3_lz����ΐ�7�30�ywH���l�j��H�s�O�����;!�9j���$�W����������]���/�~d(���d]~4��)��-�����/aӟ��������^>f�N�(C>�h��~��~i��s�����˄[���.r����ڼ�97W@��*�(����:GN��O�OIY����rr"���]�,��s�O!oE����*�K���>{����\d�u2.�+���s�����\,Y��d}�-�2ɺ�Xlzv���W*�}���ł'^�f%�d����O�^��D��\�B1���VH���ll����!Y�5"_y���`��+����&����+߱.j^�l*�/�۽��E�O��7�Y�dOSK�g�����U�ۍM��li�$_Y\��D3�i"�舀n��4��w�e]�%�/���|�ɨ��Ȯ��\(��E��i����w{d7�[$�j�I������+��Uy�܍�"��}=`2(����X*����*��r��P6M�ɵ�-�6T�u@	�"�XF���I��R�dj�����M�O� ��2�ju��f8���70�
�����@_��G�]��ڒ6Q;_�PBx,����6^7����%,do���S����~Xֵ�w�}}�]��� (��A�7�'lu�����+eL9��J���nz�]^�?��vy���0�/���n�-J��#*�}����]���ס��%J4D��e"���hVYb���m��(��yRae��]}��tK�O�/���x*	�3��c�xR�3#�l"&��ԨgM��/��!ג���>������������&��-�Fϲ�?�w����2>\�H7��&hhԘ�7�@/���"CrcCK=4yyT�d�l꺼��`�?0�7 ��t�|�Z�rZ�X6�Vc����	r�����Wx,��G����B�	b�ԟ�^c1=�;�w�O��pT�#;#�dF�G�	->]m<Md��Zy�H<:"�!��&�H�@��\�*$�9�V�H,H*U��TZ�u�=N�S�'�X}؛Ҋqu�(�������=51�)u�h;E^��J�^��$`;�}�2�d�iL�Kt$c�I�����q�OVF���@���Ig*����.���,���
�J*M���d�����#�V�l:Yg�iZ9d��o�5B�QU�ۑ�HI$��O�=5������h���c���mIf?T��T���X)�Qt@�9.Aɋ�]T��W�e5�xlڐg}p9���{e����Ut!$����!!~KFFqg;4E�!���}C��A���������]4#�8�d��5�v���Y��WX�$ ��ŕz�J�wa�#�q�Qth���hX����0�����c+��{��!x�ػ7��baOsme����;~�`�@ �KǶ�����d�l���2j:I\�S���U�d|f���������]�^�~�i����i��Af�h�P�`Q㚎tF��(��v�:#��v�J7�[0��};D�y|�B��Z�e�����c혴����#��pA�8�N�\��k��m�C����s��or�h��̎ɚ��
6(�@U�H���U7-�Ԙ���:C��1Ѕ��܊��k�!��q9ղ@;������M6U�H�_F�y��5S�a�}:��z�B���
�M
쯥w�fT�b��xo�����>n��p���{��W�c)Uw�$��ܟ�d�;��F2`���6T^.R��HF��{��!Z|KĵTd��#P,Xr$�&��"i6�~�����,tL���$�V���L6
y�g�v��.?��D4"q��I�Qj�IX�EVN�v��B�lk\a6T��cw�,�0JX��Mn���1e�2X2����Q�Hz�*�W��]E� gp4�=��:~�~�DV]���p�׷����z{���`����=���J��ƌ�K�h�ǘ�h�`�'*y�H��2��p0�~�\G��S>�R!Y$4r>s�X��C�LP����S�Dj�%�O.s���6��h<���N����Md�:]s��z�t3*���XM�������{����s��HZk��"���5�66��y�������N�u�՘�k*��ŗh�Û׷�l��D�Bص��O�h����q�Ƕ��}g��2�����&�>v��	�Y�z�!�������S�]4��V�i)�0;s���sUC�^@����L����F�\
�؄�3��Wc#�����]VYY�l[+�	s�otS��]&s��:��uR�=W��^ຏ�����'�z��~���.��e�X��/��q��w\3�N�R��tOs��{!���>��6�\���s���<�]/ؐ��jbJ�j���l��I�/p���a%���qϓ�]9��"ɜ�e.���ag�̥�|��3������i�)�#J�j��i���}�h�#��5���N���0�_�Ή�=j�0N~��
�z�|6o�[�Q��2��R��E�L'\ �\�=�Rr+�]��-��9-�M�����T���?� ��9L>������	��xu��N([��)�[�Ѓi>���_t>�|��[�N��\N=7w���|���Ms9�����Vc�2��A�����P�P�ٝ���6�r[l��;ƫ�L�֮��&*w��YN�CF������ݚ�y�����r�㳇C��2��Y�_\?C����V�B7늢������c����<��]3r*ͦ�jl�T)�����iڸ�׃�3w�Ŷ52��W~���p[�mWގ�g�O���]��y�˟�I7��9^F»�����}��g���v���f�F�3[�i�꿧�B��3Rх�|}M&Ϝ�Q>>�!7Q��y\��.KW=��[��k�kh�{�k���s��[r����oo�T8޾{բ���g�cj?����v����6�R%O�) �@%9��K��V^lχ,zM�?BNbG�Y�����zo���T������k�E�Vf���΀��gu<�!�s8�1�1fl�\�^����
pљ���o�8�pY��
p� �T��w]0���w}�ni=�P�l>@qs�n!E�o�E��F������3�1�Y\�;�f����F=2I��gE��p�~�*�~��K��
�~� T�����d�r3�+��
�`LF���v볜��c�z�i���zx���\�f�	���N�� ?Gp��:�I�G�� �����Á�h�=V�?pX��,��u&Sz{�5��ˬ�=��l��"��_��kx=��oԟ�Gط��ϝ��ѿ0��e��K�M�	��K���7��OMyi�D�~&�+P�hmu�����n�ӈ�,&(�0#<�zs�ȸ%��h�n��N:/4�f~<մ���-f��L�J�%���C�I?�5�%2��%�BҖ0��`:x����w k��r��Q6C!G�満�p'�S6C��5�á�����iu�#���TK6���o�dcx&)��4���"QP ��@���4X!i���P~��ӕH��Z:��s
x��pL�2M�����G�hJ��J|T��kQ|��jQ|�8�Eqfi�[Ĺ8U���_"�QO`֑��������]�<�b�]�le8��ߥ��s�%#67�Dq�]8�ï��Os�Z�������8��r�:���q5�p7���������/p��
G���xS@���v4qx� g�H�?�c3��gl�����a��dLs|������3�P���5���������|����f�k��#|����z_��^o����<���7r�Bq�e��q|:9|Ǉ?��v�򹉣��g���z����3?-(��qx7��ӟ��#=������z~[������g�ʒ!�ߧ�����.欽V����Ϡ�����¾X��?k��Ù^h�VOՈ_+Y�y����g�u
��x>�x���������9��;���2�_&�^��������닟}��p�����������x�ć=����{B?l�g�c���Yޞ1ѳ�=;��-ǿ!D󝄶��\�Ӽ�s��#�W�%�N����&�x�F86Rq�f�O[Ih�Lϟ��)��������±�As�"Qz�0�������+�|[g1��gla��ҳe/�|�3�D�Y���[Bz6N��_������%�g�|��%���"}�EzY��A��Ȫ\��Q��6�J��̐��݋�w�������]��f��ƻb��oZ�1L��uv6�vn~3�!Y��AZ@lM���\~�$A*h�3z���O�3zP�Y��,]�3zƨ|Q�.���m3�W�+������'	�Q��7M�x��&Y�1s7Mo~�g.��$�xe�ˊ�4�g��n�l;�?K�F*��/�?C��ו�9d���x�����a�1F����ꌬ�������Ϳ�����rD�o���E�_h�V ��������S�9�����䳳Q���Y���3�P~����
�,R�S�wZ�wY�?�n-l������ﵐ����u���F:�2��ح�2}��Uu	m�n�����oJ`�����>F��"����\*Ϳ(ֽ�C�J��%�7Ƨ����K�4��bc`�Ow̤�;!����q��I�Ut-=�WsKK�r���q����(_�k��_��)����ս���t\�����C~a����z{��ˋ����]�tA��A�N�e��O��g�B��08(���Y��Һ��Oǵ�k9����]�rȯ�_�!��C~���_�d��|�1�b{Y��I���Cw�����X�ֵ�k9Z�r���h]�Ѻ��u-G�Z��E;�S���D��5��,��;��@c��M*��	^��s7�7�5zZp��ݲ|��i�.KGv�FȌ�)���=��pH�ܐ����ve�������J�yO�-J� �ew@G"���*�;H��'��������i|$�?nywG*��AJ2֓�Y����N�7����T�/��1uw<�vŮ���rWF/������\�P�oij2��FO�r�?�[k�W�BFx\߃�#8U���w��Τt#q'ԟY��PJ�\JQ�R�b}��򠮞L��1��X������@��q1���J�:y>`��?-nS�ot7z�����K��G#c���l��K$�p��`܅�֣����%��豄>y��oy1��r|X[X���@(���۰����ݩx��h�#\Z�%ZՕ(syƄ���U��K�U*�L"������4�iW,��׵E�q�쎉U���JFZ����.�uK�(l.$�f�
*\ZR:1�2�@i^�F?��*n����
l��`�W�K�9�J s�t�G�ǻ��/_���|����@$ L 