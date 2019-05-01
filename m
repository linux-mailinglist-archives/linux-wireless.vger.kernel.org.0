Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF2810AA9
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 18:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfEAQHy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 12:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfEAQHy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 12:07:54 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27E6720644;
        Wed,  1 May 2019 16:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556726873;
        bh=k4GAQLpqhJGYgA6xtMGHtKcMhIKAJ6pCWuvgZHN5Myk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JHLqLBcdMN3zQLb1zsFCJqRB2B/+EfWxCrZks+Ajg9btqJPCbRrnqqwuXRXY256gk
         ClrWEcFoMeo02ETE5JnckhbYFWcawTmHemgOFi3bs3OqxFEfwbfuf+GygNHTSj2q86
         vCGnKDnMGQXVpNHtjONASQRJoMVDppiMqFZC45xM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [RFC 01/17] mt7615: mcu: simplify __mt7615_mcu_set_wtbl
Date:   Wed,  1 May 2019 18:07:23 +0200
Message-Id: <d953184739a35989ed443f490e4d07b9cba65a7f.1556726268.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556726268.git.lorenzo@kernel.org>
References: <cover.1556726268.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not loop over cmd payload in __mt7615_mcu_set_wtbl since it is
already done in before running __mt7615_mcu_set_wtbl (e.g.
mt7615_mcu_set_wtbl_key)

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 62 ++++++++-----------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index ea67c6022fe6..17ed024a52c6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -918,37 +918,24 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	return __mt7615_mcu_set_bss_info(dev, &bss_info);
 }
 
-static int __mt7615_mcu_set_wtbl(struct mt7615_dev *dev, int wlan_idx,
-				 int operation, void *buf, int buf_len)
+static int
+__mt7615_mcu_set_wtbl(struct mt7615_dev *dev, int wlan_idx,
+		      int operation, int ntlv, void *buf,
+		      int buf_len)
 {
 	struct req_hdr {
 		u8 wlan_idx;
 		u8 operation;
 		__le16 tlv_num;
 		u8 rsv[4];
-	} __packed req_hdr = {0};
-	struct tlv {
-		__le16 tag;
-		__le16 len;
-		u8 buf[0];
-	} __packed;
+	} __packed req_hdr = {
+		.wlan_idx = wlan_idx,
+		.operation = operation,
+		.tlv_num = cpu_to_le16(ntlv),
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
-	req_hdr.wlan_idx = wlan_idx;
-	req_hdr.operation = operation;
-	req_hdr.tlv_num = cpu_to_le16(tlv_num);
-
 	memcpy(skb_put(skb, sizeof(req_hdr)), &req_hdr, sizeof(req_hdr));
 
 	if (buf && buf_len)
@@ -1015,8 +1002,8 @@ int mt7615_mcu_set_wtbl_key(struct mt7615_dev *dev, int wcid,
 		wtbl_sec_key.key_len = sizeof(wtbl_sec_key.key_material);
 	}
 
-	return __mt7615_mcu_set_wtbl(dev, wcid, WTBL_SET, &wtbl_sec_key,
-				     buf_len);
+	return __mt7615_mcu_set_wtbl(dev, wcid, WTBL_SET, 1,
+				     &wtbl_sec_key, buf_len);
 }
 
 int mt7615_mcu_add_wtbl_bmc(struct mt7615_dev *dev, struct ieee80211_vif *vif)
@@ -1047,7 +1034,8 @@ int mt7615_mcu_add_wtbl_bmc(struct mt7615_dev *dev, struct ieee80211_vif *vif)
 	wtbl_rx->rv = 1;
 
 	ret = __mt7615_mcu_set_wtbl(dev, mvif->sta.wcid.idx,
-				    WTBL_RESET_AND_SET, buf, buf_len);
+				    WTBL_RESET_AND_SET, 2, buf,
+				    buf_len);
 
 	kfree(buf);
 	return ret;
@@ -1058,7 +1046,7 @@ int mt7615_mcu_del_wtbl_bmc(struct mt7615_dev *dev, struct ieee80211_vif *vif)
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 
 	return __mt7615_mcu_set_wtbl(dev, mvif->sta.wcid.idx,
-				     WTBL_RESET_AND_SET, NULL, 0);
+				     WTBL_RESET_AND_SET, 0, NULL, 0);
 }
 
 int mt7615_mcu_add_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
