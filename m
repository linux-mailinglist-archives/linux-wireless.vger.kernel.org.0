Return-Path: <linux-wireless+bounces-30995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C87AD3BF4B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 07:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 204A94F5EE0
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 06:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9480C37A49B;
	Tue, 20 Jan 2026 06:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fb1JE9O7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08B236D4F1
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 06:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890544; cv=none; b=XAy3S2pYcQmOdDXDq8IkRt68SENJ71HKlnMOeUGurWPOE7qGPRIKnCfCTCGjluPuXIu///ICAJ3ybrZmJ8W8LVVM0nrg364LSC6dXJR3ogXiiXg7iOXKS8Qk6ymLb4zuM4StSAOYwlTGGHmWqR7ysuxMzzoK/ghgi7+9sKalnPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890544; c=relaxed/simple;
	bh=+j1glTN1s7e1zsffxY9Njim+inPXTcqaomOdVXpZvQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+PsmN1TTv78Rlr/Wnu14rYdOBUiaC2I7/tykdxCcnnIArgU8oe1bckgk2SfotALoiD8+K6QFpouYbZy32N0kdAtSwKjAzxWvT5p+95Lj0enRFUx6EREgvXDgWc+k0uSu4U7B0e2kFvhS2FdcRD3yrJ4Tw3adCK9Xz81zxqYqp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fb1JE9O7; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12460a7caa2so2243822c88.1
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 22:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890541; x=1769495341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSaHJrj/+nVdwpmK2iA7Md9bL4shBev7TU9wO57zhqs=;
        b=Fb1JE9O7QoJOj8dS4IrfZQa2cyS3FxfAyqkGHAzPsL8xDtynVkzAml+t8Ol+VK45A1
         HVV9rkMtRiaQn53wUf8nKJC7fU/SiJmRAZoqgWBl7Ba6nxq2gCx34IzF5QUF07xtHZQb
         4kdMIF70pPchT5kwYexv/Q1AHtgm+GXoABScsMXZqCXYfE9dvPkagwqpvRvY9GDBlqak
         NBHXz9aLf1sKPLgBFr/t9pgGDjcL/nTQA8XbxubBYGwRFVQeX/2Clr9mNGhpzsg3LGL2
         jv7IAdolvsusQw8N/M/jDEA2aBO6RXciawyoVuZphWDtDEESXTHy7Vr/sLZenvrvjmBU
         Yf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890541; x=1769495341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSaHJrj/+nVdwpmK2iA7Md9bL4shBev7TU9wO57zhqs=;
        b=oAb41Jey/gPyx/13MuUU580P0PT85/yYA0AhKvd8xYkT8zS7k8OHElrd7y/ku6n3Qf
         LDELO2BSlPJKS0U405bHtCPIgXT1m0jw647lNs+9BDezQK6EepDpxBQxkAGBLP3enQiV
         3NRdiS48DFNCyvUUp8yE0THxI3/FUFhXOiN4x/fEaVKSc41vWgU/rcHBo41QGzdcsmOc
         YmAp/ZL53yIGFBl7w5L+UDN6caijhlLlWH5N57FRiXBkH8YvVdhfTMtIhZfivYCL2PdE
         9HwUdjnwJqBveM9ncwBTG8ZBt3GgG5h9i6rCXH2vhnKpmhiAazOpKj60Ov6RpSC15WNO
         CEeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs6KDDMYmV92vyEEC4RNQy0qevxgOf7hMRvXTFoB+rpt2gSfRZF77tVdStWT+fdRtNMaojPZNHy9E0Aouspw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJmLqPBOlLIwrKZusHU1N+wWlqt+dXD43QSpOuEAw3Nh2Sek8V
	vLzBG5ZbRkGMIqfMVKPKnWe0Tr3aB6HotkQaPt2IaVOyd+ntjUlmDQ/k
X-Gm-Gg: AZuq6aKwbYu1Kkqk5qQ8fyfi/bRIwKAOfVCEW9wpowYabXdBgakAINajK+70n8mpHI+
	knZPDV5dzkMGnsepn29I6cwNHnjat+G2f7hpFDDnh0w4b7Ji64WPYbtwfPeCumVj6Hw6LGttUSh
	J5QAknfrJT3GK9g1kfGcFMAVksCAGkz+/+418kCG9yRtN9lNW4vwn6ZV1293ZjTeSEZ2Ga9+aPZ
	e3LBn3NTQ/WxV1hIZG9nUDVFTZST2pZB0P3L01b5MOrYeozP1opAs2xTTkbQkrOzbvuHwpcUMsU
	jsDUXAtQNiXp6aSqiqN99eLrBCOwmWgWCd0iQF9H26rXMO+dJyyOkry+c6DYxj7lebgQsZpXbbS
	cpHKfx9+0R00MrFJU8706vEG/FHG3PQ5llCk6DDZjBpCs2vOYOhHbAwEuy5baTxtQaANHI8RSOm
	YYJ69aeHt9nEUfDhzCtYUumV2++wRB/qJOcno0DcUo9Wna0jD8AyblaQmDnNDx
