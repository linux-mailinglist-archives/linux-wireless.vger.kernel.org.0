Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F038F571D66
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jul 2022 16:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiGLOyh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Jul 2022 10:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiGLOyc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Jul 2022 10:54:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49926B7D55
        for <linux-wireless@vger.kernel.org>; Tue, 12 Jul 2022 07:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657637666; x=1689173666;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lqsHms86NDFe0/R28gzhK7uDao2MYK6UbeTa9CX9jAE=;
  b=I7bd+IcNQW4l8JeANyBdxPXbphY0cu0FOi7+0z/hfbsjqnpODOBa/aIE
   x98R24A80wydiZ9ELyJJ362sXkwJaM6Uk4W46hqhSzOuiB6RrhYyaX9cS
   KXEpw4gDJEQr+5lh9mnjBd6XJgmN0pNLFx5tCRwIDwCCvY/fWNfgS31P0
   uC7Yh9JfOudr7AtDiKa15cKDeJkeho2/2zQhoFxIRy3jDKfgzhBGximya
   7nM28iVOL7OAA2DyHJPbl1qf9RSwsd2zhwL7TjSEOSADH7Vmbh++MZXaU
   KqizYFT6NUhf07FVnkRFDwWEfSnZvLWclEafhujTkMHI+pxcwRaOVJ/dl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="283707473"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="283707473"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 07:54:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="570226396"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Jul 2022 07:54:20 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBHHI-0002Jf-2c;
        Tue, 12 Jul 2022 14:54:20 +0000
Date:   Tue, 12 Jul 2022 22:54:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless:for-next] BUILD SUCCESS
 50e2ab39291947b6c6c7025cf01707c270fcde59
Message-ID: <62cd8b1a.6e5vHRTykUTjkKHG%lkp@intel.com>
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
branch HEAD: 50e2ab39291947b6c6c7025cf01707c270fcde59  wifi: mac80211: fix queue selection for mesh/OCB interfaces

elapsed time: 1702m

configs tested: 80
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
um                               alldefconfig
arm                           tegra_defconfig
sh                     magicpanelr2_defconfig
sh                          r7785rp_defconfig
arm                         nhk8815_defconfig
s390                       zfcpdump_defconfig
sh                   sh7724_generic_defconfig
arm                        mvebu_v7_defconfig
sh                          polaris_defconfig
xtensa                generic_kc705_defconfig
sh                   secureedge5410_defconfig
arm                         lpc18xx_defconfig
sh                         ap325rxa_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                          rb532_defconfig
arc                     nsimosci_hs_defconfig
powerpc                 linkstation_defconfig
sh                          rsk7201_defconfig
arm                       omap2plus_defconfig
sh                            shmin_defconfig
sh                           se7343_defconfig
sh                            migor_defconfig
sh                         microdev_defconfig
mips                            gpr_defconfig
arc                           tb10x_defconfig
parisc                generic-32bit_defconfig
mips                        vocore2_defconfig
ia64                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
sh                               allmodconfig
powerpc                          allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a016
i386                          randconfig-a012
riscv                randconfig-r042-20220710
arc                  randconfig-r043-20220710
s390                 randconfig-r044-20220710
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                              defconfig

clang tested configs:
mips                          malta_defconfig
mips                        qi_lb60_defconfig
arm                        neponset_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220710
hexagon              randconfig-r045-20220710

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
