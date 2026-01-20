Return-Path: <linux-wireless+bounces-31030-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKgRKRblb2lhUQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31030-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 21:27:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7390F4B456
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 21:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 077A548EB71
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 20:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF0C3A9DB0;
	Tue, 20 Jan 2026 20:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqlPmD2d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848B03A9D80
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939865; cv=none; b=HVHMQcZAyx8wDurwuWr3A5uqo8+QI5bP94ZvBY2sgGL1BiUj0I2Sao4mPjtzT5CAywglQM+oIsN0/7iajGy/40/SI1l618TD/I/aqWZuYKRrC9ZjM+YohTtkFZEXT6J74uJWyM4ZmAP6rOMZJVHJOlIx6Vx3v9zACIhE9J8RBaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939865; c=relaxed/simple;
	bh=Qln5kf9bToWgjs1fDaXaRatUHl+j8h/Zq+pqYMZ6gHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ovwtSi9RSpYD0jniaUChUVrBKRBZo+kc7j3fzlNkVrD/l1/VqxsqlNM4Q8tGY00YZk1nXfrPtc6eFbBQnNSVpClVBI5EV1eJmxf0xaTNXjLuxu3BXCMpGT2/7pXec3MLFrIT1H50WmWR+aZVLgd3NED8R1OFEysz0wrmVCcz/kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqlPmD2d; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-123320591a4so5952592c88.1
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 12:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768939859; x=1769544659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohSMRLjuL2909kuGww04u5932kdmhx8B4cMtMffQj3Y=;
        b=YqlPmD2dp+u/zHqEe9ULrnibYZaXV6EwP0DeFA56HJjJrHLkWHJ6n/3TMzr1js6VIx
         +qyDfxdSkFZS7XIfenvF8IuLeHX1rmt+lk39nmEllPhiOJdMKNtwScucgZOZFd9+DBiq
         bcfbKmkKLum/bOsXnvIr2BecTErI87crMFcfNC2gx5gV15Fhz1cYEClPm+fTvMBEGC86
         k4FNNJAiNKexqd26U/BElLdQ1JzzZfdhaW3QR6B1A0JsGxFMmuxaDJpN3EfFn3TN1FWC
         Rza1SumTk7nsGImh0vIxRI74lqZZ/hy8ffxyCQQxjTopJxpEZL69Nk6xhYhoCklbK2xb
         DROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768939859; x=1769544659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohSMRLjuL2909kuGww04u5932kdmhx8B4cMtMffQj3Y=;
        b=JInNP01mtjD1cEq3N/bLG0MmUDN/0sXQC+t3jtyU/OrEj5HxETYNCm+zMTSbnKzdf6
         Ik4kf+gRUc7zbAWSY8Fc9oJKXbEfJhJwI1hQxvk3tfBJLcWHW6LqfjJKKOgTtkgTxruM
         OfW9UMVd4yPzverOjwfJ0CE9n+DSPMlWew6p9aZ/WyeajKThdoNpv389yPjbidtQWPa6
         bTYjq5Lvp4Z+sy2nm3DlmpbJAiaj1X15Afqn9g4f+kaKrcMMXz27IXmd0nAvTntiFnPf
         Rdjipu0exg+NRMnjQI0SjtAovkw8iGTD13GqTfz14aO8VkmiE5t8jmIc0hT/qPpCy1BS
         AyJA==
X-Forwarded-Encrypted: i=1; AJvYcCVLZP7Abi1LBK9hAzrG8A8SVXV6UuD96SDNVey6JRzIUGqFGzurlmK/3QIg7oHnxVEhs8PmxXs2xO8E7YIdIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjfWncBXk/3RKUGIrcGacHwuV0WJnEak3uRxvFVHkbMFYEmAw2
	BNHPJvsOrenfUmLxvZ/hz7dQBgwyQPdWcW48OxjzGJSs2UFZPMpMTZnA
X-Gm-Gg: AY/fxX4V4cNxrsE9MQDRUKDfsQg32MKUAh/V2Gfn1C4Vz04of3KlHpG7Xwwh832+b4z
	to6gAYTRfdUOzZQkNehQ/JMs2Uoa0dsE32sTYMb9M/sqyb9E7yIlZKEtbNkFHv9ZdKR3Z/z7UtK
	d4xEA7f3rR6tBUUHsgd6D1hlxuugy15+Nu5fs7G0Xv4EmwCwAee1qowajUgsCIyrTOnVEoyaUOh
	rr9YOCMQ/5AKdAQ62/jOtLH1FVdb+8awVqfU/UczYeEna4R/2NmSYjHUq1SuylNxLl+wrZFgDag
	2xYceGo2sOh3d/nHrHxVy0fwAHH4EHQZ603dxuybEiKDo4ujOXB4XUVH0eHQQmABsoSufNj1p7h
	DWguGwj12DcNVfQCBMSVK+K6TrfFTVvDUqG7HeriweG1Ma0IrF6TZ91X+qrp1BDaLabKNRT1cnW
	FEB1ZpgLfujdog00sUskANUDNBoliJNBSg+ogHE5CzgorZWibr5DJ7S87Jf+ip3g==
