Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6824B2EA3BE
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 04:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbhAEDIR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jan 2021 22:08:17 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:22953 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbhAEDIR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jan 2021 22:08:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609816073; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=T3sRsCklDqwEnhFENfjHn40k0ckNHWhDRrRwtrFF/hc=; b=Dv8QtN4D5GlX8AgiegdeDc5riQB5V0oOQhQV6pFyQDBliHug0Wvh5BRrJr0U3V/VyqcJMQQG
 Y4oiGqeorR2MP5UBfKXDA10KJSseI0A8OWEQUP2kiV1fbQhiTJ1MZ0kgf2SSvDvtHMstZw0k
 IKC5olxWeZBSEkcvqbAodHKb5ak=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5ff3d801b100ecf37a7b677b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 05 Jan 2021 03:07:45
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 73D73C43462; Tue,  5 Jan 2021 03:07:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from gongwen-ThinkPad-T420.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 855AAC433C6;
        Tue,  5 Jan 2021 03:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 855AAC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath11k@lists.infradead.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v3 2/2] mac80211: do intersection with he mcs and nss set of peer and own
Date:   Tue,  5 Jan 2021 11:08:40 +0800
Message-Id: <1609816120-9411-3-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609816120-9411-1-git-send-email-wgong@codeaurora.org>
References: <1609816120-9411-1-git-send-email-wgong@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For VHT capbility, it has intersection of mcs and nss for peer in
function ieee80211_vht_cap_ie_to_sta_vht_cap. For HE capbility,
it does not have intersection.

This patch is do intersection for HE capbility.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 net/mac80211/he.c          | 94 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  5 ++
 2 files changed, 99 insertions(+)

diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index cc26f239838b..1850f9899726 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -52,6 +52,59 @@ ieee80211_update_from_he_6ghz_capa(const struct ieee80211_he_6ghz_capa *he_6ghz_
 	sta->sta.he_6ghz_capa = *he_6ghz_capa;
 }
 
+void
+ieee80211_he_mcs_disable(u16 *he_mcs)
+{
+	u32 i;
+
+	for (i = 0; i < 8; i++)
+		*he_mcs |= cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << i * 2);
+}
+
+void
+ieee80211_he_mcs_intersection(u16 *he_own_rx, u16 *he_peer_rx,
+			      u16 *he_own_tx, u16 *he_peer_tx)
+{
+	u32 i;
+	u16 own_rx, own_tx, peer_rx, peer_tx;
+
+	for (i = 0; i < 8; i++) {
+		own_rx = le16_to_cpu(*he_own_rx);
+		own_rx = (own_rx >> i * 2) & IEEE80211_HE_MCS_NOT_SUPPORTED;
+
+		own_tx = le16_to_cpu(*he_own_tx);
+		own_tx = (own_tx >> i * 2) & IEEE80211_HE_MCS_NOT_SUPPORTED;
+
+		peer_rx = le16_to_cpu(*he_peer_rx);
+		peer_rx = (peer_rx >> i * 2) & IEEE80211_HE_MCS_NOT_SUPPORTED;
+
+		peer_tx = le16_to_cpu(*he_peer_tx);
+		peer_tx = (peer_tx >> i * 2) & IEEE80211_HE_MCS_NOT_SUPPORTED;
+
+		if (peer_tx != IEEE80211_HE_MCS_NOT_SUPPORTED) {
+			if (own_rx == IEEE80211_HE_MCS_NOT_SUPPORTED)
+				peer_tx = IEEE80211_HE_MCS_NOT_SUPPORTED;
+			else if (own_rx < peer_tx)
+				peer_tx = own_rx;
+		}
+
+		if (peer_rx != IEEE80211_HE_MCS_NOT_SUPPORTED) {
+			if (own_tx == IEEE80211_HE_MCS_NOT_SUPPORTED)
+				peer_rx = IEEE80211_HE_MCS_NOT_SUPPORTED;
+			else if (own_tx < peer_rx)
+				peer_rx = own_tx;
+		}
+
+		*he_peer_rx &=
+			~cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << i * 2);
+		*he_peer_rx |= cpu_to_le16(peer_rx << i * 2);
+
+		*he_peer_tx &=
+			~cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << i * 2);
+		*he_peer_tx |= cpu_to_le16(peer_tx << i * 2);
+	}
+}
+
 void
 ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_supported_band *sband,
