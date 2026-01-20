Return-Path: <linux-wireless+bounces-31003-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E1DD3BF4A
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 07:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B8B03A013F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 06:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B483E394496;
	Tue, 20 Jan 2026 06:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlzuqDsJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F47038B990
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890556; cv=none; b=RX7i+7fpOA0G/BOKDUSAp/eq7azVhOgJBWT8+KXxCKuHHSfSncK/uH1PV+abYygPK5CTf4i/Ys7l6RcHUsIf2fTqpsuaJ91BgvmT18wXnopRRaHeeXAucUHyguQY6Rjan0f7c1hVuPsn/h6QkyAmWCXmxsqTKOchOX40mj4SxjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890556; c=relaxed/simple;
	bh=Sndw9GK3sDCqJHnFoVwGZIb5iFCFzmXU83jlDkwH7eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMadqRCHAWsobCOh4KKz9JUtc+C5kTbbL3/IPJs3j0nlMmH4mBnF/5lPK5ND1KqdVEStIU3kHDi/YkxZwhTQ/NK4d+mFlbCAmsoLtoqPzwM4cGmek9+XVouhdZ37i7Tr0PWhRjlcueta/6WiHVgL/LfyTU2P+sz46z6Rkqbm20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlzuqDsJ; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b6bf6adc65so4983017eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 22:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890552; x=1769495352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t40lO5bXareLzTvQoLuZnyo9jiIRTa4btYWR4lNGZPU=;
        b=JlzuqDsJktiQNRWdK++irP0r+DtuFQ4zqRkVC2v/cV8zSELko5+GxfQhv2U7OrxY+f
         6A4vTkPPj8y+Qv5QZpBU0Omp341lL3AYHydUmpFStOEI0O3vYpFQs1RneEwFrghKtgKH
         xO1E46Vhhipa+bxHyIEQfDzdQ3p3U2kqa+mZV4P43V/1SzzDScwSvPOu1ynMMTqsMdZM
         F2gkdwelAnCSyCGTV8L1YPlpCgMiKxV+OOTLpijIlyoy1UuXIv2LRJIX4lPE+niK2tyX
         MFBUCObj6S9y3gpXSxrO6S0B2Ufa3Dx0vVOnHgFZLxBTnHqeqNquI4zLc3vMn+8GzWNb
         M2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890552; x=1769495352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t40lO5bXareLzTvQoLuZnyo9jiIRTa4btYWR4lNGZPU=;
        b=OFm/t5pRB5rNPCEA5pZJNcqjhatKQdkXW+dpGaq4qzKwKx4ZJw0EdVJA3SPQ7znvPE
         ptIv8BhMfhbY2wt4YR59JyEFjXiOJX1ewuy78gJ5jjd1ybKO8v7KuvLacV+Uw1kRwmFI
         sbZ/pphbw1YbxJovZfdjwJypeAm/VEcUwY3oRTYVRlMAxOkhE4MocRAm2+fJVjtUjZAI
         MYWt/K29wn21WyQZosk3ZDSSq+PeEk1yMjXFx/UMKeaDHn51RpCVnoJ2ad4nZ538HC1A
         YLpW2FHsEwJiGwgX3/yb9s2eHwvM1VRrfrPn+unWg9UTfS42fR7Tfqp4U8Ij994tp6NW
         mr6A==
X-Forwarded-Encrypted: i=1; AJvYcCXscz0h2ubKhyL0KUi33qCQlEbuiVF1XRQ9Qubm73O9ErhVWkvN1x34xNT9lVH94ZCSnrx7/B8K4/CBTOIjXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhUkugDI4zNT8FliNpfWZECZsGpJm6gVqAiggsf06Vnh/68QEb
	+cCu0JgzaJ3oPlcde0Oo888uxDCiOwm5QhBoY6supEySVE3yhipuSKB8