@@ -1092,8 +1080,8 @@ int mt7615_mcu_add_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	wtbl_rx->rca2 = 1;
 	wtbl_rx->rv = 1;
 
-	ret = __mt7615_mcu_set_wtbl(dev, msta->wcid.idx,
-				    WTBL_RESET_AND_SET, buf, buf_len);
+	ret = __mt7615_mcu_set_wtbl(dev, msta->wcid.idx, WTBL_RESET_AND_SET,
+				    2, buf, buf_len);
 
 	kfree(buf);
 	return ret;
@@ -1105,12 +1093,12 @@ int mt7615_mcu_del_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
 
 	return __mt7615_mcu_set_wtbl(dev, msta->wcid.idx,
-				     WTBL_RESET_AND_SET, NULL, 0);
+				     WTBL_RESET_AND_SET, 0, NULL, 0);
 }
 
 int mt7615_mcu_del_wtbl_all(struct mt7615_dev *dev)
 {
-	return __mt7615_mcu_set_wtbl(dev, 0, WTBL_RESET_ALL, NULL, 0);
+	return __mt7615_mcu_set_wtbl(dev, 0, WTBL_RESET_ALL, 0, NULL, 0);
 }
 
 static int __mt7615_mcu_set_sta_rec(struct mt7615_dev *dev, int bss_idx,
@@ -1367,7 +1355,7 @@ int mt7615_mcu_set_ht_cap(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	struct wtbl_ht *wtbl_ht;
 	struct wtbl_raw *wtbl_raw;
 	struct sta_rec_ht *sta_rec_ht;
-	int buf_len, ret;
+	int buf_len, ret, ntlv = 2;
 	u32 msk, val = 0;
 	u8 *buf;
 
@@ -1400,6 +1388,7 @@ int mt7615_mcu_set_ht_cap(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		wtbl_vht->len = cpu_to_le16(sizeof(*wtbl_vht));
 		wtbl_vht->ldpc = sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC;
 		wtbl_vht->vht = 1;
+		ntlv++;
 
 		if (sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_80)
 			val |= MT_WTBL_W5_SHORT_GI_80;
@@ -1416,6 +1405,7 @@ int mt7615_mcu_set_ht_cap(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		wtbl_smps->tag = cpu_to_le16(WTBL_SMPS);
 		wtbl_smps->len = cpu_to_le16(sizeof(*wtbl_smps));
 		wtbl_smps->smps = 1;
+		ntlv++;
 	}
 
 	/* sgi */
@@ -1431,8 +1421,8 @@ int mt7615_mcu_set_ht_cap(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	wtbl_raw->msk = cpu_to_le32(~msk);
 	wtbl_raw->val = cpu_to_le32(val);
 
-	ret = __mt7615_mcu_set_wtbl(dev, msta->wcid.idx, WTBL_SET, buf,
-				    buf_len);
+	ret = __mt7615_mcu_set_wtbl(dev, msta->wcid.idx, WTBL_SET, ntlv,
+				    buf, buf_len);
 	if (ret) {
 		kfree(buf);
 		return ret;
@@ -1501,8 +1491,8 @@ int mt7615_mcu_set_tx_ba(struct mt7615_dev *dev,
 		wtbl_ba.ba_winsize_idx = idx;
 	}
 
-	ret = __mt7615_mcu_set_wtbl(dev, msta->wcid.idx, WTBL_SET, &wtbl_ba,
-				    buf_len);
+	ret = __mt7615_mcu_set_wtbl(dev, msta->wcid.idx, WTBL_SET, 1,
+				    &wtbl_ba, buf_len);
 	if (ret)
 		return ret;
 
@@ -1561,7 +1551,7 @@ int mt7615_mcu_set_rx_ba(struct mt7615_dev *dev,
 	wtbl_ba.rst_ba_sb = 1;
 
 	return  __mt7615_mcu_set_wtbl(dev, msta->wcid.idx, WTBL_SET,
-				      &wtbl_ba, buf_len);
+				      1, &wtbl_ba, buf_len);
 }
 
 void mt7615_mcu_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
-- 
2.20.1

