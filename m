Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F476BB3D5
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 14:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjCONFU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 09:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCONFS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 09:05:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEF020D29
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 06:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678885516; x=1710421516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UpQUpBxxyaEjLoFqHt0eaV3ezGS6tMZlfewo6xWRFnU=;
  b=HvoaSWiMc9hPlotka+o7YE53Lfo0Yoh68nZ0Joc8WXdlHeXgJIQOg50S
   lbgN8slA/n76w7X5n4rzv8sXmpcGBtjnUUgrj8OZkZzAY1FER4BYajwJg
   fDjWIuuDFjLRs8CDjkCfuabQp7z8U6sD4JTIS8l6voBWL7uhGr7Co+fBT
   gltgEUT/AhojFQolReNMq7VclDefm4DYEaNcanDkH2Y6WpeIe64aO9Tmb
   iEP1FHrwOmGDR8jRA1srLymh3KrAQuLT7Q33WqFP9lO6KVeMb5ETpmiPF
   WbpJbRON4jEfr5V8x11WXUH3P3l9KrKrxhG430+kY9QoobDZjo9Yhpnxv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="318090075"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="318090075"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 06:04:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="748426245"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="748426245"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 15 Mar 2023 06:04:46 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcQo9-0007gR-3D;
        Wed, 15 Mar 2023 13:04:46 +0000
Date:   Wed, 15 Mar 2023 21:04:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, johannes@sipsolutions.net,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH 7/7] mac80211: implement support for yet another mesh
 A-MSDU format
Message-ID: <202303152012.0WeM62qN-lkp@intel.com>
References: <20230314095956.62085-7-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314095956.62085-7-nbd@nbd.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Felix,

I love your patch! Perhaps something to improve:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.3-rc2 next-20230315]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Felix-Fietkau/wifi-mac80211-fix-race-in-mesh-sequence-number-assignment/20230314-180138
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20230314095956.62085-7-nbd%40nbd.name
patch subject: [PATCH 7/7] mac80211: implement support for yet another mesh A-MSDU format
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/c393207cf2199fbd0a5aaf929ddccdec98ef66bc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Felix-Fietkau/wifi-mac80211-fix-race-in-mesh-sequence-number-assignment/20230314-180138
        git checkout c393207cf2199fbd0a5aaf929ddccdec98ef66bc
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303152012.0WeM62qN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/driver-api/80211/mac80211-advanced:214: ./net/mac80211/sta_info.h:628: WARNING: Unexpected indentation.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
