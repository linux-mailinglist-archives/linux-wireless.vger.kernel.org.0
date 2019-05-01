Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6284610ABA
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 18:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfEAQIQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 12:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfEAQIP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 12:08:15 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 845612177B;
        Wed,  1 May 2019 16:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556726894;
        bh=CTcktBWvOzwP8VF/jZdnObFhgt47F/aDWV/yoISnVtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xjB0+PoC72m/TxPilS7WawgAn1IKkZp4lfUj7RnxrxN5bNY/5ZBArX3UCL6gPa0lF
         8qQslMVUpKHgxE+6ZZsCIVFfq2EnrC4heUx4HaLqlMBhsO0F0pEkOagYnpGIQCE85g
         GKReRnXHTM6GBuGrgxnfkGCZf8Yv9ZNoplQD2L3A=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [RFC 14/17] mt7615: mcu: use standard signature for mt7615_mcu_msg_send
Date:   Wed,  1 May 2019 18:07:36 +0200
Message-Id: <9fd76648982f403f43b75ac411b5eaa893b94112.1556726268.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556726268.git.lorenzo@kernel.org>
References: <cover.1556726268.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use mt76 common signature for mt7615_mcu_msg_send. Move skb allocation
in mt7615_mcu_msg_send and remove duplicated code. Remove
__mt7615_mcu_set_wtbl and __mt7615_mcu_set_sta_rec since now are used
just to send mcu msgs.  This is a preliminary patch for mt7615-mt7603 mcu
code unification

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 592 +++++++++---------
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  19 +-
 2 files changed, 326 insertions(+), 285 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index b3fb3d731129..511d27ec15f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -57,9 +57,6 @@ static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 	u32 val;
 	__le32 *txd;
 
-	if (!skb)
-		return -EINVAL;
-
 	seq = ++dev->mt76.mmio.mcu.msg_seq & 0xf;
 	if (!seq)
 		seq = ++dev->mt76.mmio.mcu.msg_seq & 0xf;
@@ -116,19 +113,25 @@ static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 }
 
 static int
-mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb, int cmd)
+mt7615_mcu_msg_send(struct mt7615_dev *dev, int cmd, const void *data,
+		    int len, bool wait_resp)
 {
 	unsigned long expires = jiffies + 10 * HZ;
 	struct mt7615_mcu_rxd *rxd;
+	struct sk_buff *skb;
 	int ret, seq;
 
+	skb = mt7615_mcu_msg_alloc(data, len);
+	if (!skb)
+		return -ENOMEM;
+
 	mutex_lock(&dev->mt76.mmio.mcu.mutex);
 
 	ret = __mt7615_mcu_msg_send(dev, skb, cmd, &seq);
 	if (ret)
 		goto out;
 
-	while (1) {
+	while (wait_resp) {
 		skb = mt76_mcu_get_response(&dev->mt76, expires);
 		if (!skb) {
 			dev_err(dev->mt76.dev, "Message %d (seq %d) timeout\n",
@@ -167,9 +170,9 @@ static int mt7615_mcu_init_download(struct mt7615_dev *dev, u32 addr,
 		.len = cpu_to_le32(len),
 		.mode = cpu_to_le32(mode),
 	};
-	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
-	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_TARGET_ADDRESS_LEN_REQ);
+	return mt7615_mcu_msg_send(dev, -MCU_CMD_TARGET_ADDRESS_LEN_REQ,
+				   &req, sizeof(req), true);
 }
 
 static int mt7615_mcu_send_firmware(struct mt7615_dev *dev, const void *data,
@@ -208,16 +211,15 @@ static int mt7615_mcu_start_firmware(struct mt7615_dev *dev, u32 addr,
 		.option = cpu_to_le32(option),
 		.addr = cpu_to_le32(addr),
 	};
-	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
-	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_FW_START_REQ);
+	return mt7615_mcu_msg_send(dev, -MCU_CMD_FW_START_REQ,
+				   &req, sizeof(req), true);
 }
 
 static int mt7615_mcu_restart(struct mt7615_dev *dev)
 {
-	struct sk_buff *skb = mt7615_mcu_msg_alloc(NULL, 0);
-
-	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_RESTART_DL_REQ);
+	return mt7615_mcu_msg_send(dev, -MCU_CMD_RESTART_DL_REQ,
+				   NULL, 0, true);
 }
 
 static int mt7615_mcu_patch_sem_ctrl(struct mt7615_dev *dev, bool get)
@@ -227,9 +229,9 @@ static int mt7615_mcu_patch_sem_ctrl(struct mt7615_dev *dev, bool get)
 	} req = {
 		.op = cpu_to_le32(get ? PATCH_SEM_GET : PATCH_SEM_RELEASE),
 	};
-	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
-	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_PATCH_SEM_CONTROL);
+	return mt7615_mcu_msg_send(dev, -MCU_CMD_PATCH_SEM_CONTROL,
+				   &req, sizeof(req), true);
 }
 
 static int mt7615_mcu_start_patch(struct mt7615_dev *dev)
@@ -240,9 +242,9 @@ static int mt7615_mcu_start_patch(struct mt7615_dev *dev)
 	} req = {
 		.check_crc = 0,
 	};
