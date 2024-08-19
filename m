Return-Path: <linux-wireless+bounces-11596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B5E956142
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 04:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 149C3B216DF
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 02:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331D14594A;
	Mon, 19 Aug 2024 02:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="jerGQoQC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669E2381C2
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 02:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724035981; cv=none; b=TYFQqQLY6tsnvAx0gqKONreaLxt4DrpzYXSKlBKwrK6/kSanjhS68nTg9Vvj2HmDcvs9Zf1W5eQx0fPn1ckfNsy/Bnv0Svnk5EyFOCYT+/sWHQ+nhhcwczo+ZDLiNgxnr+dbL55fFgyHVJgI7ag6OHbZ9bIKr5lGhHr2LVdJTuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724035981; c=relaxed/simple;
	bh=ZN96AwL2KsBQqu0cIFeHRYHxE7NB+f8wSAU2QFiwhQo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j06NeG6U2twXAdjPPGpBiEUb3NXaHYqE6HlNFuGblR3kaOfy0pa08TZ33O3rUFtZbN5NaPQSbtTSboOIXsh44D99+KEVSNlbKR91foONkijmKLPQ4jX6DFOOUsL6X7UdUi4kU+kg63lCkx6/01uVK/efdZ0JBiX2xmAc86rXmk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=jerGQoQC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47J2qrh073762440, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724035973; bh=ZN96AwL2KsBQqu0cIFeHRYHxE7NB+f8wSAU2QFiwhQo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=jerGQoQC1m7gS28kPEKMTy+8vW+NT9Jhalatgl0RASDNPsT/CoVPt0WnhNtACiZkF
	 wP/Pkfeofn5QGIEx+FAELJbfQaDsVDMkBOoEYeSSaHs/egGUuokzmx8Re/VdZv6f+e
	 GOSNpUXySAGEo92tFeFW9/Ivwv0Rix/+i9VO11YF+XRc/d49NW7TvuicocrLSQFCHJ
	 HQteXKTbXqvjEeUBEbApfkuufsiY1B/t/qtxnPd4hmYAaUWoBRgWCY1ISe6eul/Kp7
	 t/2fezdVFp0fFs+6CUfwJvkOFm5rwwcLWf5y5F9xffDJk20bUIfuhGZyb9S8suKCQt
	 TaSljmD8p0CaQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47J2qrh073762440
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 10:52:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 10:52:53 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 19 Aug
 2024 10:52:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtw88: assign mac_id for vif/sta and update to TX desc
Date: Mon, 19 Aug 2024 10:52:48 +0800
Message-ID: <20240819025248.17939-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

A mac_id as an instance in firmware has to be assigned for each station
including AP and connected stations. Firmware will use the mac_id to
control TX rate and do statistics.

Assignment rule is to assign mac_id to each vif when adding vif.
For station mode, sta->mac_id will reuse vif->mac_id. For AP mode,
dynamically allocate an sta->mac_id to a station, and vif->mac_id is
used to send broadcast/multicast packets which are not belong to
a station. For example,

                  vif->mac_id      sta->mac_id
vif0 (STA mode)        0               0
vif1 (AP mode)         1               2...

By the way, remove unused RTW_BC_MC_MACID, which was planed to send
broadcast/multicast packets on fixed mac_id.

Tested-on RTL8822CE with STA + AP SCC mode.

Link: https://lore.kernel.org/linux-wireless/e4be0a75-43b2-4ae5-9aab-5c4a88e78097@gmail.com/
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c | 13 ++++++--
 drivers/net/wireless/realtek/rtw88/main.c     | 30 ++++++++-----------
 drivers/net/wireless/realtek/rtw88/main.h     | 14 +++++++--
 drivers/net/wireless/realtek/rtw88/tx.c       | 11 +++++--
 drivers/net/wireless/realtek/rtw88/tx.h       |  1 +
 5 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 63326b352738..b39e90fb66b4 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -167,6 +167,12 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 
 	mutex_lock(&rtwdev->mutex);
 
