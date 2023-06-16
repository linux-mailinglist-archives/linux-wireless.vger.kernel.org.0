Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689117327FB
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 08:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241250AbjFPGzL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 02:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243788AbjFPGyz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 02:54:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1341FF9
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 23:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686898494; x=1718434494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=soANGHM0tuBnWIyP/n9itpqgSiPqBhfG//l77/K0XCc=;
  b=DCuesWunb1RBiO3uRqGRFRaW+gcZeNcuExxiLXsNAK55m7s7TaCB75P0
   MoLZz3+uSjJoFFX4eGkw0NMZU5HIX89lQYy7eL4QnVAfd9rPoW+UzxoIs
   M+X6caHxFqlWmZvFLwgYNeYWFFr/lE1QVi7JJOzUJBm8bnmlg89Bsc6fY
   CTipolxNm50qaRfVlbxVXnBtzEsVORwglEUnlD0hRvueBdeOKyZm9v/L8
   PJolk4JzJk/eT+JBbSs2eu/IOB3hHH7/JGZpomRUuh1z2ZPSg0O4MELI1
   95SlBIqsr35VMpLVYzHU8dTqXzdcs4SHPbpPhYKGHuclZ6ioMTbSeGQGj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425078892"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425078892"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802720143"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="802720143"
Received: from ereznaim-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.237.118])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:52 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/20] wifi: cfg80211: ignore invalid TBTT info field types
Date:   Fri, 16 Jun 2023 09:54:02 +0300
Message-Id: <20230616094949.7865606ffe94.I7ff28afb875d1b4c39acd497df8490a7d3628e3f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230616065409.633290-1-gregory.greenman@intel.com>
References: <20230616065409.633290-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

The TBTT information field type must be zero. This is only changed in
the 802.11be draft specification where the value 1 is used to indicate
that only the MLD parameters are included.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/linux/ieee80211.h | 2 ++
 net/wireless/scan.c       | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 5dfed1a6625c..47ddc65b443b 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4481,6 +4481,8 @@ static inline bool for_each_element_completed(const struct element *element,
 #define IEEE80211_AP_INFO_TBTT_HDR_FILTERED			0x04
 #define IEEE80211_AP_INFO_TBTT_HDR_COLOC			0x08
 #define IEEE80211_AP_INFO_TBTT_HDR_COUNT			0xF0
+#define IEEE80211_TBTT_INFO_TYPE_TBTT				0
+#define IEEE80211_TBTT_INFO_TYPE_MLD				1
 #define IEEE80211_TBTT_INFO_OFFSET_BSSID_BSS_PARAM		9
 #define IEEE80211_TBTT_INFO_OFFSET_BSSID_SSSID_BSS_PARAM	13
 
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index d9abbf123ad1..2212e6d24204 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -629,6 +629,13 @@ static int cfg80211_parse_colocated_ap(const struct cfg80211_bss_ies *ies,
 		if (end - pos < count * length)
 			break;
 
+		if (u8_get_bits(ap_info->tbtt_info_hdr,
+				IEEE80211_AP_INFO_TBTT_HDR_TYPE) !=
+		    IEEE80211_TBTT_INFO_TYPE_TBTT) {
+			pos += count * length;
+			continue;
+		}
+
 		/*
 		 * TBTT info must include bss param + BSSID +
 		 * (short SSID or same_ssid bit to be set).
-- 
2.38.1