-	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
-	return mt7615_mcu_msg_send(dev, skb, -MCU_CMD_PATCH_FINISH_REQ);
+	return mt7615_mcu_msg_send(dev, -MCU_CMD_PATCH_FINISH_REQ,
+				   &req, sizeof(req), true);
 }
 
 static int mt7615_driver_own(struct mt7615_dev *dev)
@@ -502,9 +504,6 @@ void mt7615_mcu_exit(struct mt7615_dev *dev)
 
 int mt7615_mcu_set_eeprom(struct mt7615_dev *dev)
 {
-	struct req_data {
-		u8 val;
-	} __packed;
 	struct {
 		u8 buffer_mode;
 		u8 pad;
@@ -513,22 +512,22 @@ int mt7615_mcu_set_eeprom(struct mt7615_dev *dev)
 		.buffer_mode = 1,
 		.len = __MT_EE_MAX - MT_EE_NIC_CONF_0,
 	};
-	struct sk_buff *skb;
-	struct req_data *data;
-	const int size = (__MT_EE_MAX - MT_EE_NIC_CONF_0) *
-			 sizeof(struct req_data);
-	u8 *eep = (u8 *)dev->mt76.eeprom.data;
-	u16 off;
+	int ret, len = sizeof(req_hdr) + __MT_EE_MAX - MT_EE_NIC_CONF_0;
+	u8 *req, *eep = (u8 *)dev->mt76.eeprom.data;
+
+	req = kzalloc(len, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
 
-	skb = mt7615_mcu_msg_alloc(NULL, size + sizeof(req_hdr));
-	memcpy(skb_put(skb, sizeof(req_hdr)), &req_hdr, sizeof(req_hdr));
-	data = (struct req_data *)skb_put(skb, size);
-	memset(data, 0, size);
+	memcpy(req, &req_hdr, sizeof(req_hdr));
+	memcpy(req + sizeof(req_hdr), eep + MT_EE_NIC_CONF_0,
+	       __MT_EE_MAX - MT_EE_NIC_CONF_0);
 
-	for (off = MT_EE_NIC_CONF_0; off < __MT_EE_MAX; off++)
-		data[off - MT_EE_NIC_CONF_0].val = eep[off];
+	ret = mt7615_mcu_msg_send(dev, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
+				  req, len, true);
+	kfree(req);
 
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_EFUSE_BUFFER_MODE);
+	return ret;
 }
 
 int mt7615_mcu_init_mac(struct mt7615_dev *dev)
@@ -541,9 +540,9 @@ int mt7615_mcu_init_mac(struct mt7615_dev *dev)
 		.enable = 1,
 		.band = 0,
 	};
-	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_MAC_INIT_CTRL);
+	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_MAC_INIT_CTRL,
+				   &req, sizeof(req), true);
 }
 
 int mt7615_mcu_set_rts_thresh(struct mt7615_dev *dev, u32 val)
@@ -560,9 +559,9 @@ int mt7615_mcu_set_rts_thresh(struct mt7615_dev *dev, u32 val)
 		.len_thresh = cpu_to_le32(val),
 		.pkt_thresh = cpu_to_le32(0x2),
 	};
-	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_PROTECT_CTRL);
+	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_PROTECT_CTRL,
+				   &req, sizeof(req), true);
 }
 
 int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
@@ -588,7 +587,6 @@ int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
 		.aifs = params->aifs,
 		.txop = cpu_to_le16(params->txop),
 	};
-	struct sk_buff *skb;
 
 	if (params->cw_min) {
 		req.valid |= WMM_CW_MIN_SET;
@@ -599,8 +597,8 @@ int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
 		req.cw_max = cpu_to_le16(params->cw_max);
 	}
 
-	skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_EDCA_UPDATE);
+	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_EDCA_UPDATE,
+				   &req, sizeof(req), true);
 }
 
 int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int enter)
@@ -628,9 +626,9 @@ int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int enter)
 		.pm_state = (enter) ? ENTER_PM_STATE : EXIT_PM_STATE,
 		.band_idx = 0,
 	};
-	struct sk_buff *skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
 
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_PM_STATE_CTRL);
+	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_PM_STATE_CTRL,
+				   &req, sizeof(req), true);
 }
 
 int mt7615_mcu_set_dev_info(struct mt7615_dev *dev,
@@ -666,14 +664,10 @@ int mt7615_mcu_set_dev_info(struct mt7615_dev *dev,
 			.band_idx = mvif->band_idx,
 		},
 	};
-	struct sk_buff *skb;
 
 	memcpy(data.tlv.omac_addr, vif->addr, ETH_ALEN);
-	skb = mt7615_mcu_msg_alloc(&data, sizeof(data));
-	if (!skb)
-		return -ENOMEM;
-
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_DEV_INFO_UPDATE);
+	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_DEV_INFO_UPDATE,
+				   &data, sizeof(data), true);
 }
 
 static void
@@ -744,7 +738,6 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
 	u32 conn_type = NETWORK_INFRA, net_type = 0;
 	u8 *buf, *data, tx_wlan_idx = 0;
 	struct req_hdr *hdr;
-	struct sk_buff *skb;
 
 	if (en) {
 		len += sizeof(struct bss_info_omac);
@@ -819,46 +812,13 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
 		}
 	}
 
