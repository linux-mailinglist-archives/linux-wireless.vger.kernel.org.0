Return-Path: <linux-wireless+bounces-34407-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB+/FV1q1GletwcAu9opvQ
	(envelope-from <linux-wireless+bounces-34407-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 04:22:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2583A8FB2
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 04:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 104BC3011F23
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 02:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C6B34DB54;
	Tue,  7 Apr 2026 02:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqAAr2wq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8902617993
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 02:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775528462; cv=none; b=oXePBEoK2ObxvjgctdKuiQg+mw0oW2nETFo3WvxPK6dO0cezXiG7p1jngV5pKjNYcI30RMDhUJ8n5qMAKTJhbl7p7SI41A7XsYyp40bBaEQLEsSn9SlwlCZdLvor5hR1JNGujcOCdHSZG3K5HhJEeqw0FHUpfA2ff5wFsTdf0Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775528462; c=relaxed/simple;
	bh=PxU3cfTdJfl+LMIvHCxQwCKCx1rkMTwzyN+ZiBDZeOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hP/L6x26yPfddzEZck8nG5Ptyg2yP7IU3ArTWuaGgjxhFCuK9vRY+nFqlL9SmPUZmfXTw2Ku7SxdxPUuWgnuQAp+2xbP7xbacQ/Dc5mJk1AyZ1MoUfV+uEbRIHGokNmSSVjZATjZKsbWwW9zr3AIx7jX5ts9NXAfHlnpEQFJX3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqAAr2wq; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7991db3dc98so47849217b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 19:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775528459; x=1776133259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JddOLnmdz26EEBsXn/Qc2EtayJ/Lg+OLGCr/6YZatwU=;
        b=JqAAr2wq904uS+Lwd23RaZSvtkNzlKzZ4TyWBCMxA2Y6gfhzNlF1HdvOa1z7diJhaS
         JItj3sl7yr6XvqB//XM2cYzshifu+1j6F327JK8G0RLCERBl/VLvrjvnzJw9IqsQE8lZ
         cS4dPmRRDefdfYekdWJtieVQNO44oDcG3YUHjpEN0EAK652eZY7ohiG8SQERUJKIlqzi
         3ChhKEh8hVtk/nhEJUzmPSygfkzqRJ+AvfkKDsQxRkdQCezWlQyLtD93v2s4T+QyWcOQ
         bal1rA91QjWN30FW1p0AGZf8nXUoVDT5ChGkvy+pyDVh9mbN07rykkrzT4bEGQlfT8nY
         d0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775528459; x=1776133259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JddOLnmdz26EEBsXn/Qc2EtayJ/Lg+OLGCr/6YZatwU=;
        b=Q5eh+/LcCC+KW0tFs90ODlJ6+ZG9YGEheH+i+WH3lcRwkMYATtjejGop5w/XX9GL5A
         5BUG0Wx0/2XYF+fTnN6y/g4MxbouHo1sg5859Wsd6pwCe6cbD6dH46V33KFULNGTtr9P
         oZ70EeUElPuYFcsanVW+7NjdHO+E8fJMfRDeMGnbwVwUYczxoTUFz0SSmqrE/beL15ON
         5Ag1ssQO7lgLizvfL/bTvsiyxZZgSF4JfR+tvmbJVYdwU55kklxhVa5r6M91FHrv8Kyj
         r7JI6Mq1B+OfbI1C8NnK/5KvRhkzXsnERhKsLMqW7oDqMAH8RayAD36l7jlIRKIrvWw6
         BBoQ==
X-Gm-Message-State: AOJu0Yyj+WBoOGk9L5sKCmBLhsKpmGbv9hCam+ArnaAZ0pFn//Eo+qg5
	i70RDIretVmDrbRGqYh+OnVniqJl8DU0A0UnlVa3l1o+2kGlavnQq/+vq24SSX2m
X-Gm-Gg: AeBDieuFZPREDWH/915sCN6XEQv2PBjwrD9ci+vjPcJkSNPeEpMrBRbgdwovTBfg7l4
	ZGY04Ncbbzw9cm5D/U39Eoo1Km0u/9I97JQd7VkPMh8mRmdoSlCx7cxfxD/T2Q6o9nHZbrjpSuJ
	iqw+4SgzyVxgYl6y2/wyAwpQYosmZQpIA7goCqbgdPUEj/LJYMcYzDr3UNBldTMK8Xg5HcKIYRs
	ZTE6TWkA/mk146fVL03twuvBEHh4b69lRgkNeFxBQ8nqrHnutLgNDpmibe7HdKIbE78EM3MSPGj
	perf1rV3PLgPBknNANBv7G+oBmyVR7gKjzQP/7L9vXx/a5ztxyLOZZk8ZmfU8YQq8iB8MQG3/fK
	oQ/bBK4Up+Cp8NN5eRhxkGM+9v+CUTk7OARLhM/nZGiqRa8JCSOEgcgzrnXqwthss/8DnmVYT6a
	e6QfeOdi/3HzTKDWSAl/Tu4yo3av4Tz/sXov1gJSZ//xGLZAjAisdxz8r7LXxX
X-Received: by 2002:a05:690c:dd5:b0:79f:2e53:8606 with SMTP id 00721157ae682-7a4d5c5e341mr158670937b3.41.1775528459311;
        Mon, 06 Apr 2026 19:20:59 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a3712ecc31sm60979597b3.45.2026.04.06.19.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 19:20:59 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>
Subject: [PATCH wireless] wifi: mt76: mt7996: replace direct WTBL access with MCU for station statistics
Date: Mon,  6 Apr 2026 22:20:52 -0400
Message-ID: <20260407022052.49707-1-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-34407-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB2583A8FB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Direct MMIO access to WTBL entries for airtime and RSSI statistics in
mt7996_mac_sta_poll() races with firmware, causing warnings at
mt7996_mac_wtbl_lmac_addr, MCU message timeouts, and firmware
communication breakdown. The function was called from
mt7996_mac_tx_free() on every TX-Free-Done event, compounding the
issue with heavy CPU overhead.

Replace the direct WTBL polling with firmware MCU queries:
- Airtime: UNI_ALL_STA_TXRX_AIR_TIME via the existing all_sta_info
  MCU command, with a new handler in mt7996_mcu_rx_all_sta_info_event()
- RSSI: UNI_PER_STA_RSSI via new mt7996_mcu_get_per_sta_info() using
  MCU_WM_UNI_CMD(PER_STA_INFO)

Both queries run from mt7996_mac_work() every 5th tick under dev mutex,
matching the pattern already used for TX rate, admission stats, and
MSDU count reporting.

Remove mt7996_mac_sta_poll() and its airtime_ac tracking array entirely.

Vendor driver analysis (mt_wifi.ko from Xiaomi AX3000T MT7981 firmware)
confirms the RCPI-to-RSSI conversion formula (rcpi - 220) / 2 and that
the vendor never performs direct WTBL reads for statistics.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Link: https://github.com/openwrt/openwrt/issues/21177
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   7 ++
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 117 +-----------------
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 116 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   |  25 ++++
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |   2 +-
 5 files changed, 151 insertions(+), 116 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 8d59cf43f0e2..14d3ee7defa1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1392,6 +1392,13 @@ enum {
 	UNI_OFFLOAD_OFFLOAD_BMC_RPY_DETECT,
 };
 
+#define PER_STA_INFO_MAX_NUM	90
+
+enum UNI_PER_STA_INFO_TAG {
+	UNI_PER_STA_RSSI,
+	UNI_PER_STA_MAX_NUM
+};
+
 enum UNI_ALL_STA_INFO_TAG {
 	UNI_ALL_STA_TXRX_RATE,
 	UNI_ALL_STA_TX_STAT,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index d4f3ee943b47..3d9648fb6773 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -111,119 +111,6 @@ u32 mt7996_mac_wtbl_lmac_addr(struct mt7996_dev *dev, u16 wcid, u8 dw)
 	return MT_WTBL_LMAC_OFFS(wcid, dw);
 }
 
-static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
-{
-	static const u8 ac_to_tid[] = {
-		[IEEE80211_AC_BE] = 0,
-		[IEEE80211_AC_BK] = 1,
-		[IEEE80211_AC_VI] = 4,
-		[IEEE80211_AC_VO] = 6
-	};
-	struct mt7996_sta_link *msta_link;
-	struct mt76_vif_link *mlink;
-	struct ieee80211_sta *sta;
-	struct mt7996_sta *msta;
-	u32 tx_time[IEEE80211_NUM_ACS], rx_time[IEEE80211_NUM_ACS];
-	LIST_HEAD(sta_poll_list);
-	struct mt76_wcid *wcid;
-	int i;
-
-	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	list_splice_init(&dev->mt76.sta_poll_list, &sta_poll_list);
-	spin_unlock_bh(&dev->mt76.sta_poll_lock);
-
-	rcu_read_lock();
-
-	while (true) {
-		bool clear = false;
-		u32 addr, val;
-		u16 idx;
-		s8 rssi[4];
-
-		spin_lock_bh(&dev->mt76.sta_poll_lock);
-		if (list_empty(&sta_poll_list)) {
-			spin_unlock_bh(&dev->mt76.sta_poll_lock);
-			break;
-		}
-		msta_link = list_first_entry(&sta_poll_list,
-					     struct mt7996_sta_link,
-					     wcid.poll_list);
-		msta = msta_link->sta;
-		wcid = &msta_link->wcid;
-		list_del_init(&wcid->poll_list);
-		spin_unlock_bh(&dev->mt76.sta_poll_lock);
-
-		idx = wcid->idx;
-
-		/* refresh peer's airtime reporting */
-		addr = mt7996_mac_wtbl_lmac_addr(dev, idx, 20);
-
-		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-			u32 tx_last = msta_link->airtime_ac[i];
-			u32 rx_last = msta_link->airtime_ac[i + 4];
-
-			msta_link->airtime_ac[i] = mt76_rr(dev, addr);
-			msta_link->airtime_ac[i + 4] = mt76_rr(dev, addr + 4);
-
-			tx_time[i] = msta_link->airtime_ac[i] - tx_last;
-			rx_time[i] = msta_link->airtime_ac[i + 4] - rx_last;
-
-			if ((tx_last | rx_last) & BIT(30))
-				clear = true;
-
-			addr += 8;
-		}
-
-		if (clear) {
-			mt7996_mac_wtbl_update(dev, idx,
-					       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
-			memset(msta_link->airtime_ac, 0,
-			       sizeof(msta_link->airtime_ac));
-		}
-
-		if (!wcid->sta)
-			continue;
-
-		sta = container_of((void *)msta, struct ieee80211_sta,
-				   drv_priv);
-		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-			u8 q = mt76_connac_lmac_mapping(i);
-			u32 tx_cur = tx_time[q];
-			u32 rx_cur = rx_time[q];
-			u8 tid = ac_to_tid[i];
-
-			if (!tx_cur && !rx_cur)
-				continue;
-
-			ieee80211_sta_register_airtime(sta, tid, tx_cur, rx_cur);
-		}
-
-		/* get signal strength of resp frames (CTS/BA/ACK) */
-		addr = mt7996_mac_wtbl_lmac_addr(dev, idx, 34);
-		val = mt76_rr(dev, addr);
-
-		rssi[0] = to_rssi(GENMASK(7, 0), val);
-		rssi[1] = to_rssi(GENMASK(15, 8), val);
-		rssi[2] = to_rssi(GENMASK(23, 16), val);
-		rssi[3] = to_rssi(GENMASK(31, 14), val);
-
-		mlink = rcu_dereference(msta->vif->mt76.link[wcid->link_id]);
-		if (mlink) {
-			struct mt76_phy *mphy = mt76_vif_link_phy(mlink);
-
-			if (mphy)
-				msta_link->ack_signal =
-					mt76_rx_signal(mphy->antenna_mask,
-						       rssi);
-		}
-
-		ewma_avg_signal_add(&msta_link->avg_ack_signal,
-				    -msta_link->ack_signal);
-	}
-
-	rcu_read_unlock();
-}
-
 /* The HW does not translate the mac header to 802.3 for mesh point */
 static int mt7996_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 {
@@ -1424,8 +1311,6 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 		}
 	}
 
