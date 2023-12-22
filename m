Return-Path: <linux-wireless+bounces-1241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC6A81C805
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 11:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8744A1F25D40
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 10:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C821CA96;
	Fri, 22 Dec 2023 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CsR3goGU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aXZDT7sd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B693718C3F
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703240090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iai9m/7T0bqmCvoUZE2i/47FQ+4dCGDwpLs2cq3puz4=;
	b=CsR3goGUcIjp8KVV4fYmy3KqAzvh9s+HLCRWc+bQzPtrunYbiobmoEFe4CtLyQhi1jUtqb
	s+GNbbJYsoJoauqHDdlymj9GT/OXllFBrS4OvG7titEw47Blk8U3pBV+oYjihKwh7iTXgO
	ezJLQlN6LiQeRkKJVxzHpisLb+nrEdeJgEeXledSjnJTl2muiF8iI5MmFTqSt7UINBim4w
	e9mtcUWLA91uewHIo0BppnYO0VC1HrJaUCuQs/TnVruT2ZpuAuXuaz138ntWMSB+6CCARx
	jj/pei86BGUrLvCgSjZ7CUynAbHpn3JzZxsg0UW0Yjli10YzcV9UOiuhNF2suw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703240090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iai9m/7T0bqmCvoUZE2i/47FQ+4dCGDwpLs2cq3puz4=;
	b=aXZDT7sdTohvEsKIyozQ9nGav0wGSRbxwAx85m2IZZM5GCzauv5Ed0s8ocNc0TXsxD5QlF
	JrWC66xOHtD3PKDw==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 19/21] wifi: rtl8xxxu: add hw crypto support for AP mode
Date: Fri, 22 Dec 2023 11:14:40 +0100
Message-Id: <20231222101442.626837-20-martin.kaistra@linutronix.de>
In-Reply-To: <20231222101442.626837-1-martin.kaistra@linutronix.de>
References: <20231222101442.626837-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a custom function for allocating entries in the sec cam. This allows
us to store multiple keys with the same keyidx.

The maximum number of sec cam entries for 8188f is 16 according to the
vendor driver. Add the number to rtl8xxxu_fileops, so that other chips
which might support more entries, can set a different number there.

Set the bssid as mac address for group keys instead of just using the
ethernet broadcast address and use BIT(6) in the sec cam ctrl entry
for differentiating them from pairwise keys like in the vendor driver.

Add the TXDESC_EN_DESC_ID bit and the hw_key_idx to tx
broadcast/multicast packets in AP mode.

Finally, allow the usage of rtl8xxxu_set_key() for AP mode.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  5 ++
 .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |  1 +
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 48 +++++++++++++++----
 3 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index c5e6d8f7d26bd..62e6318bc0924 100644
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
@@ -1775,6 +1776,7 @@ struct rtl8xxxu_cfo_tracking {
 #define RTL8XXXU_MAX_MAC_ID_NUM	128
 #define RTL8XXXU_BC_MC_MACID	0
 #define RTL8XXXU_BC_MC_MACID1	1
+#define RTL8XXXU_MAX_SEC_CAM_NUM	64
 
 struct rtl8xxxu_priv {
 	struct ieee80211_hw *hw;
@@ -1908,6 +1910,7 @@ struct rtl8xxxu_priv {
 	char led_name[32];
 	struct led_classdev led_cdev;
 	DECLARE_BITMAP(mac_id_map, RTL8XXXU_MAX_MAC_ID_NUM);
+	DECLARE_BITMAP(cam_map, RTL8XXXU_MAX_SEC_CAM_NUM);
 };
 
 struct rtl8xxxu_sta_info {
@@ -1919,6 +1922,7 @@ struct rtl8xxxu_sta_info {
 
 struct rtl8xxxu_vif {
 	int port_num;
+	u8 hw_key_idx;
 };
 
 struct rtl8xxxu_rx_urb {
@@ -1993,6 +1997,7 @@ struct rtl8xxxu_fileops {
 	u16 max_aggr_num;
 	u8 supports_ap:1;
 	u16 max_macid_num;
+	u16 max_sec_cam_num;
 	u32 adda_1t_init;
 	u32 adda_1t_path_on;
 	u32 adda_2t_path_on_a;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index 1e1c8fa194cb8..574a5fe951543 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -1751,6 +1751,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
 	.max_aggr_num = 0x0c14,
 	.supports_ap = 1,
 	.max_macid_num = 16,
+	.max_sec_cam_num = 16,
 	.adda_1t_init = 0x03c00014,
 	.adda_1t_path_on = 0x03c00014,
 	.trxff_boundary = 0x3f7f,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index ecf54eb8dba61..7aafae9fe76b8 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4559,8 +4559,10 @@ static void rtl8xxxu_cam_write(struct rtl8xxxu_priv *priv,
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
@@ -5546,13 +5548,14 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
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
@@ -5594,10 +5597,14 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
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
@@ -5612,6 +5619,10 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 		default:
 			break;
 		}
+		if (bmc && rtlvif->hw_key_idx != 0xff) {
+			tx_desc->txdw1 |= TXDESC_EN_DESC_ID;
+			macid = rtlvif->hw_key_idx;
+		}
 	}
 
 	/* (tx_info->flags & IEEE80211_TX_CTL_AMPDU) && */
@@ -5655,7 +5666,6 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 	else
 		rts_rate = 0;
 
-	macid = rtl8xxxu_get_macid(priv, sta);
 	priv->fops->fill_txdesc(hw, hdr, tx_info, tx_desc, sgi, short_preamble,
 				ampdu_enable, rts_rate, macid);
 
@@ -6667,6 +6677,7 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
 
 	priv->vifs[port_num] = vif;
 	rtlvif->port_num = port_num;
+	rtlvif->hw_key_idx = 0xff;
 
 	rtl8xxxu_set_linktype(priv, vif->type, port_num);
 	ether_addr_copy(priv->mac_addr, vif->addr);
@@ -6843,11 +6854,19 @@ static int rtl8xxxu_set_rts_threshold(struct ieee80211_hw *hw, u32 rts)
 	return 0;
 }
 
+static int rtl8xxxu_get_free_sec_cam(struct ieee80211_hw *hw)
+{
+	struct rtl8xxxu_priv *priv = hw->priv;
+
+	return find_first_zero_bit(priv->cam_map, priv->fops->max_sec_cam_num);
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
@@ -6859,9 +6878,6 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	dev_dbg(dev, "%s: cmd %02x, cipher %08x, index %i\n",
 		__func__, cmd, key->cipher, key->keyidx);
 
-	if (vif->type != NL80211_IFTYPE_STATION)
-		return -EOPNOTSUPP;
-
 	if (key->keyidx > 3)
 		return -EOPNOTSUPP;
 
@@ -6885,7 +6901,7 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		ether_addr_copy(mac_addr, sta->addr);
 	} else {
 		dev_dbg(dev, "%s: group key\n", __func__);
-		eth_broadcast_addr(mac_addr);
+		ether_addr_copy(mac_addr, vif->bss_conf.bssid);
 	}
 
 	val16 = rtl8xxxu_read16(priv, REG_CR);
@@ -6899,16 +6915,28 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
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


