Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00294EFD54
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Apr 2022 01:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbiDBAA5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 20:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbiDBAAz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 20:00:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415ED83027
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 16:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648857545; x=1680393545;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mM+WXpDsO9dlensgqSDPC5m+B3WsxfJP2XPe+/7tK74=;
  b=El0q52vvUXSofvxPCkM8oyVs/olr4VHXK+ez0VXEOEjJPb8T8DatYTh/
   qWMIu6IDS7cV93zkPAV8biiczHU6ykqPtKxg9CHmsMd7ylr516BQTqjAd
   q2k5HI8agDVc+CB+WGd4SVlye46A4nar45BrE2wZKlnotAfE3UVR7RohI
   1c16kpa583mS3qO5WhfiuLX7y6WDDElbiRl+PR1jUAEOj6/59OhD5QoLK
   +RSIyEbDdHQLch87al3qKPwEk1OYwgcCErqgJxkFGDLml1vGYz6nfMaPC
   SfSb/AnjTbggLkH/0M9FNtlbzKlSWmdFcHzo6xS25+VDqCVuNKHG18Hma
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="260432925"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="260432925"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 16:59:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="567930866"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 01 Apr 2022 16:59:03 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naRAU-0001bs-KG;
        Fri, 01 Apr 2022 23:59:02 +0000
Date:   Sat, 02 Apr 2022 07:58:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:main] BUILD SUCCESS
 61a891efbb1099bb7bdcedfc50f802fabbe46a0e
Message-ID: <624791ac.k5x7GbUZlRfxkfp+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git main
branch HEAD: 61a891efbb1099bb7bdcedfc50f802fabbe46a0e  MAINTAINERS: mark wil6210 as orphan

elapsed time: 1005m

configs tested: 108
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
ia64                      gensparse_defconfig
powerpc                       maple_defconfig
powerpc64                        alldefconfig
m68k                       m5208evb_defconfig
m68k                       m5275evb_defconfig
sh                            titan_defconfig
arm                            zeus_defconfig
sparc                       sparc64_defconfig
powerpc                     mpc83xx_defconfig
arc                        nsimosci_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220331
ia64                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220331
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc              randconfig-c003-20220331
x86_64                        randconfig-c007
s390                 randconfig-c005-20220331
arm                  randconfig-c002-20220331
riscv                randconfig-c006-20220331
mips                 randconfig-c004-20220331
i386                          randconfig-c001
powerpc                     pseries_defconfig
arm                        neponset_defconfig
powerpc                      obs600_defconfig
powerpc                     akebono_defconfig
powerpc                    mvme5100_defconfig
arm                             mxs_defconfig
mips                      malta_kvm_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220331
hexagon              randconfig-r045-20220331
s390                 randconfig-r044-20220331
riscv                randconfig-r042-20220331

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
