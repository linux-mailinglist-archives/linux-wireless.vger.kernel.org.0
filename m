Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2A75F829A
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Oct 2022 04:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJHC40 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Oct 2022 22:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJHC4Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Oct 2022 22:56:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49485E567
        for <linux-wireless@vger.kernel.org>; Fri,  7 Oct 2022 19:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665197784; x=1696733784;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=wREN3D+IK2+Z3O6Z3cohEKoQEPbgxtmn1DzpXFmDAD8=;
  b=A+7C7Sx2jPM8Jt1HXQ8B+BZ172+r3cRPMKORddrg3/7j5aqmMepHu56Z
   a8xWXYOEEsyf+yty/lE4y2oMaPVQu8919NZi3BMCWAr/qbzunHEuSoS++
   eyVf/E3pAcPuQdO2/5ipS0yZ6Fj+q01LhtekR47qqRxIAlIr/cw9eksgm
   LkuRIdKoN19WPQMRG8qLcpn9WcOkmF6IUH8Rs+trqFVf8sA+WhOgIXUiZ
   Yqll6cGAszFwhCkBJlFdia4FNMxk03myMPmfZ1/7kJEUiT49THdpLjvwo
   Dwlpx95CbiTf05JcpY6DJpwawtj23SeOPSy+sDvR1TZu7mnaV2iZYDf0T
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="302608367"
X-IronPort-AV: E=Sophos;i="5.95,168,1661842800"; 
   d="scan'208";a="302608367"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 19:56:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="656282536"
X-IronPort-AV: E=Sophos;i="5.95,168,1661842800"; 
   d="scan'208";a="656282536"
Received: from lkp-server01.sh.intel.com (HELO 3c15167049b7) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 Oct 2022 19:56:20 -0700
Received: from kbuild by 3c15167049b7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oh00i-0001lb-0F;
        Sat, 08 Oct 2022 02:56:20 +0000
Date:   Sat, 08 Oct 2022 10:56:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:main] BUILD SUCCESS
 0ff57171d6d225558c81a69439d5323e35b40549
Message-ID: <6340e6d0.mdjeMIDfO7WpwLjL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 0ff57171d6d225558c81a69439d5323e35b40549  cfg80211: Update Transition Disable policy during port authorization

elapsed time: 720m

configs tested: 91
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
i386                                defconfig
i386                 randconfig-a011-20221003
i386                 randconfig-a012-20221003
s390                             allyesconfig
x86_64                               rhel-8.3
i386                 randconfig-a013-20221003
i386                 randconfig-a015-20221003
i386                 randconfig-a016-20221003
i386                 randconfig-a014-20221003
arm                                 defconfig
x86_64                           allyesconfig
riscv                randconfig-r042-20221007
x86_64               randconfig-a011-20221003
arc                  randconfig-r043-20221007
x86_64               randconfig-a015-20221003
riscv                randconfig-r042-20221003
powerpc                           allnoconfig
x86_64               randconfig-a014-20221003
arc                  randconfig-r043-20221003
x86_64               randconfig-a012-20221003
x86_64               randconfig-a013-20221003
x86_64               randconfig-a016-20221003
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
mips                             allyesconfig
arm                              allyesconfig
s390                 randconfig-r044-20221007
s390                 randconfig-r044-20221003
arm64                            allyesconfig
i386                             allyesconfig
powerpc                     ep8248e_defconfig
sh                  sh7785lcr_32bit_defconfig
sparc64                          alldefconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
alpha                            allyesconfig
ia64                             allmodconfig
um                               alldefconfig
powerpc                     sequoia_defconfig
sh                          kfr2r09_defconfig
arc                              allyesconfig
m68k                             allmodconfig
arm                  randconfig-c002-20221002
x86_64                        randconfig-c001
i386                          randconfig-c001
arm                           sunxi_defconfig
sparc                       sparc64_defconfig
parisc                generic-64bit_defconfig
arm                             ezx_defconfig
arc                  randconfig-r043-20221002
mips                 randconfig-c004-20221002
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
x86_64               randconfig-a003-20221003
x86_64               randconfig-a002-20221003
x86_64               randconfig-a001-20221003
i386                 randconfig-a004-20221003
x86_64               randconfig-a004-20221003
i386                 randconfig-a003-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a001-20221003
hexagon              randconfig-r041-20221003
i386                 randconfig-a005-20221003
i386                 randconfig-a006-20221003
x86_64               randconfig-a005-20221003
hexagon              randconfig-r045-20221007
x86_64               randconfig-a006-20221003
hexagon              randconfig-r041-20221007
hexagon              randconfig-r045-20221003
x86_64                        randconfig-k001
powerpc                 mpc832x_mds_defconfig
hexagon              randconfig-r041-20221002
hexagon              randconfig-r045-20221002
riscv                randconfig-r042-20221002
s390                 randconfig-r044-20221002

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
