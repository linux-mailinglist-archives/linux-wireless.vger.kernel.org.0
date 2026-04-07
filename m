Return-Path: <linux-wireless+bounces-34430-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOMRMXqY1GmkvgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34430-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:39:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3C63A9FEB
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9EC7E3006801
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 05:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3E6175A7D;
	Tue,  7 Apr 2026 05:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhvjPU66"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFCE72617
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 05:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775540343; cv=none; b=S1ubrehIRPX4GmH0h6tzgilzPux27vno2oarGqoY7fVaZcwMklmyCZrhgz1SI7gOYwqrQJZ8szWB7tfS4Iu3p1A09s/6v8e4vAY/IXRKdoxixROnuLzTrzi0cHMy5VfmlGjJ8XpBcHrI6prIadO7gXIavQGgv8F+Rwe4Eeeu0U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775540343; c=relaxed/simple;
	bh=IRn1iHsh+KT5bQLVxdgsR9/SL1/3QCs4bivfyu0Ddj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eiL0t/nCGi2DFBoswpNcvtMZF58Mt2SyHXyuAhk8N+jqUDzXdEVIXLFYkSjGMyIXrZjfSIdX6ZbSEpzpT0vm9Wadx9mA+Pgu+bU2HyBU6O1rgNfjB4H+Tkv1sNikgBO9WT2hgSZvdMaFZXQMY1fprH7FfPSXEzmCYCCp+/BGUKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhvjPU66; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6501d242e2fso4288926d50.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 22:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775540341; x=1776145141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UoNOtbIcVuuYeRhi/A1CU8Wxo31bIwYVCXUlJdOsgso=;
        b=WhvjPU66UkSfruIQ8D0FYHZpGvKvI3FDtk0WRgnd3Zd2KxRIhl/dxJYaPeNXOB77FW
         ipcWTGyRvD9QWSv4NnF3wq2h0J9lpu9LlJQiKViOSTLCWTA9EoWoUG8P4RTYNKMKb6Ic
         Qj7k+qwuXcJtUgyWNwtyEdaFw9ZQHfejE4cjVDAtTQhlSNd2ENlYmHnelhCPnkea9yGJ
         gftx87Rbc4EdvfEsSbrni1jWbJ8el4Djo6Bry0aa5DLF7e4tNxfMg2hFYnDofRC/dwp8
         RMkS57nhpRDHAdQrhH7H3Fg2hEod3dGpxaMIF911nS4XX7IdKjkWOmIgwzNfc9PUahGy
         YugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775540341; x=1776145141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UoNOtbIcVuuYeRhi/A1CU8Wxo31bIwYVCXUlJdOsgso=;
        b=hq33gaBJY30mjlyr4BkNnrom9n9iWtaSVnmwgt/lTUz15f752FCQagVkJEtD6/zkS5
         wAWixBvgUqUC+1ymkQfJ0IQjcIdeDxQBT4cBaDus7AuHjv/hbDuYFnz/MrT0l/aj+j/t
         RMZq0JzZKM7cogjJ+gXMlwrOnqCcrLBU+L0QnTwBehI72HWaLqkJ6caHZ8SBWxZ2gsYf
         7/v07xTHj03QLfIWt3MDTq7aO+/zg28F0z1PK9OjvRnqYqb8cXEXNeSjF8y/VArAsd88
         6r0TpTAOB90xgqkh3K3MsAnv3hp3TlKRZCtDWDXq5USdGnKIdUWFGagQ3dZZr8LPrWxF
         c7Ag==
X-Gm-Message-State: AOJu0YwyO8fH5WdHfnB1KKUB7ZqOW22i0DxG1fj7b8/BOFmtcoFqODKB
	bqgu09hIsMlikXauh+1copzCsPypKpXhESzWZoL9PbNWnV0ad6C7QR0yGXWHhayv
X-Gm-Gg: AeBDiev45wJf6Wt+v9mfV15VidhOmqC0b0/1h1/qbc0MqgKaBFeWCo7mSZOYyUBM2sn
	A3oOiw4RO2sDjQiAyYICgfpKKO3bTug8zhRCLVWZhkFJ+w2AKD2AQiHP3wQuqOa4q64lLjXMviu
	MAS9yYJecPNN1vzNc/bbvUMEqfBZqxdcQyUiQXsYO+t6go6YyE7ienbltCDzTgz6JvXsXxuHSWZ
	L8yHcH0TTKl1m3kXE5B2K9Icx3xIRc1c/p6P9IbvmEPOiSIZ80hy2opTlvYI45p28ShMNNuMDlY
	p4LmMrXczMjjwTR1hX7ClTHljS94kLG0ln0vyS3tievj/P/9uNlEcNlJt9GPi35RlUqj9Gc/PdB
	uzfADCm1wK69acB+CJknOtMG2vYsVnxW9mMr9Ypf1Nyw5A5kCnwu6l+r8BC5QLOsAd2YCCv+ItS
	a3hUdVLM+kx0HeH0NqokdAkKVKCj5m9UQ5CUuFDcT8+u01JEX+nlBidgUKZFgO