-	mt7996_mac_sta_poll(dev);
-
 	if (wake)
 		mt76_set_tx_blocked(&dev->mt76, false);
 
@@ -2947,6 +2832,8 @@ void mt7996_mac_work(struct work_struct *work)
 		mt7996_mac_update_stats(phy);
 
 		mt7996_mcu_get_all_sta_info(phy, UNI_ALL_STA_TXRX_RATE);
+		mt7996_mcu_get_all_sta_info(phy, UNI_ALL_STA_TXRX_AIR_TIME);
+		mt7996_mcu_get_per_sta_info(phy, UNI_PER_STA_RSSI);
 		if (mtk_wed_device_active(&phy->dev->mt76.mmio.wed)) {
 			mt7996_mcu_get_all_sta_info(phy, UNI_ALL_STA_TXRX_ADM_STAT);
 			mt7996_mcu_get_all_sta_info(phy, UNI_ALL_STA_TXRX_MSDU_COUNT);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index c0c042de477b..05b43c16f0d3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -616,6 +616,35 @@ mt7996_mcu_rx_all_sta_info_event(struct mt7996_dev *dev, struct sk_buff *skb)
 			wcid->stats.rx_packets +=
 				le32_to_cpu(res->msdu_cnt[i].rx_msdu_cnt);
 			break;
+		case UNI_ALL_STA_TXRX_AIR_TIME: {
+			static const u8 ac_to_tid[] = {
+				[IEEE80211_AC_BE] = 0,
+				[IEEE80211_AC_BK] = 1,
+				[IEEE80211_AC_VI] = 4,
+				[IEEE80211_AC_VO] = 6
+			};
+			struct ieee80211_sta *sta;
+
+			wlan_idx = le16_to_cpu(res->airtime[i].wlan_idx);
+			wcid = mt76_wcid_ptr(dev, wlan_idx);
+			sta = wcid_to_sta(wcid);
+			if (!sta)
+				break;
+
+			for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+				u8 lmac_ac = mt76_connac_lmac_mapping(ac);
+				u32 tx_cur = le32_to_cpu(res->airtime[i].tx[lmac_ac]);
+				u32 rx_cur = le32_to_cpu(res->airtime[i].rx[lmac_ac]);
+
+				if (!tx_cur && !rx_cur)
+					continue;
+
+				ieee80211_sta_register_airtime(sta,
+							      ac_to_tid[ac],
+							      tx_cur, rx_cur);
+			}
+			break;
+		}
 		default:
 			break;
 		}