-	skb = mt7615_mcu_msg_alloc(buf, len);
-	if (!skb) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	ret = mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_BSS_INFO_UPDATE);
-
-out:
+	ret = mt7615_mcu_msg_send(dev, MCU_EXT_CMD_BSS_INFO_UPDATE,
+				  buf, len, true);
 	kfree(buf);
 
 	return ret;
 }
 
-static int
-__mt7615_mcu_set_wtbl(struct mt7615_dev *dev, int wlan_idx,
-		      int operation, int ntlv, void *buf,
-		      int buf_len)
-{
-	struct req_hdr {
-		u8 wlan_idx;
-		u8 operation;
-		__le16 tlv_num;
-		u8 rsv[4];
-	} __packed req_hdr = {
-		.wlan_idx = wlan_idx,
-		.operation = operation,
-		.tlv_num = cpu_to_le16(ntlv),
-	};
-	struct sk_buff *skb;
-
-	skb = mt7615_mcu_msg_alloc(NULL, sizeof(req_hdr) + buf_len);
-	memcpy(skb_put(skb, sizeof(req_hdr)), &req_hdr, sizeof(req_hdr));
-
-	if (buf && buf_len)
-		memcpy(skb_put(skb, buf_len), buf, buf_len);
-
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_WTBL_UPDATE);
-}
-
 static enum mt7615_cipher_type
 mt7615_get_key_info(struct ieee80211_key_conf *key, u8 *key_data)
 {
@@ -896,28 +856,38 @@ int mt7615_mcu_set_wtbl_key(struct mt7615_dev *dev, int wcid,
 			    struct ieee80211_key_conf *key,
 			    enum set_key_cmd cmd)
 {
-	struct wtbl_sec_key wtbl_sec_key = {0};
-	int buf_len = sizeof(struct wtbl_sec_key);
-	u8 cipher;
-
-	wtbl_sec_key.tag = cpu_to_le16(WTBL_SEC_KEY);
-	wtbl_sec_key.len = cpu_to_le16(buf_len);
-	wtbl_sec_key.add = cmd;
+	struct {
+		struct wtbl_req_hdr hdr;
+		struct wtbl_sec_key key;
+	} req = {
+		.hdr = {
+			.wlan_idx = wcid,
+			.operation = WTBL_SET,
+			.tlv_num = cpu_to_le16(1),
+		},
+		.key = {
+			.tag = cpu_to_le16(WTBL_SEC_KEY),
+			.len = cpu_to_le16(sizeof(struct wtbl_sec_key)),
+			.add = cmd,
+		},
+	};
 
 	if (cmd == SET_KEY) {
-		cipher = mt7615_get_key_info(key, wtbl_sec_key.key_material);
+		u8 cipher;
+
+		cipher = mt7615_get_key_info(key, req.key.key_material);
 		if (cipher == MT_CIPHER_NONE && key)
 			return -EOPNOTSUPP;
 
-		wtbl_sec_key.cipher_id = cipher;
-		wtbl_sec_key.key_id = key->keyidx;
-		wtbl_sec_key.key_len = key->keylen;
+		req.key.cipher_id = cipher;
+		req.key.key_id = key->keyidx;
+		req.key.key_len = key->keylen;
 	} else {
-		wtbl_sec_key.key_len = sizeof(wtbl_sec_key.key_material);
+		req.key.key_len = sizeof(req.key.key_material);
 	}
 
-	return __mt7615_mcu_set_wtbl(dev, wcid, WTBL_SET, 1,
-				     &wtbl_sec_key, buf_len);
+	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_WTBL_UPDATE,
+				   &req, sizeof(req), true);
 }
 
 static int
@@ -925,9 +895,15 @@ mt7615_mcu_add_wtbl_bmc(struct mt7615_dev *dev,
 			struct mt7615_vif *mvif)
 {
 	struct {
+		struct wtbl_req_hdr hdr;
 		struct wtbl_generic g_wtbl;
 		struct wtbl_rx rx_wtbl;
-	} data = {
+	} req = {
+		.hdr = {
+			.wlan_idx = mvif->sta.wcid.idx,
+			.operation = WTBL_RESET_AND_SET,
+			.tlv_num = cpu_to_le16(2),
+		},
 		.g_wtbl = {
 			.tag = cpu_to_le16(WTBL_GENERIC),
 			.len = cpu_to_le16(sizeof(struct wtbl_generic)),
@@ -941,12 +917,10 @@ mt7615_mcu_add_wtbl_bmc(struct mt7615_dev *dev,
 			.rv = 1,
 		},
 	};
-	eth_broadcast_addr(data.g_wtbl.peer_addr);
+	eth_broadcast_addr(req.g_wtbl.peer_addr);
 
-	return __mt7615_mcu_set_wtbl(dev, mvif->sta.wcid.idx,
-				     WTBL_RESET_AND_SET, 2, &data,
-				     sizeof(struct wtbl_generic) +
-				     sizeof(struct wtbl_rx));
+	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_WTBL_UPDATE,
+				   &req, sizeof(req), true);
 }
 
 int mt7615_mcu_wtbl_bmc(struct mt7615_dev *dev,
@@ -954,11 +928,17 @@ int mt7615_mcu_wtbl_bmc(struct mt7615_dev *dev,
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 
-	if (enable)
-		return mt7615_mcu_add_wtbl_bmc(dev, mvif);
+	if (!enable) {
+		struct wtbl_req_hdr req = {
+			.wlan_idx = mvif->sta.wcid.idx,
+			.operation = WTBL_RESET_AND_SET,
+		};
 
-	return __mt7615_mcu_set_wtbl(dev, mvif->sta.wcid.idx,
-				     WTBL_RESET_AND_SET, 0, NULL, 0);
+		return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_WTBL_UPDATE,
+					   &req, sizeof(req), true);
+	}
+
+	return mt7615_mcu_add_wtbl_bmc(dev, mvif);
 }
 
 int mt7615_mcu_add_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
