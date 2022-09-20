Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0E15BD8A4
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 02:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiITAJx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 20:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiITAJv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 20:09:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAACB15A13
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 17:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663632584; x=1695168584;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Leu/uINyzMF99r0kXDxjqu7CpWw+NxbfQ7IQZUE1piQ=;
  b=VqvFWgDoyGK9QHAbi5vc6H6X4sT3687L3Hh1Hoo43xHewxfQ0Y7oJsuM
   WlVxAuBsD/mGPafE7Iv8XXpeqilXkP/4PRXk+DUd81oyEjQF/3VR0zYo1
   E7M3ZTv6/u77Zqx3vccudIl1/pMq5KUb97AGyQAktcyCRxmzvd6UHD5gh
   vOjhIQzLAK2fQmMzLhIrretHtipAgLGx3LhdxgOWAGdFf7S/LUGnW1wVz
   G8o53XvZsLDOG/8a6/VqbOnSQYICn1w14BG65YuX/8AM9S/FqWNBYCdMB
   SxxYgoWU/fCZziR5S3B6ObN+XEN+DJq3NBx7hknd43oq3vdHniQqGd4Kj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="298279912"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="298279912"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 17:09:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="596296147"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Sep 2022 17:09:42 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaQpZ-0002K9-1p;
        Tue, 20 Sep 2022 00:09:41 +0000
Date:   Tue, 20 Sep 2022 08:09:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:pending] BUILD SUCCESS
 364fbc5708915a48ac26ab226858b925418ac493
Message-ID: <632904a8.CFR19kdcTYD+9Emj%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: 364fbc5708915a48ac26ab226858b925418ac493  Merge tag 'mt76-for-kvalo-2022-09-15' of https://github.com/nbd168/wireless into pending

elapsed time: 804m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
arc                  randconfig-r043-20220919
s390                 randconfig-r044-20220919
s390                             allmodconfig
arc                              allyesconfig
x86_64               randconfig-a012-20220919
powerpc                           allnoconfig
riscv                randconfig-r042-20220919
i386                 randconfig-a013-20220919
x86_64               randconfig-a016-20220919
i386                 randconfig-a012-20220919
i386                                defconfig
mips                             allyesconfig
s390                                defconfig
x86_64               randconfig-a011-20220919
i386                 randconfig-a011-20220919
powerpc                          allmodconfig
x86_64                          rhel-8.3-func
alpha                            allyesconfig
x86_64               randconfig-a014-20220919
s390                             allyesconfig
x86_64               randconfig-a015-20220919
x86_64                         rhel-8.3-kunit
i386                 randconfig-a014-20220919
x86_64               randconfig-a013-20220919
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a016-20220919
x86_64                           rhel-8.3-syz
i386                 randconfig-a015-20220919
x86_64                           rhel-8.3-kvm
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
ia64                             allmodconfig
i386                             allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
hexagon              randconfig-r041-20220919
x86_64               randconfig-a003-20220919
hexagon              randconfig-r045-20220919
x86_64               randconfig-a001-20220919
i386                 randconfig-a001-20220919
i386                 randconfig-a006-20220919
i386                 randconfig-a002-20220919
x86_64               randconfig-a005-20220919
x86_64               randconfig-a002-20220919
i386                 randconfig-a003-20220919
x86_64               randconfig-a004-20220919
i386                 randconfig-a004-20220919
x86_64               randconfig-a006-20220919
i386                 randconfig-a005-20220919

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
