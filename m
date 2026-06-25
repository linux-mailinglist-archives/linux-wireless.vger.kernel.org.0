Return-Path: <linux-wireless+bounces-38064-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id inmLOSN0PGq4oAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38064-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 02:19:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE9A6C1F54
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 02:19:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38064-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38064-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4799E30262BD
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 00:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE661FECAB;
	Thu, 25 Jun 2026 00:19:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B5920459A
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 00:19:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782346786; cv=none; b=RqZcVl+tRGDte5ezWcfOFIjnlkyrZBh38/AG2TzGp1ToZ0t8oe0R1DfJ4lKqV25wNbrmaRUerjx3i6/c1Goj/cDU1rjKwA7K4RKX+yoomMUlcBvWKGzahhkOcLsFWwjARJMFBfXkVQ1ZCDeyDckIrglIaoP5GtAtT6IxQCfDcbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782346786; c=relaxed/simple;
	bh=CXpk5ExvI17JEYAL2n6vLKRd85hFp4ZxPwv6wO7LxkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVraUcY2gJTDsPSAfCYvey6Ulj2CYG60zEK1to7ItwxRXKKuDb3P/nnr+1jcGDYX5a1HT0xK6M+o2uomK9JCjPn/fxoq3vPGqJxdClqoUZf2ADG1GIUlR6IuuqnjzSVHEgwazRisTlnId0VTegPpeHSI9keWLfoson1pcvBmalg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.180
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c88b7c92577so672631a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 17:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782346785; x=1782951585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mLh1L+tMJu8LSp3EeO8J+yo8C17Dwm0vsGYlD7jYuDI=;
        b=qCuAIVoXXHq2gg1cwBZ1ViHblQ3hZylxH63g92y7l27t+IsoOUfEwoL1ffLXV9T/7y
         N22ZvjIHR7ASD7Du9hlZIueSXoCss64AVHe/W0+ZI7nWKn0197yHXtt+VGYVkn6tPpyI
         JYEedVjovbtWGsPYaVTl2FK0+vCxuqgnNVOlGIHmccFT2/xJslZj9c1ED4HDoi2Ef/P1
         YSTZo2LoC11cglV5lc+vTLzHM/ZdLGqhKGHEQ4vVY9bOmjXj8sYWENTrDT/17JWgetUT
         ITCWC12cCAaVwNxxw4C/KIsqPzeG/y4FdDTY2dxoFzvv3ecL9JRP12mt+MRAp6IjIN5f
         bIug==
X-Forwarded-Encrypted: i=1; AFNElJ/MD6l5ngLDIk65eBLq/zVodEerUc/2WJ8ma7M4PPPtybf5VU6XWnkN3ObJAnXuzK5Eh4HyBU+9mfGrladQfA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6tdGHzPnPblhhGKXJ18d6T8cxI15b0mnfevOUvdXNsID+CsnR
	PFixiFu3Fx2ToyYZhxx8eq8Sygzjse9B1FMXMN6jQqvto5zAIoh97X8r
X-Gm-Gg: AfdE7cmVdMbVm7pu+FFUdmoQpLJRaC5k0XK9rlSlJjdsEZBCiqhZqWgMK8FR1apUTVa
	Ereq6zs7EQuS06PpaAnmJY9o7dCLbIKg/oG+xtF8rfLu0LvZjXOkEoNfVs7HsXPwTzggmOAv1yC
	gj8OhYwL88vGPWSlw1z4mh5haUv2DTOPUctX5pxDeMupHJ7Mw0HnSSYUHFnD2GaFzgNFTBJ6WBg
	fnQs0f3sdon+l3oFINGGgk7Cq8MGuL92jflK0Jq98T5wwfnbDaaGbSvH8sMJWLpIKbHKVTguCze
	Z2/NjXqcSMDccZzOOXjffNMuZ1M4KSgd8ikHpvaOcpCOxbdj+len2oFcZwHURJGndNIDx8l+MnH
	oRdBbmlyuGmmxHczq0Zn4/dVvx/ywNpSOavtQ+QONwpvAimivAcpkfwW7eer8C7IQWA2r1AFlh6
	jQUAbE15PtEadpqwlY5h3VQ+V30MSxdzwyzhviSOU961IVQJjB541VQ763CaqorFSvjsQU6gCcO
	PHiib+kR7DwzIZbScuNtQ1R+xZI8QzsVGOIPZhS
