Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709555A5983
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 04:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiH3CsH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 22:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiH3CsG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 22:48:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034D19DB5B
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661827686; x=1693363686;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=seYz4sGkNfnp762qyuRtIemMkecgeVbm8/ofFzqkt7Y=;
  b=Cc2XHoBbWHxXPKMHV0dTGUkt2tNwrghTeTSN6TQxvd92F/JpCfAgFWNC
   wlYlji7upoqz+LlLXD0IQDP/JzmTM3gGIAHbC4eLQPJ5kZcJhXMDwSs8H
   F7jB+VFQws079FC+1bXfNyqx1rskD2d1htJH98MoLZWA31x9ABTbEWIfM
   P0RgqPgyJ/y05d5v5IrBRxIiUsJ+MN9k4MUo1XPIT82/QwdTSuroeItEr
   Rdn6e/FkQUE+s+zMiBF+Vb70/lfZKSzsuYZDf7cGSVdriIcxJBl1YzEtR
   EI3fesO67hJMZm7/QQqmkvYT6SFsOQHKfLvLPQu/EeP60dieMqObRApAP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="321186932"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="321186932"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 19:48:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="641181971"
Received: from lkp-server02.sh.intel.com (HELO e45bc14ccf4d) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 29 Aug 2022 19:47:54 -0700
Received: from kbuild by e45bc14ccf4d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSrIA-0000SJ-0H;
        Tue, 30 Aug 2022 02:47:54 +0000
Date:   Tue, 30 Aug 2022 10:47:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:main] BUILD SUCCESS
 7c13844c3b7662976270996552eee3a0849afc3f
Message-ID: <630d7a4e.9O/aM1D63Eof66cQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 7c13844c3b7662976270996552eee3a0849afc3f  wifi: mac80211: fix potential deadlock in ieee80211_key_link()

elapsed time: 877m

configs tested: 56
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                  randconfig-r043-20220829
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
mips                             allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20220829
i386                 randconfig-a002-20220829
i386                 randconfig-a004-20220829
i386                 randconfig-a003-20220829
i386                 randconfig-a005-20220829
i386                 randconfig-a006-20220829
i386                             allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arm                                 defconfig
x86_64               randconfig-a002-20220829
x86_64               randconfig-a005-20220829
x86_64               randconfig-a006-20220829
x86_64               randconfig-a003-20220829
x86_64               randconfig-a001-20220829
x86_64               randconfig-a004-20220829
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm                              allyesconfig
ia64                             allmodconfig
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r041-20220829
hexagon              randconfig-r045-20220829
s390                 randconfig-r044-20220829
riscv                randconfig-r042-20220829
i386                 randconfig-a016-20220829
i386                 randconfig-a015-20220829
i386                 randconfig-a011-20220829
i386                 randconfig-a013-20220829
i386                 randconfig-a014-20220829
i386                 randconfig-a012-20220829
x86_64               randconfig-a013-20220829
x86_64               randconfig-a014-20220829
x86_64               randconfig-a011-20220829
x86_64               randconfig-a016-20220829
x86_64               randconfig-a012-20220829
x86_64               randconfig-a015-20220829

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