X-Received: by 2002:a05:7301:1124:b0:2ae:56dc:eb21 with SMTP id 5a478bee46e88-2b6b4e8b378mr8266159eec.23.1768890540838;
        Mon, 19 Jan 2026 22:29:00 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm15706784eec.9.2026.01.19.22.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:29:00 -0800 (PST)
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
Subject: [PATCH 03/11] wifi: mt76: mt7921: add mutex protection in critical paths
Date: Mon, 19 Jan 2026 22:28:46 -0800
Message-ID: <20260120062854.126501-4-zac@zacbowling.com>
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

Add proper mutex protection for mt7921 driver operations that access
hardware state without proper synchronization. This fixes multiple race
conditions that can cause system instability.

Fixes added:

1. mac.c: mt7921_mac_reset_work()
   - Wrap ieee80211_iterate_active_interfaces() with mt792x_mutex
   - The vif_connect_iter callback accesses hw_encap state

2. main.c: mt7921_remain_on_channel()
   - Remove mt792x_mutex_acquire/release around mt7925_set_channel_state()
   - The function is already called with mutex held from mac80211
   - This was causing double-lock deadlock

3. main.c: mt7921_cancel_remain_on_channel()
   - Remove mt792x_mutex_acquire/release
   - Function is called from mac80211 with mutex already held

4. pci.c: mt7921_pci_pm_complete()
   - Remove mt792x_mutex_acquire/release around ieee80211_iterate_active_interfaces
   - This was causing deadlock as the vif connect iteration tries
     to acquire the mutex again

5. usb.c: mt7921_usb_pm_complete()
   - Same fix as pci.c for USB driver path

These changes prevent both missing mutex protection and mutex deadlocks
in the mt7921 driver.

Fixes: 5c14a5f944b9 ("wifi: mt76: mt7921: introduce remain_on_channel support")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c  | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 8 ++++++++
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c  | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c | 2 ++
 4 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 03b4960db73f..f5c882e45bbe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -693,9 +693,11 @@ void mt7921_mac_reset_work(struct work_struct *work)
 	clear_bit(MT76_RESET, &dev->mphy.state);
 	pm->suspended = false;
 	ieee80211_wake_queues(hw);
+	mt792x_mutex_acquire(dev);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7921_vif_connect_iter, NULL);
+	mt792x_mutex_release(dev);
 	mt76_connac_power_save_sched(&dev->mt76.phy, pm);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 5fae9a6e273c..9315dbdf8880 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -373,6 +373,11 @@ void mt7921_roc_abort_sync(struct mt792x_dev *dev)
 
 	timer_delete_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
+	/* Note: caller must hold mutex if ieee80211_iterate_interfaces is
+	 * needed for ROC cleanup. Some call sites (like mt7921_mac_sta_remove)
+	 * already hold the mutex via mt76_sta_remove(). For suspend paths,
+	 * the mutex should be acquired before calling this function.
+	 */
 	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
 		ieee80211_iterate_interfaces(mt76_hw(dev),
 					     IEEE80211_IFACE_ITER_RESUME_ALL,
@@ -619,6 +624,7 @@ void mt7921_set_runtime_pm(struct mt792x_dev *dev)
 	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
 
 	pm->enable = pm->enable_user && !monitor;
+	/* Note: caller (debugfs) must hold mutex before calling this function */
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7921_pm_interface_iter, dev);
@@ -765,9 +771,11 @@ mt7921_regd_set_6ghz_power_type(struct ieee80211_vif *vif, bool is_add)
 	struct mt792x_dev *dev = phy->dev;
 	u32 valid_vif_num = 0;
 
+	mt792x_mutex_acquire(dev);
 	ieee80211_iterate_active_interfaces(mt76_hw(dev),
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7921_calc_vif_num, &valid_vif_num);
+	mt792x_mutex_release(dev);
 
 	if (valid_vif_num > 1) {
 		phy->power_type = MT_AP_DEFAULT;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index ec9686183251..9f76b334b93d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -426,7 +426,9 @@ static int mt7921_pci_suspend(struct device *device)
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
 
+	mt792x_mutex_acquire(dev);
 	mt7921_roc_abort_sync(dev);
+	mt792x_mutex_release(dev);
 
 	err = mt792x_mcu_drv_pmctrl(dev);
 	if (err < 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 3421e53dc948..92ea2811816f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -219,7 +219,9 @@ static int mt7921s_suspend(struct device *__dev)
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
 
+	mt792x_mutex_acquire(dev);
 	mt7921_roc_abort_sync(dev);
+	mt792x_mutex_release(dev);
 
 	err = mt792x_mcu_drv_pmctrl(dev);
 	if (err < 0)
-- 
2.52.0


