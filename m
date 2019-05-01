Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3319B10ABB
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 18:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfEAQIR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 12:08:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfEAQIR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 12:08:17 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CFD22089E;
        Wed,  1 May 2019 16:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556726895;
        bh=nfZTErDuopKiS94QZrsHVNC9vn0CAr1owyq5Be54G+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yurHmefDJvkXsu+1pYXijwwimG3PFYwANw7kkThg8Wu9DZ7gotBmGbGGx+CkZfpuw
         OqSBTVqEcVrhmvm798SNYwphUquS9zSA+Ytz03b2POSmz1UaeqZeoqLYNcEqpnktuC
         sYVyJzF569M6GxMSAMp6PE+3LxkTDniJmEKYSBLg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [RFC 15/17] mt7615: initialize mt76_mcu_ops data structure
Date:   Wed,  1 May 2019 18:07:37 +0200
Message-Id: <e60abd48c5d9e3d12ab2b5d879e7022fdc1bcc92.1556726268.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556726268.git.lorenzo@kernel.org>
References: <cover.1556726268.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use __mt76_mcu_send_msg wrapper instead of mt7615_mcu_msg_send.
This is a preliminary patch for mt7615-mt7603 mcu code unification

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 74 ++++++++++---------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 511d27ec15f4..d01f1a8bdd57 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -113,9 +113,10 @@ static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 }
 
 static int
-mt7615_mcu_msg_send(struct mt7615_dev *dev, int cmd, const void *data,
+mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 		    int len, bool wait_resp)
 {
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 	unsigned long expires = jiffies + 10 * HZ;
 	struct mt7615_mcu_rxd *rxd;
 	struct sk_buff *skb;
@@ -125,16 +126,16 @@ mt7615_mcu_msg_send(struct mt7615_dev *dev, int cmd, const void *data,
 	if (!skb)
 		return -ENOMEM;
 
-	mutex_lock(&dev->mt76.mmio.mcu.mutex);
+	mutex_lock(&mdev->mmio.mcu.mutex);
 
 	ret = __mt7615_mcu_msg_send(dev, skb, cmd, &seq);
 	if (ret)
 		goto out;
 
 	while (wait_resp) {
-		skb = mt76_mcu_get_response(&dev->mt76, expires);
+		skb = mt76_mcu_get_response(mdev, expires);
 		if (!skb) {
-			dev_err(dev->mt76.dev, "Message %d (seq %d) timeout\n",
+			dev_err(mdev->dev, "Message %d (seq %d) timeout\n",
 				cmd, seq);
 			ret = -ETIMEDOUT;
 			break;
@@ -153,7 +154,7 @@ mt7615_mcu_msg_send(struct mt7615_dev *dev, int cmd, const void *data,
 	}
 
 out:
-	mutex_unlock(&dev->mt76.mmio.mcu.mutex);
+	mutex_unlock(&mdev->mmio.mcu.mutex);
 
 	return ret;
 }
@@ -171,7 +172,7 @@ static int mt7615_mcu_init_download(struct mt7615_dev *dev, u32 addr,
 		.mode = cpu_to_le32(mode),
 	};
 
-	return mt7615_mcu_msg_send(dev, -MCU_CMD_TARGET_ADDRESS_LEN_REQ,
+	return __mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_TARGET_ADDRESS_LEN_REQ,
 				   &req, sizeof(req), true);
 }
 
@@ -212,13 +213,13 @@ static int mt7615_mcu_start_firmware(struct mt7615_dev *dev, u32 addr,
 		.addr = cpu_to_le32(addr),
 	};
 
-	return mt7615_mcu_msg_send(dev, -MCU_CMD_FW_START_REQ,
+	return __mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_FW_START_REQ,
 				   &req, sizeof(req), true);
 }
 
 static int mt7615_mcu_restart(struct mt7615_dev *dev)
 {
-	return mt7615_mcu_msg_send(dev, -MCU_CMD_RESTART_DL_REQ,
+	return __mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_RESTART_DL_REQ,
 				   NULL, 0, true);
 }
 
@@ -230,7 +231,7 @@ static int mt7615_mcu_patch_sem_ctrl(struct mt7615_dev *dev, bool get)
 		.op = cpu_to_le32(get ? PATCH_SEM_GET : PATCH_SEM_RELEASE),
 	};
 
-	return mt7615_mcu_msg_send(dev, -MCU_CMD_PATCH_SEM_CONTROL,
+	return __mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_PATCH_SEM_CONTROL,
 				   &req, sizeof(req), true);
 }
 
