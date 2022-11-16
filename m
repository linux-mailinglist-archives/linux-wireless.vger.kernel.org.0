Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC10062CE25
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 23:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbiKPW61 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 17:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiKPW60 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 17:58:26 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43B91B0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 14:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668639503; x=1700175503;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=B9r57ltMm8GN9gxcEMw/UujW9RtVWf2lti63miQev7Q=;
  b=SG5OFgc8q0tj5dmMqowSpAASyrqFSjzBOVqOwINskUxzAZMdXMKlaHEI
   8a2fe4S+C0sESgJcARswvJIiKpRwlzYgMeaD+zdY53f8c0Xpvl+civYpD
   pQMxa3PIVxLyqPJ89GkfKWtc2deaZ7ckAyirOyJY92eg3nKaW+2n7QAKw
   glhjZ0nwv4JcGq6kjqBtU/yP6WlXSFQuOeX5NiEAWV79Kb+H6BK5YQsuO
   SlGDyrjdvaomiFC7VyK1JYpbs6lQU5sYecnLopgtzzlDLjgE7ib+aSsbZ
   GNb3lVAqjZmyrEGRnkP8NRA4uSYYpn+WSVXNzWVRJahOwoGfsd9v9TWLs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="310320204"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="310320204"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 14:58:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="814265456"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="814265456"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Nov 2022 14:58:21 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ovRML-0002oP-0y;
        Wed, 16 Nov 2022 22:58:21 +0000
Date:   Thu, 17 Nov 2022 06:57:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 a1d0b9535cd8ce6f6c6870fcac1760cbaafc0f48
Message-ID: <63756aeb.JD6Lrym3eKTO6Zij%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: a1d0b9535cd8ce6f6c6870fcac1760cbaafc0f48  wifi: wl1251: switch to using gpiod API

elapsed time: 726m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                               defconfig
arc                                 defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allmodconfig
s390                                defconfig
sh                               allmodconfig
powerpc                           allnoconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
x86_64                              defconfig
s390                             allyesconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
ia64                             allmodconfig
i386                                defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a001
i386                          randconfig-a014
i386                          randconfig-a003
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arc                  randconfig-r043-20221116
x86_64                           rhel-8.3-kvm
i386                          randconfig-a016
i386                          randconfig-a005
x86_64                        randconfig-a004
arm                                 defconfig
x86_64                        randconfig-a002
i386                          randconfig-a012
x86_64                        randconfig-a006
x86_64                        randconfig-a011
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a004
hexagon              randconfig-r041-20221116
hexagon              randconfig-r045-20221116
x86_64                        randconfig-a001
i386                          randconfig-a006
riscv                randconfig-r042-20221116
x86_64                        randconfig-a003
i386                          randconfig-a011
x86_64                        randconfig-a005
s390                 randconfig-r044-20221116
x86_64                        randconfig-a016
x86_64                        randconfig-a012

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