X-Gm-Gg: AZuq6aJ2v+BZtCgy43oAXSGbXNmqPBhZNNdBgFPYA7QINapyg2jzaGslbW6MiwSNa7l
	Y5j36Jxc1fzY7bVjMegA40dDwiLfpsOj8l12/LW7rrHJEwOWwXwz9Jg3kGCBtPLWWxANP0rYNvm
	kfSQWQi65VpwxfkR0kFDCgIuT32RJxOtbt5nO2ZbZyXrrrmYTq4QmYfVPVGGEm8wZj7yKpDx2zA
	fPIIuzMDfrlDNtFtTZBkvPMnKYC2n9qNtt+sDq8LMI232/acNZqQw/4eDl4ivkHabtfLgyZnjv/
	pjNDwEsdBy1vKtw20dZUp4DiDDTI/R/z8eaW7DmhvakXPCq4mL6GtzxlnvKrqfnf6mI1tYgczjg
	fd79cD3d0b+dGtRr+SSOe4VZ7lH6lajlTXBquW7LsK0NqyA7/F0LvWUNXlEXOOMJkHD6QKZpjcT
	iiM8quvQ4gpQnErAnwZIXbU01lizgsQpb1lFJ7y7j9b0GoxK6QPfAe0lYp/LEPl/FCGY9vSB0=
X-Received: by 2002:a05:7300:3254:b0:2b0:bd77:7ba2 with SMTP id 5a478bee46e88-2b6b4e99646mr8575481eec.35.1768890551789;
        Mon, 19 Jan 2026 22:29:11 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm15706784eec.9.2026.01.19.22.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:29:11 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	stable@vger.kernel.org,
	linux@frame.work,
	zbowling@gmail.com,
	Zac Bowling <zac@zacbowling.com>
Subject: [PATCH 11/11] wifi: mt76: mt7925: fix ROC deadlocks and race conditions
Date: Mon, 19 Jan 2026 22:28:54 -0800
Message-ID: <20260120062854.126501-12-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120062854.126501-1-zac@zacbowling.com>
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
 <20260120062854.126501-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

Fix multiple interrelated issues in the remain-on-channel (ROC) handling
that cause deadlocks, race conditions, and resource leaks.

Problems fixed:

1. Deadlock in sta removal ROC abort path:
   When a station is removed while a ROC operation is in progress, the
   driver would call mt7925_roc_abort_sync() which waits for ROC completion.
   However, the ROC work itself needs to acquire mt792x_mutex which is
   already held during station removal, causing a deadlock.

   Fix: Use async ROC abort (mt76_connac_mcu_abort_roc) when called from
   paths that already hold the mutex, and add MT76_STATE_ROC_ABORT flag
   to coordinate between the abort and the ROC timer.

2. ROC timer race during suspend:
   The ROC timer could fire after the device started suspending but before
   the ROC was properly aborted, causing undefined behavior.

   Fix: Delete ROC timer synchronously before suspend and check device
   state before processing ROC timeout.

3. ROC rate limiting for MLO auth failures:
   Rapid ROC requests during MLO authentication can overwhelm the firmware,
   causing authentication timeouts. The MT7925 firmware has limited ROC
   handling capacity.

   Fix: Add rate limiting infrastructure with configurable minimum interval
   between ROC requests. Track last ROC completion time and defer new
   requests if they arrive too quickly.

4. WCID leak in ROC cleanup:
   When ROC operations are aborted, the associated WCID resources were
   not being properly released, causing resource exhaustion over time.

   Fix: Ensure WCID cleanup happens in all ROC termination paths.

5. Async ROC abort race condition:
   The async ROC abort could race with normal ROC completion, causing
   double-free or use-after-free of ROC resources.

   Fix: Use MT76_STATE_ROC_ABORT flag and proper synchronization to
   prevent races between async abort and normal completion paths.

