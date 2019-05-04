Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC1213AE9
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2019 17:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfEDP3b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 May 2019 11:29:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfEDP3b (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 May 2019 11:29:31 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.59.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D65520644;
        Sat,  4 May 2019 15:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556983769;
        bh=BEnCAzNldgIP3cZi3KP+nnQ/+IjSdm3NiBdrPLxgZcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w48I5nG+Yn/on64DHF0nfe/6wPWZmTy5QR+X16PrwSPosYmP0agwukGZI3ja/MVaw
         nM/P5mUqMz/8TAnW8NQldcnSG8RztS1qJ1HjheshxmD4KKsAzlmWTAWP2tYELqzikY
         7eGFiVsIUmX6Gu15guHBAoL5kA1ZEIwhvx1EBBZk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 02/17] mt7615: mcu: simplify __mt7615_mcu_set_sta_rec
Date:   Sat,  4 May 2019 17:28:54 +0200
Message-Id: <906270db1df1efa902eb7ab926cd5d42d4f00b3f.1556981521.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556981521.git.lorenzo@kernel.org>
References: <cover.1556981521.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not loop over cmd payload in __mt7615_mcu_set_sta_rec since it is
already done in before running __mt7615_mcu_set_sta_rec (e.g.
mt7615_mcu_set_sta_rec)

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 51 ++++++++-----------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 3de20c8111cf..2a632c0debe9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1101,9 +1101,10 @@ int mt7615_mcu_del_wtbl_all(struct mt7615_dev *dev)
 	return __mt7615_mcu_set_wtbl(dev, 0, WTBL_RESET_ALL, 0, NULL, 0);
 }
 
-static int __mt7615_mcu_set_sta_rec(struct mt7615_dev *dev, int bss_idx,
-				    int wlan_idx, int muar_idx, void *buf,
-				    int buf_len)
+static int
+__mt7615_mcu_set_sta_rec(struct mt7615_dev *dev, int bss_idx,
+			 int wlan_idx, int muar_idx, int ntlv,
+			 void *buf, int buf_len)
 {
 	struct req_hdr {
 		u8 bss_idx;
@@ -1112,31 +1113,16 @@ static int __mt7615_mcu_set_sta_rec(struct mt7615_dev *dev, int bss_idx,
 		u8 is_tlv_append;
 		u8 muar_idx;
 		u8 rsv[2];
-	} __packed req_hdr = {0};
-	struct tlv {
-		__le16 tag;
-		__le16 len;
-		u8 buf[0];
-	} __packed;
+	} __packed req_hdr = {
+		.bss_idx = bss_idx,
+		.wlan_idx = wlan_idx,
+		.tlv_num = cpu_to_le16(ntlv),
+		.is_tlv_append = !!ntlv,
+		.muar_idx = muar_idx,
+	};
 	struct sk_buff *skb;
-	u16 tlv_num = 0;
-	int offset = 0;
-
-	while (offset < buf_len) {
-		struct tlv *tlv = (struct tlv *)((u8 *)buf + offset);
-
-		tlv_num++;
-		offset += tlv->len;
-	}
 
 	skb = mt7615_mcu_msg_alloc(NULL, sizeof(req_hdr) + buf_len);
-
-	req_hdr.bss_idx = bss_idx;
-	req_hdr.wlan_idx = wlan_idx;
-	req_hdr.tlv_num = cpu_to_le16(tlv_num);
-	req_hdr.is_tlv_append = tlv_num ? 1 : 0;
-	req_hdr.muar_idx = muar_idx;
-
 	memcpy(skb_put(skb, sizeof(req_hdr)), &req_hdr, sizeof(req_hdr));
 
 	if (buf && buf_len)
@@ -1167,7 +1153,7 @@ int mt7615_mcu_set_sta_rec_bmc(struct mt7615_dev *dev,
 	}
 
 	return __mt7615_mcu_set_sta_rec(dev, mvif->idx, mvif->sta.wcid.idx,
-					mvif->omac_idx, &sta_rec_basic,
+					mvif->omac_idx, 1, &sta_rec_basic,
 					buf_len);
 }
 
@@ -1216,7 +1202,7 @@ int mt7615_mcu_set_sta_rec(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	}
 
 	return __mt7615_mcu_set_sta_rec(dev, mvif->idx, msta->wcid.idx,
-					mvif->omac_idx, &sta_rec_basic,
+					mvif->omac_idx, 1, &sta_rec_basic,
 					buf_len);
 }
 
@@ -1435,6 +1421,7 @@ int mt7615_mcu_set_ht_cap(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	sta_rec_ht->tag = cpu_to_le16(STA_REC_HT);
 	sta_rec_ht->len = cpu_to_le16(sizeof(*sta_rec_ht));
 	sta_rec_ht->ht_cap = cpu_to_le16(sta->ht_cap.cap);
+	ntlv = 1;
 
 	if (sta->vht_cap.vht_supported) {
 		struct sta_rec_vht *sta_rec_vht;
@@ -1448,10 +1435,12 @@ int mt7615_mcu_set_ht_cap(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			cpu_to_le16(sta->vht_cap.vht_mcs.rx_mcs_map);
 		sta_rec_vht->vht_tx_mcs_map =
 			cpu_to_le16(sta->vht_cap.vht_mcs.tx_mcs_map);
+		ntlv++;
 	}
 
 	ret = __mt7615_mcu_set_sta_rec(dev, mvif->idx, msta->wcid.idx,
-				       mvif->omac_idx, buf, buf_len);
+				       mvif->omac_idx, ntlv, buf,
+				       buf_len);
 	kfree(buf);
 	return ret;
 }
@@ -1508,7 +1497,8 @@ int mt7615_mcu_set_tx_ba(struct mt7615_dev *dev,
 	sta_rec_ba.winsize = cpu_to_le16(ba_size);
 
 	return __mt7615_mcu_set_sta_rec(dev, mvif->idx, msta->wcid.idx,
-					mvif->omac_idx, &sta_rec_ba, buf_len);
+					mvif->omac_idx, 1, &sta_rec_ba,
+					buf_len);
 }
 
 int mt7615_mcu_set_rx_ba(struct mt7615_dev *dev,
@@ -1535,7 +1525,8 @@ int mt7615_mcu_set_rx_ba(struct mt7615_dev *dev,
 	sta_rec_ba.winsize = cpu_to_le16(params->buf_size);
 
 	ret = __mt7615_mcu_set_sta_rec(dev, mvif->idx, msta->wcid.idx,
-				       mvif->omac_idx, &sta_rec_ba, buf_len);
+				       mvif->omac_idx, 1, &sta_rec_ba,
+				       buf_len);
 	if (ret || !add)
 		return ret;
 
-- 
2.20.1

