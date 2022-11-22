Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08F1634540
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 21:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbiKVULO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 15:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKVULN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 15:11:13 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF464A84E6
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 12:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669147872; x=1700683872;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4smjbYO8NuspzAfBppJOJf6T3kJkBGUVlKuLhSfbRc0=;
  b=QFQAfjT6XdTV9ydraKpAIA2DdNTWgrSbMhF2IgvAbAF9NuHbXAFdKt3x
   g2H4EW//JJ4KnWPcYTDqjtC9x/Gruc3ZU09qfmBeLht1W1zlCml6DQPUw
   +CDq4wV10ykO+1QqZiLsICw50Z3XVp3kPCeabcLJLtpYmacrrsbaVFCv2
   YRbpwZp7VSJweBVYkpxvdzYxoHxu9q4uDw8c2F2p5d5gINnBHAcXqQNn3
   mrtSE6EEZnWoir/y54bBlUg1lYUj8v8einUjzeHYtVwnjaxZUB1DwKYbT
   bIsHATY0j531SpJgfyKiDGtD9WB0zqnxn2Wr2K0GASYZ4e9zuoUmnw/06
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="313938072"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="313938072"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 12:11:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="747486920"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="747486920"
Received: from mkoshili-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.209.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 12:11:10 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 0/9] wifi: iwlwifi: updates intended for v6.2 2022-11-22 
Date:   Tue, 22 Nov 2022 22:10:31 +0200
Message-Id: <20221122201040.2618863-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

Here's the third set of patches intended for v6.2, with the fixes.
Resending all the patches since I think it'll make the review easier.
The fixes are only for two patches (1 and 4), the rest are unchanged.

It contains EHT adjustments for iwlwifi. It contains only iwlwifi
changes, all the required mac80211/cfg80211 changes are already merged
upstream.

As usual, I'm pushing this to a pending branch, for kbuild bot,
and will send a pull-request later.

Please review.

Thanks,
Gregory.

Abhishek Naik (1):
  wifi: iwlwifi: nvm: Update EHT capabilities for GL device

Ilan Peer (1):
  wifi: iwlwifi: mvm: Advertise EHT capabilities

Johannes Berg (4):
  wifi: iwlwifi: mvm: support 320 MHz PHY configuration
  wifi: iwlwifi: mvm: set HE PHY bandwidth according to band
  wifi: iwlwifi: mvm: advertise 320 MHz in 6 GHz only conditionally
  wifi: iwlwifi: nvm-parse: support A-MPDU in EHT 2.4 GHz

Miri Korenblit (1):
  wifi: iwlwifi: mvm: support PPE Thresholds for EHT

Mordechay Goodstein (2):
  wifi: iwlwifi: rs: add support for parsing max MCS per NSS/BW in 11be
  wifi: iwlwifi: mvm: add support for EHT 1K aggregation size

 .../net/wireless/intel/iwlwifi/fw/api/mac.h   |   6 +-
 .../wireless/intel/iwlwifi/fw/api/phy-ctxt.h  |  33 ++-
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  10 +-
 drivers/net/wireless/intel/iwlwifi/fw/rs.c    |   2 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   3 +
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.h |   3 +-
 .../wireless/intel/iwlwifi/iwl-modparams.h    |   1 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 235 ++++++++++++++++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 179 ++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  10 +-
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c |  54 ++--
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 125 +++++++++-
 12 files changed, 548 insertions(+), 113 deletions(-)

-- 
2.35.3

