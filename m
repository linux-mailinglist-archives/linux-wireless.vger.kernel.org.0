Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC5A674124
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 19:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjASSmM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 13:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjASSmL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 13:42:11 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8999C8C922
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 10:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674153729; x=1705689729;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=q4o9kflqG0iNYlQlt5XKi8GkpnkbCfsjhiiSbsGnuZ4=;
  b=nyk3uPrMCMikSzfWyOtJTra9QaemcWOsI3fZGfpT+xpgb2oJano6ltoA
   Frp5ekLh9AofR0WqX5uyCBHTUIK/fG8XjBEqIxkVDGOSQL7P56AJ0brWk
   9mi0uI9d5ArZdAoC3hXKNheIyvU+BVw0/JJtVstcerQ4ZUQahXyvkC3T+
   qk4TS0uKvp9Bnb48h05yHuhudYZmkUMxl+bZycDhgLakpHtToGbiU6YsZ
   SZ7xhG1aiXZ81sgQ58qYWU9mEFR/XqyajuhaJ2+pP8EM3FZ1u6gY6GsRJ
   BtiGzWLhSl2EPVRtZojj+FaKZxgYu6czR2FZVQbsvtyNrq7Imw57fzf8n
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="326659678"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="326659678"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 10:42:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="749029368"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="749029368"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jan 2023 10:42:06 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIZrR-0001jm-2c;
        Thu, 19 Jan 2023 18:42:05 +0000
Date:   Fri, 20 Jan 2023 02:41:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-wireless@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 aa5c49149a823599764e6953229b028e4bf6e9cc
Message-ID: <63c98ef4.WF7KGM4apV4U5xFO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: aa5c49149a823599764e6953229b028e4bf6e9cc  Add linux-next specific files for 20230119

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202301191616.R33Dvxk4-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202301192229.wL7iPJxS-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:1125:76: error: storage size of 'hdmi_encoded_link_bw' isn't known
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:1129:101: error: 'struct <anonymous>' has no member named 'MAX_ENCODED_LINK_BW_SUPPORT'
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:231:17: error: function declaration isn't a prototype [-Werror=strict-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:233:42: error: parameter 2 ('hdmi_encoded_link_bw') has incomplete type
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_training.c:1583:38: warning: variable 'result' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_training.c:1585:38: warning: variable 'result' set but not used [-Wunused-but-set-variable]
drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5198:24: sparse:    left side has type restricted __le16
drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5198:24: sparse:    right side has type restricted __le32
idma64.c:(.text+0x6a): undefined reference to `devm_platform_ioremap_resource'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-randconfig-r024-20230119
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
|-- arc-randconfig-r023-20230118
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:function-declaration-isn-t-a-prototype
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:parameter-(-hdmi_encoded_link_bw-)-has-incomplete-type
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:storage-size-of-hdmi_encoded_link_bw-isn-t-known
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:struct-anonymous-has-no-member-named-MAX_ENCODED_LINK_BW_SUPPORT
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:function-declaration-isn-t-a-prototype
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:parameter-(-hdmi_encoded_link_bw-)-has-incomplete-type
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:storage-size-of-hdmi_encoded_link_bw-isn-t-known
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:struct-anonymous-has-no-member-named-MAX_ENCODED_LINK_BW_SUPPORT
|-- ia64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:function-declaration-isn-t-a-prototype
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:parameter-(-hdmi_encoded_link_bw-)-has-incomplete-type
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:storage-size-of-hdmi_encoded_link_bw-isn-t-known
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:struct-anonymous-has-no-member-named-MAX_ENCODED_LINK_BW_SUPPORT
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:function-declaration-isn-t-a-prototype
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:parameter-(-hdmi_encoded_link_bw-)-has-incomplete-type
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:storage-size-of-hdmi_encoded_link_bw-isn-t-known
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:struct-anonymous-has-no-member-named-MAX_ENCODED_LINK_BW_SUPPORT
|-- mips-randconfig-r036-20230118
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:function-declaration-isn-t-a-prototype
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:parameter-(-hdmi_encoded_link_bw-)-has-incomplete-type
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:storage-size-of-hdmi_encoded_link_bw-isn-t-known
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:struct-anonymous-has-no-member-named-MAX_ENCODED_LINK_BW_SUPPORT
|-- openrisc-randconfig-s043-20230119
|   |-- drivers-net-wireless-realtek-rtl8xxxu-rtl8xxxu_core.c:sparse:left-side-has-type-restricted-__le16
|   |-- drivers-net-wireless-realtek-rtl8xxxu-rtl8xxxu_core.c:sparse:right-side-has-type-restricted-__le32
|   `-- drivers-net-wireless-realtek-rtl8xxxu-rtl8xxxu_core.c:sparse:sparse:invalid-assignment:
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:function-declaration-isn-t-a-prototype
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:parameter-(-hdmi_encoded_link_bw-)-has-incomplete-type
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:storage-size-of-hdmi_encoded_link_bw-isn-t-known
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:struct-anonymous-has-no-member-named-MAX_ENCODED_LINK_BW_SUPPORT
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:function-declaration-isn-t-a-prototype
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:parameter-(-hdmi_encoded_link_bw-)-has-incomplete-type
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:storage-size-of-hdmi_encoded_link_bw-isn-t-known
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:struct-anonymous-has-no-member-named-MAX_ENCODED_LINK_BW_SUPPORT
|-- sparc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:function-declaration-isn-t-a-prototype
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:parameter-(-hdmi_encoded_link_bw-)-has-incomplete-type
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:storage-size-of-hdmi_encoded_link_bw-isn-t-known
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_capability.c:error:struct-anonymous-has-no-member-named-MAX_ENCODED_LINK_BW_SUPPORT
`-- x86_64-allyesconfig
    `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
clang_recent_errors
`-- s390-randconfig-r044-20230119
    `-- idma64.c:(.text):undefined-reference-to-devm_platform_ioremap_resource

elapsed time: 721m

configs tested: 53
configs skipped: 2

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
i386                                defconfig
x86_64                            allnoconfig
s390                                defconfig
x86_64                           rhel-8.3-syz
s390                             allmodconfig
x86_64                           rhel-8.3-kvm
m68k                             allmodconfig
arc                              allyesconfig
arc                  randconfig-r043-20230118
alpha                            allyesconfig
s390                             allyesconfig
x86_64                        randconfig-a004
riscv                randconfig-r042-20230118
m68k                             allyesconfig
x86_64                        randconfig-a002
s390                 randconfig-r044-20230118
x86_64                        randconfig-a006
um                             i386_defconfig
x86_64                    rhel-8.3-kselftests
powerpc                          allmodconfig
i386                          randconfig-a012
x86_64                              defconfig
mips                             allyesconfig
um                           x86_64_defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
powerpc                           allnoconfig
i386                          randconfig-a014
ia64                             allmodconfig
arm                                 defconfig
i386                          randconfig-a001
i386                          randconfig-a003
arm                              allyesconfig
i386                             allyesconfig
x86_64                        randconfig-a015
arm64                            allyesconfig
x86_64                           allyesconfig
sh                               allmodconfig

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230118
arm                  randconfig-r046-20230118
hexagon              randconfig-r045-20230118
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a011
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a002
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
