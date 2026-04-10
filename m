Return-Path: <linux-wireless+bounces-34633-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEuNGMVJ2WmkoAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34633-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 21:04:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3703DBC59
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 21:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8891304F7DC
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 19:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A045133A6F2;
	Fri, 10 Apr 2026 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="ccD/+AHA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D542206A7
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775847843; cv=none; b=b51fK2BuMOw/6LqbttHcM/sXPK5aKeM+/FcXExGXSwOkl8yShqN99pSthlntypPku79KgYNFW3NwnC3KYxh8xlliwouBJ6vFCaHAoPT9OuTD7mCSTzvR4b24oFBz0tZhBx49kXFiPWnEJ6M0+hIRHpOnLwKSlz0LPIypD40Y7Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775847843; c=relaxed/simple;
	bh=HAr/K3CBn7HDTVVf0fjHw4z446rdqlXRAWk4Vv9RM84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SG1qE03Evq6ygGeksteZlLcBBAYKid0FTcrlm/1hhAYxe6DGxwPftCDdCgcLcBNHUrhm8e51ytyu6SGytbpZDJgtfJgH3nTaIm+2a4iJAO8n0QMJQX1fMrAnSN4i08ig8DWBLAojzcteO/G+wUttULLWtwMAF7GYvG36H7mHu7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=ccD/+AHA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso28562455e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 12:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1775847840; x=1776452640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5RdO5WA7/K98piU7r4B0O1/HoTZg1APD9BkWUFyEGk=;
        b=ccD/+AHAg6HrMMHKrzUp0W+Dr+HEWqNAexCdjuEX2wi2vxG14PICPbCcRryCvGcpf2
         slbsR70Eg0hQZv7EVaxqYbpuZ03CGGC4gbFz+pKfq13eex5uFoimJIrtLMV1q6XT3lsC
         EITOVUZFRJNuhCLeOmkPDlGNNd7LSBf2VNbL55J3ZCbLTvk8G/jWFKrRCaWuijRQWVRl
         H8FHZBSpl2OA4hrn20YrgpheJ8ChHvIyx4ynZdsLkBkuziIprVtYSU2J5C46rJLv1ts2
         Kci4W2ubhj02Y47LxKsXcn01/A/I81N+Ch8SB2YW2Jo1LQWdeZ70Qz3qQa3aIRNsJNoF
         ezug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775847840; x=1776452640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P5RdO5WA7/K98piU7r4B0O1/HoTZg1APD9BkWUFyEGk=;
        b=q31dvXOE7Wc7758U6ODOncquNowWK7TCu92x1irRZAA43R6xXj/VTncFJmpKkteivj
         9ZCBlVkw4vrruaHTpdqvX7xVxV/tGDoA/O3pDlDPrceeWGhzpQ+aANGQagrRVHTwx59M
         VA81CoXufwhNY1lUuodKJMAz4rGQ2E7RxI7WZOy9W+rjdGaAqKELRnuum4NV+FzDTzsP
         oePlL7/Lt2pMKIJQ9LKIOexPOcZHnevJPf20NbuRuwvZH0tUD2emyBJCWatxoZNBltFV
         7oB3TDr7NZ/TWtHGBLmSL8GzWZyEOUtZWlvg5wBDCOKa0z75WkMNvKAllzN6DP1sTDlN
         nEdA==
X-Gm-Message-State: AOJu0YxL4tLS/A/pdhZQzp9MV2hUcKmIZOxeGfnfjWiR4UX9cvUT0gx6
	R2jaHnj5EakT5AC/a1NRpDeR35bWD0D4YrshdM6JJmR46c87GI4r3EQQ7RO3500c61A=
X-Gm-Gg: AeBDietsu/1aCLi2SrqeiHYK1xpEbT25x6Vbs4JQqhISPJxY/un0Yq5fSbhCOIFu3bc
	xYVKsXFa6IMFVCfojOKUQOCzlGg+InNHonOaedl1uUAWpquG5g4Kr0++Odab52G4iTlFLJo1oJm
	BWKrLUEeVPCAOHaxfrh+tAvq81HOjG75qA4x8AJrBC0aVark+W3TIno8INzMjD1lJ/ffIUhkBsn
	5GsyhIRq9yUVwHNYFn6LLaBTyXYI47vbAi4tVkwAzqd7/TUobf5Ul0uHz5dr+VLfsIUBAuRmF5+
	cDDBSUy1XY8a9N9eOpt5JcEitYEnm3tyaqoo76XUEaWJcEHs/owg72HCMl37Z1nW66hPF8mD7vW
	moqpmgY8zPmLS7otUBTND3GCkmhVCuxBdWLhV4oLJumEtHJNYa6doOH679Ggz+6Tlg4wJ9y2RWS
	Zn5tiapqvGm3tF61NyBXpJj3gjxS8BQXckF2p6guz3BB6nnqqX+NDpLhhUce2wtshbHnL6AuZaB
	WDKE3iaxc/S
