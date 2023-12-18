Return-Path: <linux-wireless+bounces-929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E69B8173D3
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 15:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D4B1C24260
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B930B42381;
	Mon, 18 Dec 2023 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ABraujKc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s1X9XmfA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEF43D57B
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702910230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Otl+NpsEL3PAMBJcmNZWGY2l9CvTQ/WiB2HvHTF9jio=;
	b=ABraujKc4zdDpfklqlXGYEON3WjIiY3r6ucb/kE+37bZaE9TRs6A35tDq7Hg6TKWh/MKTU
	qWXVfbofIJkf7wsiriyDri2d7XTe4ZF2/m4zeywrP1kRO1U3k4JaL4u9zDG41u/kwZTLWw
	POxhUsa5Z1njmfs2Eqi++3ePd/u7rAGYCUs8a0Qv0igyTETg5R5IJnbXigJjMiqHh9QPmS
	HR58K9HvyUbX70a9DrBp4n2btj5U1gFchyEYdnmuC4IsFL3L68FfgDB7PNF7EQWRtKlrdR
	hWc/AV/kybtHDdYN9TTfdKe7DaLncjXAet/7oQM0DtPrOniMhihMc6PVW1SzBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702910230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Otl+NpsEL3PAMBJcmNZWGY2l9CvTQ/WiB2HvHTF9jio=;
	b=s1X9XmfAQo1uvX/NHd4cnLa7vpaVmwbqgisM6+XsnmPAMjbNaCDujHG1KhKe1TefrIkNz2
	CWBOGm7dcCoZpxCA==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 18/20] wifi: rtl8xxxu: add hw crypto support for AP mode
Date: Mon, 18 Dec 2023 15:36:43 +0100
Message-Id: <20231218143645.433356-19-martin.kaistra@linutronix.de>
In-Reply-To: <20231218143645.433356-1-martin.kaistra@linutronix.de>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a custom function for allocating entries in the sec cam. This allows
us to store multiple keys with the same keyidx.

The maximum number of sec cam entries (for 8188f) is 16 according to the
vendor driver.

Set the bssid as mac address for group keys instead of just using the
ethernet broadcast address and use BIT(6) in the sec cam ctrl entry
for differentiating them from pairwise keys like in the vendor driver.

Add the TXDESC_EN_DESC_ID bit and the hw_key_idx to tx
broadcast/multicast packets in AP mode.

