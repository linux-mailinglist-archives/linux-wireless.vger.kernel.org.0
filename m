Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206C8234C03
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jul 2020 22:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgGaUND (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jul 2020 16:13:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:39403 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726644AbgGaUNC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jul 2020 16:13:02 -0400
IronPort-SDR: NIarx5GSI193dSpu1j4wy06/VeTfyyGa1EyvuwjxxrkAH6cz5xHxlmUlrbCdMY7s2GlqEvUyh1
 p5wntZwce++Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="151832413"
X-IronPort-AV: E=Sophos;i="5.75,419,1589266800"; 
   d="scan'208";a="151832413"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 13:12:54 -0700
IronPort-SDR: 23DRocfzefcrppvygLfoz137C/fu72XRLv+DV3cZVnQgH/YityakkqUT5saJsCaaYKR/OwtoJo
 2RfaQRCssaFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,419,1589266800"; 
   d="scan'208";a="313914404"
Received: from lkp-server01.sh.intel.com (HELO e21119890065) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jul 2020 13:12:52 -0700
Received: from kbuild by e21119890065 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k1bOe-00006n-32; Fri, 31 Jul 2020 20:12:52 +0000
Date:   Sat, 01 Aug 2020 04:11:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:master] BUILD SUCCESS
 c8ad010665c0b85c6a35466b2159e907b8dd85d1
Message-ID: <5f247b0e.RJcAxmiLGTnNQkKz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git  master
branch HEAD: c8ad010665c0b85c6a35466b2159e907b8dd85d1  mac80211: warn only once in check_sdata_in_driver() at each caller

elapsed time: 724m

configs tested: 66
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a005-20200731
i386                 randconfig-a004-20200731
i386                 randconfig-a006-20200731
i386                 randconfig-a002-20200731
i386                 randconfig-a001-20200731
i386                 randconfig-a003-20200731
x86_64               randconfig-a015-20200731
x86_64               randconfig-a014-20200731
x86_64               randconfig-a016-20200731
x86_64               randconfig-a012-20200731
x86_64               randconfig-a013-20200731
x86_64               randconfig-a011-20200731
i386                 randconfig-a016-20200731
i386                 randconfig-a012-20200731
i386                 randconfig-a014-20200731
i386                 randconfig-a015-20200731
i386                 randconfig-a011-20200731
i386                 randconfig-a013-20200731
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