X-Received: by 2002:a05:600c:c08b:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-488d6816f66mr39579155e9.2.1775847839907;
        Fri, 10 Apr 2026 12:03:59 -0700 (PDT)
Received: from pablomg-ThinkStation-P620.mgt.proxad.net (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d6ee98sm38909125e9.1.2026.04.10.12.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:03:59 -0700 (PDT)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [RFC PATCH 2/7] wifi: make EHT capa size check not read reserved bits
Date: Fri, 10 Apr 2026 21:03:49 +0200
Message-ID: <20260410190354.394742-3-pmartin-gomez@freebox.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410190354.394742-1-pmartin-gomez@freebox.fr>
References: <20260410190354.394742-1-pmartin-gomez@freebox.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34633-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[freebox-fr.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB3703DBC59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ieee80211_eht_mcs_nss_size() reads the value of reserved bits to deduce
the current band used assuming the reserved bits are set to 0.

However, Mediatek's chipsets MT7927 and MT7925 with Windows driver 5.4.0.3044
(and earlier versions) set the bits in Supported Channel Width Set subfield
of the HE PHY Capabilities Information field, regardless of the current band.
This causes the kernel to miscalculate mcs_nss_size to 3 bytes, resulting in
a incorrect rx/tx nss map, so the sta is believed to have 0 NSS for 160/320.

Pass the band to ieee80211_eht_mcs_nss_size() to only read non reserved
bits in the Supported Channel Width Set subfield.

Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
---
 drivers/net/wireless/ath/ath12k/mac.c |  3 +-
 include/linux/ieee80211-eht.h         | 58 ++++++++++++++++-----------
 net/mac80211/eht.c                    |  3 +-
 net/mac80211/util.c                   |  8 ++--
 net/wireless/nl80211.c                | 13 ++++--
 5 files changed, 53 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 553ec28b6aaa..6e4cfbb0e5bd 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -12537,7 +12537,8 @@ ath12k_mac_bitrate_mask_get_single_nss(struct ath12k *ar,
 
 	mcs_nss_len = ieee80211_eht_mcs_nss_size(&data->he_cap.he_cap_elem,
 						 &data->eht_cap.eht_cap_elem,
-						 false);
+						 false,
+						 sband->band);
 	if (mcs_nss_len == 4) {
 		/* 20 MHz only STA case */
 		const struct ieee80211_eht_mcs_nss_supp_20mhz_only *eht_mcs_nss =
diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index 76e1cb80dcc7..d6f7072df5d6 100644
--- a/include/linux/ieee80211-eht.h
+++ b/include/linux/ieee80211-eht.h
@@ -17,6 +17,7 @@
 
 #include <linux/types.h>
 #include <linux/if_ether.h>
+#include <linux/nl80211.h>
 /* need HE definitions for the inlines here */
 #include <linux/ieee80211-he.h>
 
@@ -283,31 +284,41 @@ struct ieee80211_eht_operation_info {
 static inline u8
 ieee80211_eht_mcs_nss_size(const struct ieee80211_he_cap_elem *he_cap,
 			   const struct ieee80211_eht_cap_elem_fixed *eht_cap,
-			   bool from_ap)
+			   bool from_ap,
+			   enum nl80211_band band)
 {
 	u8 count = 0;
 
-	/* on 2.4 GHz, if it supports 40 MHz, the result is 3 */
-	if (he_cap->phy_cap_info[0] &
-	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G)
-		return 3;
-
-	/* on 2.4 GHz, these three bits are reserved, so should be 0 */
-	if (he_cap->phy_cap_info[0] &
-	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G)
-		count += 3;
-
-	if (he_cap->phy_cap_info[0] &
-	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)
-		count += 3;
-
-	if (eht_cap->phy_cap_info[0] & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ)
-		count += 3;
-
-	if (count)
-		return count;
+	switch (band) {
+	case NL80211_BAND_2GHZ:
+		if (from_ap || he_cap->phy_cap_info[0] &
+		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G)
+			count += 3;
+		else
+			count = 4;
+	break;
+	case NL80211_BAND_6GHZ:
+		if (eht_cap->phy_cap_info[0] & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ)
+			count += 3;
+	fallthrough;
+	case NL80211_BAND_5GHZ:
+		if (he_cap->phy_cap_info[0] &
+		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)
+			count += 3;
+		if (he_cap->phy_cap_info[0] &
+		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G)
+			count += 3;
+		if (!from_ap && (he_cap->phy_cap_info[0] &
+		    (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
+		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
+		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)) == 0)
+			count = 4;
+	break;
+	default:
+	break;
+	}
 
-	return from_ap ? 3 : 4;
+	return count;
 }
 
 /* 802.11be EHT PPE Thresholds */
@@ -344,7 +355,7 @@ ieee80211_eht_ppe_size(u16 ppe_thres_hdr, const u8 *phy_cap_info)
 
 static inline bool
 ieee80211_eht_capa_size_ok(const u8 *he_capa, const u8 *data, u8 len,
-			   bool from_ap)
+			   bool from_ap, enum nl80211_band band)
 {
 	const struct ieee80211_eht_cap_elem_fixed *elem = (const void *)data;
 	u8 needed = sizeof(struct ieee80211_eht_cap_elem_fixed);
@@ -354,7 +365,8 @@ ieee80211_eht_capa_size_ok(const u8 *he_capa, const u8 *data, u8 len,
 
 	needed += ieee80211_eht_mcs_nss_size((const void *)he_capa,
 					     (const void *)data,
-					     from_ap);
+					     from_ap,
+					     band);
 	if (len < needed)
 		return false;
 
diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
index e88f28edfd57..37b8387bd728 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -32,7 +32,8 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 	mcs_nss_size = ieee80211_eht_mcs_nss_size(he_cap_ie_elem,
 						  &eht_cap_ie_elem->fixed,
 						  sdata->vif.type ==
-							NL80211_IFTYPE_STATION);
+							NL80211_IFTYPE_STATION,
+						  sband->band);
 
 	eht_total_size += mcs_nss_size;
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 8987a4504520..8e0c7ec95827 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4431,7 +4431,8 @@ u8 ieee80211_ie_len_eht_cap(struct ieee80211_sub_if_data *sdata)
 
 	n = ieee80211_eht_mcs_nss_size(&he_cap->he_cap_elem,
 				       &eht_cap->eht_cap_elem,
-				       is_ap);
+				       is_ap,
+				       sband->band);
 	return 2 + 1 +
 	       sizeof(eht_cap->eht_cap_elem) + n +
 	       ieee80211_eht_ppe_size(eht_cap->eht_ppe_thres[0],
@@ -4464,7 +4465,8 @@ int ieee80211_put_eht_cap(struct sk_buff *skb,
 
 	orig_mcs_nss_len = ieee80211_eht_mcs_nss_size(&he_cap->he_cap_elem,
 						      &eht_cap->eht_cap_elem,
-						      for_ap);
+						      for_ap,
+						      sband->band);
 
 	ieee80211_get_adjusted_he_cap(conn, he_cap, &he);
 
@@ -4498,7 +4500,7 @@ int ieee80211_put_eht_cap(struct sk_buff *skb,
 		fixed.phy_cap_info[0] &=
 			~IEEE80211_EHT_PHY_CAP0_242_TONE_RU_GT20MHZ;
 
-	mcs_nss_len = ieee80211_eht_mcs_nss_size(&he, &fixed, for_ap);
+	mcs_nss_len = ieee80211_eht_mcs_nss_size(&he, &fixed, for_ap, sband->band);
 	ppet_len = ieee80211_eht_ppe_size(eht_cap->eht_ppe_thres[0],
 					  fixed.phy_cap_info);
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fb0bb4a957d9..3c29872073f8 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2137,7 +2137,8 @@ nl80211_send_iftype_data(struct sk_buff *msg,
 		mcs_nss_size =
 			ieee80211_eht_mcs_nss_size(&he_cap->he_cap_elem,
 						   &eht_cap->eht_cap_elem,
-						   is_ap);
+						   is_ap,
+						   sband->band);
 
 		ppe_thres_hdr = get_unaligned_le16(&eht_cap->eht_ppe_thres[0]);
 		ppe_thresh_size =
@@ -5919,7 +5920,8 @@ static bool eht_set_mcs_mask(struct genl_info *info, struct wireless_dev *wdev,
 	mcs_nss_len = ieee80211_eht_mcs_nss_size(&he_cap->he_cap_elem,
 						 &eht_cap->eht_cap_elem,
 						 wdev->iftype ==
-							NL80211_IFTYPE_STATION);
+							NL80211_IFTYPE_STATION,
+						 sband->band);
 
 	if (mcs_nss_len == 3) {
 		/* Supported iftypes for setting non-20 MHZ only EHT MCS */
@@ -6007,7 +6009,8 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 		mcs_nss_len = ieee80211_eht_mcs_nss_size(&he_cap->he_cap_elem,
 							 &eht_cap->eht_cap_elem,
 							 wdev->iftype ==
-							 NL80211_IFTYPE_STATION);
+								NL80211_IFTYPE_STATION,
+							 sband->band);
 
 		eht_build_mcs_mask(info, eht_cap, mcs_nss_len,
 				   mask->control[i].eht_mcs);
@@ -6686,7 +6689,9 @@ static int nl80211_calculate_ap_params(struct cfg80211_ap_settings *params)
 		params->eht_cap = (void *)(cap->data + 1);
 		if (!ieee80211_eht_capa_size_ok((const u8 *)params->he_cap,
 						(const u8 *)params->eht_cap,
-						cap->datalen - 1, true))
+						cap->datalen - 1,
+						true,
+						params->chandef.chan->band))
 			return -EINVAL;
 	}
 	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_OPERATION, ies, ies_len);
-- 
2.43.0