X-Received: by 2002:a05:6a20:9f48:b0:3b3:486f:f2d1 with SMTP id adf61e73a8af0-3bd4abffc73mr359802637.3.1782346784814;
        Wed, 24 Jun 2026 17:19:44 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.. (114-34-228-194.hinet-ip.hinet.net. [114.34.228.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92bc1e0d10sm586839a12.21.2026.06.24.17.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 17:19:44 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: chengwei.yu@mediatek.com,
	yu-ching.liu@mediatek.com,
	jenhao.yang@mediatek.com,
	posh.sun@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 5/9] wifi: mt76: mt7925: add NAN MCU handling
Date: Wed, 24 Jun 2026 19:18:30 -0500
Message-ID: <20260625001834.475094-6-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625001834.475094-1-sean.wang@kernel.org>
References: <20260625001834.475094-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38064-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:chengwei.yu@mediatek.com,m:yu-ching.liu@mediatek.com,m:jenhao.yang@mediatek.com,m:posh.sun@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:sean.wang@mediatek.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCE9A6C1F54

From: Sean Wang <sean.wang@mediatek.com>

Route NAN MCU responses and unsolicited events through the mt7925 MCU
path, and handle NAN-specific BSS and station TLVs.

Co-developed-by: Stella Liu <yu-ching.liu@mediatek.com>
Signed-off-by: Stella Liu <yu-ching.liu@mediatek.com>
Co-developed-by: Jeremy Yu <chengwei.yu@mediatek.com>
Signed-off-by: Jeremy Yu <chengwei.yu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 99 ++++++++++++++++---
 1 file changed, 84 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index cff91b4eeac6..f58f24583453 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -7,10 +7,17 @@
 #include "regd.h"
 #include "mcu.h"
 #include "mac.h"
+#include "nan.h"
 
 #define MT_STA_BFER			BIT(0)
 #define MT_STA_BFEE			BIT(1)
 
+static bool mt7925_vif_is_nan(struct ieee80211_vif *vif)
+{
+	return vif->type == NL80211_IFTYPE_NAN ||
+	       vif->type == NL80211_IFTYPE_NAN_DATA;
+}
+
 int mt7925_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			      struct sk_buff *skb, int seq)
 {
@@ -37,7 +44,8 @@ int mt7925_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 		   cmd == MCU_UNI_CMD(BSS_INFO_UPDATE) ||
 		   cmd == MCU_UNI_CMD(STA_REC_UPDATE) ||
 		   cmd == MCU_UNI_CMD(OFFLOAD) ||
-		   cmd == MCU_UNI_CMD(SUSPEND)) {
+		   cmd == MCU_UNI_CMD(SUSPEND) ||
+		   cmd == MCU_UNI_CMD(NAN)) {
 		struct mt7925_mcu_uni_event *event;
 
 		skb_pull(skb, sizeof(*rxd));
@@ -631,6 +639,9 @@ mt7925_mcu_uni_rx_unsolicited_event(struct mt792x_dev *dev,
 		dev->fw_assert = true;
 		mt76_connac_mcu_coredump_event(&dev->mt76, skb, &dev->coredump);
 		return;
+	case MCU_UNI_EVENT_NAN:
+		mt7925_nan_mcu_event(dev, skb);
+		break;
 	default:
 		break;
 	}
@@ -1835,9 +1846,20 @@ mt7925_mcu_sta_phy_tlv(struct sk_buff *skb,
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_PHY, sizeof(*phy));
 	phy = (struct sta_rec_phy *)tlv;
-	phy->phy_type = mt76_connac_get_phy_mode_v2(mvif->phy->mt76, vif,
-						    chandef->chan->band,
-						    link_sta);
+
+	if (mt7925_vif_is_nan(vif)) {
+		enum nl80211_band band = chandef->chan ? chandef->chan->band
+						       : NL80211_BAND_2GHZ;
+		phy->phy_type = PHY_TYPE_BIT_OFDM | PHY_TYPE_BIT_ERP;
+		phy->phy_type |= mt76_connac_get_phy_mode_v2(mvif->phy->mt76, vif,
+							     band,
+							     link_sta);
+	} else {
+		phy->phy_type = mt76_connac_get_phy_mode_v2(mvif->phy->mt76, vif,
+							    chandef->chan->band,
+							    link_sta);
+	}
+
 	phy->basic_rate = cpu_to_le16((u16)link_conf->basic_rates);
 	if (link_sta->ht_cap.ht_supported) {
 		af = link_sta->ht_cap.ampdu_factor;
@@ -1910,11 +1932,15 @@ mt7925_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb,
 	mconf = mt792x_vif_to_link(mvif, link_sta->link_id);
 	chandef = mconf->mt76.ctx ? &mconf->mt76.ctx->def :
 				    &link_conf->chanreq.oper;
-	band = chandef->chan->band;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra_info));
 	ra_info = (struct sta_rec_ra_info *)tlv;
 
+	if (mt7925_vif_is_nan(vif))
+		band = chandef->chan ? chandef->chan->band : NL80211_BAND_2GHZ;
+	else
+		band = chandef->chan->band;
+
 	supp_rates = link_sta->supp_rates[band];
 	if (band == NL80211_BAND_2GHZ)
 		supp_rates = FIELD_PREP(RA_LEGACY_OFDM, supp_rates >> 4) |
@@ -2561,6 +2587,29 @@ mt7925_get_phy_mode_ext(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	return mode;
 }
 