These fixes work together to provide robust ROC handling that doesn't
deadlock, properly releases resources, and handles edge cases during
suspend and MLO operations.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 device")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |   1 +
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 175 ++++++++++++++++--
 drivers/net/wireless/mediatek/mt76/mt792x.h   |   7 +
 3 files changed, 170 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index d05e83ea1cac..91f9dd95c89e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -511,6 +511,7 @@ enum {
 	MT76_STATE_POWER_OFF,
 	MT76_STATE_SUSPEND,
 	MT76_STATE_ROC,
+	MT76_STATE_ROC_ABORT,
 	MT76_STATE_PM,
 	MT76_STATE_WED_RESET,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index cc7ef2c17032..2404f7812897 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -453,6 +453,24 @@ static void mt7925_roc_iter(void *priv, u8 *mac,
 	mt7925_mcu_abort_roc(phy, &mvif->bss_conf, phy->roc_token_id);
 }
 
+/* Async ROC abort - safe to call while holding mutex.
+ * Sets abort flag and lets roc_work handle cleanup without blocking.
+ * This prevents deadlock when called from sta_remove path which holds mutex.
+ */
+static void mt7925_roc_abort_async(struct mt792x_dev *dev)
+{
+	struct mt792x_phy *phy = &dev->phy;
+
+	/* Set abort flag - roc_work checks this before acquiring mutex */
+	set_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state);
+
+	/* Stop timer and schedule work to handle cleanup.
+	 * Must schedule work since timer may not have fired yet.
+	 */
+	timer_delete(&phy->roc_timer);
+	ieee80211_queue_work(phy->mt76->hw, &phy->roc_work);
+}
+
 void mt7925_roc_abort_sync(struct mt792x_dev *dev)
 {
 	struct mt792x_phy *phy = &dev->phy;
@@ -473,6 +491,17 @@ void mt7925_roc_work(struct work_struct *work)
 	phy = (struct mt792x_phy *)container_of(work, struct mt792x_phy,
 						roc_work);
 
+	/* Check abort flag BEFORE acquiring mutex to prevent deadlock.
+	 * If abort is requested while we're in the sta_remove path (which
+	 * holds the mutex), we must not try to acquire it or we'll deadlock.
+	 * Clear the flags and only notify mac80211 if ROC was actually active.
+	 */
+	if (test_and_clear_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state)) {
+		if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+			ieee80211_remain_on_channel_expired(phy->mt76->hw);
+		return;
+	}
+
 	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
 		return;
 
@@ -500,14 +529,93 @@ static int mt7925_abort_roc(struct mt792x_phy *phy,
 	return err;
 }
 
+/* ROC rate limiting constants - exponential backoff to prevent MCU overload
+ * when upper layers trigger rapid reconnection cycles (e.g., MLO auth failures).
+ * Max backoff ~1.6s, resets after 10s of no timeouts.
+ */
+#define MT7925_ROC_BACKOFF_BASE_MS	100
+#define MT7925_ROC_BACKOFF_MAX_MS	1600
+#define MT7925_ROC_TIMEOUT_RESET_MS	10000
+#define MT7925_ROC_TIMEOUT_WARN_THRESH	5
+
+/* Check if ROC should be throttled due to recent timeouts.
+ * Returns delay in jiffies if throttling, 0 if OK to proceed.
+ */
+static unsigned long mt7925_roc_throttle_check(struct mt792x_phy *phy)
+{
+	unsigned long now = jiffies;
+
+	/* Reset timeout counter if it's been a while since last timeout */
+	if (phy->roc_timeout_count &&
+	    time_after(now, phy->roc_last_timeout +
+		       msecs_to_jiffies(MT7925_ROC_TIMEOUT_RESET_MS))) {
+		phy->roc_timeout_count = 0;
+		phy->roc_backoff_until = 0;
+	}
+
+	/* Check if we're still in backoff period */
+	if (phy->roc_backoff_until && time_before(now, phy->roc_backoff_until))
+		return phy->roc_backoff_until - now;
+
+	return 0;
+}
+
+/* Record ROC timeout and calculate backoff period */
+static void mt7925_roc_record_timeout(struct mt792x_phy *phy)
+{
+	unsigned int backoff_ms;
+
+	phy->roc_last_timeout = jiffies;
+	phy->roc_timeout_count++;
+
+	/* Exponential backoff: 100ms, 200ms, 400ms, 800ms, 1600ms (capped) */
+	backoff_ms = MT7925_ROC_BACKOFF_BASE_MS <<
+		     min_t(u8, phy->roc_timeout_count - 1, 4);
+	if (backoff_ms > MT7925_ROC_BACKOFF_MAX_MS)
+		backoff_ms = MT7925_ROC_BACKOFF_MAX_MS;
+
+	phy->roc_backoff_until = jiffies + msecs_to_jiffies(backoff_ms);
+
+	/* Warn if we're seeing repeated timeouts - likely upper layer issue */
+	if (phy->roc_timeout_count == MT7925_ROC_TIMEOUT_WARN_THRESH)
+		dev_warn(phy->dev->mt76.dev,
+			 "mt7925: %u consecutive ROC timeouts, possible mac80211/wpa_supplicant issue (MLO key race?)\n",
+			 phy->roc_timeout_count);
+}
+
+/* Clear timeout tracking on successful ROC */
+static void mt7925_roc_clear_timeout(struct mt792x_phy *phy)
+{
+	phy->roc_timeout_count = 0;
+	phy->roc_backoff_until = 0;
+}
+
 static int mt7925_set_roc(struct mt792x_phy *phy,
 			  struct mt792x_bss_conf *mconf,
 			  struct ieee80211_channel *chan,
 			  int duration,
 			  enum mt7925_roc_req type)
 {
+	unsigned long throttle;
 	int err;
 
+	/* Check rate limiting - if in backoff period, wait or return busy */
+	throttle = mt7925_roc_throttle_check(phy);
+	if (throttle) {
+		/* For short backoffs, wait; for longer ones, return busy */
+		if (throttle < msecs_to_jiffies(200)) {
+			msleep(jiffies_to_msecs(throttle));
+		} else {
+			dev_dbg(phy->dev->mt76.dev,
+				"mt7925: ROC throttled, %lu ms remaining\n",
+				jiffies_to_msecs(throttle));
+			return -EBUSY;
+		}
+	}
+
+	/* Clear stale abort flag from previous ROC */
+	clear_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state);
+
 	if (test_and_set_bit(MT76_STATE_ROC, &phy->mt76->state))
 		return -EBUSY;
 
