Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76DB57F891
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jul 2022 06:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiGYEHA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jul 2022 00:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiGYEG7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jul 2022 00:06:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75C4EE0C
        for <linux-wireless@vger.kernel.org>; Sun, 24 Jul 2022 21:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658722018; x=1690258018;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xPiPzoMVlVXkAF3nJ45p2a7hSPTI8h1eae6rpHCrxfc=;
  b=mDxDdbjjh+bH3hU6CxS7aM+sEKUQ1V3dTbk/Lu8EQ1ar0jzjIBX8sF7s
   Zjjflj5bkv6Mi73xQaehUSF5fRiuJOkizlyRpnxOH2U3tOlbqClZ9g5sf
   GWGTHLyMzzsaOP4p6PgEmgyaHKkvnR88FBwdaDdgF+hKZw1/Gt7yP/St8
   tlgzuvUqar7aNrJaaL7WZConpnGd+Tx6R6GofTtANXr24RYtu6oFzdisy
   HXjbkd/yJ5oM1F20gDWCHGaKrzmuEoUxJWVICTZ0zNep8sA52xUdi19EW
   nEn3czgWqDHYCQehRTyP1bxf+dhWp3/1HP08vIW8NgMErj80RMXwzqxpq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="373908164"
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="373908164"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 21:06:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="741689601"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jul 2022 21:06:57 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFpMu-0004hr-2M;
        Mon, 25 Jul 2022 04:06:56 +0000
Date:   Mon, 25 Jul 2022 12:06:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:mld] BUILD SUCCESS
 f69d4554386b4d2b56ca883fb97c92d64e188615
Message-ID: <62de16c9.e5Mp0H3HvOdGpkgX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git mld
branch HEAD: f69d4554386b4d2b56ca883fb97c92d64e188615  wifi: mac80211: properly set old_links when removing a link

elapsed time: 726m

configs tested: 87
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-c001
parisc64                         alldefconfig
arm                        clps711x_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                       imx_v6_v7_defconfig
arm                       aspeed_g5_defconfig
sh                      rts7751r2d1_defconfig
sh                 kfr2r09-romimage_defconfig
arm                          lpd270_defconfig
mips                         cobalt_defconfig
arm                            lart_defconfig
sh                           se7724_defconfig
powerpc                    sam440ep_defconfig
sh                     sh7710voipgw_defconfig
s390                                defconfig
sh                          sdk7786_defconfig
riscv                            allyesconfig
powerpc                    amigaone_defconfig
xtensa                generic_kc705_defconfig
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a013
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
s390                 randconfig-r044-20220724
arc                  randconfig-r043-20220724
riscv                randconfig-r042-20220724
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                       cns3420vb_defconfig
powerpc                     powernv_defconfig
mips                            e55_defconfig
mips                     loongson2k_defconfig
mips                        omega2p_defconfig
mips                          malta_defconfig
arm                          pxa168_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                         hackkit_defconfig
mips                         tb0219_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220724
hexagon              randconfig-r045-20220724

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
