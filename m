Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9B1561B06
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jun 2022 15:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbiF3NJz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jun 2022 09:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbiF3NJy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jun 2022 09:09:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDD21C935
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jun 2022 06:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656594593; x=1688130593;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VqZDNCJr2nY9IiRb5++/E5G6TPtijYbteqq1qy0n+oQ=;
  b=XepM+L3KQbsZuuI+DG9aPFdrn6jjhZbAN6pIQWd4f6d+QwW3qpyWEahD
   cLYU3AV9paJoFDrB5N2tVuheOGsPEQfT/i3kMrzu+xqjAPYzfL+aEQrQO
   DYK6Z8NjLGLco64Sk7MuVGTVX22nXHjd8N0W3nacKPFLP6PYftiY1X/Gt
   x7ht6Z+TLrylGeCP+FzKfL+O+PJQDwc4wI0WTgBc12n3cb2f6HGuTPhZy
   GtGmkAGNSXOcLs2PbstqIhQzF+Uh7k4a/7mkZCQbzR2wVE/7JhD+OK7Wc
   gaXUVFL81vGam0r7Yof1+87thwG+76IGo7Yj29Em0S+AYyf7hqe1jSv9D
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="262140895"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="262140895"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 06:09:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="541322502"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 30 Jun 2022 06:09:51 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6tvb-000CmI-0v;
        Thu, 30 Jun 2022 13:09:51 +0000
Date:   Thu, 30 Jun 2022 21:09:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless:for-next] BUILD SUCCESS
 8d70f33ed7207e82e51d5a4436c8ba2268a83b14
Message-ID: <62bda08c.VzXjIsY+coSNrzpC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 8d70f33ed7207e82e51d5a4436c8ba2268a83b14  wifi: cfg80211: Allow P2P client interface to indicate port authorization

elapsed time: 1524m

configs tested: 111
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                           imxrt_defconfig
arc                              alldefconfig
nios2                         10m50_defconfig
sh                            hp6xx_defconfig
nios2                         3c120_defconfig
m68k                       m5208evb_defconfig
powerpc                      ppc6xx_defconfig
m68k                       bvme6000_defconfig
powerpc                       maple_defconfig
sh                          sdk7780_defconfig
m68k                           virt_defconfig
m68k                         amcore_defconfig
sh                          landisk_defconfig
m68k                       m5475evb_defconfig
sh                               alldefconfig
mips                        vocore2_defconfig
sh                               j2_defconfig
arc                           tb10x_defconfig
riscv                    nommu_k210_defconfig
i386                             alldefconfig
sh                         apsh4a3a_defconfig
parisc                generic-64bit_defconfig
arm                             ezx_defconfig
mips                     loongson1b_defconfig
sh                          r7785rp_defconfig
powerpc                 mpc834x_itx_defconfig
sh                         microdev_defconfig
mips                          rb532_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-c001
arm                  randconfig-c002-20220629
ia64                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a004
x86_64                        randconfig-a015
x86_64                        randconfig-a013
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220629
s390                 randconfig-r044-20220629
riscv                randconfig-r042-20220629
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                  cavium_octeon_defconfig
powerpc                 mpc836x_mds_defconfig
arm                         s5pv210_defconfig
arm                            mmp2_defconfig
powerpc                      ppc64e_defconfig
mips                       rbtx49xx_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                     mpc512x_defconfig
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220629
hexagon              randconfig-r045-20220629
x86_64                        randconfig-a001
x86_64                        randconfig-a003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