@@ -4755,6 +4784,93 @@ int mt7996_mcu_get_all_sta_info(struct mt7996_phy *phy, u16 tag)
 				 &req, sizeof(req), false);
 }
 
+int mt7996_mcu_get_per_sta_info(struct mt7996_phy *phy, u16 tag)
+{
+	struct mt7996_dev *dev = phy->dev;
+	struct mt7996_mcu_per_sta_info_event *res;
+	struct mt76_wcid *wcid;
+	struct sk_buff *skb;
+	int i, ret, sta_num = 0;
+	struct {
+		u8 _rsv1;
+		u8 unsolicit;
+		u8 _rsv2[2];
+
+		__le16 tag;
+		__le16 len;
+		__le16 sta_num;
+		u8 _rsv3[2];
+		__le16 wlan_idx[PER_STA_INFO_MAX_NUM];
+	} __packed req = {
+		.tag = cpu_to_le16(tag),
+		.len = cpu_to_le16(sizeof(req) - 4),
+	};
+
+	/* Build list of active station WCIDs */
+	rcu_read_lock();
+	for (i = 0; i < mt7996_wtbl_size(dev) && sta_num < PER_STA_INFO_MAX_NUM; i++) {
+		wcid = rcu_dereference(dev->mt76.wcid[i]);
+		if (!wcid || !wcid->sta)
+			continue;
+		req.wlan_idx[sta_num] = cpu_to_le16(i);
+		sta_num++;
+	}
+	rcu_read_unlock();
+
+	if (!sta_num)
+		return 0;
+
+	req.sta_num = cpu_to_le16(sta_num);
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_WM_UNI_CMD(PER_STA_INFO),
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	res = (struct mt7996_mcu_per_sta_info_event *)skb->data;
+
+	rcu_read_lock();
+	for (i = 0; i < sta_num; i++) {
+		struct mt7996_sta_link *msta_link;
+		struct mt76_vif_link *mlink;
+		struct mt76_phy *mphy;
+		u16 wlan_idx;
+		s8 rssi[4];
+
+		switch (tag) {
+		case UNI_PER_STA_RSSI:
+			wlan_idx = le16_to_cpu(res->rssi[i].wlan_idx);
+			wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
+			if (!wcid || !wcid->sta)
+				break;
+
+			msta_link = container_of(wcid, struct mt7996_sta_link, wcid);
+
+			rssi[0] = (res->rssi[i].rcpi[0] - 220) / 2;
+			rssi[1] = (res->rssi[i].rcpi[1] - 220) / 2;
+			rssi[2] = (res->rssi[i].rcpi[2] - 220) / 2;
+			rssi[3] = (res->rssi[i].rcpi[3] - 220) / 2;
+
+			mlink = rcu_dereference(msta_link->sta->vif->mt76.link[wcid->link_id]);
+			if (mlink) {
+				mphy = mt76_vif_link_phy(mlink);
+				if (mphy)
+					msta_link->ack_signal =
+						mt76_rx_signal(mphy->antenna_mask, rssi);
+			}
+
+			ewma_avg_signal_add(&msta_link->avg_ack_signal,
+					    -msta_link->ack_signal);
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	dev_kfree_skb(skb);
+
+	return 0;
+}
+
 int mt7996_mcu_wed_rro_reset_sessions(struct mt7996_dev *dev, u16 id)
 {
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index e0b83ac9f5e2..b5bad9a76c49 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -220,6 +220,31 @@ struct mt7996_mcu_all_sta_info_event {
 			__le32 tx_msdu_cnt;
 			__le32 rx_msdu_cnt;
 		} __packed, msdu_cnt);
+
+		DECLARE_FLEX_ARRAY(struct {
+			__le16 wlan_idx;
+			u8 rsv[2];
+			__le32 tx[IEEE80211_NUM_ACS];
+			__le32 rx[IEEE80211_NUM_ACS];
+		} __packed, airtime);
+	} __packed;
+} __packed;
+
+struct mt7996_mcu_per_sta_info_event {
+	u8 rsv[4];
+	__le16 tag;
+	__le16 len;
+	u8 more;
+	u8 rsv2;
+	__le16 sta_num;
+	u8 rsv3[4];
+
+	union {
+		DECLARE_FLEX_ARRAY(struct {
+			__le16 wlan_idx;
+			u8 rsv[2];
+			u8 rcpi[4];
+		} __packed, rssi);
 	} __packed;
 } __packed;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 7a884311800e..b523e971f78c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -222,7 +222,6 @@ struct mt7996_sta_link {
 	struct mt7996_sta *sta;
 
 	struct list_head rc_list;
-	u32 airtime_ac[8];
 
 	int ack_signal;
 	struct ewma_avg_signal avg_ack_signal;
@@ -741,6 +740,7 @@ int mt7996_mcu_trigger_assert(struct mt7996_dev *dev);
 void mt7996_mcu_rx_event(struct mt7996_dev *dev, struct sk_buff *skb);
 void mt7996_mcu_exit(struct mt7996_dev *dev);
 int mt7996_mcu_get_all_sta_info(struct mt7996_phy *phy, u16 tag);
+int mt7996_mcu_get_per_sta_info(struct mt7996_phy *phy, u16 tag);
 int mt7996_mcu_wed_rro_reset_sessions(struct mt7996_dev *dev, u16 id);
 int mt7996_mcu_set_sniffer_mode(struct mt7996_phy *phy, bool enabled);
 
-- 
2.43.0


