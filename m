Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025FF732800
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 08:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjFPGzR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 02:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243186AbjFPGzH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 02:55:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481E21FE8
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 23:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686898505; x=1718434505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uY4zcMH/bjWULtd9Ek31fGfLPC+P0QkZW10T3FH31nQ=;
  b=J6Ed5CB/nWhtAVSGa7TolZMjQqqJZ79w3Ric3OZU/Y/rPgle2S4ZgEwk
   YBnknXGzfNePugXHKoHaopOxY8kStCMiZjOWO9zynFstW5jELs1jnQV6s
   xtGAvfSz7xR/1pUndfla9CVY6aqzIcAYH+EVKrRR/tQUEy31BwCNp3xSd
   aZGyzk1eZ3MVB78XwsYWcnk49bLm2CpNzAmoNTrAbTFgCN1AmMyyyZAOn
   LgevG1AVwFXLceWQoCzWw3H6tUEu41UiabpqqyMC0HkPwY9dX7ylAvEyP
   hhS6eWCvVrl+5HU+uUf329+06ntnZt9mfmmOfj6XsjfjdBFDbycDHb11q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425078921"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425078921"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:55:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802720356"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="802720356"
Received: from ereznaim-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.237.118])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:55:03 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 18/20] wifi: mac80211: Rename multi_link
Date:   Fri, 16 Jun 2023 09:54:07 +0300
Message-Id: <20230616094949.b11370d3066a.I34280ae3728597056a6a2f313063962206c0d581@changeid>
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

From: Ilan Peer <ilan.peer@intel.com>

As a preparation to support Reconfiguration Multi Link
element, rename 'multi_link' and 'multi_link_len' fields
in 'struct ieee802_11_elems' to 'ml_basic' and 'ml_basic_len'.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/ieee80211_i.h |  9 +++++----
 net/mac80211/mlme.c        |  8 ++++----
 net/mac80211/util.c        | 19 +++++++++----------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 4ae9c58d6a12..554aeb2e20d9 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1726,7 +1726,7 @@ struct ieee802_11_elems {
 	const struct ieee80211_aid_response_ie *aid_resp;
 	const struct ieee80211_eht_cap_elem *eht_cap;
 	const struct ieee80211_eht_operation *eht_operation;
-	const struct ieee80211_multi_link_elem *multi_link;
+	const struct ieee80211_multi_link_elem *ml_basic;
 
 	/* length of them, respectively */
 	u8 ext_capab_len;
@@ -1751,9 +1751,10 @@ struct ieee802_11_elems {
 	u8 eht_cap_len;
 
 	/* mult-link element can be de-fragmented and thus u8 is not sufficient */
-	size_t multi_link_len;
-	/* The element in the original IEs */
-	const struct element *multi_link_elem;
+	size_t ml_basic_len;
+
+	/* The basic Multi-Link element in the original IEs */
+	const struct element *ml_basic_elem;
 
 	/*
 	 * store the per station profile pointer and length in case that the
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 1fc66f09cbb8..b8f8220cd9ff 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5277,24 +5277,24 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		}
 
 		if (ieee80211_vif_is_mld(&sdata->vif)) {
-			if (!elems->multi_link) {
+			if (!elems->ml_basic) {
 				sdata_info(sdata,
 					   "MLO association with %pM but no multi-link element in response!\n",
 					   assoc_data->ap_addr);
 				goto abandon_assoc;
 			}
 
-			if (le16_get_bits(elems->multi_link->control,
+			if (le16_get_bits(elems->ml_basic->control,
 					  IEEE80211_ML_CONTROL_TYPE) !=
 					IEEE80211_ML_CONTROL_TYPE_BASIC) {
 				sdata_info(sdata,
 					   "bad multi-link element (control=0x%x)\n",
-					   le16_to_cpu(elems->multi_link->control));
+					   le16_to_cpu(elems->ml_basic->control));
 				goto abandon_assoc;
 			} else {
 				struct ieee80211_mle_basic_common_info *common;
 
-				common = (void *)elems->multi_link->variable;
+				common = (void *)elems->ml_basic->variable;
 
 				if (memcmp(assoc_data->ap_addr,
 					   common->mld_mac_addr, ETH_ALEN)) {
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 2e3270dc4d05..473c77dd3137 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -984,9 +984,9 @@ ieee80211_parse_extension_element(u32 *crc,
 		break;
 	case WLAN_EID_EXT_EHT_MULTI_LINK:
 		if (ieee80211_mle_size_ok(data, len)) {
-			elems->multi_link_elem = (void *)elem;
-			elems->multi_link = (void *)data;
-			elems->multi_link_len = len;
+			elems->ml_basic_elem = (void *)elem;
+			elems->ml_basic = (void *)data;
+			elems->ml_basic_len = len;
 		}
 		break;
 	}
@@ -1462,8 +1462,8 @@ static size_t ieee802_11_find_bssid_profile(const u8 *start, size_t len,
 static void ieee80211_mle_get_sta_prof(struct ieee802_11_elems *elems,
 				       u8 link_id)
 {
-	const struct ieee80211_multi_link_elem *ml = elems->multi_link;
-	ssize_t ml_len = elems->multi_link_len;
+	const struct ieee80211_multi_link_elem *ml = elems->ml_basic;
+	ssize_t ml_len = elems->ml_basic_len;
 	const struct element *sub;
 
 	if (!ml || !ml_len)
@@ -1523,14 +1523,14 @@ static void ieee80211_mle_parse_link(struct ieee802_11_elems *elems,
 		.from_ap = params->from_ap,
 		.link_id = -1,
 	};
-	ssize_t ml_len = elems->multi_link_len;
+	ssize_t ml_len = elems->ml_basic_len;
 	const struct element *non_inherit = NULL;
 	const u8 *end;
 
 	if (params->link_id == -1)
 		return;
 
-	ml_len = cfg80211_defragment_element(elems->multi_link_elem,
+	ml_len = cfg80211_defragment_element(elems->ml_basic_elem,
 					     elems->ie_start,
 					     elems->total_len,
 					     elems->scratch_pos,
@@ -1542,9 +1542,8 @@ static void ieee80211_mle_parse_link(struct ieee802_11_elems *elems,
 	if (ml_len < 0)
 		return;
 
-	elems->multi_link = (const void *)elems->scratch_pos;
-	elems->multi_link_len = ml_len;
-	elems->scratch_pos += ml_len;
+	elems->ml_basic = (const void *)elems->scratch_pos;
+	elems->ml_basic_len = ml_len;
 
 	ieee80211_mle_get_sta_prof(elems, params->link_id);
 	prof = elems->prof;
-- 
2.38.1