@@ -523,7 +631,11 @@ static int mt7925_set_roc(struct mt792x_phy *phy,
 	if (!wait_event_timeout(phy->roc_wait, phy->roc_grant, 4 * HZ)) {
 		mt7925_mcu_abort_roc(phy, mconf, phy->roc_token_id);
 		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+		mt7925_roc_record_timeout(phy);
 		err = -ETIMEDOUT;
+	} else {
+		/* Successful ROC - reset timeout tracking */
+		mt7925_roc_clear_timeout(phy);
 	}
 
 out:
@@ -534,8 +646,27 @@ static int mt7925_set_mlo_roc(struct mt792x_phy *phy,
 			      struct mt792x_bss_conf *mconf,
 			      u16 sel_links)
 {
+	unsigned long throttle;
 	int err;
 
+	/* Check rate limiting - MLO ROC is especially prone to rapid-fire
+	 * during reconnection cycles after MLO authentication failures.
+	 */
+	throttle = mt7925_roc_throttle_check(phy);
+	if (throttle) {
+		if (throttle < msecs_to_jiffies(200)) {
+			msleep(jiffies_to_msecs(throttle));
+		} else {
+			dev_dbg(phy->dev->mt76.dev,
+				"mt7925: MLO ROC throttled, %lu ms remaining\n",
+				jiffies_to_msecs(throttle));
+			return -EBUSY;
+		}
+	}
+
+	/* Clear stale abort flag from previous ROC */
+	clear_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state);
+
 	if (WARN_ON_ONCE(test_and_set_bit(MT76_STATE_ROC, &phy->mt76->state)))
 		return -EBUSY;
 
@@ -550,7 +681,10 @@ static int mt7925_set_mlo_roc(struct mt792x_phy *phy,
 	if (!wait_event_timeout(phy->roc_wait, phy->roc_grant, 4 * HZ)) {
 		mt7925_mcu_abort_roc(phy, mconf, phy->roc_token_id);
 		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+		mt7925_roc_record_timeout(phy);
 		err = -ETIMEDOUT;
+	} else {
+		mt7925_roc_clear_timeout(phy);
 	}
 
 out:
@@ -567,6 +701,7 @@ static int mt7925_remain_on_channel(struct ieee80211_hw *hw,
 	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 	int err;
 
+	cancel_work_sync(&phy->roc_work);
 	mt792x_mutex_acquire(phy->dev);
 	err = mt7925_set_roc(phy, &mvif->bss_conf,
 			     chan, duration, MT7925_ROC_REQ_ROC);
@@ -874,14 +1009,14 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	if (!mlink)
 		return -EINVAL;
 
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1);
-	if (idx < 0)
-		return -ENOSPC;
-
 	mconf = mt792x_vif_to_link(mvif, link_id);
 	if (!mconf)
 		return -EINVAL;
 
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1);
+	if (idx < 0)
+		return -ENOSPC;
+
 	mt76_wcid_init(&mlink->wcid, 0);
 	mlink->wcid.sta = 1;
 	mlink->wcid.idx = idx;
@@ -901,14 +1036,16 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 
 	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 	if (ret)
-		return ret;
+		goto err_wcid;
 
 	mt7925_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
-	if (!link_conf)
-		return -EINVAL;
+	if (!link_conf) {
+		ret = -EINVAL;
+		goto err_wcid;
+	}
 
 	/* should update bss info before STA add */
 	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
@@ -920,7 +1057,7 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 			ret = mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
 						      link_conf, link_sta, false);
 		if (ret)
