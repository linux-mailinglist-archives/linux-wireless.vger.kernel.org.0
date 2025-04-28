Return-Path: <linux-wireless+bounces-22138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77577A9EF07
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 13:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA5717DE0D
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 11:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADA41B4138;
	Mon, 28 Apr 2025 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="UdO2Kl3U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9EA25E800
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 11:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839563; cv=none; b=VKrinMPBT/gv+id0pYdERsIROX7x3LjqVqF9+923s7Sraot3hxoGsojlPovrQflhi9siZzSEkzwqCzyQ71qZ6lpgvP0oszRdnTeOTP6Bsw3bEgbi2pS3kHxg5Fw0YbQtAhwZJA5/MEWR8u+ZclUaB45I9JQS1T7C2DN/eIxTgQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839563; c=relaxed/simple;
	bh=Xtp5+Ofxic6ztJPmZlWOV808Sc1YRIkZZTT81MyEJNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EqpwG2ZBUUGreBeqNZrNsNW5JBoYqrW3E1RpEdJvp6zYRxXLxf49SfLOxdSmIIrDIHaVm1swRPJ0jmnCNTnYi+AQ67Q0lUrjGkrUTU9pOjjmtx1zBB3WyKU8fqYRS8QL4l3v1O1g2ArfMpv6bpwvuJDWQ1OXksY4pZQknjMO6pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=UdO2Kl3U; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53SBPxpX62101270, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745839559; bh=Xtp5+Ofxic6ztJPmZlWOV808Sc1YRIkZZTT81MyEJNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=UdO2Kl3UP9rodN/LmwZu+B6/xGLsndhh1OuVICnx+003g6HKhQ5q/v9Kv1cEYiNuB
	 nEdJ1LLXjOC8UrAyhj5iR05ZqQpWR7JbwofA0huJaga0ganB0+KyCpqzwraNF/lYIc
	 xGXAdPOiShrL9dTRDTfI2htspJAMMPdLpdkEoOdU0+XdaIuftBkvIiTLnA249QVTBB
	 CHcoI8tf8aFHhBvaXLKvHDwq4ORL/G+kvNfnAeVEbLLV9UDt1iXT2YGDJWDKAmn+Gc
	 ROF8J/DhuPKe93Xsl78WFgZZUIuwOrtwiHj4AnwdiBK4b2RV052UK1LE7wMHqbdsBZ
	 9H1tusVCUJ5YA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53SBPxpX62101270
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 19:25:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Apr 2025 19:25:59 +0800
Received: from [127.0.1.1] (172.16.19.226) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 28 Apr
 2025 19:25:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 08/10] wifi: rtw89: Fill in correct Rx link ID for MLO
Date: Mon, 28 Apr 2025 19:24:54 +0800
Message-ID: <20250428112456.13165-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250428112456.13165-1-pkshih@realtek.com>
References: <20250428112456.13165-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Po-Hao Huang <phhuang@realtek.com>

For MLO connections, RX link ID is required to do address conversion.
Fill it in by the hardware info.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 26 +++++++++++------------
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index fe482a923e8e..c718dd83dc1e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1654,10 +1654,7 @@ static void rtw89_core_rx_process_phy_ppdu_iter(void *data,
 	u8 evm_pos = 0;
 	int i;
 
-	/* FIXME: For single link, taking link on HW-0 here is okay. But, when
-	 * enabling multiple active links, we should determine the right link.
-	 */
-	rtwsta_link = rtw89_sta_get_link_inst(rtwsta, 0);
+	rtwsta_link = rtw89_sta_get_link_inst(rtwsta, phy_ppdu->phy_idx);
 	if (unlikely(!rtwsta_link))
 		return;
 
@@ -2182,8 +2179,10 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 	struct rtw89_pkt_stat *pkt_stat = &rtwdev->phystat.cur_pkt_stat;
 	struct rtw89_rx_desc_info *desc_info = iter_data->desc_info;
 	struct sk_buff *skb = iter_data->skb;
+	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct rtw89_rx_phy_ppdu *phy_ppdu = iter_data->phy_ppdu;
+	bool is_mld = ieee80211_vif_is_mld(vif);
 	struct ieee80211_bss_conf *bss_conf;
 	struct rtw89_vif_link *rtwvif_link;
 	const u8 *bssid = iter_data->bssid;
@@ -2195,10 +2194,7 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 
 	rcu_read_lock();
 
-	/* FIXME: For single link, taking link on HW-0 here is okay. But, when
-	 * enabling multiple active links, we should determine the right link.
-	 */
-	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
+	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, desc_info->bb_sel);
 	if (unlikely(!rtwvif_link))
 		goto out;
 
@@ -2214,6 +2210,11 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 	if (!ether_addr_equal(bss_conf->bssid, bssid))
 		goto out;
 
+	if (is_mld) {
+		rx_status->link_valid = true;
+		rx_status->link_id = rtwvif_link->link_id;
+	}
+
 	if (ieee80211_is_beacon(hdr->frame_control)) {
 		if (vif->type == NL80211_IFTYPE_STATION &&
 		    !test_bit(RTW89_FLAG_WOWLAN, rtwdev->flags)) {
@@ -2512,7 +2513,8 @@ static void rtw89_core_rx_process_ppdu_sts(struct rtw89_dev *rtwdev,
 					     .len = skb->len,
 					     .to_self = desc_info->addr1_match,
 					     .rate = desc_info->data_rate,
-					     .mac_id = desc_info->mac_id};
+					     .mac_id = desc_info->mac_id,
+					     .phy_idx = desc_info->bb_sel};
 	int ret;
 
 	if (desc_info->mac_info_valid) {
@@ -2623,6 +2625,7 @@ void rtw89_core_query_rxdesc_v2(struct rtw89_dev *rtwdev,
 	desc_info->shift = le32_get_bits(rxd_s->dword0, BE_RXD_SHIFT_MASK);
 	desc_info->long_rxdesc = le32_get_bits(rxd_s->dword0, BE_RXD_LONG_RXD);
 	desc_info->pkt_type = le32_get_bits(rxd_s->dword0, BE_RXD_RPKT_TYPE_MASK);
+	desc_info->bb_sel = le32_get_bits(rxd_s->dword0, BE_RXD_BB_SEL);
 	if (desc_info->pkt_type == RTW89_CORE_RX_TYPE_PPDU_STAT)
 		desc_info->mac_info_valid = true;
 
@@ -2695,10 +2698,7 @@ void rtw89_core_stats_sta_rx_status_iter(void *data, struct ieee80211_sta *sta)
 	struct rtw89_sta_link *rtwsta_link;
 	u8 mac_id = iter_data->mac_id;
 
-	/* FIXME: For single link, taking link on HW-0 here is okay. But, when
-	 * enabling multiple active links, we should determine the right link.
-	 */
-	rtwsta_link = rtw89_sta_get_link_inst(rtwsta, 0);
+	rtwsta_link = rtw89_sta_get_link_inst(rtwsta, desc_info->bb_sel);
 	if (unlikely(!rtwsta_link))
 		return;
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 8f51bbde1fad..ce5521c413a1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -798,6 +798,7 @@ struct rtw89_rx_phy_ppdu {
 	u8 rssi[RF_PATH_MAX];
 	u8 mac_id;
 	u8 chan_idx;
+	u8 phy_idx;
 	u8 ie;
 	u16 rate;
 	u8 rpl_avg;
-- 
2.25.1