@@ -60,10 +113,12 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 				  struct sta_info *sta)
 {
 	struct ieee80211_sta_he_cap *he_cap = &sta->sta.he_cap;
+	struct ieee80211_sta_he_cap own_he_cap = sband->iftype_data->he_cap;
 	struct ieee80211_he_cap_elem *he_cap_ie_elem = (void *)he_cap_ie;
 	u8 he_ppe_size;
 	u8 mcs_nss_size;
 	u8 he_total_size;
+	bool own_160, peer_160, own_80p80, peer_80p80;
 
 	memset(he_cap, 0, sizeof(*he_cap));
 
@@ -101,6 +156,45 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 
 	if (sband->band == NL80211_BAND_6GHZ && he_6ghz_capa)
 		ieee80211_update_from_he_6ghz_capa(he_6ghz_capa, sta);
+
+	ieee80211_he_mcs_intersection(&own_he_cap.he_mcs_nss_supp.rx_mcs_80,
+				      &he_cap->he_mcs_nss_supp.rx_mcs_80,
+				      &own_he_cap.he_mcs_nss_supp.tx_mcs_80,
+				      &he_cap->he_mcs_nss_supp.tx_mcs_80);
+
+	own_160 = !!(own_he_cap.he_cap_elem.phy_cap_info[0] &
+		  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G);
+	peer_160 = !!(he_cap->he_cap_elem.phy_cap_info[0] &
+		  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G);
+
+	if (peer_160 && own_160) {
+		ieee80211_he_mcs_intersection(&own_he_cap.he_mcs_nss_supp.rx_mcs_160,
+					      &he_cap->he_mcs_nss_supp.rx_mcs_160,
+					      &own_he_cap.he_mcs_nss_supp.tx_mcs_160,
+					      &he_cap->he_mcs_nss_supp.tx_mcs_160);
+	} else if (peer_160 && !own_160) {
+		ieee80211_he_mcs_disable(&he_cap->he_mcs_nss_supp.rx_mcs_160);
+		ieee80211_he_mcs_disable(&he_cap->he_mcs_nss_supp.tx_mcs_160);
+		he_cap->he_cap_elem.phy_cap_info[0] &=
+			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+	}
+
+	own_80p80 = !!(own_he_cap.he_cap_elem.phy_cap_info[0] &
+		  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G);
+	peer_80p80 = !!(he_cap->he_cap_elem.phy_cap_info[0] &
+		  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G);
+
+	if (peer_80p80 && own_80p80) {
+		ieee80211_he_mcs_intersection(&own_he_cap.he_mcs_nss_supp.rx_mcs_80p80,
+					      &he_cap->he_mcs_nss_supp.rx_mcs_80p80,
+					      &own_he_cap.he_mcs_nss_supp.tx_mcs_80p80,
+					      &he_cap->he_mcs_nss_supp.tx_mcs_80p80);
+	} else if (peer_80p80 && !own_80p80) {
+		ieee80211_he_mcs_disable(&he_cap->he_mcs_nss_supp.rx_mcs_80p80);
+		ieee80211_he_mcs_disable(&he_cap->he_mcs_nss_supp.tx_mcs_80p80);
+		he_cap->he_cap_elem.phy_cap_info[0] &=
+			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
+	}
 }
 
 void
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 2a21226fb518..93c8e8d0b9e3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1915,6 +1915,11 @@ ieee80211_sta_rx_bw_to_chan_width(struct sta_info *sta);
 
 /* HE */
 void
+ieee80211_he_mcs_disable(u16 *he_mcs);
+void
+ieee80211_he_mcs_intersection(u16 *he_own_rx, u16 *he_peer_rx,
+			      u16 *he_own_tx, u16 *he_peer_tx);
+void
 ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_supported_band *sband,
 				  const u8 *he_cap_ie, u8 he_cap_len,
-- 
2.23.0