Finally, allow the usage of rtl8xxxu_set_key() for AP mode.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  4 ++
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 48 +++++++++++++++----
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 889ef7217f142..a0222d2666000 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -498,6 +498,7 @@ struct rtl8xxxu_txdesc40 {
 #define DESC_RATE_ID_SHIFT		16
 #define DESC_RATE_ID_MASK		0xf
 #define TXDESC_NAVUSEHDR		BIT(20)
+#define TXDESC_EN_DESC_ID		BIT(21)
 #define TXDESC_SEC_RC4			0x00400000
 #define TXDESC_SEC_AES			0x00c00000
 #define TXDESC_PKT_OFFSET_SHIFT		26
@@ -1774,6 +1775,7 @@ struct rtl8xxxu_cfo_tracking {
 #define RTL8XXXU_HW_LED_CONTROL	2
 #define RTL8XXXU_MAX_MAC_ID_NUM	128
 #define RTL8XXXU_BC_MC_MACID	0
+#define RTL8XXXU_MAX_SEC_CAM_NUM	16
 
 struct rtl8xxxu_priv {
 	struct ieee80211_hw *hw;
@@ -1907,6 +1909,7 @@ struct rtl8xxxu_priv {
 	char led_name[32];
 	struct led_classdev led_cdev;
 	DECLARE_BITMAP(mac_id_map, RTL8XXXU_MAX_MAC_ID_NUM);
+	DECLARE_BITMAP(cam_map, RTL8XXXU_MAX_SEC_CAM_NUM);
 };
 
 struct rtl8xxxu_sta_info {
@@ -1918,6 +1921,7 @@ struct rtl8xxxu_sta_info {
 
 struct rtl8xxxu_vif {
 	int port_num;
+	u8 hw_key_idx;
 };
 
 struct rtl8xxxu_rx_urb {
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index c2a577ebd061e..88730791091a7 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4558,8 +4558,10 @@ static void rtl8xxxu_cam_write(struct rtl8xxxu_priv *priv,
 	 * This is a bit of a hack - the lower bits of the cipher
 	 * suite selector happens to match the cipher index in the CAM
 	 */
-	addr = key->keyidx << CAM_CMD_KEY_SHIFT;
+	addr = key->hw_key_idx << CAM_CMD_KEY_SHIFT;
 	ctrl = (key->cipher & 0x0f) << 2 | key->keyidx | CAM_WRITE_VALID;
+	if (!(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+		ctrl |= BIT(6);
 
 	for (j = 5; j >= 0; j--) {
 		switch (j) {
@@ -5545,13 +5547,14 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 	struct rtl8xxxu_tx_urb *tx_urb;
 	struct ieee80211_sta *sta = NULL;
 	struct ieee80211_vif *vif = tx_info->control.vif;
+	struct rtl8xxxu_vif *rtlvif = (struct rtl8xxxu_vif *)vif->drv_priv;
 	struct device *dev = &priv->udev->dev;
 	u32 queue, rts_rate;
 	u16 pktlen = skb->len;
 	int tx_desc_size = priv->fops->tx_desc_size;
 	u8 macid;
 	int ret;
-	bool ampdu_enable, sgi = false, short_preamble = false;
+	bool ampdu_enable, sgi = false, short_preamble = false, bmc = false;
 
 	if (skb_headroom(skb) < tx_desc_size) {
 		dev_warn(dev,
@@ -5593,10 +5596,14 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 		tx_desc->txdw0 =
 			TXDESC_OWN | TXDESC_FIRST_SEGMENT | TXDESC_LAST_SEGMENT;
 	if (is_multicast_ether_addr(ieee80211_get_DA(hdr)) ||
-	    is_broadcast_ether_addr(ieee80211_get_DA(hdr)))
+	    is_broadcast_ether_addr(ieee80211_get_DA(hdr))) {
 		tx_desc->txdw0 |= TXDESC_BROADMULTICAST;
+		bmc = true;
+	}
+
 
 	tx_desc->txdw1 = cpu_to_le32(queue << TXDESC_QUEUE_SHIFT);
+	macid = rtl8xxxu_get_macid(priv, sta);
 
 	if (tx_info->control.hw_key) {
 		switch (tx_info->control.hw_key->cipher) {
@@ -5611,6 +5618,10 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 		default:
 			break;
 		}
+		if (bmc && rtlvif->hw_key_idx != 0xff) {
+			tx_desc->txdw1 |= TXDESC_EN_DESC_ID;
+			macid = rtlvif->hw_key_idx;
+		}
 	}
 
 	/* (tx_info->flags & IEEE80211_TX_CTL_AMPDU) && */
@@ -5654,7 +5665,6 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 	else
 		rts_rate = 0;
 
-	macid = rtl8xxxu_get_macid(priv, sta);
 	priv->fops->fill_txdesc(hw, hdr, tx_info, tx_desc, sgi, short_preamble,
 				ampdu_enable, rts_rate, macid);
 
@@ -6656,6 +6666,7 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
 
 	priv->vifs[port_num] = vif;
 	rtlvif->port_num = port_num;
+	rtlvif->hw_key_idx = 0xff;
 
 	rtl8xxxu_set_linktype(priv, vif->type, port_num);
 	ether_addr_copy(priv->mac_addr, vif->addr);
@@ -6832,11 +6843,19 @@ static int rtl8xxxu_set_rts_threshold(struct ieee80211_hw *hw, u32 rts)
 	return 0;
 }
 
+static int rtl8xxxu_get_free_sec_cam(struct ieee80211_hw *hw)
+{
+	struct rtl8xxxu_priv *priv = hw->priv;
+
+	return find_first_zero_bit(priv->cam_map, RTL8XXXU_MAX_SEC_CAM_NUM);
+}
+
 static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			    struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta,
 			    struct ieee80211_key_conf *key)
 {
+	struct rtl8xxxu_vif *rtlvif = (struct rtl8xxxu_vif *)vif->drv_priv;
 	struct rtl8xxxu_priv *priv = hw->priv;
 	struct device *dev = &priv->udev->dev;
 	u8 mac_addr[ETH_ALEN];
@@ -6848,9 +6867,6 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	dev_dbg(dev, "%s: cmd %02x, cipher %08x, index %i\n",
 		__func__, cmd, key->cipher, key->keyidx);
 
-	if (vif->type != NL80211_IFTYPE_STATION)
-		return -EOPNOTSUPP;
-
 	if (key->keyidx > 3)
 		return -EOPNOTSUPP;
 
@@ -6874,7 +6890,7 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		ether_addr_copy(mac_addr, sta->addr);
 	} else {
 		dev_dbg(dev, "%s: group key\n", __func__);
-		eth_broadcast_addr(mac_addr);
+		ether_addr_copy(mac_addr, vif->bss_conf.bssid);
 	}
 
 	val16 = rtl8xxxu_read16(priv, REG_CR);
@@ -6888,16 +6904,28 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	switch (cmd) {
 	case SET_KEY:
-		key->hw_key_idx = key->keyidx;
+
+		retval = rtl8xxxu_get_free_sec_cam(hw);
+		if (retval < 0)
+			return -EOPNOTSUPP;
+
+		key->hw_key_idx = retval;
+
+		if (vif->type == NL80211_IFTYPE_AP && !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+			rtlvif->hw_key_idx = key->hw_key_idx;
+
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV;
 		rtl8xxxu_cam_write(priv, key, mac_addr);
+		set_bit(key->hw_key_idx, priv->cam_map);
 		retval = 0;
 		break;
 	case DISABLE_KEY:
 		rtl8xxxu_write32(priv, REG_CAM_WRITE, 0x00000000);
 		val32 = CAM_CMD_POLLING | CAM_CMD_WRITE |
-			key->keyidx << CAM_CMD_KEY_SHIFT;
+			key->hw_key_idx << CAM_CMD_KEY_SHIFT;
 		rtl8xxxu_write32(priv, REG_CAM_CMD, val32);
+		rtlvif->hw_key_idx = 0xff;
+		clear_bit(key->hw_key_idx, priv->cam_map);
 		retval = 0;
 		break;
 	default:
-- 
2.39.2


