Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D21B58F19E
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Aug 2022 19:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiHJRcI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Aug 2022 13:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiHJRcB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Aug 2022 13:32:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41762832C3
        for <linux-wireless@vger.kernel.org>; Wed, 10 Aug 2022 10:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660152720; x=1691688720;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jHpgleogFGUQAAPHNM69fXlJCvMm8rUY3wR8cNCLG7Q=;
  b=VeIHypVYlyl1e6xiHYDIi66LYS73ffTX6c2OwXkCthiSuT4MxjqItUfv
   sf5sy5ypGM0i/Vyf0yxnnAz7apYCAap2TVgh/95dBmSjKP4lcYRUXOcZR
   fQ+kB6I/6zNf6YU9u10v7ETCktXT/Rz/I/B+QJSBpcTuj1+n1QYwPHNdQ
   MrxBkjUqg8DGJkrnMNvzZdn30EOM72fhkGegeOkL0OylQETU0bzGbLG7q
   +GTLBgOqHOqS8EWvkDQgutuHlB4gzgNUi9BzU1F5X7wq2tvfMJQsQmSNE
   kmhVj/bgq/VOChxd6AvBr1MmJRLi2C8cjqoDAPyhX7LS/WduqETrNdEZk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="271532612"
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="271532612"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 10:31:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="850912774"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 10 Aug 2022 10:31:58 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLpYj-0000Xf-1f;
        Wed, 10 Aug 2022 17:31:57 +0000
Date:   Thu, 11 Aug 2022 01:31:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:for-next] BUILD SUCCESS
 bc3c8fe3c79bcdae4d90e3726054fac5cca8ac32
Message-ID: <62f3eb80.3JntlPJ9zew7JO94%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: bc3c8fe3c79bcdae4d90e3726054fac5cca8ac32  plip: avoid rcu debug splat

elapsed time: 1191m

configs tested: 132
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                             allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
m68k                            q40_defconfig
mips                      loongson3_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
riscv                randconfig-r042-20220810
s390                 randconfig-r044-20220810
arc                  randconfig-r043-20220810
i386                          randconfig-c001
loongarch                           defconfig
loongarch                         allnoconfig
m68k                        m5407c3_defconfig
sh                ecovec24-romimage_defconfig
sh                          polaris_defconfig
arm                          badge4_defconfig
microblaze                          defconfig
s390                          debug_defconfig
arm                            qcom_defconfig
openrisc                         alldefconfig
mips                           jazz_defconfig
arm                          pxa3xx_defconfig
ia64                          tiger_defconfig
alpha                               defconfig
powerpc                 mpc834x_itx_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
sparc                             allnoconfig
sh                        sh7785lcr_defconfig
sh                          r7780mp_defconfig
sh                                  defconfig
powerpc                 mpc8540_ads_defconfig
mips                  maltasmvp_eva_defconfig
sparc                       sparc32_defconfig
sh                           se7722_defconfig
arc                     haps_hs_smp_defconfig
openrisc                       virt_defconfig
xtensa                generic_kc705_defconfig
sh                             sh03_defconfig
powerpc                     tqm8541_defconfig
arm                        mvebu_v7_defconfig
arm                        spear6xx_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-c001
arm                  randconfig-c002-20220810
mips                     decstation_defconfig
sparc64                             defconfig
sh                              ul2_defconfig
sparc                       sparc64_defconfig
arm64                            alldefconfig
m68k                        stmark2_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                            shmin_defconfig
sh                           se7751_defconfig
m68k                       bvme6000_defconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
s390                             allyesconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
arm                        mvebu_v5_defconfig
powerpc                      acadia_defconfig
powerpc                    ge_imp3a_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-k001
hexagon                          alldefconfig
arm                         hackkit_defconfig
mips                          rm200_defconfig
powerpc                          allyesconfig
mips                        qi_lb60_defconfig
powerpc                     tqm5200_defconfig
hexagon              randconfig-r041-20220810
hexagon              randconfig-r045-20220810

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
