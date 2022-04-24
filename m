Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D84950CE33
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Apr 2022 03:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237476AbiDXB1F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Apr 2022 21:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiDXB1E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Apr 2022 21:27:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26B53916F
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 18:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650763445; x=1682299445;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GHcddqF3gAKV/zSB6V6I8Xiqd/pTDh5gqHWIkQy/4Fw=;
  b=OGm0uu0oJsGIWKVdAmKHrX0FB/haTs88vYn2WlRn4Ny79uc1BTNBO4Oj
   q9jg0C0rXIrfxuGnN7dT7IBhX2X/Htc17kZm6dqpQffbNLTFOjBWBRbO4
   AEw6SmrewVzLJ9j5xyGBYBbFRJ/vS/xCx6EKhO1Pik3b0DfMTtwiD91OA
   5PLFQHEXP83d7NM8fCMS8fyw78UdIB+opRKbCBuRt+8ksncEX2ndwJZUg
   +ee1aBXok5c2nJvMgGImNZ+5olTtjY4VC7RzIlf5FUQ+RVW2awkvUmklO
   ozl4rNz0Y5DKCYnAZzHrk6auzwX5UsOcejFob+GA5e/JfoC/tHir3+YZk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="325440686"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="325440686"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 18:24:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="729113800"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Apr 2022 18:24:03 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niQyo-0000o9-V3;
        Sun, 24 Apr 2022 01:24:02 +0000
Date:   Sun, 24 Apr 2022 09:23:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 9ebacb1e7e75f2a7a9745d42da7031d3a1741029
Message-ID: <6264a6ad.hJS+7ERLnkqWPbCi%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 9ebacb1e7e75f2a7a9745d42da7031d3a1741029  rtw88: pci: 8821c: Disable 21ce completion timeout

elapsed time: 736m

configs tested: 146
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                  maltasmvp_eva_defconfig
m68k                          atari_defconfig
arm                          badge4_defconfig
um                                  defconfig
arc                        vdk_hs38_defconfig
sh                        edosk7760_defconfig
arm                             rpc_defconfig
sh                            hp6xx_defconfig
openrisc                            defconfig
sh                               j2_defconfig
mips                    maltaup_xpa_defconfig
powerpc                    klondike_defconfig
arm                         lubbock_defconfig
powerpc                 mpc837x_mds_defconfig
xtensa                    xip_kc705_defconfig
arm                             ezx_defconfig
arm                         vf610m4_defconfig
sh                           sh2007_defconfig
m68k                            q40_defconfig
ia64                      gensparse_defconfig
sh                          lboxre2_defconfig
arm                      footbridge_defconfig
powerpc                     taishan_defconfig
h8300                               defconfig
powerpc                     tqm8541_defconfig
xtensa                  cadence_csp_defconfig
sparc64                          alldefconfig
m68k                         amcore_defconfig
sh                          landisk_defconfig
m68k                          sun3x_defconfig
arc                     nsimosci_hs_defconfig
arm                            xcep_defconfig
mips                  decstation_64_defconfig
m68k                          amiga_defconfig
xtensa                  audio_kc705_defconfig
arm                            zeus_defconfig
riscv                            allyesconfig
arm                            mps2_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220422
arm                  randconfig-c002-20220424
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220422
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
riscv                randconfig-c006-20220424
mips                 randconfig-c004-20220424
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220424
powerpc              randconfig-c003-20220424
powerpc                      walnut_defconfig
powerpc                     kilauea_defconfig
mips                           ip27_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      ppc64e_defconfig
powerpc                      pmac32_defconfig
powerpc                      acadia_defconfig
powerpc                     akebono_defconfig
powerpc                     ppa8548_defconfig
mips                        omega2p_defconfig
arm                          pxa168_defconfig
powerpc                    mvme5100_defconfig
arm                         hackkit_defconfig
arm                      tct_hammer_defconfig
arm                        vexpress_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220424
riscv                randconfig-r042-20220424
hexagon              randconfig-r045-20220424
hexagon              randconfig-r041-20220422
hexagon              randconfig-r045-20220422
s390                 randconfig-r044-20220422
riscv                randconfig-r042-20220422

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
