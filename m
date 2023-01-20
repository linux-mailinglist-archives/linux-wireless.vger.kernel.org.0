Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CB2674D86
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jan 2023 07:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjATG5u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Jan 2023 01:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjATG5t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Jan 2023 01:57:49 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F564230
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 22:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674197866; x=1705733866;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VaQHAueuwYRd3OQVg1mwsKXWw0ugHxT/AkI25NGmqkE=;
  b=NXlhM3calO/C6Km4OhE+eP5lPmPudGqmYTIEi/qtJ9KaRvoFjZ1LcIhv
   Dz/A0FGxQFghBOMjXt2MRW5Hu/bS/OjBCGQzyhiy0wSL44NU6uR1f+hgx
   Pd4sOuceC3b5H2N5IsGIdU8a6xxOlsQOmLzdielF4GdFY78uC1B2SElTK
   L5bRtehXEhUUPLd2zY+eSF6M21mRII6HeBWW4SZGbmjptjqDSqyvh3Mbv
   QY4Zyf6Eb84gwjX4QILk1c0w0taUc/O2W6xzS80d4E+XyvqprJdAw+BOP
   3DQRStnsZKb7jEt0H+K3LAlsfwPTkNCQfWUm49VD7Vzo3hQTts8rxsFEF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="411749996"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="411749996"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 22:57:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="690949207"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="690949207"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 19 Jan 2023 22:57:44 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIlLM-0002II-03;
        Fri, 20 Jan 2023 06:57:44 +0000
Date:   Fri, 20 Jan 2023 14:57:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 4ca69027691a0039279b64cfa0aa511d9c9fde59
Message-ID: <63ca3b44.Tp1OJL2FyeMlT3N0%lkp@intel.com>
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
branch HEAD: 4ca69027691a0039279b64cfa0aa511d9c9fde59  wifi: wireless: deny wireless extensions on MLO-capable devices

elapsed time: 724m

configs tested: 73
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                               defconfig
arc                                 defconfig
powerpc                           allnoconfig
s390                                defconfig
um                             i386_defconfig
x86_64                            allnoconfig
um                           x86_64_defconfig
s390                             allmodconfig
sh                               allmodconfig
s390                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
mips                             allyesconfig
powerpc                          allmodconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arm                                 defconfig
x86_64                               rhel-8.3
m68k                             allyesconfig
x86_64                           allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
arm64                            allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a013
arm                              allyesconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                                defconfig
x86_64                        randconfig-a015
ia64                             allmodconfig
arm                  randconfig-r046-20230119
arc                  randconfig-r043-20230119
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
sh                           se7722_defconfig
powerpc                  storcenter_defconfig
sh                          rsk7269_defconfig
powerpc                       maple_defconfig
ia64                                defconfig
sh                        sh7757lcr_defconfig
openrisc                  or1klitex_defconfig
sh                          sdk7786_defconfig
parisc                              defconfig
xtensa                          iss_defconfig
sh                         ecovec24_defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a001
s390                 randconfig-r044-20230119
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20230119
riscv                randconfig-r042-20230119
hexagon              randconfig-r041-20230119
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
