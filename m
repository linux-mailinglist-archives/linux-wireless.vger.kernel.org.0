Return-Path: <linux-wireless+bounces-25413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82923B04BB5
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 01:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BE91AA1BB3
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 23:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492A228A3F5;
	Mon, 14 Jul 2025 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSNSfyKY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044B828DB78;
	Mon, 14 Jul 2025 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752534424; cv=none; b=Fm3pc0DfSPN4Y7AmZNMZwr+R68MPqWHGluDdn1Zy1MtwDSrXlrwrmL/zMSnkTmIq1hi55VWkrynaw1n8sBhaH8y9NvEGlyKcrK+BEgeKuvVWYdUNSZl2KSoZI6kr59ZrV+4ElsHqTczqgS8MQuodwwybm9Slqtys7IyWukRV4Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752534424; c=relaxed/simple;
	bh=iYpg6jMMA4D2mfS3V7LxiDCKM20iy8BXDJ5WGYM8nlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZh1inwOrXQ+I+7EmHMGDoAUe9t/MMgANaPWR+6XIz4y1kowUqIvBvhwCMacSjgDu9CriHnXLfrxc7zph6y77idlUnewhsMfahnCm0TYRmu8q/QJlKTH92i7rIa5EgfyeB3Ugkb3XZdPkmhOb7OoavEc+EnHxqW78ubWuF56mWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSNSfyKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E354C4CEED;
	Mon, 14 Jul 2025 23:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752534423;
	bh=iYpg6jMMA4D2mfS3V7LxiDCKM20iy8BXDJ5WGYM8nlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tSNSfyKY8tM0hJtdSG/2XqXzm1L1ebC7dJ5Tu/zjqK/1Qlc60t9VgIVWz7ujyHeuC
	 WvRuWtdT9rEbXFHt+a8bkIf+y9dBSKyY7QJ2FC2zpPaFUy5ZHJGiRY0BTNAsQVdKwt
	 +kgegdyUAj+qzQn3cBhNzeJfFpxfP0/4F4TBHrS3+HyDOt1ZghrLJ1GiRd+7IVhFb3
	 Pakwm35ldI+dpnUq29k6xLo+EsYc3e2sgwwCwfM/FrhOoBg4Voy0zFfb4MIhOLsSQ/
	 F7uEXu3EuA7DkEyH7XXfNdCTjOhaL2hyrvxKoQpCh8s9nqAz1qAbJsjcSmymquFxzj
	 DVzHqq4IZe4XA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	kuba@kernel.org,
	edumazet@google.com,
	shayne.chen@mediatek.com,
	StanleyYP.Wang@mediatek.com,
	razvan.grigore@vampirebyte.ro,
	quic_adisi@quicinc.com,
	chad@monroe.io,
	bsdhenrymartin@gmail.com,
	wiagn233@outlook.com,
	chui-hao.chiu@mediatek.com,
	sean.wang@mediatek.com,
	mingyen.hsieh@mediatek.com,
	quan.zhou@mediatek.com,
	Bo.Jiao@mediatek.com,
	benjamin-jw.lin@mediatek.com,
	howard-yh.hsu@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.15 11/15] wifi: mt76: add a wrapper for wcid access with validation
Date: Mon, 14 Jul 2025 19:06:12 -0400
Message-Id: <20250714230616.3709521-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250714230616.3709521-1-sashal@kernel.org>
References: <20250714230616.3709521-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit dc66a129adf1f25e944d0b93cd2df2ee0f0bd4d6 ]

Several places use rcu_dereference to get a wcid entry without validating
if the index exceeds the array boundary. Fix this by using a helper function,
which handles validation.

Link: https://patch.msgid.link/20250707154702.1726-1-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my analysis, I can now provide a determination:

**YES**, this commit should be backported to stable kernel trees.

## Extensive Explanation:

### 1. **Security Impact - Preventing Out-of-Bounds Access**

The commit adds crucial bounds checking to prevent out-of-bounds array
access. The wcid array has a fixed size of `MT76_N_WCIDS` (1088
entries), but multiple code paths were accessing it using an index
without validating if it's within bounds:

```c
- wcid = rcu_dereference(dev->mt76.wcid[idx]);
+ wcid = mt76_wcid_ptr(dev, idx);
```

The new `__mt76_wcid_ptr()` function adds:
```c
if (idx >= ARRAY_SIZE(dev->wcid))
    return NULL;
```

### 2. **Real-World Crashes and CVE Prevention**