@@ -243,7 +244,7 @@ static int mt7615_mcu_start_patch(struct mt7615_dev *dev)
 		.check_crc = 0,
 	};
 
-	return mt7615_mcu_msg_send(dev, -MCU_CMD_PATCH_FINISH_REQ,
+	return __mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_PATCH_FINISH_REQ,
 				   &req, sizeof(req), true);
 }
 
@@ -480,8 +481,13 @@ static int mt7615_load_firmware(struct mt7615_dev *dev)
 
 int mt7615_mcu_init(struct mt7615_dev *dev)
 {
+	static const struct mt76_mcu_ops mt7615_mcu_ops = {
+		.mcu_send_msg = mt7615_mcu_msg_send,
+	};
 	int ret;
 
+	dev->mt76.mcu_ops = &mt7615_mcu_ops,
+
 	ret = mt7615_driver_own(dev);
 	if (ret)
 		return ret;
@@ -523,7 +529,7 @@ int mt7615_mcu_set_eeprom(struct mt7615_dev *dev)
 	memcpy(req + sizeof(req_hdr), eep + MT_EE_NIC_CONF_0,
 	       __MT_EE_MAX - MT_EE_NIC_CONF_0);
 
-	ret = mt7615_mcu_msg_send(dev, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
+	ret = __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
 				  req, len, true);
 	kfree(req);
 
@@ -541,7 +547,7 @@ int mt7615_mcu_init_mac(struct mt7615_dev *dev)
 		.band = 0,
 	};
 
-	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_MAC_INIT_CTRL,
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_MAC_INIT_CTRL,
 				   &req, sizeof(req), true);
 }
 
@@ -560,7 +566,7 @@ int mt7615_mcu_set_rts_thresh(struct mt7615_dev *dev, u32 val)
 		.pkt_thresh = cpu_to_le32(0x2),
 	};
 
-	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_PROTECT_CTRL,
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_PROTECT_CTRL,
 				   &req, sizeof(req), true);
 }
 
@@ -597,7 +603,7 @@ int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
 		req.cw_max = cpu_to_le16(params->cw_max);
 	}
 
-	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_EDCA_UPDATE,
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EDCA_UPDATE,
 				   &req, sizeof(req), true);
 }
 
@@ -627,7 +633,7 @@ int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int enter)
 		.band_idx = 0,
 	};
 
-	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_PM_STATE_CTRL,
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_PM_STATE_CTRL,
 				   &req, sizeof(req), true);
 }
 
@@ -666,7 +672,7 @@ int mt7615_mcu_set_dev_info(struct mt7615_dev *dev,
 	};
 
 	memcpy(data.tlv.omac_addr, vif->addr, ETH_ALEN);
-	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_DEV_INFO_UPDATE,
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_DEV_INFO_UPDATE,
 				   &data, sizeof(data), true);
 }
 
@@ -812,7 +818,7 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
 		}
 	}
 
-	ret = mt7615_mcu_msg_send(dev, MCU_EXT_CMD_BSS_INFO_UPDATE,
+	ret = __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_BSS_INFO_UPDATE,
 				  buf, len, true);
 	kfree(buf);
 
@@ -886,7 +892,7 @@ int mt7615_mcu_set_wtbl_key(struct mt7615_dev *dev, int wcid,
 		req.key.key_len = sizeof(req.key.key_material);
 	}
 
-	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_WTBL_UPDATE,
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_WTBL_UPDATE,
 				   &req, sizeof(req), true);
 }
 
@@ -919,7 +925,7 @@ mt7615_mcu_add_wtbl_bmc(struct mt7615_dev *dev,
 	};
 	eth_broadcast_addr(req.g_wtbl.peer_addr);
 
-	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_WTBL_UPDATE,
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_WTBL_UPDATE,
 				   &req, sizeof(req), true);
 }
 
@@ -934,7 +940,7 @@ int mt7615_mcu_wtbl_bmc(struct mt7615_dev *dev,
 			.operation = WTBL_RESET_AND_SET,
 		};
 
-		return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_WTBL_UPDATE,
+		return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_WTBL_UPDATE,
 					   &req, sizeof(req), true);
 	}
 
@@ -973,7 +979,7 @@ int mt7615_mcu_add_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	};
 	memcpy(req.g_wtbl.peer_addr, sta->addr, ETH_ALEN);
 
-	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_WTBL_UPDATE,
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_WTBL_UPDATE,
 				   &req, sizeof(req), true);
 }
 
