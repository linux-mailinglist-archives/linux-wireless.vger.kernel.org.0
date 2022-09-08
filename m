Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E8F5B10D3
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 02:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiIHAPp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Sep 2022 20:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiIHAPm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Sep 2022 20:15:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E42CBB688
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 17:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662596141; x=1694132141;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=J0Y6cFlnO0sx32OIRmLhF8wd1a9vi//WtKdAnN5u1NI=;
  b=R+JC/WdztGowpuXlD9kNMXhrZSj0dObQ93fnTmePNdCb8Y7BTa5H+iK2
   CO6ux+RYLpLmi+F/rhwpqfoVM/iHGU95G8HziGjp96ql5e6gt107R9Zeh
   JXRo5LxOv/o32AtY8SvIUZbbcnzCguF5pAqTj4cJQ92UtYwW/Le81baWo
   5kTVyNN2s9+4Ru/1FgAAikXliktNH+4jOyPOn6VURUqtCDMXBlRCnWhJs
   1P098ibia/D+DMMfKurEpz5EOycfZWy7TYPaqV9MPWG5vkguabgX5mfyc
   rd0Qo+SJ0nSYeSCNOQcaGmHKce8J+4WD9j8O0292/sNUGoNQMaWhfXrmF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="358760556"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="358760556"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 17:15:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="565727990"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2022 17:15:39 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oW5Cl-000789-0R;
        Thu, 08 Sep 2022 00:15:39 +0000
Date:   Thu, 08 Sep 2022 08:15:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:for-next] BUILD SUCCESS
 4d8421f2dd88583cc7a4d6c2a5532c35e816a52a
Message-ID: <63193406.2IqFiCE6mdOgoUtC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 4d8421f2dd88583cc7a4d6c2a5532c35e816a52a  wifi: iwlwifi: don't spam logs with NSS>2 messages

elapsed time: 972m

configs tested: 138
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220906
riscv                randconfig-r042-20220906
powerpc                           allnoconfig
s390                 randconfig-r044-20220906
i386                                defconfig
sh                               allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
i386                          randconfig-a001
x86_64                              defconfig
m68k                             allyesconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                             allyesconfig
x86_64                        randconfig-a004
i386                          randconfig-a005
x86_64                               rhel-8.3
x86_64                        randconfig-a013
x86_64                          rhel-8.3-func
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
i386                          randconfig-a016
i386                          randconfig-a012
i386                          randconfig-a014
alpha                            allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arc                              allyesconfig
m68k                             allmodconfig
powerpc                 mpc837x_mds_defconfig
m68k                          atari_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                      rts7751r2d1_defconfig
sh                          landisk_defconfig
arm                           u8500_defconfig
ia64                             alldefconfig
arm                          iop32x_defconfig
powerpc                    sam440ep_defconfig
m68k                          amiga_defconfig
powerpc                      tqm8xx_defconfig
m68k                        stmark2_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
sh                                  defconfig
m68k                                defconfig
mips                     loongson1b_defconfig
xtensa                         virt_defconfig
ia64                         bigsur_defconfig
arm                        keystone_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                          multi_defconfig
arm                             pxa_defconfig
arc                          axs103_defconfig
mips                           gcw0_defconfig
parisc64                         alldefconfig
loongarch                           defconfig
loongarch                         allnoconfig
i386                          randconfig-c001
sparc                               defconfig
sh                     sh7710voipgw_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                             alldefconfig
powerpc                     ep8248e_defconfig
m68k                          hp300_defconfig
m68k                        m5272c3_defconfig
arm                          exynos_defconfig
sparc                             allnoconfig
arm                        cerfcube_defconfig
powerpc                      arches_defconfig
openrisc                 simple_smp_defconfig
powerpc                     asp8347_defconfig
sparc                            alldefconfig
arm                          pxa3xx_defconfig
arm                         s3c6400_defconfig
powerpc                     stx_gp3_defconfig
arm64                            alldefconfig
sh                           se7722_defconfig
sh                             sh03_defconfig
sh                           se7750_defconfig
s390                             allmodconfig
xtensa                       common_defconfig
sh                          r7785rp_defconfig
powerpc                     mpc83xx_defconfig
xtensa                generic_kc705_defconfig
csky                                defconfig
um                                  defconfig
sh                            titan_defconfig
arm                            mps2_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                          r7780mp_defconfig
arm                            qcom_defconfig
ia64                          tiger_defconfig
arc                              alldefconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220906
hexagon              randconfig-r041-20220906
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a006
i386                          randconfig-a004
arm                              alldefconfig
arm                    vt8500_v6_v7_defconfig
powerpc                        icon_defconfig
powerpc                      obs600_defconfig
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
riscv                randconfig-r042-20220907
hexagon              randconfig-r041-20220907
hexagon              randconfig-r045-20220907
s390                 randconfig-r044-20220907
x86_64                        randconfig-k001
powerpc                     tqm8540_defconfig
arm                           spitz_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                           ip22_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