@@ -967,9 +947,15 @@ int mt7615_mcu_add_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
 	struct {
+		struct wtbl_req_hdr hdr;
 		struct wtbl_generic g_wtbl;
 		struct wtbl_rx rx_wtbl;
-	} data = {
+	} req = {
+		.hdr = {
+			.wlan_idx = msta->wcid.idx,
+			.operation = WTBL_RESET_AND_SET,
+			.tlv_num = cpu_to_le16(2),
+		},
 		.g_wtbl = {
 			.tag = cpu_to_le16(WTBL_GENERIC),
 			.len = cpu_to_le16(sizeof(struct wtbl_generic)),
@@ -985,81 +971,69 @@ int mt7615_mcu_add_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			.rv = 1,
 		},
 	};
-	memcpy(data.g_wtbl.peer_addr, sta->addr, ETH_ALEN);
+	memcpy(req.g_wtbl.peer_addr, sta->addr, ETH_ALEN);
 
-	return __mt7615_mcu_set_wtbl(dev, msta->wcid.idx,
-				     WTBL_RESET_AND_SET, 2, &data,
-				     sizeof(struct wtbl_generic) +
-				     sizeof(struct wtbl_rx));
+	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_WTBL_UPDATE,
+				   &req, sizeof(req), true);
 }
 
 int mt7615_mcu_del_wtbl(struct mt7615_dev *dev,
 			struct ieee80211_sta *sta)
 {
 	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
+	struct wtbl_req_hdr req = {
+		.wlan_idx = msta->wcid.idx,
+		.operation = WTBL_RESET_AND_SET,
+	};
 
-	return __mt7615_mcu_set_wtbl(dev, msta->wcid.idx,
-				     WTBL_RESET_AND_SET, 0, NULL, 0);
+	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_WTBL_UPDATE,
+				   &req, sizeof(req), true);
 }
 
 int mt7615_mcu_del_wtbl_all(struct mt7615_dev *dev)
 {
-	return __mt7615_mcu_set_wtbl(dev, 0, WTBL_RESET_ALL, 0, NULL, 0);
-}
-
-static int
-__mt7615_mcu_set_sta_rec(struct mt7615_dev *dev, int bss_idx,
-			 int wlan_idx, int muar_idx, int ntlv,
-			 void *buf, int buf_len)
-{
-	struct req_hdr {
-		u8 bss_idx;
-		u8 wlan_idx;
-		__le16 tlv_num;
-		u8 is_tlv_append;
-		u8 muar_idx;
-		u8 rsv[2];
-	} __packed req_hdr = {
-		.bss_idx = bss_idx,
-		.wlan_idx = wlan_idx,
-		.tlv_num = cpu_to_le16(ntlv),
-		.is_tlv_append = !!ntlv,
-		.muar_idx = muar_idx,
+	struct wtbl_req_hdr req = {
+		.operation = WTBL_RESET_ALL,
 	};
-	struct sk_buff *skb;
 
-	skb = mt7615_mcu_msg_alloc(NULL, sizeof(req_hdr) + buf_len);
-	memcpy(skb_put(skb, sizeof(req_hdr)), &req_hdr, sizeof(req_hdr));
-
-	if (buf && buf_len)
-		memcpy(skb_put(skb, buf_len), buf, buf_len);
-
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_STA_REC_UPDATE);
+	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_WTBL_UPDATE,
+				   &req, sizeof(req), true);
 }
 
 int mt7615_mcu_set_sta_rec_bmc(struct mt7615_dev *dev,
 			       struct ieee80211_vif *vif, bool en)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct sta_rec_basic sta_rec_basic = {0};
-	int buf_len = sizeof(struct sta_rec_basic);
+	struct {
+		struct sta_req_hdr hdr;
+		struct sta_rec_basic basic;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+			.wlan_idx = mvif->sta.wcid.idx,
+			.tlv_num = cpu_to_le16(1),
+			.is_tlv_append = 1,
+			.muar_idx = mvif->omac_idx,
+		},
+		.basic = {
+			.tag = cpu_to_le16(STA_REC_BASIC),
+			.len = cpu_to_le16(sizeof(struct sta_rec_basic)),
+			.conn_type = cpu_to_le32(CONNECTION_INFRA_BC),
+		},
+	};
+	eth_broadcast_addr(req.basic.peer_addr);
 
