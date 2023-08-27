Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92667899EF
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Aug 2023 02:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjH0AjN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Aug 2023 20:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjH0AjF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Aug 2023 20:39:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804BC124
        for <linux-wireless@vger.kernel.org>; Sat, 26 Aug 2023 17:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693096743; x=1724632743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=maLv8T71t6az0MXeBHNv3vZujgwO6W/8hNucNN8Ujg0=;
  b=Oi36PENVGH9iXvGPwLSQBPrcrVf+ldpvraK5Ys96WW+4f0SH96vd/74H
   2pKaOfU2jut7oZYf1c486rxmaV7jfkLs3uRcijjo1TRD2SshFwrm2wTqS
   gOpMins1OQK4l1QIzMjtlSxcUky/ePNdXmrcTylT5j1IoBeByBWwQyc4c
   qdvHZin1ceqCReEchSwnVItzK3EsHMbjv7yfMU/msBGIYF91+yq0uuh7K
   Vy7DPsKeCJdHxNcI00zn1TOWJjFCefseBhhhU1wFGGaOqdFLCEMHuCg7l
   ynPxbhrIIL5xPpH/T5GBAnfNHSE8wkFrcKnlvpQilZddfCq9xddok3inm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="374877055"
X-IronPort-AV: E=Sophos;i="6.02,204,1688454000"; 
   d="scan'208";a="374877055"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2023 17:39:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="984494335"
X-IronPort-AV: E=Sophos;i="6.02,204,1688454000"; 
   d="scan'208";a="984494335"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 26 Aug 2023 17:39:02 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qa3nx-0005Dh-13;
        Sun, 27 Aug 2023 00:39:01 +0000
Date:   Sun, 27 Aug 2023 08:38:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/2] wifi: ath9k_htc: use module_usb_driver
Message-ID: <202308270817.fkin6iCi-lkp@intel.com>
References: <20230826200929.9756-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826200929.9756-1-rosenp@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Rosen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kvalo-ath/ath-next]
[also build test WARNING on wireless-next/main wireless/main linus/master v6.5-rc7 next-20230825]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/wifi-purelifi-use-module_usb_driver/20230827-041155
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git ath-next
patch link:    https://lore.kernel.org/r/20230826200929.9756-1-rosenp%40gmail.com
patch subject: [PATCH 1/2] wifi: ath9k_htc: use module_usb_driver
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230827/202308270817.fkin6iCi-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230827/202308270817.fkin6iCi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308270817.fkin6iCi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath9k/hif_usb.c:1525:26: warning: 'ath9k_hif_usb_driver' defined but not used [-Wunused-variable]
    1525 | static struct usb_driver ath9k_hif_usb_driver = {
         |                          ^~~~~~~~~~~~~~~~~~~~


vim +/ath9k_hif_usb_driver +1525 drivers/net/wireless/ath/ath9k/hif_usb.c

fb9987d0f748c9 Sujith 2010-03-17  1524  
fb9987d0f748c9 Sujith 2010-03-17 @1525  static struct usb_driver ath9k_hif_usb_driver = {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