+	rtwvif->mac_id = rtw_acquire_macid(rtwdev);
+	if (rtwvif->mac_id >= RTW_MAX_MAC_ID_NUM) {
+		mutex_unlock(&rtwdev->mutex);
+		return -ENOSPC;
+	}
+
 	port = find_first_zero_bit(rtwdev->hw_port, RTW_PORT_NUM);
 	if (port >= RTW_PORT_NUM) {
 		mutex_unlock(&rtwdev->mutex);
@@ -214,7 +220,8 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 
 	mutex_unlock(&rtwdev->mutex);
 
-	rtw_dbg(rtwdev, RTW_DBG_STATE, "start vif %pM on port %d\n", vif->addr, rtwvif->port);
+	rtw_dbg(rtwdev, RTW_DBG_STATE, "start vif %pM mac_id %d on port %d\n",
+		vif->addr, rtwvif->mac_id, rtwvif->port);
 	return 0;
 }
 
@@ -225,7 +232,8 @@ static void rtw_ops_remove_interface(struct ieee80211_hw *hw,
 	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
 	u32 config = 0;
 
-	rtw_dbg(rtwdev, RTW_DBG_STATE, "stop vif %pM on port %d\n", vif->addr, rtwvif->port);
+	rtw_dbg(rtwdev, RTW_DBG_STATE, "stop vif %pM mac_id %d on port %d\n",
+		vif->addr, rtwvif->mac_id, rtwvif->port);
 
 	mutex_lock(&rtwdev->mutex);
 
@@ -242,6 +250,7 @@ static void rtw_ops_remove_interface(struct ieee80211_hw *hw,
 	config |= PORT_SET_BCN_CTRL;
 	rtw_vif_port_config(rtwdev, rtwvif, config);
 	clear_bit(rtwvif->port, rtwdev->hw_port);
+	rtw_release_macid(rtwdev, rtwvif->mac_id);
 	rtw_recalc_lps(rtwdev, NULL);
 
 	mutex_unlock(&rtwdev->mutex);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index b0c9b0ff7017..bbdef38c7e34 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -311,17 +311,6 @@ static void rtw_ips_work(struct work_struct *work)
 	mutex_unlock(&rtwdev->mutex);
 }
 
-static u8 rtw_acquire_macid(struct rtw_dev *rtwdev)
-{
-	unsigned long mac_id;
-
-	mac_id = find_first_zero_bit(rtwdev->mac_id_map, RTW_MAX_MAC_ID_NUM);
-	if (mac_id < RTW_MAX_MAC_ID_NUM)
-		set_bit(mac_id, rtwdev->mac_id_map);
-
-	return mac_id;
-}
-
 static void rtw_sta_rc_work(struct work_struct *work)
 {
 	struct rtw_sta_info *si = container_of(work, struct rtw_sta_info,
@@ -340,12 +329,14 @@ int rtw_sta_add(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
 	int i;
 
-	si->mac_id = rtw_acquire_macid(rtwdev);
-	if (si->mac_id >= RTW_MAX_MAC_ID_NUM)
-		return -ENOSPC;
+	if (vif->type == NL80211_IFTYPE_STATION) {
+		si->mac_id = rtwvif->mac_id;
+	} else {
+		si->mac_id = rtw_acquire_macid(rtwdev);
+		if (si->mac_id >= RTW_MAX_MAC_ID_NUM)
+			return -ENOSPC;
+	}
 
-	if (vif->type == NL80211_IFTYPE_STATION && vif->cfg.assoc == 0)
-		rtwvif->mac_id = si->mac_id;
 	si->rtwdev = rtwdev;
 	si->sta = sta;
 	si->vif = vif;
@@ -370,11 +361,13 @@ void rtw_sta_remove(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 		    bool fw_exist)
 {
 	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
+	struct ieee80211_vif *vif = si->vif;
 	int i;
 
 	cancel_work_sync(&si->rc_work);
 
-	rtw_release_macid(rtwdev, si->mac_id);
+	if (vif->type != NL80211_IFTYPE_STATION)
+		rtw_release_macid(rtwdev, si->mac_id);
 	if (fw_exist)
 		rtw_fw_media_status_report(rtwdev, si->mac_id, false);
 
@@ -614,6 +607,8 @@ static void rtw_reset_vif_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
 	rtw_bf_disassoc(rtwdev, vif, NULL);
 	rtw_vif_assoc_changed(rtwvif, NULL);
 	rtw_txq_cleanup(rtwdev, vif->txq);
+
+	rtw_release_macid(rtwdev, rtwvif->mac_id);
 }
 
 void rtw_fw_recovery(struct rtw_dev *rtwdev)
@@ -2139,7 +2134,6 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 	rtwdev->sec.total_cam_num = 32;
 	rtwdev->hal.current_channel = 1;
 	rtwdev->dm_info.fix_rate = U8_MAX;
-	set_bit(RTW_BC_MC_MACID, rtwdev->mac_id_map);
 
 	rtw_stats_init(rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 12b564ad3a58..945117afe143 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -742,7 +742,6 @@ struct rtw_txq {
 	unsigned long flags;
 };
 
-#define RTW_BC_MC_MACID 1
 DECLARE_EWMA(rssi, 10, 16);
 
 struct rtw_sta_info {
@@ -805,7 +804,7 @@ struct rtw_bf_info {
 struct rtw_vif {
 	enum rtw_net_type net_type;
 	u16 aid;
-	u8 mac_id; /* for STA mode only */
+	u8 mac_id;
 	u8 mac_addr[ETH_ALEN];
 	u8 bssid[ETH_ALEN];
 	u8 port;
@@ -2131,6 +2130,17 @@ static inline bool rtw_chip_has_tx_stbc(struct rtw_dev *rtwdev)
 	return rtwdev->chip->tx_stbc;
 }
 
+static inline u8 rtw_acquire_macid(struct rtw_dev *rtwdev)
+{
+	unsigned long mac_id;
+
+	mac_id = find_first_zero_bit(rtwdev->mac_id_map, RTW_MAX_MAC_ID_NUM);
+	if (mac_id < RTW_MAX_MAC_ID_NUM)
+		set_bit(mac_id, rtwdev->mac_id_map);
+
+	return mac_id;
+}
+
 static inline void rtw_release_macid(struct rtw_dev *rtwdev, u8 mac_id)
 {
 	clear_bit(mac_id, rtwdev->mac_id_map);
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index c02ac673be32..dae7ca148865 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -46,7 +46,8 @@ void rtw_tx_fill_tx_desc(struct rtw_tx_pkt_info *pkt_info, struct sk_buff *skb)
 		      le32_encode_bits(pkt_info->ls, RTW_TX_DESC_W0_LS) |
 		      le32_encode_bits(pkt_info->dis_qselseq, RTW_TX_DESC_W0_DISQSELSEQ);
 
-	tx_desc->w1 = le32_encode_bits(pkt_info->qsel, RTW_TX_DESC_W1_QSEL) |
+	tx_desc->w1 = le32_encode_bits(pkt_info->mac_id, RTW_TX_DESC_W1_MACID) |
+		      le32_encode_bits(pkt_info->qsel, RTW_TX_DESC_W1_QSEL) |
 		      le32_encode_bits(pkt_info->rate_id, RTW_TX_DESC_W1_RATE_ID) |
 		      le32_encode_bits(pkt_info->sec_type, RTW_TX_DESC_W1_SEC_TYPE) |
 		      le32_encode_bits(pkt_info->pkt_offset, RTW_TX_DESC_W1_PKT_OFFSET) |
@@ -401,14 +402,18 @@ void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_vif *vif = info->control.vif;
 	struct rtw_sta_info *si;
-	struct ieee80211_vif *vif = NULL;
+	struct rtw_vif *rtwvif;
 	__le16 fc = hdr->frame_control;
 	bool bmc;
 
 	if (sta) {
 		si = (struct rtw_sta_info *)sta->drv_priv;
-		vif = si->vif;
+		pkt_info->mac_id = si->mac_id;
+	} else if (vif) {
+		rtwvif = (struct rtw_vif *)vif->drv_priv;
+		pkt_info->mac_id = rtwvif->mac_id;
 	}
 
 	if (ieee80211_is_mgmt(fc) || ieee80211_is_nullfunc(fc))
diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
index 324189606257..3d544fd7f60f 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.h
+++ b/drivers/net/wireless/realtek/rtw88/tx.h
@@ -27,6 +27,7 @@ struct rtw_tx_desc {
 #define RTW_TX_DESC_W0_BMC BIT(24)
 #define RTW_TX_DESC_W0_LS BIT(26)
 #define RTW_TX_DESC_W0_DISQSELSEQ BIT(31)
+#define RTW_TX_DESC_W1_MACID GENMASK(7, 0)
 #define RTW_TX_DESC_W1_QSEL GENMASK(12, 8)
 #define RTW_TX_DESC_W1_RATE_ID GENMASK(20, 16)
 #define RTW_TX_DESC_W1_SEC_TYPE GENMASK(23, 22)
-- 
2.25.1