-	sta_rec_basic.tag = cpu_to_le16(STA_REC_BASIC);
-	sta_rec_basic.len = cpu_to_le16(buf_len);
-	sta_rec_basic.conn_type = cpu_to_le32(CONNECTION_INFRA_BC);
-	eth_broadcast_addr(sta_rec_basic.peer_addr);
 	if (en) {
-		sta_rec_basic.conn_state = CONN_STATE_PORT_SECURE;
-		sta_rec_basic.extra_info =
-			cpu_to_le16(EXTRA_INFO_VER | EXTRA_INFO_NEW);
+		req.basic.conn_state = CONN_STATE_PORT_SECURE;
+		req.basic.extra_info = cpu_to_le16(EXTRA_INFO_VER |
+						   EXTRA_INFO_NEW);
 	} else {
-		sta_rec_basic.conn_state = CONN_STATE_DISCONNECT;
-		sta_rec_basic.extra_info = cpu_to_le16(EXTRA_INFO_VER);
+		req.basic.conn_state = CONN_STATE_DISCONNECT;
+		req.basic.extra_info = cpu_to_le16(EXTRA_INFO_VER);
 	}
 
-	return __mt7615_mcu_set_sta_rec(dev, mvif->idx, mvif->sta.wcid.idx,
-					mvif->omac_idx, 1, &sta_rec_basic,
-					buf_len);
+	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_STA_REC_UPDATE,
+				   &req, sizeof(req), true);
 }
 
 static void sta_rec_convert_vif_type(enum nl80211_iftype type, u32 *conn_type)
@@ -1084,31 +1058,42 @@ int mt7615_mcu_set_sta_rec(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
-	struct sta_rec_basic sta_rec_basic = {0};
-	int buf_len = sizeof(struct sta_rec_basic);
 	u32 conn_type = 0;
 
-	sta_rec_convert_vif_type(vif->type, &conn_type);
+	struct {
+		struct sta_req_hdr hdr;
+		struct sta_rec_basic basic;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+			.wlan_idx = msta->wcid.idx,
+			.tlv_num = cpu_to_le16(1),
+			.is_tlv_append = 1,
+			.muar_idx = mvif->omac_idx,
+		},
+		.basic = {
+			.tag = cpu_to_le16(STA_REC_BASIC),
+			.len = cpu_to_le16(sizeof(struct sta_rec_basic)),
+			.qos = sta->wme,
+			.aid = cpu_to_le16(sta->aid),
+		},
+	};
+	memcpy(req.basic.peer_addr, sta->addr, ETH_ALEN);
 
-	sta_rec_basic.tag = cpu_to_le16(STA_REC_BASIC);
-	sta_rec_basic.len = cpu_to_le16(buf_len);
-	sta_rec_basic.conn_type = cpu_to_le32(conn_type);
-	sta_rec_basic.qos = sta->wme;
-	sta_rec_basic.aid = cpu_to_le16(sta->aid);
-	memcpy(sta_rec_basic.peer_addr, sta->addr, ETH_ALEN);
+	sta_rec_convert_vif_type(vif->type, &conn_type);
+	req.basic.conn_type = cpu_to_le32(conn_type);
 
 	if (en) {
-		sta_rec_basic.conn_state = CONN_STATE_PORT_SECURE;
-		sta_rec_basic.extra_info =
-			cpu_to_le16(EXTRA_INFO_VER | EXTRA_INFO_NEW);
+		req.basic.conn_state = CONN_STATE_PORT_SECURE;
+		req.basic.extra_info = cpu_to_le16(EXTRA_INFO_VER |
+						   EXTRA_INFO_NEW);
 	} else {
-		sta_rec_basic.conn_state = CONN_STATE_DISCONNECT;
-		sta_rec_basic.extra_info = cpu_to_le16(EXTRA_INFO_VER);
+		req.basic.conn_state = CONN_STATE_DISCONNECT;
+		req.basic.extra_info = cpu_to_le16(EXTRA_INFO_VER);
 	}
 
-	return __mt7615_mcu_set_sta_rec(dev, mvif->idx, msta->wcid.idx,
-					mvif->omac_idx, 1, &sta_rec_basic,
-					buf_len);
+	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_STA_REC_UPDATE,
+				   &req, sizeof(req), true);
 }
 
 int mt7615_mcu_set_bcn(struct mt7615_dev *dev, struct ieee80211_vif *vif,
@@ -1160,9 +1145,8 @@ int mt7615_mcu_set_bcn(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	req.pkt_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
 	req.tim_ie_pos = cpu_to_le16(MT_TXD_SIZE + tim_off);
 
-	skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
-
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_BCN_OFFLOAD);
+	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_BCN_OFFLOAD,
+				   &req, sizeof(req), true);
 }
 
 int mt7615_mcu_set_channel(struct mt7615_dev *dev)
@@ -1187,7 +1171,6 @@ int mt7615_mcu_set_channel(struct mt7615_dev *dev)
 		u8 txpower_sku[53];
 		u8 rsv2[3];
 	} req = {0};
-	struct sk_buff *skb;
 	int ret;
 
 	req.control_chan = chdef->chan->hw_value;
@@ -1223,16 +1206,15 @@ int mt7615_mcu_set_channel(struct mt7615_dev *dev)
 	default:
 		req.bw = CMD_CBW_20MHZ;
 	}
-
 	memset(req.txpower_sku, 0x3f, 49);
 
-	skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
-	ret = mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_CHANNEL_SWITCH);
+	ret = mt7615_mcu_msg_send(dev, MCU_EXT_CMD_CHANNEL_SWITCH,
+				  &req, sizeof(req), true);
 	if (ret)
 		return ret;
 