+static void
+mt7925_mcu_bss_basic_tlv_nan(struct mt76_phy *phy,
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_link_sta *link_sta,
+			     struct mt76_connac_bss_basic_tlv *basic_req)
+{
+	u8 mode_2g, mode_5g;
+
+	mode_2g = mt7925_get_phy_mode_ext(phy, vif, NL80211_BAND_2GHZ,
+					  link_sta);
+	mode_5g = mt7925_get_phy_mode_ext(phy, vif, NL80211_BAND_5GHZ,
+					  link_sta);
+	basic_req->phymode_ext = mode_2g | mode_5g;
+
+	basic_req->nonht_basic_phy = cpu_to_le16(PHY_TYPE_ERP_INDEX);
+
+	mode_2g = mt76_connac_get_phy_mode(phy, vif, NL80211_BAND_2GHZ,
+					   link_sta);
+	mode_5g = mt76_connac_get_phy_mode(phy, vif, NL80211_BAND_5GHZ,
+					   link_sta);
+	basic_req->phymode = (mode_2g | mode_5g) & ~PHY_MODE_B;
+}
+
 static void
 mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 			 struct ieee80211_bss_conf *link_conf,
@@ -2575,7 +2624,7 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
 	struct cfg80211_chan_def *chandef = ctx ? &ctx->def :
 						  &link_conf->chanreq.oper;
-	enum nl80211_band band = chandef->chan->band;
+	enum nl80211_band band = NL80211_BAND_2GHZ;
 	struct mt76_connac_bss_basic_tlv *basic_req;
 	struct tlv *tlv;
 	int conn_type;
@@ -2588,16 +2637,25 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 						      mconf->mt76.omac_idx;
 	basic_req->hw_bss_idx = idx;
 
-	basic_req->phymode_ext = mt7925_get_phy_mode_ext(phy, vif, band,
-							 link_sta);
+	if (mt7925_vif_is_nan(vif)) {
+		mt7925_mcu_bss_basic_tlv_nan(phy, vif, link_sta, basic_req);
+	} else {
+		band = chandef->chan->band;
+		basic_req->phymode_ext = mt7925_get_phy_mode_ext(phy, vif, band,
+								 link_sta);
 
-	if (band == NL80211_BAND_2GHZ)
-		basic_req->nonht_basic_phy = cpu_to_le16(PHY_TYPE_ERP_INDEX);
-	else
-		basic_req->nonht_basic_phy = cpu_to_le16(PHY_TYPE_OFDM_INDEX);
+		if (band == NL80211_BAND_2GHZ)
+			basic_req->nonht_basic_phy =
+				cpu_to_le16(PHY_TYPE_ERP_INDEX);
+		else
+			basic_req->nonht_basic_phy =
+				cpu_to_le16(PHY_TYPE_OFDM_INDEX);
+
+		memcpy(basic_req->bssid, link_conf->bssid, ETH_ALEN);
+		basic_req->phymode = mt76_connac_get_phy_mode(phy, vif, band,
+							      link_sta);
+	}
 
-	memcpy(basic_req->bssid, link_conf->bssid, ETH_ALEN);
-	basic_req->phymode = mt76_connac_get_phy_mode(phy, vif, band, link_sta);
 	basic_req->bcn_interval = cpu_to_le16(link_conf->beacon_int);
 	basic_req->dtim_period = link_conf->dtim_period;
 	basic_req->bmc_tx_wlan_idx = cpu_to_le16(bmc_tx_wlan_idx);
@@ -2630,6 +2688,11 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 		basic_req->conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
 		basic_req->active = true;
 		break;
+	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
+		basic_req->conn_type = cpu_to_le32(CONNECTION_NAN);
+		basic_req->active = enable;
+		break;
 	default:
 		WARN_ON(1);
 		break;
@@ -2688,10 +2751,11 @@ mt7925_mcu_bss_bmc_tlv(struct sk_buff *skb, struct mt792x_phy *phy,
 		       struct ieee80211_chanctx_conf *ctx,
 		       struct ieee80211_bss_conf *link_conf)
 {
+	struct ieee80211_vif *vif = link_conf->vif;
 	struct cfg80211_chan_def *chandef = ctx ? &ctx->def :
 						  &link_conf->chanreq.oper;
 	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
-	enum nl80211_band band = chandef->chan->band;
+	enum nl80211_band band = NL80211_BAND_2GHZ;
 	struct mt76_vif_link *mvif = &mconf->mt76;
 	struct bss_rate_tlv *bmc;
 	struct tlv *tlv;
@@ -2702,6 +2766,11 @@ mt7925_mcu_bss_bmc_tlv(struct sk_buff *skb, struct mt792x_phy *phy,
 
 	bmc = (struct bss_rate_tlv *)tlv;
 
+	if (mt7925_vif_is_nan(vif))
+		band = chandef->chan ? chandef->chan->band : NL80211_BAND_2GHZ;
+	else
+		band = chandef->chan->band;
+
 	if (band == NL80211_BAND_2GHZ)
 		bmc->basic_rate = cpu_to_le16(HR_DSSS_ERP_BASIC_RATE);
 	else
-- 
2.43.0


