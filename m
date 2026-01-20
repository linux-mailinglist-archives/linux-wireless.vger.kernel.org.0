Return-Path: <linux-wireless+bounces-31029-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF/vNS/tb2m+UQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31029-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 22:01:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 471D24BE73
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 22:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F83270DCF9
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 20:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CE73A962B;
	Tue, 20 Jan 2026 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVJ7gyl6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1302F3A9603
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939860; cv=none; b=o/8yXQHa/8GUw1GpopogKBq0Kk8iy/I8NCuiZfWuij6ymuP2bvB1saR0lRRMhhbD3o7L60Mptfh2xtHQbB4NkrBjbS0U3UDy4p7VKReuIxVWpH91gKIrOOEKTvdA7GNHP1XFIRynTmTVfuyU2fmkrIKthiUxUeCZsM4c36soFWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939860; c=relaxed/simple;
	bh=buXZ8ZhwZ4WLutL3QxZCoKHua3QGYw2h+xXvQJn0DF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2qspTX4p0xsWpX4wTigSJfg7xG+5cuIYNNJeVaTjDWers3R1mpBHje3iIx6gnIyTIDHUmUD8K3pDY86V92DH08wkWCN3+0Y2Xegjpz9huyG4TQoorH65L61QaRrlVjHPoZbVUPDm6h4hijMri1D4+TV+XIcr9n3wNVEC7rZ/IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVJ7gyl6; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-121a0bcd376so2066733c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 12:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768939857; x=1769544657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjl6ClmLjdJ8toC0jMG8lsjY5DLCl9w4mz+RB5F5EOs=;
        b=TVJ7gyl6GgFhtPwJhH1P/LZXVY0vk5kr/5Qo72B+OyRO4W78ZDegNqC5MhIeypJgNE
         vh9ghJs1zcGJxXhjPlKdYSfD4lHjhLxCrr9Wa+/LDPsuzhlQ/q4wcb57yWMnRet9mwQs
         TwomWhZqYZROAcqBUCow2CJBO1oUU6nS37LuNHVfd2YMk5l+4jdw5I3E+LGe0zBfyo63
         uDUvm3Yat/iJcTHCTG/vrq+rYlghE7/QuqrG3stB1PCL6CR43/mrixvTHiJj2vRtdWnz
         lJPA00lV/4r0B2/R6cLBobj3APQr4geZgZD2MhYdNXKgzZsQ6hywyX+b6vmAg1joXIA/
         3H5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768939857; x=1769544657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qjl6ClmLjdJ8toC0jMG8lsjY5DLCl9w4mz+RB5F5EOs=;
        b=R64tMxrYZvmEbo1U9zMUi003uWBva714gZx4EPBSG2BWxI9eNBm/8TxiMCAiiW5PZh
         qrrNJuCl/IWXRCK6TWplnm6DXbTmFWzPT+5iVpOWKBssbHk2StpGTU189Zj+/ac0h+7s
         IGPsnajqzmzwsA55Rp6aVhawBltbnBgF1euQhV2tFAkpitWg+YYUH6nTJrKe9XT2ILwF
         hTLB7zEB1xC5/FparF58BMuh691fKjPZOOAB/iHjggxnLjB81J6UMBR3cADojgEeV0R9
         mKlQTSa7IXrT4JGCFe5rQI3aG7nkzqif+8+fqmE6xg3dbrRiNxzGlMaXI7TPwdkC2mnz
         Dang==
X-Forwarded-Encrypted: i=1; AJvYcCWxoDDebebIlnLc2IYIDBKfYxpYcg5zAKqLCZxlD2J+zRg/hG5lNXusAlAtGc5qzRvroVV+LmRcYVf7tC9TZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxANd4I2ft3mpzvkIcVF8UWhxvEc2z/BA/2TTj5TbfJwg1CsjhW
	LJgzlT53YLqGUt99l3v/V1HBzAVbEONzGUZjwJYogMyZNZlBTIb+RCHn
X-Gm-Gg: AY/fxX7Mv2kpvNUjLkYb6hUurNEnqH63INTWeUZFEscjf4amFX48d56mDavANVI/96V
	7sPjMWa5QW1DUF/kGg7OeRzFnyXfSoX/1P/gx+YWvM7FMkd1o1KRzhN/7rwvSjRmOYbawbMNpjy
	KUgyA53VJKcjb1f+jYTTl8S23rtqtebaWVGIcA5VMDHOAJ/MvTVSp/EFwS1BFlt/86/JOvTgVew
	Wa0ssZoeX8QZJSSsZMHGnbRvsBgB8NSOwwYkjdCV45tfpgnUTTF9uIua7g9I5xkvdhdkDFRrbeu
	r7z3i77J7z3/vuzlEaDecuYMpAqJH4LMotLPdFmfwXuFEwo8FPMxgPKV3E/rlclaHO/hqqpUbxp
	SLaewMrxlnbXaB33OxVYz4P1j61gQ1XvwSIuL0YdBnLstLHZAfkk7Lu8YXzwjvEmqlmtg8MxGsA
	CNuHyusTPzVln1qgk29DAkuJM03agw5L+iz8Q5Wnf8ess9Vm+qyZIGCSI1WLDOEA==
X-Received: by 2002:a05:7022:7a7:b0:119:e56b:c73d with SMTP id a92af1059eb24-1246a9707f2mr2196739c88.2.1768939856662;
        Tue, 20 Jan 2026 12:10:56 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:4a3c:9f7c:8037:90c1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad7201fsm21982990c88.7.2026.01.20.12.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:10:55 -0800 (PST)
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
Subject: [PATCH 04/13] wifi: mt76: mt7921: add mutex protection in critical paths
Date: Tue, 20 Jan 2026 12:10:34 -0800
Message-ID: <20260120201043.38225-5-zac@zacbowling.com>
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,frame.work,nbd.name,zacbowling.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-31029-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[zacbowling.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,linux-wireless@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zacbowling.com:email,zacbowling.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 471D24BE73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 9 +++++++++
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c  | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c | 2 ++
 4 files changed, 15 insertions(+)

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
index 5fae9a6e273c..196fcb1e2e94 100644
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
@@ -765,6 +771,9 @@ mt7921_regd_set_6ghz_power_type(struct ieee80211_vif *vif, bool is_add)
 	struct mt792x_dev *dev = phy->dev;
 	u32 valid_vif_num = 0;
 
+	/* Note: caller (mt7921_mac_sta_add/remove via mt76_sta_add/remove)
+	 * already holds dev->mt76.mutex, so we must not acquire it here.
+	 */
 	ieee80211_iterate_active_interfaces(mt76_hw(dev),
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7921_calc_vif_num, &valid_vif_num);
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