-	skb = mt7615_mcu_msg_alloc(&req, sizeof(req));
-	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_SET_RX_PATH);
+	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_SET_RX_PATH,
+				   &req, sizeof(req), true);
 }
 
 int mt7615_mcu_set_ht_cap(struct mt7615_dev *dev, struct ieee80211_vif *vif,
@@ -1240,9 +1222,11 @@ int mt7615_mcu_set_ht_cap(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 {
 	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct wtbl_ht *wtbl_ht;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct sta_req_hdr *sta_hdr;
 	struct wtbl_raw *wtbl_raw;
-	struct sta_rec_ht *sta_rec_ht;
+	struct sta_rec_ht *sta_ht;
+	struct wtbl_ht *wtbl_ht;
 	int buf_len, ret, ntlv = 2;
 	u32 msk, val = 0;
 	u8 *buf;
@@ -1251,15 +1235,20 @@ int mt7615_mcu_set_ht_cap(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	if (!buf)
 		return -ENOMEM;
 
+	wtbl_hdr = (struct wtbl_req_hdr *)buf;
+	wtbl_hdr->wlan_idx = msta->wcid.idx;
+	wtbl_hdr->operation = WTBL_SET;
+	buf_len = sizeof(*wtbl_hdr);
+
 	/* ht basic */
-	buf_len = sizeof(*wtbl_ht);
-	wtbl_ht = (struct wtbl_ht *)buf;
+	wtbl_ht = (struct wtbl_ht *)(buf + buf_len);
 	wtbl_ht->tag = cpu_to_le16(WTBL_HT);
 	wtbl_ht->len = cpu_to_le16(sizeof(*wtbl_ht));
 	wtbl_ht->ht = 1;
 	wtbl_ht->ldpc = sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING;
 	wtbl_ht->af = sta->ht_cap.ampdu_factor;
 	wtbl_ht->mm = sta->ht_cap.ampdu_density;
+	buf_len += sizeof(*wtbl_ht);
 
 	if (sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_20)
 		val |= MT_WTBL_W5_SHORT_GI_20;
@@ -1309,41 +1298,48 @@ int mt7615_mcu_set_ht_cap(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	wtbl_raw->msk = cpu_to_le32(~msk);
 	wtbl_raw->val = cpu_to_le32(val);
 
-	ret = __mt7615_mcu_set_wtbl(dev, msta->wcid.idx, WTBL_SET, ntlv,
-				    buf, buf_len);
-	if (ret) {
-		kfree(buf);
-		return ret;
-	}
+	wtbl_hdr->tlv_num = cpu_to_le16(ntlv);
+	ret = mt7615_mcu_msg_send(dev, MCU_EXT_CMD_WTBL_UPDATE,
+				  buf, buf_len, true);
+	if (ret)
+		goto out;
 
 	memset(buf, 0, MT7615_WTBL_UPDATE_MAX_SIZE);
 
-	buf_len = sizeof(*sta_rec_ht);
-	sta_rec_ht = (struct sta_rec_ht *)buf;
-	sta_rec_ht->tag = cpu_to_le16(STA_REC_HT);
-	sta_rec_ht->len = cpu_to_le16(sizeof(*sta_rec_ht));
-	sta_rec_ht->ht_cap = cpu_to_le16(sta->ht_cap.cap);
-	ntlv = 1;
+	sta_hdr = (struct sta_req_hdr *)buf;
+	sta_hdr->bss_idx = mvif->idx;
+	sta_hdr->wlan_idx = msta->wcid.idx;
+	sta_hdr->is_tlv_append = 1;
+	ntlv =  sta->vht_cap.vht_supported ? 2 : 1;
+	sta_hdr->tlv_num = cpu_to_le16(ntlv);
+	sta_hdr->muar_idx = mvif->omac_idx;
+	buf_len = sizeof(*sta_hdr);
+
+	sta_ht = (struct sta_rec_ht *)(buf + buf_len);
+	sta_ht->tag = cpu_to_le16(STA_REC_HT);
+	sta_ht->len = cpu_to_le16(sizeof(*sta_ht));
+	sta_ht->ht_cap = cpu_to_le16(sta->ht_cap.cap);
+	buf_len += sizeof(*sta_ht);
 
 	if (sta->vht_cap.vht_supported) {
-		struct sta_rec_vht *sta_rec_vht;
-
-		sta_rec_vht = (struct sta_rec_vht *)(buf + buf_len);
-		buf_len += sizeof(*sta_rec_vht);
-		sta_rec_vht->tag = cpu_to_le16(STA_REC_VHT);
-		sta_rec_vht->len = cpu_to_le16(sizeof(*sta_rec_vht));
-		sta_rec_vht->vht_cap = cpu_to_le32(sta->vht_cap.cap);
-		sta_rec_vht->vht_rx_mcs_map =
+		struct sta_rec_vht *sta_vht;
+
+		sta_vht = (struct sta_rec_vht *)(buf + buf_len);
+		buf_len += sizeof(*sta_vht);
+		sta_vht->tag = cpu_to_le16(STA_REC_VHT);
+		sta_vht->len = cpu_to_le16(sizeof(*sta_vht));
+		sta_vht->vht_cap = cpu_to_le32(sta->vht_cap.cap);
+		sta_vht->vht_rx_mcs_map =
 			cpu_to_le16(sta->vht_cap.vht_mcs.rx_mcs_map);
-		sta_rec_vht->vht_tx_mcs_map =
+		sta_vht->vht_tx_mcs_map =
 			cpu_to_le16(sta->vht_cap.vht_mcs.tx_mcs_map);
-		ntlv++;
 	}
 
-	ret = __mt7615_mcu_set_sta_rec(dev, mvif->idx, msta->wcid.idx,
-				       mvif->omac_idx, ntlv, buf,
-				       buf_len);
+	ret = mt7615_mcu_msg_send(dev, MCU_EXT_CMD_STA_REC_UPDATE,
+				  buf, buf_len, true);
+out:
 	kfree(buf);
+
 	return ret;
 }
 
@@ -1351,100 +1347,128 @@ int mt7615_mcu_set_tx_ba(struct mt7615_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool add)
 {
-	struct ieee80211_sta *sta = params->sta;
-	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
+	struct mt7615_sta *msta = (struct mt7615_sta *)params->sta->drv_priv;
 	struct mt7615_vif *mvif = msta->vif;
-	u8 ba_range[8] = {4, 8, 12, 24, 36, 48, 54, 64};
-	u16 tid = params->tid;
-	u16 ba_size = params->buf_size;
-	u16 ssn = params->ssn;
-	struct wtbl_ba wtbl_ba = {0};
-	struct sta_rec_ba sta_rec_ba = {0};
-	int ret, buf_len;
-
-	buf_len = sizeof(struct wtbl_ba);
-
-	wtbl_ba.tag = cpu_to_le16(WTBL_BA);
-	wtbl_ba.len = cpu_to_le16(buf_len);
-	wtbl_ba.tid = tid;
-	wtbl_ba.ba_type = MT_BA_TYPE_ORIGINATOR;
+	struct {
+		struct wtbl_req_hdr hdr;
+		struct wtbl_ba ba;
+	} wtbl_req = {
+		.hdr = {
+			.wlan_idx = msta->wcid.idx,
+			.operation = WTBL_SET,
+			.tlv_num = cpu_to_le16(1),
+		},
+		.ba = {
+			.tag = cpu_to_le16(WTBL_BA),
+			.len = cpu_to_le16(sizeof(struct wtbl_ba)),
+			.tid = params->tid,
+			.ba_type = MT_BA_TYPE_ORIGINATOR,
+			.sn = add ? cpu_to_le16(params->ssn) : 0,
+			.ba_en = add,
+		},
+	};
+	struct {
+		struct sta_req_hdr hdr;
+		struct sta_rec_ba ba;
+	} sta_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+			.wlan_idx = msta->wcid.idx,
+			.tlv_num = cpu_to_le16(1),
+			.is_tlv_append = 1,
+			.muar_idx = mvif->omac_idx,
+		},
+		.ba = {
+			.tag = cpu_to_le16(STA_REC_BA),
+			.len = cpu_to_le16(sizeof(struct sta_rec_ba)),
+			.tid = params->tid,
+			.ba_type = MT_BA_TYPE_ORIGINATOR,
+			.amsdu = params->amsdu,
+			.ba_en = add << params->tid,
+			.ssn = cpu_to_le16(params->ssn),
+			.winsize = cpu_to_le16(params->buf_size),
+		},
+	};
+	int ret;
 
 	if (add) {
-		u8 idx;
+		u8 idx, ba_range[] = { 4, 8, 12, 24, 36, 48, 54, 64 };
 
 		for (idx = 7; idx > 0; idx--) {
-			if (ba_size >= ba_range[idx])
+			if (params->buf_size >= ba_range[idx])
 				break;
 		}
 
-		wtbl_ba.sn = cpu_to_le16(ssn);
-		wtbl_ba.ba_en = 1;
-		wtbl_ba.ba_winsize_idx = idx;
+		wtbl_req.ba.ba_winsize_idx = idx;
 	}
 
-	ret = __mt7615_mcu_set_wtbl(dev, msta->wcid.idx, WTBL_SET, 1,
-				    &wtbl_ba, buf_len);
+	ret = mt7615_mcu_msg_send(dev, MCU_EXT_CMD_WTBL_UPDATE,
+				  &wtbl_req, sizeof(wtbl_req), true);
 	if (ret)
 		return ret;
 
-	buf_len = sizeof(struct sta_rec_ba);
-
-	sta_rec_ba.tag = cpu_to_le16(STA_REC_BA);
-	sta_rec_ba.len = cpu_to_le16(buf_len);
-	sta_rec_ba.tid = tid;
-	sta_rec_ba.ba_type = MT_BA_TYPE_ORIGINATOR;
-	sta_rec_ba.amsdu = params->amsdu;
-	sta_rec_ba.ba_en = add << tid;
-	sta_rec_ba.ssn = cpu_to_le16(ssn);
-	sta_rec_ba.winsize = cpu_to_le16(ba_size);
-
-	return __mt7615_mcu_set_sta_rec(dev, mvif->idx, msta->wcid.idx,
-					mvif->omac_idx, 1, &sta_rec_ba,
-					buf_len);
+	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_STA_REC_UPDATE,
+				   &sta_req, sizeof(sta_req), true);
 }
 
 int mt7615_mcu_set_rx_ba(struct mt7615_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool add)
 {
-	struct ieee80211_sta *sta = params->sta;
-	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
+	struct mt7615_sta *msta = (struct mt7615_sta *)params->sta->drv_priv;
 	struct mt7615_vif *mvif = msta->vif;
-	u16 tid = params->tid;
-	struct wtbl_ba wtbl_ba = {0};
-	struct sta_rec_ba sta_rec_ba = {0};
-	int ret, buf_len;
-
-	buf_len = sizeof(struct sta_rec_ba);
-
-	sta_rec_ba.tag = cpu_to_le16(STA_REC_BA);
-	sta_rec_ba.len = cpu_to_le16(buf_len);
-	sta_rec_ba.tid = tid;
-	sta_rec_ba.ba_type = MT_BA_TYPE_RECIPIENT;
-	sta_rec_ba.amsdu = params->amsdu;
-	sta_rec_ba.ba_en = add << tid;
-	sta_rec_ba.ssn = cpu_to_le16(params->ssn);
-	sta_rec_ba.winsize = cpu_to_le16(params->buf_size);
-
-	ret = __mt7615_mcu_set_sta_rec(dev, mvif->idx, msta->wcid.idx,
-				       mvif->omac_idx, 1, &sta_rec_ba,
-				       buf_len);
-	if (ret || !add)
-		return ret;
+	struct {
+		struct wtbl_req_hdr hdr;
+		struct wtbl_ba ba;
+	} wtbl_req = {
+		.hdr = {
+			.wlan_idx = msta->wcid.idx,
+			.operation = WTBL_SET,
+			.tlv_num = cpu_to_le16(1),
+		},
+		.ba = {
+			.tag = cpu_to_le16(WTBL_BA),
+			.len = cpu_to_le16(sizeof(struct wtbl_ba)),
+			.tid = params->tid,
+			.ba_type = MT_BA_TYPE_RECIPIENT,
+			.rst_ba_tid = params->tid,
+			.rst_ba_sel = RST_BA_MAC_TID_MATCH,
+			.rst_ba_sb = 1,
+		},
+	};
+	struct {
+		struct sta_req_hdr hdr;
+		struct sta_rec_ba ba;
+	} sta_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+			.wlan_idx = msta->wcid.idx,
+			.tlv_num = cpu_to_le16(1),
+			.is_tlv_append = 1,
+			.muar_idx = mvif->omac_idx,
+		},
+		.ba = {
+			.tag = cpu_to_le16(STA_REC_BA),
+			.len = cpu_to_le16(sizeof(struct sta_rec_ba)),
+			.tid = params->tid,
+			.ba_type = MT_BA_TYPE_RECIPIENT,
+			.amsdu = params->amsdu,
+			.ba_en = add << params->tid,
+			.ssn = cpu_to_le16(params->ssn),
+			.winsize = cpu_to_le16(params->buf_size),
+		},
+	};
+	int ret;
 