@@ -986,7 +992,7 @@ int mt7615_mcu_del_wtbl(struct mt7615_dev *dev,
 		.operation = WTBL_RESET_AND_SET,
 	};
 
-	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_WTBL_UPDATE,
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_WTBL_UPDATE,
 				   &req, sizeof(req), true);
 }
 
@@ -996,7 +1002,7 @@ int mt7615_mcu_del_wtbl_all(struct mt7615_dev *dev)
 		.operation = WTBL_RESET_ALL,
 	};
 
-	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_WTBL_UPDATE,
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_WTBL_UPDATE,
 				   &req, sizeof(req), true);
 }
 
@@ -1032,7 +1038,7 @@ int mt7615_mcu_set_sta_rec_bmc(struct mt7615_dev *dev,
 		req.basic.extra_info = cpu_to_le16(EXTRA_INFO_VER);
 	}
 
-	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_STA_REC_UPDATE,
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_STA_REC_UPDATE,
 				   &req, sizeof(req), true);
 }
 
@@ -1092,7 +1098,7 @@ int mt7615_mcu_set_sta_rec(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		req.basic.extra_info = cpu_to_le16(EXTRA_INFO_VER);
 	}
 
-	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_STA_REC_UPDATE,
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_STA_REC_UPDATE,
 				   &req, sizeof(req), true);
 }
 
@@ -1145,7 +1151,7 @@ int mt7615_mcu_set_bcn(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	req.pkt_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
 	req.tim_ie_pos = cpu_to_le16(MT_TXD_SIZE + tim_off);
 
-	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_BCN_OFFLOAD,
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_BCN_OFFLOAD,
 				   &req, sizeof(req), true);
 }
 
@@ -1208,12 +1214,12 @@ int mt7615_mcu_set_channel(struct mt7615_dev *dev)
 	}
 	memset(req.txpower_sku, 0x3f, 49);
 
-	ret = mt7615_mcu_msg_send(dev, MCU_EXT_CMD_CHANNEL_SWITCH,
+	ret = __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_CHANNEL_SWITCH,
 				  &req, sizeof(req), true);
 	if (ret)
 		return ret;
 
-	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_SET_RX_PATH,
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RX_PATH,
 				   &req, sizeof(req), true);
 }
 
@@ -1299,7 +1305,7 @@ int mt7615_mcu_set_ht_cap(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	wtbl_raw->val = cpu_to_le32(val);
 
 	wtbl_hdr->tlv_num = cpu_to_le16(ntlv);
-	ret = mt7615_mcu_msg_send(dev, MCU_EXT_CMD_WTBL_UPDATE,
+	ret = __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_WTBL_UPDATE,
 				  buf, buf_len, true);
 	if (ret)
 		goto out;
@@ -1335,7 +1341,7 @@ int mt7615_mcu_set_ht_cap(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			cpu_to_le16(sta->vht_cap.vht_mcs.tx_mcs_map);
 	}
 
-	ret = mt7615_mcu_msg_send(dev, MCU_EXT_CMD_STA_REC_UPDATE,
+	ret = __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_STA_REC_UPDATE,
 				  buf, buf_len, true);
 out:
 	kfree(buf);
@@ -1402,12 +1408,12 @@ int mt7615_mcu_set_tx_ba(struct mt7615_dev *dev,
 		wtbl_req.ba.ba_winsize_idx = idx;
 	}
 
-	ret = mt7615_mcu_msg_send(dev, MCU_EXT_CMD_WTBL_UPDATE,
+	ret = __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_WTBL_UPDATE,
 				  &wtbl_req, sizeof(wtbl_req), true);
 	if (ret)
 		return ret;
 
-	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_STA_REC_UPDATE,
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_STA_REC_UPDATE,
 				   &sta_req, sizeof(sta_req), true);
 }
 
@@ -1462,12 +1468,12 @@ int mt7615_mcu_set_rx_ba(struct mt7615_dev *dev,
 
 	memcpy(wtbl_req.ba.peer_addr, params->sta->addr, ETH_ALEN);
 
-	ret = mt7615_mcu_msg_send(dev, MCU_EXT_CMD_STA_REC_UPDATE,
+	ret = __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_STA_REC_UPDATE,
 				  &sta_req, sizeof(sta_req), true);
 	if (ret || !add)
 		return ret;
 
-	return mt7615_mcu_msg_send(dev, MCU_EXT_CMD_WTBL_UPDATE,
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_WTBL_UPDATE,
 				   &wtbl_req, sizeof(wtbl_req), true);
 }
 
-- 
2.20.1