Looking at historical commits, there have been multiple crashes related
to invalid wcid access:
- Commit `862bf7cbd772` fixed an oops caused by dereferencing invalid
  wcid indices
- The crash trace shows: "Unable to handle kernel read from unreadable
  memory at virtual address 0000000000000024"
- Similar to commit `098428c400ff` (marked as backport candidate) which
  added null checks for wcid

### 3. **Attack Surface Consideration**

This vulnerability is particularly concerning because:
- The wcid index often comes from external sources (received packets,
  firmware events)
- Malicious or corrupted data could trigger out-of-bounds access
- Wi-Fi drivers are exposed to untrusted input from the air interface

### 4. **Minimal Risk of Regression**

The fix is:
- Simple and focused - just adds a bounds check wrapper
- Doesn't change any logic or behavior for valid indices
- Returns NULL for invalid indices, which existing code already handles
- Similar pattern to stable-worthy commit `098428c400ff`

### 5. **Wide Impact Across Multiple Chipsets**

The change affects all mt76-supported chipsets:
- mt7603, mt7615, mt7915, mt7921, mt7925, mt7996
- mt76x02 family
- Both PCIe and USB/SDIO variants

### 6. **Stable Tree Criteria Met**

According to stable tree rules:
- ✓ Fixes a real bug (out-of-bounds access)
- ✓ Small and contained change
- ✓ No new features or architectural changes
- ✓ Critical for security (prevents potential crashes/exploits)
- ✓ Minimal risk of regression

### 7. **Pattern of Similar Fixes**

The historical commits show this is part of an ongoing effort to harden
wcid handling:
- Multiple previous fixes for wcid-related crashes
- Commit `098428c400ff` (backported) added null checks before
  dereferencing
- This commit completes the hardening by adding bounds checks