-	buf_len = sizeof(struct wtbl_ba);
+	memcpy(wtbl_req.ba.peer_addr, params->sta->addr, ETH_ALEN);
 
-	wtbl_ba.tag = cpu_to_le16(WTBL_BA);
-	wtbl_ba.len = cpu_to_le16(buf_len);
-	wtbl_ba.tid = tid;
-	wtbl_ba.ba_type = MT_BA_TYPE_RECIPIENT;
-	memcpy(wtbl_ba.peer_addr, sta->addr, ETH_ALEN);
-	wtbl_ba.rst_ba_tid = tid;
-	wtbl_ba.rst_ba_sel = RST_BA_MAC_TID_MATCH;
-	wtbl_ba.rst_ba_sb = 1;
+	ret = mt7615_mcu_msg_send(dev, MCU_EXT_CMD_STA_REC_UPDATE,
+				  &sta_req, sizeof(sta_req), true);
+	if (ret || !add)
+		return ret;
 
-	return  __mt7615_mcu_set_wtbl(dev, msta->wcid.idx, WTBL_SET,
-				      1, &wtbl_ba, buf_len);
+	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_WTBL_UPDATE,
+				   &wtbl_req, sizeof(wtbl_req), true);
 }
 
 void mt7615_mcu_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 2d3f88ed8dc9..e96efb13fa4d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -201,6 +201,13 @@ enum {
 	WTBL_RESET_ALL
 };
 
+struct wtbl_req_hdr {
+	u8 wlan_idx;
+	u8 operation;
+	__le16 tlv_num;
+	u8 rsv[4];
+} __packed;
+
 struct wtbl_generic {
 	__le16 tag;
 	__le16 len;
@@ -366,7 +373,8 @@ struct wtbl_raw {
 	__le32 val;
 } __packed;
 
-#define MT7615_WTBL_UPDATE_MAX_SIZE (sizeof(struct wtbl_generic) + \
+#define MT7615_WTBL_UPDATE_MAX_SIZE (sizeof(struct wtbl_req_hdr) + \
+				     sizeof(struct wtbl_generic) + \
 				     sizeof(struct wtbl_rx) + \
 				     sizeof(struct wtbl_ht) + \
 				     sizeof(struct wtbl_vht) + \
@@ -400,6 +408,15 @@ enum {
 	WTBL_MAX_NUM
 };
 
+struct sta_req_hdr {
+	u8 bss_idx;
+	u8 wlan_idx;
+	__le16 tlv_num;
+	u8 is_tlv_append;
+	u8 muar_idx;
+	u8 rsv[2];
+} __packed;
+
 struct sta_rec_basic {
 	__le16 tag;
 	__le16 len;
-- 
2.20.1