-			return ret;
+			goto err_wcid;
 	}
 
 	if (ieee80211_vif_is_mld(vif) &&
@@ -928,28 +1065,34 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 		ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
 					    MT76_STA_INFO_STATE_NONE);
 		if (ret)
-			return ret;
+			goto err_wcid;
 	} else if (ieee80211_vif_is_mld(vif) &&
 		   link_sta != mlink->pri_link) {
 		ret = mt7925_mcu_sta_update(dev, mlink->pri_link, vif,
 					    true, MT76_STA_INFO_STATE_ASSOC);
 		if (ret)
-			return ret;
+			goto err_wcid;
 
 		ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
 					    MT76_STA_INFO_STATE_ASSOC);
 		if (ret)
-			return ret;
+			goto err_wcid;
 	} else {
 		ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
 					    MT76_STA_INFO_STATE_NONE);
 		if (ret)
-			return ret;
+			goto err_wcid;
 	}
 
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 
 	return 0;
+
+err_wcid:
+	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
+	mt76_wcid_mask_clear(dev->mt76.wcid_mask, idx);
+	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
+	return ret;
 }
 
 static int
@@ -1135,7 +1278,8 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 	if (!mlink)
 		return;
 
-	mt7925_roc_abort_sync(dev);
+	/* Async abort - caller already holds mutex */
+	mt7925_roc_abort_async(dev);
 
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &mlink->wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
@@ -1530,6 +1674,8 @@ static int mt7925_suspend(struct ieee80211_hw *hw,
 	cancel_delayed_work_sync(&dev->pm.ps_work);
 	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
 
+	/* Cancel ROC before quiescing starts */
+	mt7925_roc_abort_sync(dev);
 	mt792x_mutex_acquire(dev);
 
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
@@ -1876,6 +2022,8 @@ static void mt7925_mgd_prepare_tx(struct ieee80211_hw *hw,
 	u16 duration = info->duration ? info->duration :
 		       jiffies_to_msecs(HZ);
 
+	cancel_work_sync(&mvif->phy->roc_work);
+
 	mt792x_mutex_acquire(dev);
 	mt7925_set_roc(mvif->phy, &mvif->bss_conf,
 		       mvif->bss_conf.mt76.ctx->def.chan, duration,
@@ -2033,6 +2181,7 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (old_links == new_links)
 		return 0;
 
+	cancel_work_sync(&phy->roc_work);
 	mt792x_mutex_acquire(dev);
 
 	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 8388638ed550..d9c1ea709390 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -186,6 +186,13 @@ struct mt792x_phy {
 	wait_queue_head_t roc_wait;
 	u8 roc_token_id;
 	bool roc_grant;
+
+	/* ROC rate limiting to prevent MCU overload during rapid reconnection
+	 * cycles (e.g., MLO authentication failures causing repeated ROC).
+	 */
+	u8 roc_timeout_count;		/* consecutive ROC timeouts */
+	unsigned long roc_last_timeout;	/* jiffies of last timeout */
+	unsigned long roc_backoff_until;/* don't issue ROC until this time */
 };
 
 struct mt792x_irq_map {
-- 
2.52.0