X-Received: by 2002:a05:7022:1288:b0:119:e56c:189d with SMTP id a92af1059eb24-1244a71415emr11839754c88.5.1768939858961;
        Tue, 20 Jan 2026 12:10:58 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:4a3c:9f7c:8037:90c1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad7201fsm21982990c88.7.2026.01.20.12.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:10:57 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux@frame.work,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	zac@zacbowling.com,
	zbowling@gmail.com
Subject: [PATCH 05/13] wifi: mt76: mt7921: fix deadlock in sta removal and suspend ROC abort
Date: Tue, 20 Jan 2026 12:10:35 -0800
Message-ID: <20260120201043.38225-6-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120201043.38225-1-zac@zacbowling.com>
References: <CAGp9LzrcvW18xKFL-oF3wxRmb73G6PN59Y2NSA2E5idva1wtKg@mail.gmail.com>
 <20260120201043.38225-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,frame.work,nbd.name,zacbowling.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-31030-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[zacbowling.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[13];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,zacbowling.com:email,zacbowling.com:mid]
X-Rspamd-Queue-Id: 7390F4B456
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zac Bowling <zac@zacbowling.com>

Fix deadlock scenarios in mt7921 ROC (Remain On Channel) abort paths:

1. Suspend path deadlock (pci.c, sdio.c):
   - Previous fix (b74d48c46f) added mutex around mt7921_roc_abort_sync
   - But roc_work acquires mutex, so cancel_work_sync can deadlock
   - Fix: Remove mutex wrappers since mt7921_roc_abort_sync doesn't
     actually need them (it only calls timer_delete_sync, cancel_work_sync,
     and ieee80211_iterate_interfaces which handles its own locking)

2. sta_remove path deadlock:
   - mt7921_mac_sta_remove is called from mt76_sta_remove which holds mutex
   - Calling mt7921_roc_abort_sync → cancel_work_sync can deadlock if
     roc_work is waiting for the mutex
   - Fix: Add mt7921_roc_abort_async (matching mt7925 pattern) that sets
     abort flag and schedules work instead of blocking
   - Add abort flag checking in mt7921_roc_work to handle async abort

The fix mirrors the mt7925 implementation which already handles these
scenarios correctly.

Fixes: b74d48c46f ("wifi: mt76: mt7921: fix mutex handling in multiple paths")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 29 +++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  2 --
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  2 --
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 196fcb1e2e94..f3941a25fd6f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -367,17 +367,24 @@ static void mt7921_roc_iter(void *priv, u8 *mac,
 	mt7921_mcu_abort_roc(phy, mvif, phy->roc_token_id);
 }
 
+/* Async ROC abort - safe to call while holding mutex.
+ * Sets abort flag and schedules roc_work for cleanup.
+ */
+static void mt7921_roc_abort_async(struct mt792x_dev *dev)
+{
+	struct mt792x_phy *phy = &dev->phy;
+
+	set_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state);
+	timer_delete(&phy->roc_timer);
+	ieee80211_queue_work(phy->mt76->hw, &phy->roc_work);
+}
+
 void mt7921_roc_abort_sync(struct mt792x_dev *dev)
 {
 	struct mt792x_phy *phy = &dev->phy;
 
 	timer_delete_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
-	/* Note: caller must hold mutex if ieee80211_iterate_interfaces is
-	 * needed for ROC cleanup. Some call sites (like mt7921_mac_sta_remove)
-	 * already hold the mutex via mt76_sta_remove(). For suspend paths,
-	 * the mutex should be acquired before calling this function.
-	 */
 	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
 		ieee80211_iterate_interfaces(mt76_hw(dev),
 					     IEEE80211_IFACE_ITER_RESUME_ALL,
@@ -392,6 +399,15 @@ void mt7921_roc_work(struct work_struct *work)
 	phy = (struct mt792x_phy *)container_of(work, struct mt792x_phy,
 						roc_work);
 
+	/* Check abort flag before acquiring mutex to prevent deadlock.
+	 * Only send expired callback if ROC was actually active.
+	 */
+	if (test_and_clear_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state)) {
+		if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+			ieee80211_remain_on_channel_expired(phy->mt76->hw);
+		return;
+	}
+
 	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
 		return;
 
@@ -888,7 +904,8 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 
-	mt7921_roc_abort_sync(dev);
+	/* Async abort - caller already holds mutex */
+	mt7921_roc_abort_async(dev);
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->deflink.wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 9f76b334b93d..ec9686183251 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -426,9 +426,7 @@ static int mt7921_pci_suspend(struct device *device)
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
 
-	mt792x_mutex_acquire(dev);
 	mt7921_roc_abort_sync(dev);
-	mt792x_mutex_release(dev);
 
 	err = mt792x_mcu_drv_pmctrl(dev);
 	if (err < 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 92ea2811816f..3421e53dc948 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -219,9 +219,7 @@ static int mt7921s_suspend(struct device *__dev)
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
 
-	mt792x_mutex_acquire(dev);
 	mt7921_roc_abort_sync(dev);
-	mt792x_mutex_release(dev);
 
 	err = mt792x_mcu_drv_pmctrl(dev);
 	if (err < 0)
-- 
2.52.0