X-Received: by 2002:a53:acdb:0:10b0:64e:a8fc:a29a with SMTP id 956f58d0204a3-6504870d1a0mr11376258d50.21.1775540340750;
        Mon, 06 Apr 2026 22:39:00 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a84352asm7075682d50.6.2026.04.06.22.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 22:39:00 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>
Subject: [PATCH wireless v2] wifi: mt76: mt7996: replace direct WTBL access with MCU for station statistics
Date: Tue,  7 Apr 2026 01:38:55 -0400
Message-ID: <20260407053855.75828-1-joshuaklinesmith@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-34430-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B3C63A9FEB
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

The per-sta-info response handler validates the firmware-returned entry
count against what was requested and against the skb payload length
before walking the response array, and uses bounds-checked
mt76_wcid_ptr() for WLAN ID lookup. RSSI polling is batched in groups
of PER_STA_INFO_MAX_NUM to cover the full WTBL capacity.

Vendor driver analysis (mt_wifi.ko from Xiaomi AX3000T MT7981 firmware)
confirms the RCPI-to-RSSI conversion formula (rcpi - 220) / 2 and that
the vendor never performs direct WTBL reads for statistics.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Link: https://github.com/openwrt/openwrt/issues/21177
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   7 +
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 117 +--------------
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 135 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   |  25 ++++
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |   2 +-
 5 files changed, 170 insertions(+), 116 deletions(-)

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
index c0c042de477b..bf95e1d9299d 100644
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
@@ -4755,6 +4784,112 @@ int mt7996_mcu_get_all_sta_info(struct mt7996_phy *phy, u16 tag)
 				 &req, sizeof(req), false);
 }
 
+int mt7996_mcu_get_per_sta_info(struct mt7996_phy *phy, u16 tag)
+{
+	struct mt7996_dev *dev = phy->dev;
+	struct mt7996_mcu_per_sta_info_event *res;
+	struct mt76_wcid *wcid;
+	struct sk_buff *skb;
+	int i, ret, sta_num, resp_sta_num;
+	int wcid_idx = 0;
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
+	while (wcid_idx < mt7996_wtbl_size(dev)) {
+		sta_num = 0;
+
+		rcu_read_lock();
+		for (i = wcid_idx;
+		     i < mt7996_wtbl_size(dev) && sta_num < PER_STA_INFO_MAX_NUM;
+		     i++) {
+			wcid = rcu_dereference(dev->mt76.wcid[i]);
+			if (!wcid || !wcid->sta)
+				continue;
+			req.wlan_idx[sta_num++] = cpu_to_le16(i);
+		}
+		rcu_read_unlock();
+		wcid_idx = i;
+
+		if (!sta_num)
+			continue;
+
+		req.sta_num = cpu_to_le16(sta_num);
+
+		ret = mt76_mcu_send_and_get_msg(&dev->mt76,
+						MCU_WM_UNI_CMD(PER_STA_INFO),
+						&req, sizeof(req), true, &skb);
+		if (ret)
+			return ret;
+
+		res = (struct mt7996_mcu_per_sta_info_event *)skb->data;
+
+		resp_sta_num = le16_to_cpu(res->sta_num);
+		if (resp_sta_num > sta_num ||
+		    skb->len < struct_size(res, rssi, resp_sta_num)) {
+			dev_kfree_skb(skb);
+			return -EINVAL;
+		}
+
+		rcu_read_lock();
+		for (i = 0; i < resp_sta_num; i++) {
+			struct mt7996_sta_link *msta_link;
+			struct mt76_vif_link *mvif;
+			struct mt76_vif_link *mlink;
+			struct mt76_phy *mphy;
+			u16 wlan_idx;
+			s8 rssi[4];
+
+			switch (tag) {
+			case UNI_PER_STA_RSSI:
+				wlan_idx = le16_to_cpu(res->rssi[i].wlan_idx);
+				wcid = mt76_wcid_ptr(dev, wlan_idx);
+				if (!wcid || !wcid->sta)
+					break;
+
+				msta_link = container_of(wcid,
+							 struct mt7996_sta_link,
+							 wcid);
+
+				rssi[0] = (res->rssi[i].rcpi[0] - 220) / 2;
+				rssi[1] = (res->rssi[i].rcpi[1] - 220) / 2;
+				rssi[2] = (res->rssi[i].rcpi[2] - 220) / 2;
+				rssi[3] = (res->rssi[i].rcpi[3] - 220) / 2;
+
+				mvif = &msta_link->sta->vif->mt76;
+				mlink = rcu_dereference(mvif->link[wcid->link_id]);
+				if (mlink) {
+					mphy = mt76_vif_link_phy(mlink);
+					if (mphy)
+						msta_link->ack_signal =
+							mt76_rx_signal(mphy->antenna_mask,
+								       rssi);
+				}
+
+				ewma_avg_signal_add(&msta_link->avg_ack_signal,
+						    -msta_link->ack_signal);
+				break;
+			}
+		}
+		rcu_read_unlock();
+
+		dev_kfree_skb(skb);
+	}
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


