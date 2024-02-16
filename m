Return-Path: <linux-wireless+bounces-3674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 284BA857C28
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 12:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B457C28641C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 11:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138FF77F3F;
	Fri, 16 Feb 2024 11:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ehtu8yGS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E5678677
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084504; cv=none; b=lq/Z9iYBEgx74+2HO/c9hm3IriGHfiynNtxrFHkwFYRe2zEEr/Hm60cCX4KbnCVNba5HloclHLUWA1gP209PSVQ171F1IHE7f3PvzknyvahyDDGbfsqTDfNOnppQVzFKg/NfmsrqQfBI0JPOXMtV4jbuu1kGzjbO7QVxvM6XW4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084504; c=relaxed/simple;
	bh=QAuuiswwm91RMzn9rmv9lhDLCjvf7228VRt8om8MfJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kwzMCPRfDzODs9cZhOzmPeAHG5zRcR7IOBNGh0cQ4V5ZKD1EjyvO6SsgmdIO6ZpcCSw3IB3VisyYTnAedyPxWgP7BWMrAmZhxtln1lYkIA78lrgJe/20e7lXurjJDCGQG68zBLa1cHQNzffr+3a+iW1RR4kp22zrKk+dUGcFgQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ehtu8yGS; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708084502; x=1739620502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QAuuiswwm91RMzn9rmv9lhDLCjvf7228VRt8om8MfJg=;
  b=ehtu8yGSl9IHLdS1uPgAx4xJ3AIzyexK2AGrLe77i8VktbkFZJcrn50I
   b3gUzANOxXuCIsbr4oLRrJnEIrKUL8c6br1RfJc7w5Pf1SwaEPQ4Gj7z2
   36tGxUMqpfz0QbAXovlAWYktJSd7BD+8khBi/01oVRIOB28QnC4hVXMeC
   g0BAOxmRDxWnC/ROu2jwXlVVFWuSslUg4qFcTkbpcXbHVIxS9oM1HWX81
   FAol9sbEli0P/OwFmLI6KQykvoKN86N0Ga4+tKZWH7YwetKk11d8BzdES
   2JEpOOH8vXZ4bUz6QRk/swnSWnSa4sJYnC6EY/jcM5polkWMabYe3Xp3I
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2321933"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2321933"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:55:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="3795607"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:55:01 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 7/7] wifi: mac80211: parse the BSS Load element
Date: Fri, 16 Feb 2024 13:54:33 +0200
Message-Id: <20240216135047.b771830d9b12.If5885d651cb0114711ee1f6c1cb8fe31a69bf0a7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216115433.1044027-1-miriam.rachel.korenblit@intel.com>
References: <20240216115433.1044027-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Some drivers need this. Parse the element and save the
channel utilization field in the link conf.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h  | 18 ++++++++++++++++++
 include/net/mac80211.h     |  7 +++++++
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/mlme.c        |  5 +++++
 net/mac80211/parse.c       |  8 ++++++++
 5 files changed, 39 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 3385a2cc5b09..f23340654ecf 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1287,6 +1287,24 @@ struct ieee80211_ttlm_elem {
 	u8 optional[];
 } __packed;
 
+/**
+ * struct ieee80211_bss_load_elem - BSS Load elemen
+ *
+ * Defined in section 9.4.2.26 in IEEE 802.11-REVme D4.1
+ *
+ * @sta_count: total number of STAs currently associated with the AP.
+ * @channel_util: Percentage of time that the access point sensed the channel
+ *	was busy. This value is in range [0, 255], the highest value means
+ *	100% busy.
+ * @avail_admission_capa: remaining amount of medium time used for admission
+ *	control.
+ */
+struct ieee80211_bss_load_elem {
+	__le16 sta_count;
+	u8 channel_util;
+	__le16 avail_admission_capa;
+} __packed;
+
 struct ieee80211_mgmt {
 	__le16 frame_control;
 	__le16 duration;
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index fc223761e3af..0af80a2b6cfc 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -671,6 +671,11 @@ struct ieee80211_fils_discovery {
  *	processed after it switches back to %NULL.
  * @color_change_active: marks whether a color change is ongoing.
  * @color_change_color: the bss color that will be used after the change.
+ * @channel_util: Channel utilization as published by the AP in the
+ *	WLAN_EID_QBSS_LOAD information element. An unsigned integer in the
+ *	range [0,255], when 255 means the 100% busy. Valid only for a
+ *	station, and only when associated. Will be -1 if AP didn't
+ *	send the element.
  * @ht_ldpc: in AP mode, indicates interface has HT LDPC capability.
  * @vht_ldpc: in AP mode, indicates interface has VHT LDPC capability.
  * @he_ldpc: in AP mode, indicates interface has HE LDPC capability.
@@ -774,6 +779,8 @@ struct ieee80211_bss_conf {
 	bool color_change_active;
 	u8 color_change_color;
 
+	s16 channel_util;
+
 	bool ht_ldpc;
 	bool vht_ldpc;
 	bool he_ldpc;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index f3edb1a148a7..7bc1e55de358 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1741,6 +1741,7 @@ struct ieee802_11_elems {
 	const struct ieee80211_multi_link_elem *ml_reconf;
 	const struct ieee80211_bandwidth_indication *bandwidth_indication;
 	const struct ieee80211_ttlm_elem *ttlm[IEEE80211_TTLM_MAX_CNT];
+	const struct ieee80211_bss_load_elem *bss_load;
 
 	/* length of them, respectively */
 	u8 ext_capab_len;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2f13451ba003..8a9c9188eb65 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3078,6 +3078,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	/* other links will be destroyed */
 	sdata->deflink.u.mgd.bss = NULL;
 	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
+	sdata->deflink.conf->channel_util = -1;
 
 	netif_carrier_off(sdata->dev);
 
@@ -6359,6 +6360,9 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 		erp_valid = false;
 	}
 
+	bss_conf->channel_util =
+		elems->bss_load ? elems->bss_load->channel_util : -1;
+
 	if (!ieee80211_is_s1g_beacon(hdr->frame_control))
 		changed |= ieee80211_handle_bss_capability(link,
 				le16_to_cpu(mgmt->u.beacon.capab_info),
@@ -7444,6 +7448,7 @@ void ieee80211_mgd_setup_link(struct ieee80211_link_data *link)
 	link->u.mgd.p2p_noa_index = -1;
 	link->conf->bssid = link->u.mgd.bssid;
 	link->smps_mode = IEEE80211_SMPS_OFF;
+	link->conf->channel_util = -1;
 
 	wiphy_work_init(&link->u.mgd.request_smps_work,
 			ieee80211_request_smps_mgd_work);
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 196a882e4c19..07bb21a92360 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -203,6 +203,7 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 		case WLAN_EID_CF_PARAMS:
 		case WLAN_EID_TIM:
 		case WLAN_EID_IBSS_PARAMS:
+		case WLAN_EID_QBSS_LOAD:
 		case WLAN_EID_CHALLENGE:
 		case WLAN_EID_RSN:
 		case WLAN_EID_ERP_INFO:
@@ -297,6 +298,13 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 				elem_parse_failed =
 					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			break;
+		case WLAN_EID_QBSS_LOAD:
+			if (elen == sizeof(struct ieee80211_bss_load_elem))
+				elems->bss_load = (void *)pos;
+			else
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
+			break;
 		case WLAN_EID_VENDOR_SPECIFIC:
 			if (elen >= 4 && pos[0] == 0x00 && pos[1] == 0x50 &&
 			    pos[2] == 0xf2) {
-- 
2.34.1