The combination of security impact, real-world crash prevention, minimal
regression risk, and the pattern of similar backported fixes makes this
an excellent candidate for stable backporting.

 drivers/net/wireless/mediatek/mt76/mt76.h            | 10 ++++++++++
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c      |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c      | 10 ++--------
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c      |  7 ++-----
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h         |  5 +----
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c     |  4 +---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c      | 12 +++---------
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c     |  5 +----
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c      |  6 +++---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c      |  6 +++---
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c      |  5 +----
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c      | 12 +++---------
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c      | 11 ++++-------
 drivers/net/wireless/mediatek/mt76/tx.c              |  8 +++-----
 drivers/net/wireless/mediatek/mt76/util.c            |  2 +-
 17 files changed, 41 insertions(+), 68 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index d7cd467b812fc..f00946aa2a1e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1212,6 +1212,16 @@ static inline int mt76_wed_dma_setup(struct mt76_dev *dev, struct mt76_queue *q,
 #define mt76_dereference(p, dev) \
 	rcu_dereference_protected(p, lockdep_is_held(&(dev)->mutex))
 
+static inline struct mt76_wcid *
+__mt76_wcid_ptr(struct mt76_dev *dev, u16 idx)
+{
+	if (idx >= ARRAY_SIZE(dev->wcid))
+		return NULL;
+	return rcu_dereference(dev->wcid[idx]);
+}
+
+#define mt76_wcid_ptr(dev, idx) __mt76_wcid_ptr(&(dev)->mt76, idx)
+
 struct mt76_dev *mt76_alloc_device(struct device *pdev, unsigned int size,
 				   const struct ieee80211_ops *ops,
 				   const struct mt76_driver_ops *drv_ops);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 863e5770df51d..e26cc78fff949 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -44,7 +44,7 @@ mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 	if (idx >= MT7603_WTBL_STA - 1)
 		goto free;
 
-	wcid = rcu_dereference(dev->mt76.wcid[idx]);
+	wcid = mt76_wcid_ptr(dev, idx);
 	if (!wcid)
 		goto free;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 413973d05b431..6387f9e61060a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -487,10 +487,7 @@ mt7603_rx_get_wcid(struct mt7603_dev *dev, u8 idx, bool unicast)
 	struct mt7603_sta *sta;
 	struct mt76_wcid *wcid;
 
-	if (idx >= MT7603_WTBL_SIZE)
-		return NULL;
-
-	wcid = rcu_dereference(dev->mt76.wcid[idx]);
+	wcid = mt76_wcid_ptr(dev, idx);
 	if (unicast || !wcid)
 		return wcid;
 
@@ -1266,12 +1263,9 @@ void mt7603_mac_add_txs(struct mt7603_dev *dev, void *data)
 	if (pid == MT_PACKET_ID_NO_ACK)
 		return;
 
-	if (wcidx >= MT7603_WTBL_SIZE)
-		return;
-
 	rcu_read_lock();
 
-	wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
+	wcid = mt76_wcid_ptr(dev, wcidx);
 	if (!wcid)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 3ca4fae7c4b0f..f8d2cc94b742c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -90,10 +90,7 @@ static struct mt76_wcid *mt7615_rx_get_wcid(struct mt7615_dev *dev,
 	struct mt7615_sta *sta;
 	struct mt76_wcid *wcid;
 
-	if (idx >= MT7615_WTBL_SIZE)
-		return NULL;
-
-	wcid = rcu_dereference(dev->mt76.wcid[idx]);
+	wcid = mt76_wcid_ptr(dev, idx);
 	if (unicast || !wcid)
 		return wcid;
 
@@ -1504,7 +1501,7 @@ static void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data)
 
 	rcu_read_lock();
 
-	wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
+	wcid = mt76_wcid_ptr(dev, wcidx);
 	if (!wcid)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index e9ac8a7317a11..0db00efe88b0b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -1172,7 +1172,7 @@ void mt76_connac2_txwi_free(struct mt76_dev *dev, struct mt76_txwi_cache *t,
 		wcid_idx = wcid->idx;
 	} else {
 		wcid_idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
-		wcid = rcu_dereference(dev->wcid[wcid_idx]);
+		wcid = __mt76_wcid_ptr(dev, wcid_idx);
 
 		if (wcid && wcid->sta) {
 			sta = container_of((void *)wcid, struct ieee80211_sta,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 4cd63bacd742c..9d7ee09b6cc97 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -262,10 +262,7 @@ mt76x02_rx_get_sta(struct mt76_dev *dev, u8 idx)
 {
 	struct mt76_wcid *wcid;
 
-	if (idx >= MT76x02_N_WCIDS)
-		return NULL;
-
-	wcid = rcu_dereference(dev->wcid[idx]);
+	wcid = __mt76_wcid_ptr(dev, idx);
 	if (!wcid)
 		return NULL;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index d5db6ffd6d365..83488b2d6efb9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -564,9 +564,7 @@ void mt76x02_send_tx_status(struct mt76x02_dev *dev,
 
 	rcu_read_lock();
 
-	if (stat->wcid < MT76x02_N_WCIDS)
-		wcid = rcu_dereference(dev->mt76.wcid[stat->wcid]);
-
+	wcid = mt76_wcid_ptr(dev, stat->wcid);
 	if (wcid && wcid->sta) {
 		void *priv;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 2ba6eb3038cec..2cc47eaed2e23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -56,10 +56,7 @@ static struct mt76_wcid *mt7915_rx_get_wcid(struct mt7915_dev *dev,
 	struct mt7915_sta *sta;
 	struct mt76_wcid *wcid;
 
-	if (idx >= ARRAY_SIZE(dev->mt76.wcid))
-		return NULL;
-
-	wcid = rcu_dereference(dev->mt76.wcid[idx]);
+	wcid = mt76_wcid_ptr(dev, idx);
 	if (unicast || !wcid)
 		return wcid;
 
@@ -917,7 +914,7 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 			u16 idx;
 
 			idx = FIELD_GET(MT_TX_FREE_WLAN_ID, info);
-			wcid = rcu_dereference(dev->mt76.wcid[idx]);
+			wcid = mt76_wcid_ptr(dev, idx);
 			sta = wcid_to_sta(wcid);
 			if (!sta)
 				continue;
@@ -1013,12 +1010,9 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 	if (pid < MT_PACKET_ID_WED)
 		return;
 
-	if (wcidx >= mt7915_wtbl_size(dev))
-		return;
-
 	rcu_read_lock();
 
-	wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
+	wcid = mt76_wcid_ptr(dev, wcidx);
 	if (!wcid)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 3643c72bb68d4..0160e05db18c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3964,7 +3964,7 @@ int mt7915_mcu_wed_wa_tx_stats(struct mt7915_dev *dev, u16 wlan_idx)
 
 	rcu_read_lock();
 
-	wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
+	wcid = mt76_wcid_ptr(dev, wlan_idx);
 	if (wcid)
 		wcid->stats.tx_packets += le32_to_cpu(res->tx_packets);
 	else
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 9c4d5cea0c42e..4a82f8e4c1180 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -587,12 +587,9 @@ static void mt7915_mmio_wed_update_rx_stats(struct mtk_wed_device *wed,
 
 	dev = container_of(wed, struct mt7915_dev, mt76.mmio.wed);
 
-	if (idx >= mt7915_wtbl_size(dev))
-		return;
-
 	rcu_read_lock();
 
-	wcid = rcu_dereference(dev->mt76.wcid[idx]);
+	wcid = mt76_wcid_ptr(dev, idx);
 	if (wcid) {
 		wcid->stats.rx_bytes += le32_to_cpu(stats->rx_byte_cnt);
 		wcid->stats.rx_packets += le32_to_cpu(stats->rx_pkt_cnt);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 5dd57de59f275..f1f76506b0a5b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -465,7 +465,7 @@ void mt7921_mac_add_txs(struct mt792x_dev *dev, void *data)
 
 	rcu_read_lock();
 
-	wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
+	wcid = mt76_wcid_ptr(dev, wcidx);
 	if (!wcid)
 		goto out;
 
@@ -516,7 +516,7 @@ static void mt7921_mac_tx_free(struct mt792x_dev *dev, void *data, int len)
 
 			count++;
 			idx = FIELD_GET(MT_TX_FREE_WLAN_ID, info);
-			wcid = rcu_dereference(dev->mt76.wcid[idx]);
+			wcid = mt76_wcid_ptr(dev, idx);
 			sta = wcid_to_sta(wcid);
 			if (!sta)
 				continue;
@@ -816,7 +816,7 @@ void mt7921_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
 	u16 idx;
 
 	idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
-	wcid = rcu_dereference(mdev->wcid[idx]);
+	wcid = __mt76_wcid_ptr(mdev, idx);
 	sta = wcid_to_sta(wcid);
 
 	if (sta && likely(e->skb->protocol != cpu_to_be16(ETH_P_PAE)))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index c871d2f9688b8..75823c9fd3a10 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1040,7 +1040,7 @@ void mt7925_mac_add_txs(struct mt792x_dev *dev, void *data)
 
 	rcu_read_lock();
 
-	wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
+	wcid = mt76_wcid_ptr(dev, wcidx);
 	if (!wcid)
 		goto out;
 
@@ -1122,7 +1122,7 @@ mt7925_mac_tx_free(struct mt792x_dev *dev, void *data, int len)
 			u16 idx;
 
 			idx = FIELD_GET(MT_TXFREE_INFO_WLAN_ID, info);
-			wcid = rcu_dereference(dev->mt76.wcid[idx]);
+			wcid = mt76_wcid_ptr(dev, idx);
 			sta = wcid_to_sta(wcid);
 			if (!sta)
 				continue;
@@ -1445,7 +1445,7 @@ void mt7925_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
 	u16 idx;
 
 	idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
-	wcid = rcu_dereference(mdev->wcid[idx]);
+	wcid = __mt76_wcid_ptr(mdev, idx);
 	sta = wcid_to_sta(wcid);
 
 	if (sta && likely(e->skb->protocol != cpu_to_be16(ETH_P_PAE)))
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
index 05978d9c7b916..3f1d9ba49076f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
@@ -142,10 +142,7 @@ struct mt76_wcid *mt792x_rx_get_wcid(struct mt792x_dev *dev, u16 idx,
 	struct mt792x_sta *sta;
 	struct mt76_wcid *wcid;
 
-	if (idx >= ARRAY_SIZE(dev->mt76.wcid))
-		return NULL;
-
-	wcid = rcu_dereference(dev->mt76.wcid[idx]);
+	wcid = mt76_wcid_ptr(dev, idx);
 	if (unicast || !wcid)
 		return wcid;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 2108361543a0c..75fa0ccf27183 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -61,10 +61,7 @@ static struct mt76_wcid *mt7996_rx_get_wcid(struct mt7996_dev *dev,
 	struct mt76_wcid *wcid;
 	int i;
 
-	if (idx >= ARRAY_SIZE(dev->mt76.wcid))
-		return NULL;
-
-	wcid = rcu_dereference(dev->mt76.wcid[idx]);
+	wcid = mt76_wcid_ptr(dev, idx);
 	if (!wcid)
 		return NULL;
 
@@ -1219,7 +1216,7 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 			u16 idx;
 
 			idx = FIELD_GET(MT_TXFREE_INFO_WLAN_ID, info);
-			wcid = rcu_dereference(dev->mt76.wcid[idx]);
+			wcid = mt76_wcid_ptr(dev, idx);
 			sta = wcid_to_sta(wcid);
 			if (!sta)
 				continue;
@@ -1436,12 +1433,9 @@ static void mt7996_mac_add_txs(struct mt7996_dev *dev, void *data)
 	if (pid < MT_PACKET_ID_NO_SKB)
 		return;
 
-	if (wcidx >= mt7996_wtbl_size(dev))
-		return;
-
 	rcu_read_lock();
 
-	wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
+	wcid = mt76_wcid_ptr(dev, wcidx);
 	if (!wcid)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index ddd555942c738..03c04dfdeaab4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -533,7 +533,7 @@ mt7996_mcu_rx_all_sta_info_event(struct mt7996_dev *dev, struct sk_buff *skb)
 		switch (le16_to_cpu(res->tag)) {
 		case UNI_ALL_STA_TXRX_RATE:
 			wlan_idx = le16_to_cpu(res->rate[i].wlan_idx);
-			wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
+			wcid = mt76_wcid_ptr(dev, wlan_idx);
 
 			if (!wcid)
 				break;
@@ -543,7 +543,7 @@ mt7996_mcu_rx_all_sta_info_event(struct mt7996_dev *dev, struct sk_buff *skb)
 			break;
 		case UNI_ALL_STA_TXRX_ADM_STAT:
 			wlan_idx = le16_to_cpu(res->adm_stat[i].wlan_idx);
-			wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
+			wcid = mt76_wcid_ptr(dev, wlan_idx);
 
 			if (!wcid)
 				break;
@@ -557,7 +557,7 @@ mt7996_mcu_rx_all_sta_info_event(struct mt7996_dev *dev, struct sk_buff *skb)
 			break;
 		case UNI_ALL_STA_TXRX_MSDU_COUNT:
 			wlan_idx = le16_to_cpu(res->msdu_cnt[i].wlan_idx);
-			wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
+			wcid = mt76_wcid_ptr(dev, wlan_idx);
 
 			if (!wcid)
 				break;
@@ -654,10 +654,7 @@ mt7996_mcu_wed_rro_event(struct mt7996_dev *dev, struct sk_buff *skb)
 
 			e = (void *)skb->data;
 			idx = le16_to_cpu(e->wlan_id);
-			if (idx >= ARRAY_SIZE(dev->mt76.wcid))
-				break;
-
-			wcid = rcu_dereference(dev->mt76.wcid[idx]);
+			wcid = mt76_wcid_ptr(dev, idx);
 			if (!wcid || !wcid->sta)
 				break;
 
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index dc9bf2fff51bb..e6cf16706667e 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -64,7 +64,7 @@ mt76_tx_status_unlock(struct mt76_dev *dev, struct sk_buff_head *list)
 		struct mt76_tx_cb *cb = mt76_tx_skb_cb(skb);
 		struct mt76_wcid *wcid;
 
-		wcid = rcu_dereference(dev->wcid[cb->wcid]);
+		wcid = __mt76_wcid_ptr(dev, cb->wcid);
 		if (wcid) {
 			status.sta = wcid_to_sta(wcid);
 			if (status.sta && (wcid->rate.flags || wcid->rate.legacy)) {
@@ -251,9 +251,7 @@ void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *
 
 	rcu_read_lock();
 
-	if (wcid_idx < ARRAY_SIZE(dev->wcid))
-		wcid = rcu_dereference(dev->wcid[wcid_idx]);
-
+	wcid = __mt76_wcid_ptr(dev, wcid_idx);
 	mt76_tx_check_non_aql(dev, wcid, skb);
 
 #ifdef CONFIG_NL80211_TESTMODE
@@ -538,7 +536,7 @@ mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 			break;
 
 		mtxq = (struct mt76_txq *)txq->drv_priv;
-		wcid = rcu_dereference(dev->wcid[mtxq->wcid]);
+		wcid = __mt76_wcid_ptr(dev, mtxq->wcid);
 		if (!wcid || test_bit(MT_WCID_FLAG_PS, &wcid->flags))
 			continue;
 
diff --git a/drivers/net/wireless/mediatek/mt76/util.c b/drivers/net/wireless/mediatek/mt76/util.c
index 95b3dc96e4c45..97249ebb4bc8f 100644
--- a/drivers/net/wireless/mediatek/mt76/util.c
+++ b/drivers/net/wireless/mediatek/mt76/util.c
@@ -83,7 +83,7 @@ int mt76_get_min_avg_rssi(struct mt76_dev *dev, u8 phy_idx)
 			if (!(mask & 1))
 				continue;
 
-			wcid = rcu_dereference(dev->wcid[j]);
+			wcid = __mt76_wcid_ptr(dev, j);
 			if (!wcid || wcid->phy_idx != phy_idx)
 				continue;
 
-- 
2.39.5


