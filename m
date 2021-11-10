Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0293444C2D2
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Nov 2021 15:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhKJOSi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 09:18:38 -0500
Received: from mga17.intel.com ([192.55.52.151]:31185 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231641AbhKJOSg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 09:18:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="213402779"
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="gz'50?scan'50,208,50";a="213402779"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 06:15:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="gz'50?scan'50,208,50";a="503978204"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 10 Nov 2021 06:15:44 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mkoO7-000F3g-C1; Wed, 10 Nov 2021 14:15:43 +0000
Date:   Wed, 10 Nov 2021 22:15:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luca Coelho <luca@coelho.fi>, kvalo@codeaurora.org
Cc:     kbuild-all@lists.01.org, luca@coelho.fi,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: mvm: retry init flow if failed
Message-ID: <202111102225.2lAk9WxL-lkp@intel.com>
References: <iwlwifi.20211109192950.486dfa9c4f35.I52a0411774b700bdc7dedb124d8b59bf99456eb2@changeid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <iwlwifi.20211109192950.486dfa9c4f35.I52a0411774b700bdc7dedb124d8b59bf99456eb2@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Luca,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kvalo-wireless-drivers-next/master]
[also build test ERROR on kvalo-wireless-drivers/master v5.15 next-20211110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Luca-Coelho/iwlwifi-mvm-retry-init-flow-if-failed/20211110-013343
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
config: arc-allyesconfig (attached as .config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/71e548532c8247fa57b9e952895bba06002eddb0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Luca-Coelho/iwlwifi-mvm-retry-init-flow-if-failed/20211110-013343
        git checkout 71e548532c8247fa57b9e952895bba06002eddb0
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/wireless/intel/iwlwifi/iwl-drv.c: In function '_iwl_op_mode_start':
>> drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1342:13: error: invalid storage class for function '_iwl_op_mode_stop'
    1342 | static void _iwl_op_mode_stop(struct iwl_drv *drv)
         |             ^~~~~~~~~~~~~~~~~
>> drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1342:1: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
    1342 | static void _iwl_op_mode_stop(struct iwl_drv *drv)
         | ^~~~~~
>> drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1362:13: error: invalid storage class for function 'iwl_req_fw_callback'
    1362 | static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
         |             ^~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1756:1: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
    1756 | int iwl_opmode_register(const char *name, const struct iwl_op_mode_ops *ops)
         | ^~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1780:1: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
    1780 | void iwl_opmode_deregister(const char *name)
         | ^~~~
>> drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1802:19: error: invalid storage class for function 'iwl_drv_init'
    1802 | static int __init iwl_drv_init(void)
         |                   ^~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1802:1: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
    1802 | static int __init iwl_drv_init(void)
         | ^~~~~~
   In file included from arch/arc/include/asm/smp.h:12,
                    from arch/arc/include/asm/cmpxchg.h:13,
                    from arch/arc/include/asm/atomic.h:13,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:188,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:12,
                    from include/linux/list.h:9,
                    from include/linux/swait.h:5,
                    from include/linux/completion.h:12,
                    from drivers/net/wireless/intel/iwlwifi/iwl-drv.c:7:
>> drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1828:13: error: initializer element is not constant
    1828 | module_init(iwl_drv_init);
         |             ^~~~~~~~~~~~
   include/linux/init.h:250:55: note: in definition of macro '____define_initcall'
     250 |                 __attribute__((__section__(__sec))) = fn;
         |                                                       ^~
   include/linux/init.h:260:9: note: in expansion of macro '__unique_initcall'
     260 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:262:35: note: in expansion of macro '___define_initcall'
     262 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:291:41: note: in expansion of macro '__define_initcall'
     291 | #define device_initcall(fn)             __define_initcall(fn, 6)
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:296:24: note: in expansion of macro 'device_initcall'
     296 | #define __initcall(fn) device_initcall(fn)
         |                        ^~~~~~~~~~~~~~~
   include/linux/module.h:88:25: note: in expansion of macro '__initcall'
      88 | #define module_init(x)  __initcall(x);
         |                         ^~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1828:1: note: in expansion of macro 'module_init'
    1828 | module_init(iwl_drv_init);
         | ^~~~~~~~~~~
>> drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1830:20: error: invalid storage class for function 'iwl_drv_exit'
    1830 | static void __exit iwl_drv_exit(void)
         |                    ^~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1830:1: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
    1830 | static void __exit iwl_drv_exit(void)
         | ^~~~~~
   In file included from arch/arc/include/asm/smp.h:12,
                    from arch/arc/include/asm/cmpxchg.h:13,
                    from arch/arc/include/asm/atomic.h:13,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:188,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:12,
                    from include/linux/list.h:9,
                    from include/linux/swait.h:5,
                    from include/linux/completion.h:12,
                    from drivers/net/wireless/intel/iwlwifi/iwl-drv.c:7:
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1838:13: error: initializer element is not constant
    1838 | module_exit(iwl_drv_exit);
         |             ^~~~~~~~~~~~
   include/linux/init.h:299:57: note: in definition of macro '__exitcall'
     299 |         static exitcall_t __exitcall_##fn __exit_call = fn
         |                                                         ^~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1838:1: note: in expansion of macro 'module_exit'
    1838 | module_exit(iwl_drv_exit);
         | ^~~~~~~~~~~
   In file included from include/linux/module.h:22,
                    from drivers/net/wireless/intel/iwlwifi/iwl-drv.c:10:
>> include/linux/moduleparam.h:409:45: error: invalid storage class for function '__check_debug'
     409 |         static inline type __always_unused *__check_##name(void) { return(p); }
         |                                             ^~~~~~~~
   include/linux/moduleparam.h:436:35: note: in expansion of macro '__param_check'
     436 | #define param_check_uint(name, p) __param_check(name, p, unsigned int)
         |                                   ^~~~~~~~~~~~~
   include/linux/moduleparam.h:150:9: note: in expansion of macro 'param_check_uint'
     150 |         param_check_##type(name, &(value));                                \
         |         ^~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1841:1: note: in expansion of macro 'module_param_named'
    1841 | module_param_named(debug, iwlwifi_mod_params.debug_level, uint, 0644);
         | ^~~~~~~~~~~~~~~~~~
>> include/linux/moduleparam.h:409:9: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
     409 |         static inline type __always_unused *__check_##name(void) { return(p); }
         |         ^~~~~~
   include/linux/moduleparam.h:436:35: note: in expansion of macro '__param_check'
     436 | #define param_check_uint(name, p) __param_check(name, p, unsigned int)
         |                                   ^~~~~~~~~~~~~
   include/linux/moduleparam.h:150:9: note: in expansion of macro 'param_check_uint'
     150 |         param_check_##type(name, &(value));                                \
         |         ^~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1841:1: note: in expansion of macro 'module_param_named'
    1841 | module_param_named(debug, iwlwifi_mod_params.debug_level, uint, 0644);
         | ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:289:9: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
     289 |         static const char __param_str_##name[] = prefix #name;          \
         |         ^~~~~~
   include/linux/moduleparam.h:176:9: note: in expansion of macro '__module_param_call'
     176 |         __module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1841:1: note: in expansion of macro 'module_param_named'
    1841 | module_param_named(debug, iwlwifi_mod_params.debug_level, uint, 0644);
         | ^~~~~~~~~~~~~~~~~~
>> include/linux/moduleparam.h:151:50: error: initializer element is not constant
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |                                                  ^
   include/linux/moduleparam.h:294:61: note: in definition of macro '__module_param_call'
     294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
         |                                                             ^~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1841:1: note: in expansion of macro 'module_param_named'
    1841 | module_param_named(debug, iwlwifi_mod_params.debug_level, uint, 0644);
         | ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:151:50: note: (near initialization for '__param_debug.<anonymous>.arg')
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |                                                  ^
   include/linux/moduleparam.h:294:61: note: in definition of macro '__module_param_call'
     294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
         |                                                             ^~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1841:1: note: in expansion of macro 'module_param_named'
    1841 | module_param_named(debug, iwlwifi_mod_params.debug_level, uint, 0644);
         | ^~~~~~~~~~~~~~~~~~
>> include/linux/moduleparam.h:409:45: error: invalid storage class for function '__check_swcrypto'
     409 |         static inline type __always_unused *__check_##name(void) { return(p); }
         |                                             ^~~~~~~~
   include/linux/moduleparam.h:429:34: note: in expansion of macro '__param_check'
     429 | #define param_check_int(name, p) __param_check(name, p, int)
         |                                  ^~~~~~~~~~~~~
   include/linux/moduleparam.h:150:9: note: in expansion of macro 'param_check_int'
     150 |         param_check_##type(name, &(value));                                \
         |         ^~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1845:1: note: in expansion of macro 'module_param_named'
    1845 | module_param_named(swcrypto, iwlwifi_mod_params.swcrypto, int, 0444);
         | ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:289:9: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
     289 |         static const char __param_str_##name[] = prefix #name;          \
         |         ^~~~~~
   include/linux/moduleparam.h:176:9: note: in expansion of macro '__module_param_call'
     176 |         __module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1845:1: note: in expansion of macro 'module_param_named'
    1845 | module_param_named(swcrypto, iwlwifi_mod_params.swcrypto, int, 0444);
         | ^~~~~~~~~~~~~~~~~~
>> include/linux/moduleparam.h:151:50: error: initializer element is not constant
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |                                                  ^
   include/linux/moduleparam.h:294:61: note: in definition of macro '__module_param_call'
     294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
         |                                                             ^~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1845:1: note: in expansion of macro 'module_param_named'
    1845 | module_param_named(swcrypto, iwlwifi_mod_params.swcrypto, int, 0444);
         | ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:151:50: note: (near initialization for '__param_swcrypto.<anonymous>.arg')
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |                                                  ^
   include/linux/moduleparam.h:294:61: note: in definition of macro '__module_param_call'
     294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
         |                                                             ^~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1845:1: note: in expansion of macro 'module_param_named'
    1845 | module_param_named(swcrypto, iwlwifi_mod_params.swcrypto, int, 0444);
         | ^~~~~~~~~~~~~~~~~~
>> include/linux/moduleparam.h:409:45: error: invalid storage class for function '__check_11n_disable'
     409 |         static inline type __always_unused *__check_##name(void) { return(p); }
         |                                             ^~~~~~~~
   include/linux/moduleparam.h:436:35: note: in expansion of macro '__param_check'
     436 | #define param_check_uint(name, p) __param_check(name, p, unsigned int)
         |                                   ^~~~~~~~~~~~~
   include/linux/moduleparam.h:150:9: note: in expansion of macro 'param_check_uint'
     150 |         param_check_##type(name, &(value));                                \
         |         ^~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1847:1: note: in expansion of macro 'module_param_named'
    1847 | module_param_named(11n_disable, iwlwifi_mod_params.disable_11n, uint, 0444);
         | ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:289:9: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
     289 |         static const char __param_str_##name[] = prefix #name;          \
         |         ^~~~~~
   include/linux/moduleparam.h:176:9: note: in expansion of macro '__module_param_call'
     176 |         __module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1847:1: note: in expansion of macro 'module_param_named'
    1847 | module_param_named(11n_disable, iwlwifi_mod_params.disable_11n, uint, 0444);
         | ^~~~~~~~~~~~~~~~~~
>> include/linux/moduleparam.h:151:50: error: initializer element is not constant
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |                                                  ^
   include/linux/moduleparam.h:294:61: note: in definition of macro '__module_param_call'
     294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
         |                                                             ^~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1847:1: note: in expansion of macro 'module_param_named'
    1847 | module_param_named(11n_disable, iwlwifi_mod_params.disable_11n, uint, 0444);
         | ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:151:50: note: (near initialization for '__param_11n_disable.<anonymous>.arg')
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |                                                  ^
   include/linux/moduleparam.h:294:61: note: in definition of macro '__module_param_call'
     294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
         |                                                             ^~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1847:1: note: in expansion of macro 'module_param_named'
    1847 | module_param_named(11n_disable, iwlwifi_mod_params.disable_11n, uint, 0444);
         | ^~~~~~~~~~~~~~~~~~
>> include/linux/moduleparam.h:409:45: error: invalid storage class for function '__check_amsdu_size'
     409 |         static inline type __always_unused *__check_##name(void) { return(p); }
         |                                             ^~~~~~~~
   include/linux/moduleparam.h:429:34: note: in expansion of macro '__param_check'
     429 | #define param_check_int(name, p) __param_check(name, p, int)
         |                                  ^~~~~~~~~~~~~
   include/linux/moduleparam.h:150:9: note: in expansion of macro 'param_check_int'
     150 |         param_check_##type(name, &(value));                                \
         |         ^~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1850:1: note: in expansion of macro 'module_param_named'
    1850 | module_param_named(amsdu_size, iwlwifi_mod_params.amsdu_size, int, 0444);
         | ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:289:9: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
     289 |         static const char __param_str_##name[] = prefix #name;          \
         |         ^~~~~~
   include/linux/moduleparam.h:176:9: note: in expansion of macro '__module_param_call'
     176 |         __module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1850:1: note: in expansion of macro 'module_param_named'
    1850 | module_param_named(amsdu_size, iwlwifi_mod_params.amsdu_size, int, 0444);
         | ^~~~~~~~~~~~~~~~~~
>> include/linux/moduleparam.h:151:50: error: initializer element is not constant
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |                                                  ^
   include/linux/moduleparam.h:294:61: note: in definition of macro '__module_param_call'
     294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
         |                                                             ^~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1850:1: note: in expansion of macro 'module_param_named'
    1850 | module_param_named(amsdu_size, iwlwifi_mod_params.amsdu_size, int, 0444);
         | ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:151:50: note: (near initialization for '__param_amsdu_size.<anonymous>.arg')
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |                                                  ^
   include/linux/moduleparam.h:294:61: note: in definition of macro '__module_param_call'
     294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
         |                                                             ^~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1850:1: note: in expansion of macro 'module_param_named'
    1850 | module_param_named(amsdu_size, iwlwifi_mod_params.amsdu_size, int, 0444);
         | ^~~~~~~~~~~~~~~~~~
>> include/linux/moduleparam.h:409:45: error: invalid storage class for function '__check_fw_restart'
     409 |         static inline type __always_unused *__check_##name(void) { return(p); }
         |                                             ^~~~~~~~
   include/linux/moduleparam.h:468:35: note: in expansion of macro '__param_check'
     468 | #define param_check_bool(name, p) __param_check(name, p, bool)
         |                                   ^~~~~~~~~~~~~
   include/linux/moduleparam.h:150:9: note: in expansion of macro 'param_check_bool'
     150 |         param_check_##type(name, &(value));                                \
         |         ^~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1854:1: note: in expansion of macro 'module_param_named'
    1854 | module_param_named(fw_restart, iwlwifi_mod_params.fw_restart, bool, 0444);
         | ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:289:9: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
     289 |         static const char __param_str_##name[] = prefix #name;          \
         |         ^~~~~~
   include/linux/moduleparam.h:176:9: note: in expansion of macro '__module_param_call'
     176 |         __module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1854:1: note: in expansion of macro 'module_param_named'
    1854 | module_param_named(fw_restart, iwlwifi_mod_params.fw_restart, bool, 0444);
         | ^~~~~~~~~~~~~~~~~~
>> include/linux/moduleparam.h:151:50: error: initializer element is not constant
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |                                                  ^
   include/linux/moduleparam.h:294:61: note: in definition of macro '__module_param_call'
     294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
         |                                                             ^~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1854:1: note: in expansion of macro 'module_param_named'
    1854 | module_param_named(fw_restart, iwlwifi_mod_params.fw_restart, bool, 0444);
         | ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:151:50: note: (near initialization for '__param_fw_restart.<anonymous>.arg')
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |                                                  ^
   include/linux/moduleparam.h:294:61: note: in definition of macro '__module_param_call'
     294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
         |                                                             ^~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1854:1: note: in expansion of macro 'module_param_named'
    1854 | module_param_named(fw_restart, iwlwifi_mod_params.fw_restart, bool, 0444);
         | ^~~~~~~~~~~~~~~~~~
>> include/linux/moduleparam.h:409:45: error: invalid storage class for function '__check_nvm_file'
     409 |         static inline type __always_unused *__check_##name(void) { return(p); }
         |                                             ^~~~~~~~
   include/linux/moduleparam.h:462:36: note: in expansion of macro '__param_check'
     462 | #define param_check_charp(name, p) __param_check(name, p, char *)
         |                                    ^~~~~~~~~~~~~
   include/linux/moduleparam.h:150:9: note: in expansion of macro 'param_check_charp'
     150 |         param_check_##type(name, &(value));                                \
         |         ^~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1857:1: note: in expansion of macro 'module_param_named'
    1857 | module_param_named(nvm_file, iwlwifi_mod_params.nvm_file, charp, 0444);
         | ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:289:9: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
     289 |         static const char __param_str_##name[] = prefix #name;          \
         |         ^~~~~~
   include/linux/moduleparam.h:176:9: note: in expansion of macro '__module_param_call'
     176 |         __module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1857:1: note: in expansion of macro 'module_param_named'
    1857 | module_param_named(nvm_file, iwlwifi_mod_params.nvm_file, charp, 0444);
         | ^~~~~~~~~~~~~~~~~~
>> include/linux/moduleparam.h:151:50: error: initializer element is not constant
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |                                                  ^
   include/linux/moduleparam.h:294:61: note: in definition of macro '__module_param_call'
     294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
         |                                                             ^~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1857:1: note: in expansion of macro 'module_param_named'
    1857 | module_param_named(nvm_file, iwlwifi_mod_params.nvm_file, charp, 0444);
         | ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:151:50: note: (near initialization for '__param_nvm_file.<anonymous>.arg')
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |                                                  ^
   include/linux/moduleparam.h:294:61: note: in definition of macro '__module_param_call'
     294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
         |                                                             ^~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1857:1: note: in expansion of macro 'module_param_named'
    1857 | module_param_named(nvm_file, iwlwifi_mod_params.nvm_file, charp, 0444);
         | ^~~~~~~~~~~~~~~~~~
>> include/linux/moduleparam.h:409:45: error: invalid storage class for function '__check_uapsd_disable'
     409 |         static inline type __always_unused *__check_##name(void) { return(p); }
         |                                             ^~~~~~~~
   include/linux/moduleparam.h:436:35: note: in expansion of macro '__param_check'
     436 | #define param_check_uint(name, p) __param_check(name, p, unsigned int)
         |                                   ^~~~~~~~~~~~~
   include/linux/moduleparam.h:150:9: note: in expansion of macro 'param_check_uint'
     150 |         param_check_##type(name, &(value));                                \
         |         ^~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1860:1: note: in expansion of macro 'module_param_named'
    1860 | module_param_named(uapsd_disable, iwlwifi_mod_params.uapsd_disable, uint, 0644);
         | ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:289:9: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
     289 |         static const char __param_str_##name[] = prefix #name;          \
         |         ^~~~~~
   include/linux/moduleparam.h:176:9: note: in expansion of macro '__module_param_call'
     176 |         __module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1860:1: note: in expansion of macro 'module_param_named'
    1860 | module_param_named(uapsd_disable, iwlwifi_mod_params.uapsd_disable, uint, 0644);
         | ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:151:50: error: initializer element is not constant
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |                                                  ^
   include/linux/moduleparam.h:294:61: note: in definition of macro '__module_param_call'
     294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
         |                                                             ^~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1860:1: note: in expansion of macro 'module_param_named'
    1860 | module_param_named(uapsd_disable, iwlwifi_mod_params.uapsd_disable, uint, 0644);
         | ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:151:50: note: (near initialization for '__param_uapsd_disable.<anonymous>.arg')
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |                                                  ^
   include/linux/moduleparam.h:294:61: note: in definition of macro '__module_param_call'
     294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
         |                                                             ^~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1860:1: note: in expansion of macro 'module_param_named'
    1860 | module_param_named(uapsd_disable, iwlwifi_mod_params.uapsd_disable, uint, 0644);
         | ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:409:45: error: invalid storage class for function '__check_enable_ini'
     409 |         static inline type __always_unused *__check_##name(void) { return(p); }
         |                                             ^~~~~~~~
   include/linux/moduleparam.h:468:35: note: in expansion of macro '__param_check'
     468 | #define param_check_bool(name, p) __param_check(name, p, bool)
         |                                   ^~~~~~~~~~~~~
   include/linux/moduleparam.h:150:9: note: in expansion of macro 'param_check_bool'
     150 |         param_check_##type(name, &(value));                                \
         |         ^~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1863:1: note: in expansion of macro 'module_param_named'
    1863 | module_param_named(enable_ini, iwlwifi_mod_params.enable_ini,
         | ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:289:9: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
     289 |         static const char __param_str_##name[] = prefix #name;          \
         |         ^~~~~~
   include/linux/moduleparam.h:176:9: note: in expansion of macro '__module_param_call'
     176 |         __module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1863:1: note: in expansion of macro 'module_param_named'
    1863 | module_param_named(enable_ini, iwlwifi_mod_params.enable_ini,
         | ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:151:50: error: initializer element is not constant
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |                                                  ^
   include/linux/moduleparam.h:294:61: note: in definition of macro '__module_param_call'
     294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
         |                                                             ^~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1863:1: note: in expansion of macro 'module_param_named'
    1863 | module_param_named(enable_ini, iwlwifi_mod_params.enable_ini,
         | ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:151:50: note: (near initialization for '__param_enable_ini.<anonymous>.arg')
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |                                                  ^
   include/linux/moduleparam.h:294:61: note: in definition of macro '__module_param_call'
     294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
         |                                                             ^~~
   include/linux/moduleparam.h:151:9: note: in expansion of macro 'module_param_cb'
     151 |         module_param_cb(name, &param_ops_##type, &value, perm);            \
         |         ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-drv.c:1863:1: note: in expansion of macro 'module_param_named'
    1863 | module_param_named(enable_ini, iwlwifi_mod_params.enable_ini,
         | ^~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:409:45: error: invalid storage class for function '__check_bt_coex_active'
     409 |         static inline type __always_unused *__check_##name(void) { return(p); }
         |                                             ^~~~~~~~
   include/linux/moduleparam.h:468:35: note: in expansion of macro '__param_check'
     468 | #define param_check_bool(name, p) __param_check(name, p, bool)


vim +/_iwl_op_mode_stop +1342 drivers/net/wireless/intel/iwlwifi/iwl-drv.c

9da987ac2b88b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Meenakshi Venkataraman 2012-07-16  1341  
9da987ac2b88b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Meenakshi Venkataraman 2012-07-16 @1342  static void _iwl_op_mode_stop(struct iwl_drv *drv)
9da987ac2b88b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Meenakshi Venkataraman 2012-07-16  1343  {
9da987ac2b88b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Meenakshi Venkataraman 2012-07-16  1344  	/* op_mode can be NULL if its start failed */
9da987ac2b88b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Meenakshi Venkataraman 2012-07-16  1345  	if (drv->op_mode) {
9da987ac2b88b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Meenakshi Venkataraman 2012-07-16  1346  		iwl_op_mode_stop(drv->op_mode);
9da987ac2b88b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Meenakshi Venkataraman 2012-07-16  1347  		drv->op_mode = NULL;
9da987ac2b88b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Meenakshi Venkataraman 2012-07-16  1348  
9da987ac2b88b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Meenakshi Venkataraman 2012-07-16  1349  #ifdef CONFIG_IWLWIFI_DEBUGFS
9da987ac2b88b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Meenakshi Venkataraman 2012-07-16  1350  		debugfs_remove_recursive(drv->dbgfs_op_mode);
9da987ac2b88b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Meenakshi Venkataraman 2012-07-16  1351  		drv->dbgfs_op_mode = NULL;
9da987ac2b88b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Meenakshi Venkataraman 2012-07-16  1352  #endif
9da987ac2b88b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Meenakshi Venkataraman 2012-07-16  1353  	}
9da987ac2b88b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Meenakshi Venkataraman 2012-07-16  1354  }
9da987ac2b88b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Meenakshi Venkataraman 2012-07-16  1355  
7d4ced86997f69 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Lee Jones              2020-09-10  1356  /*
1c8e11e117c28e drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2012-07-16  1357   * iwl_req_fw_callback - callback when firmware was loaded
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1358   *
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1359   * If loaded successfully, copies the firmware into buffers
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1360   * for the card to fetch (via DMA).
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1361   */
1c8e11e117c28e drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2012-07-16 @1362  static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1363  {
965974a631756a drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-06  1364  	struct iwl_drv *drv = context;
965974a631756a drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-06  1365  	struct iwl_fw *fw = &drv->fw;
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1366  	struct iwl_ucode_header *ucode;
cc5f7e39761382 drivers/net/wireless/iwlwifi/iwl-drv.c       Don Fry                2012-05-16  1367  	struct iwlwifi_opmode_table *op;
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1368  	int err;
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1369  	struct iwl_firmware_pieces *pieces;
0c4881ced8d2e3 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Luca Coelho            2016-12-13  1370  	const unsigned int api_max = drv->trans->cfg->ucode_api_max;
0c4881ced8d2e3 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Luca Coelho            2016-12-13  1371  	const unsigned int api_min = drv->trans->cfg->ucode_api_min;
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1372  	size_t trigger_tlv_sz[FW_DBG_TRIGGER_MAX];
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1373  	u32 api_ver;
6dfa8d019cd21d drivers/net/wireless/iwlwifi/iwl-drv.c       David Spinadel         2012-03-10  1374  	int i;
d4b10483223cf1 drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-06-12  1375  	bool load_module = false;
e6eb8ca9e486a8 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben-Ami          2015-08-30  1376  	bool usniffer_images = false;
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1377  
66140adc22aacd drivers/net/wireless/iwlwifi/iwl-drv.c       Luciano Coelho         2013-08-12  1378  	fw->ucode_capa.max_probe_length = IWL_DEFAULT_MAX_PROBE_LENGTH;
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1379  	fw->ucode_capa.standard_phy_calibration_size =
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1380  			IWL_DEFAULT_STANDARD_PHY_CALIBRATE_TBL_SIZE;
762533ba9c0306 drivers/net/wireless/iwlwifi/iwl-drv.c       David Spinadel         2014-06-05  1381  	fw->ucode_capa.n_scan_channels = IWL_DEFAULT_SCAN_CHANNELS;
be9ae34ead42f8 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Nathan Errera          2020-10-08  1382  	fw->ucode_capa.num_stations = IWL_MVM_STATION_COUNT_MAX;
971377e67074a0 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Shahar S Matityahu     2019-01-01  1383  	/* dump all fw memory areas by default */
971377e67074a0 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Shahar S Matityahu     2019-01-01  1384  	fw->dbg.dump_mask = 0xffffffff;
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1385  
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1386  	pieces = kzalloc(sizeof(*pieces), GFP_KERNEL);
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1387  	if (!pieces)
53d515ec677a19 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Johannes Berg          2017-02-28  1388  		goto out_free_fw;
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1389  
9d9b21d1b61647 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Emmanuel Grumbach      2016-03-24  1390  	if (!ucode_raw)
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1391  		goto try_again;
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1392  
2953c393a0a469 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Shahar S Matityahu     2019-03-04  1393  	IWL_DEBUG_FW_INFO(drv, "Loaded firmware file '%s' (%zd bytes).\n",
965974a631756a drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-06  1394  			  drv->firmware_name, ucode_raw->size);
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1395  
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1396  	/* Make sure that we got at least the API version number */
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1397  	if (ucode_raw->size < 4) {
965974a631756a drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-06  1398  		IWL_ERR(drv, "File size way too small!\n");
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1399  		goto try_again;
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1400  	}
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1401  
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1402  	/* Data from ucode file:  header followed by uCode images */
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1403  	ucode = (struct iwl_ucode_header *)ucode_raw->data;
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1404  
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1405  	if (ucode->ver)
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1406  		err = iwl_parse_v1_v2_firmware(drv, ucode_raw, pieces);
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1407  	else
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1408  		err = iwl_parse_tlv_firmware(drv, ucode_raw, pieces,
e6eb8ca9e486a8 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben-Ami          2015-08-30  1409  					     &fw->ucode_capa, &usniffer_images);
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1410  
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1411  	if (err)
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1412  		goto try_again;
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1413  
f0d8f38cd909e0 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Luca Coelho            2016-04-25  1414  	if (fw_has_api(&drv->fw.ucode_capa, IWL_UCODE_TLV_API_NEW_VERSION))
7e1223b50089ab drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-02-03  1415  		api_ver = drv->fw.ucode_ver;
f0d8f38cd909e0 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Luca Coelho            2016-04-25  1416  	else
f0d8f38cd909e0 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Luca Coelho            2016-04-25  1417  		api_ver = IWL_UCODE_API(drv->fw.ucode_ver);
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1418  
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1419  	/*
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1420  	 * api_ver should match the api version forming part of the
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1421  	 * firmware filename ... but we don't check for that and only rely
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1422  	 * on the API version read from firmware header from here on forward
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1423  	 */
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1424  	if (api_ver < api_min || api_ver > api_max) {
965974a631756a drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-06  1425  		IWL_ERR(drv,
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1426  			"Driver unable to support your firmware API. "
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1427  			"Driver supports v%u, firmware is v%u.\n",
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1428  			api_max, api_ver);
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1429  		goto try_again;
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1430  	}
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1431  
4db2c9aeb28762 drivers/net/wireless/iwlwifi/iwl-drv.c       David Spinadel         2012-03-10  1432  	/*
4db2c9aeb28762 drivers/net/wireless/iwlwifi/iwl-drv.c       David Spinadel         2012-03-10  1433  	 * In mvm uCode there is no difference between data and instructions
4db2c9aeb28762 drivers/net/wireless/iwlwifi/iwl-drv.c       David Spinadel         2012-03-10  1434  	 * sections.
4db2c9aeb28762 drivers/net/wireless/iwlwifi/iwl-drv.c       David Spinadel         2012-03-10  1435  	 */
0c4881ced8d2e3 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Luca Coelho            2016-12-13  1436  	if (fw->type == IWL_FW_DVM && validate_sec_sizes(drv, pieces,
0c4881ced8d2e3 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Luca Coelho            2016-12-13  1437  							 drv->trans->cfg))
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1438  		goto try_again;
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1439  
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1440  	/* Allocate ucode buffers for card's bus-master loading ... */
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1441  
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1442  	/* Runtime instructions and 2 copies of data:
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1443  	 * 1) unmodified from disk
1e37f79945b0b8 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Christoph Böhmwalder   2017-09-23  1444  	 * 2) backup cache for save/restore during power-downs
1e37f79945b0b8 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Christoph Böhmwalder   2017-09-23  1445  	 */
6dfa8d019cd21d drivers/net/wireless/iwlwifi/iwl-drv.c       David Spinadel         2012-03-10  1446  	for (i = 0; i < IWL_UCODE_TYPE_MAX; i++)
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1447  		if (iwl_alloc_ucode(drv, pieces, i))
75813bde1f671a drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-05-16  1448  			goto out_free_fw;
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1449  
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1450  	if (pieces->dbg_dest_tlv_init) {
17b809c9b22e34 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Sara Sharon            2018-06-11  1451  		size_t dbg_dest_size = sizeof(*drv->fw.dbg.dest_tlv) +
17b809c9b22e34 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Sara Sharon            2018-06-11  1452  			sizeof(drv->fw.dbg.dest_tlv->reg_ops[0]) *
17b809c9b22e34 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Sara Sharon            2018-06-11  1453  			drv->fw.dbg.n_dest_reg;
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1454  
17b809c9b22e34 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Sara Sharon            2018-06-11  1455  		drv->fw.dbg.dest_tlv = kmalloc(dbg_dest_size, GFP_KERNEL);
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1456  
17b809c9b22e34 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Sara Sharon            2018-06-11  1457  		if (!drv->fw.dbg.dest_tlv)
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1458  			goto out_free_fw;
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1459  
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1460  		if (*pieces->dbg_dest_ver == 0) {
17b809c9b22e34 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Sara Sharon            2018-06-11  1461  			memcpy(drv->fw.dbg.dest_tlv, pieces->dbg_dest_tlv_v1,
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1462  			       dbg_dest_size);
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1463  		} else {
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1464  			struct iwl_fw_dbg_dest_tlv_v1 *dest_tlv =
17b809c9b22e34 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Sara Sharon            2018-06-11  1465  				drv->fw.dbg.dest_tlv;
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1466  
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1467  			dest_tlv->version = pieces->dbg_dest_tlv->version;
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1468  			dest_tlv->monitor_mode =
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1469  				pieces->dbg_dest_tlv->monitor_mode;
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1470  			dest_tlv->size_power =
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1471  				pieces->dbg_dest_tlv->size_power;
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1472  			dest_tlv->wrap_count =
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1473  				pieces->dbg_dest_tlv->wrap_count;
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1474  			dest_tlv->write_ptr_reg =
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1475  				pieces->dbg_dest_tlv->write_ptr_reg;
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1476  			dest_tlv->base_shift =
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1477  				pieces->dbg_dest_tlv->base_shift;
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1478  			memcpy(dest_tlv->reg_ops,
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1479  			       pieces->dbg_dest_tlv->reg_ops,
17b809c9b22e34 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Sara Sharon            2018-06-11  1480  			       sizeof(drv->fw.dbg.dest_tlv->reg_ops[0]) *
17b809c9b22e34 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Sara Sharon            2018-06-11  1481  			       drv->fw.dbg.n_dest_reg);
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1482  
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1483  			/* In version 1 of the destination tlv, which is
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1484  			 * relevant for internal buffer exclusively,
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1485  			 * the base address is part of given with the length
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1486  			 * of the buffer, and the size shift is give instead of
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1487  			 * end shift. We now store these values in base_reg,
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1488  			 * and end shift, and when dumping the data we'll
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1489  			 * manipulate it for extracting both the length and
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1490  			 * base address */
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1491  			dest_tlv->base_reg = pieces->dbg_dest_tlv->cfg_reg;
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1492  			dest_tlv->end_shift =
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1493  				pieces->dbg_dest_tlv->size_shift;
fd527eb5d22936 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben Ami          2017-08-16  1494  		}
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1495  	}
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1496  
17b809c9b22e34 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Sara Sharon            2018-06-11  1497  	for (i = 0; i < ARRAY_SIZE(drv->fw.dbg.conf_tlv); i++) {
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1498  		if (pieces->dbg_conf_tlv[i]) {
17b809c9b22e34 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Sara Sharon            2018-06-11  1499  			drv->fw.dbg.conf_tlv[i] =
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1500  				kmemdup(pieces->dbg_conf_tlv[i],
17b809c9b22e34 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Sara Sharon            2018-06-11  1501  					pieces->dbg_conf_tlv_len[i],
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1502  					GFP_KERNEL);
a176e114ace4cc drivers/net/wireless/intel/iwlwifi/iwl-drv.c Chris Rorvick          2020-04-17  1503  			if (!drv->fw.dbg.conf_tlv[i])
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1504  				goto out_free_fw;
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1505  		}
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1506  	}
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1507  
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1508  	memset(&trigger_tlv_sz, 0xff, sizeof(trigger_tlv_sz));
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1509  
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1510  	trigger_tlv_sz[FW_DBG_TRIGGER_MISSED_BEACONS] =
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1511  		sizeof(struct iwl_fw_dbg_trigger_missed_bcon);
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1512  	trigger_tlv_sz[FW_DBG_TRIGGER_CHANNEL_SWITCH] = 0;
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1513  	trigger_tlv_sz[FW_DBG_TRIGGER_FW_NOTIF] =
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1514  		sizeof(struct iwl_fw_dbg_trigger_cmd);
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1515  	trigger_tlv_sz[FW_DBG_TRIGGER_MLME] =
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1516  		sizeof(struct iwl_fw_dbg_trigger_mlme);
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1517  	trigger_tlv_sz[FW_DBG_TRIGGER_STATS] =
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1518  		sizeof(struct iwl_fw_dbg_trigger_stats);
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1519  	trigger_tlv_sz[FW_DBG_TRIGGER_RSSI] =
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1520  		sizeof(struct iwl_fw_dbg_trigger_low_rssi);
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1521  	trigger_tlv_sz[FW_DBG_TRIGGER_TXQ_TIMERS] =
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1522  		sizeof(struct iwl_fw_dbg_trigger_txq_timer);
874c174eb9950a drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-25  1523  	trigger_tlv_sz[FW_DBG_TRIGGER_TIME_EVENT] =
874c174eb9950a drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-25  1524  		sizeof(struct iwl_fw_dbg_trigger_time_event);
4203263d8302be drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-04-15  1525  	trigger_tlv_sz[FW_DBG_TRIGGER_BA] =
4203263d8302be drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-04-15  1526  		sizeof(struct iwl_fw_dbg_trigger_ba);
1e8f1329aa6767 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben-Ami          2015-08-23  1527  	trigger_tlv_sz[FW_DBG_TRIGGER_TDLS] =
1e8f1329aa6767 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben-Ami          2015-08-23  1528  		sizeof(struct iwl_fw_dbg_trigger_tdls);
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1529  
17b809c9b22e34 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Sara Sharon            2018-06-11  1530  	for (i = 0; i < ARRAY_SIZE(drv->fw.dbg.trigger_tlv); i++) {
d2709ad723ff2a drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-01-29  1531  		if (pieces->dbg_trigger_tlv[i]) {
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1532  			/*
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1533  			 * If the trigger isn't long enough, WARN and exit.
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1534  			 * Someone is trying to debug something and he won't
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1535  			 * be able to catch the bug he is trying to chase.
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1536  			 * We'd better be noisy to be sure he knows what's
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1537  			 * going on.
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1538  			 */
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1539  			if (WARN_ON(pieces->dbg_trigger_tlv_len[i] <
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1540  				    (trigger_tlv_sz[i] +
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1541  				     sizeof(struct iwl_fw_dbg_trigger_tlv))))
2841a2d3a1b4b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-03-19  1542  				goto out_free_fw;
17b809c9b22e34 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Sara Sharon            2018-06-11  1543  			drv->fw.dbg.trigger_tlv_len[i] =
d2709ad723ff2a drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-01-29  1544  				pieces->dbg_trigger_tlv_len[i];
17b809c9b22e34 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Sara Sharon            2018-06-11  1545  			drv->fw.dbg.trigger_tlv[i] =
d2709ad723ff2a drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-01-29  1546  				kmemdup(pieces->dbg_trigger_tlv[i],
17b809c9b22e34 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Sara Sharon            2018-06-11  1547  					drv->fw.dbg.trigger_tlv_len[i],
d2709ad723ff2a drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2015-01-29  1548  					GFP_KERNEL);
17b809c9b22e34 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Sara Sharon            2018-06-11  1549  			if (!drv->fw.dbg.trigger_tlv[i])
a6017b9030f280 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben-Ami          2016-03-14  1550  				goto out_free_fw;
a6017b9030f280 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben-Ami          2016-03-14  1551  		}
a6017b9030f280 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben-Ami          2016-03-14  1552  	}
a6017b9030f280 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Golan Ben-Ami          2016-03-14  1553  
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1554  	/* Now that we can no longer fail, copy information */
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1555  
17b809c9b22e34 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Sara Sharon            2018-06-11  1556  	drv->fw.dbg.mem_tlv = pieces->dbg_mem_tlv;
2ed1e019108252 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Johannes Berg          2016-10-20  1557  	pieces->dbg_mem_tlv = NULL;
17b809c9b22e34 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Sara Sharon            2018-06-11  1558  	drv->fw.dbg.n_mem_tlv = pieces->n_mem_tlv;
2ed1e019108252 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Johannes Berg          2016-10-20  1559  
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1560  	/*
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1561  	 * The (size - 16) / 12 formula is based on the information recorded
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1562  	 * for each event, which is of mode 1 (including timestamp) for all
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1563  	 * new microcodes that include this information.
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1564  	 */
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1565  	fw->init_evtlog_ptr = pieces->init_evtlog_ptr;
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1566  	if (pieces->init_evtlog_size)
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1567  		fw->init_evtlog_size = (pieces->init_evtlog_size - 16)/12;
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1568  	else
0692fe41b36159 drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-06  1569  		fw->init_evtlog_size =
286ca8eb4d0a97 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Luca Coelho            2019-07-12  1570  			drv->trans->trans_cfg->base_params->max_event_log_size;
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1571  	fw->init_errlog_ptr = pieces->init_errlog_ptr;
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1572  	fw->inst_evtlog_ptr = pieces->inst_evtlog_ptr;
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1573  	if (pieces->inst_evtlog_size)
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1574  		fw->inst_evtlog_size = (pieces->inst_evtlog_size - 16)/12;
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1575  	else
0692fe41b36159 drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-06  1576  		fw->inst_evtlog_size =
286ca8eb4d0a97 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Luca Coelho            2019-07-12  1577  			drv->trans->trans_cfg->base_params->max_event_log_size;
490fefebb6db4c drivers/net/wireless/iwlwifi/iwl-drv.c       Liad Kaufman           2014-09-16  1578  	fw->inst_errlog_ptr = pieces->inst_errlog_ptr;
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1579  
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1580  	/*
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1581  	 * figure out the offset of chain noise reset and gain commands
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1582  	 * base on the size of standard phy calibration commands table size
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1583  	 */
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1584  	if (fw->ucode_capa.standard_phy_calibration_size >
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1585  	    IWL_MAX_PHY_CALIBRATE_TBL_SIZE)
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1586  		fw->ucode_capa.standard_phy_calibration_size =
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1587  			IWL_MAX_STANDARD_PHY_CALIBRATE_TBL_SIZE;
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1588  
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1589  	/* We have our copies now, allow OS release its copies */
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1590  	release_firmware(ucode_raw);
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1591  
ff1ffb850b7ac6 drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-06-06  1592  	mutex_lock(&iwlwifi_opmode_table_mtx);
ca221c9b946cd4 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Johannes Berg          2016-04-28  1593  	switch (fw->type) {
ca221c9b946cd4 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Johannes Berg          2016-04-28  1594  	case IWL_FW_DVM:
cc5f7e39761382 drivers/net/wireless/iwlwifi/iwl-drv.c       Don Fry                2012-05-16  1595  		op = &iwlwifi_opmode_table[DVM_OP_MODE];
ca221c9b946cd4 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Johannes Berg          2016-04-28  1596  		break;
ca221c9b946cd4 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Johannes Berg          2016-04-28  1597  	default:
ca221c9b946cd4 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Johannes Berg          2016-04-28  1598  		WARN(1, "Invalid fw type %d\n", fw->type);
10a0472d1850a9 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Gustavo A. R. Silva    2020-11-20  1599  		fallthrough;
ca221c9b946cd4 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Johannes Berg          2016-04-28  1600  	case IWL_FW_MVM:
ca221c9b946cd4 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Johannes Berg          2016-04-28  1601  		op = &iwlwifi_opmode_table[MVM_OP_MODE];
ca221c9b946cd4 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Johannes Berg          2016-04-28  1602  		break;
ca221c9b946cd4 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Johannes Berg          2016-04-28  1603  	}
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1604  
2b2719c7b5bbe3 drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2013-03-26  1605  	IWL_INFO(drv, "loaded firmware version %s op_mode %s\n",
2b2719c7b5bbe3 drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2013-03-26  1606  		 drv->fw.fw_version, op->name);
2b2719c7b5bbe3 drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2013-03-26  1607  
c03fe6d3b31c75 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Shahar S Matityahu     2019-07-08  1608  	iwl_dbg_tlv_load_bin(drv->trans->dev, drv->trans);
c03fe6d3b31c75 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Shahar S Matityahu     2019-07-08  1609  
cc5f7e39761382 drivers/net/wireless/iwlwifi/iwl-drv.c       Don Fry                2012-05-16  1610  	/* add this device to the list of devices using this op_mode */
cc5f7e39761382 drivers/net/wireless/iwlwifi/iwl-drv.c       Don Fry                2012-05-16  1611  	list_add_tail(&drv->list, &op->drv);
cc5f7e39761382 drivers/net/wireless/iwlwifi/iwl-drv.c       Don Fry                2012-05-16  1612  
cc5f7e39761382 drivers/net/wireless/iwlwifi/iwl-drv.c       Don Fry                2012-05-16  1613  	if (op->ops) {
9da987ac2b88b4 drivers/net/wireless/iwlwifi/iwl-drv.c       Meenakshi Venkataraman 2012-07-16  1614  		drv->op_mode = _iwl_op_mode_start(drv, op);
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1615  
daf67ce8cffd14 drivers/net/wireless/iwlwifi/iwl-drv.c       Dan Carpenter          2012-06-14  1616  		if (!drv->op_mode) {
daf67ce8cffd14 drivers/net/wireless/iwlwifi/iwl-drv.c       Dan Carpenter          2012-06-14  1617  			mutex_unlock(&iwlwifi_opmode_table_mtx);
f69a23b795d6ee drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-06-05  1618  			goto out_unbind;
daf67ce8cffd14 drivers/net/wireless/iwlwifi/iwl-drv.c       Dan Carpenter          2012-06-14  1619  		}
cc5f7e39761382 drivers/net/wireless/iwlwifi/iwl-drv.c       Don Fry                2012-05-16  1620  	} else {
d4b10483223cf1 drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-06-12  1621  		load_module = true;
cc5f7e39761382 drivers/net/wireless/iwlwifi/iwl-drv.c       Don Fry                2012-05-16  1622  	}
ff1ffb850b7ac6 drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-06-06  1623  	mutex_unlock(&iwlwifi_opmode_table_mtx);
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1624  
f69a23b795d6ee drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-06-05  1625  	/*
f69a23b795d6ee drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-06-05  1626  	 * Complete the firmware request last so that
f69a23b795d6ee drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-06-05  1627  	 * a driver unbind (stop) doesn't run while we
f69a23b795d6ee drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-06-05  1628  	 * are doing the start() above.
f69a23b795d6ee drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-06-05  1629  	 */
f69a23b795d6ee drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-06-05  1630  	complete(&drv->request_firmware_complete);
d4b10483223cf1 drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-06-12  1631  
d4b10483223cf1 drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-06-12  1632  	/*
d4b10483223cf1 drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-06-12  1633  	 * Load the module last so we don't block anything
d4b10483223cf1 drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-06-12  1634  	 * else from proceeding if the module fails to load
d4b10483223cf1 drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-06-12  1635  	 * or hangs loading.
d4b10483223cf1 drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-06-12  1636  	 */
1618b2b02a3a0e drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2013-04-04  1637  	if (load_module) {
06a1e85e66bac2 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Johannes Berg          2017-02-28  1638  		request_module("%s", op->name);
8edf3fd6eb0649 drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2013-05-28  1639  #ifdef CONFIG_IWLWIFI_OPMODE_MODULAR
1618b2b02a3a0e drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2013-04-04  1640  		if (err)
1618b2b02a3a0e drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2013-04-04  1641  			IWL_ERR(drv,
1618b2b02a3a0e drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2013-04-04  1642  				"failed to load module %s (error %d), is dynamic loading enabled?\n",
1618b2b02a3a0e drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2013-04-04  1643  				op->name, err);
8edf3fd6eb0649 drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2013-05-28  1644  #endif
1618b2b02a3a0e drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2013-04-04  1645  	}
2ed1e019108252 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Johannes Berg          2016-10-20  1646  	goto free;
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1647  
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1648   try_again:
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1649  	/* try next, if any */
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1650  	release_firmware(ucode_raw);
965974a631756a drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-06  1651  	if (iwl_request_firmware(drv, false))
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1652  		goto out_unbind;
2ed1e019108252 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Johannes Berg          2016-10-20  1653  	goto free;
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1654  
75813bde1f671a drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-05-16  1655   out_free_fw:
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1656  	release_firmware(ucode_raw);
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1657   out_unbind:
965974a631756a drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-06  1658  	complete(&drv->request_firmware_complete);
93faaeea4f2873 drivers/net/wireless/iwlwifi/iwl-drv.c       Emmanuel Grumbach      2012-03-22  1659  	device_release_driver(drv->trans->dev);
2ed1e019108252 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Johannes Berg          2016-10-20  1660   free:
53d515ec677a19 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Johannes Berg          2017-02-28  1661  	if (pieces) {
eef187a7b8a144 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Sara Sharon            2016-10-25  1662  		for (i = 0; i < ARRAY_SIZE(pieces->img); i++)
eef187a7b8a144 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Sara Sharon            2016-10-25  1663  			kfree(pieces->img[i].sec);
2ed1e019108252 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Johannes Berg          2016-10-20  1664  		kfree(pieces->dbg_mem_tlv);
2ed1e019108252 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Johannes Berg          2016-10-20  1665  		kfree(pieces);
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1666  	}
53d515ec677a19 drivers/net/wireless/intel/iwlwifi/iwl-drv.c Johannes Berg          2017-02-28  1667  }
15854ef94f54ae drivers/net/wireless/iwlwifi/iwl-drv.c       Johannes Berg          2012-03-05  1668  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--SUOF0GtieIMvvwua
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--SUOF0GtieIMvvwua--
