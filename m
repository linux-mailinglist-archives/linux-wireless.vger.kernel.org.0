Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2600F7187CB
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 18:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjEaQvQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 12:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjEaQvM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 12:51:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393E4132
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 09:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685551871; x=1717087871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ipDvFP0bss/pIkb/lfULH7/Q0damxzXHQu2P1ipBHg=;
  b=QD1dF/Hpw30ZXzYweHWx6m/bH/nVhKADIHWFHqjVxBHchZWfBwVHQbwv
   U79L4APSD3/DMqVHTLzqoEKlduycXYfaxr6ADWmiuSNzPz+W+DWjpxzvg
   K+JZby7/nXYAfK2zA5Y9HZ3Daga9CJEg5FLep9HS5zohacAHwHA2MXO4K
   SdoDxMaCtQSEUkyuoCqEJrZrne28b8+kH+g1rvriePtJpKsgsx5zo1fK6
   rpzmBv/EuzyDUZ2YHSijRgjAe6sHMhYGe6+9H6SDenucZe+DlwcS/WOQe
   9bez2csMumMFjvtJnanybC+Sw8BqW+NKwN2JrvCYLMqxarqAiUNrDpoK/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="339890376"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="339890376"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="706987947"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="706987947"
Received: from amilman1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.102])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:23 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/14] wifi: iwlwifi: fix Bz checksum start/result offset
Date:   Wed, 31 May 2023 19:49:53 +0300
Message-Id: <20230531194629.d3afbc073f74.I925d15b41c7c87bc2b44432ac7cd4ec03b43b8b1@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531165006.273284-1-gregory.greenman@intel.com>
References: <20230531165006.273284-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The checksum start/result offset should never be longer
than the bits we have in the mask now (nothing should put
the checksum at the end of a frame), but we should really
match the hardware definition for these bits.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index 97edf5477ba7..c2fd467bb987 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -178,8 +178,8 @@ enum iwl_tx_offload_assist_flags_pos {
 #define IWL_TX_CMD_OFFLD_IP_HDR_MASK	0x3f
 
 enum iwl_tx_offload_assist_bz {
-	IWL_TX_CMD_OFFLD_BZ_RESULT_OFFS		= 0x000003ff,
-	IWL_TX_CMD_OFFLD_BZ_START_OFFS		= 0x001ff800,
+	IWL_TX_CMD_OFFLD_BZ_RESULT_OFFS		= 0x000007ff,
+	IWL_TX_CMD_OFFLD_BZ_START_OFFS		= 0x003ff800,
 	IWL_TX_CMD_OFFLD_BZ_MH_LEN		= 0x07c00000,
 	IWL_TX_CMD_OFFLD_BZ_MH_PAD		= 0x08000000,
 	IWL_TX_CMD_OFFLD_BZ_AMSDU		= 0x10000000,
-- 
2.38.1

