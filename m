Return-Path: <linux-wireless+bounces-30325-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 575CDCF17B5
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 01:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02CDC30094BE
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 00:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB383B2AA;
	Mon,  5 Jan 2026 00:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZd/WSEZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36278139579
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767572815; cv=none; b=pX8VRDt/hHjAP5FPZoLesp+ZBeZPg4gh8nFKR2kuSEgkmES1aXM1mxvpB8/Dbfea8cK5CZLUTQlXtIJaP+v+DSYOxw+q00UAet0nhC5uZMKUypm12QMyrNT3/hZxswpGQ/gl3iVnDHbNjlJ4t/HWciTsipbeojZc7H3Kg6Wb/DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767572815; c=relaxed/simple;
	bh=ewxIszwEuo5ZkFcIxg7prkQR1SS9mN/+WvL9hST/bx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3z6ZdEc0POsamykYwpPIgpqZoH5GfQasm1OTiPnkhiMZpKCwvRrAQ4Vnxnm9e0kfUMHBlxVsSDS7zTrcEudvzpKjMOhtNxYYF04Z3QYN3EJpptcQYkul6f3Adc6ydtjK6VO8vUxBY5Yj138B1eZGGIvtTb4Yixs6Sn0hUgWZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZd/WSEZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29f0f875bc5so201261495ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 16:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767572813; x=1768177613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKmv9Qie7cHueSzyzaZ+QRp9Y7zf25ySeMeR1g7IWf4=;
        b=MZd/WSEZ9I/R25CCoCQzrL4kw7XWM6VDRD9lkwpZGmGr4mogMVthuNi181CNusTVAr
         jqm7+2W+BXBgqF2xAvVDY1uhBD7p0AIcmhi5DHI6o3hGbL4FWbwC5TZBuTHnaVNEzIe8
         YXbfL3os7TkskT+kDoONjRPqZEFmiXIA3d2mvi3vcy+FJzKR4AMhQ2U77+oGhz6ozlyR
         YjM22cri3IwVuWMsnqExCaKWMeB0B/M7JsEx9Pj1NPhdCRUpPJQ6nLjzqy2IZXJlKJRE
         NXXaSyIAuukIPK92tK5E78fpn3Fj/j+uClIbpwzkSQQELKo8n+lVwp0jAq30ECTAsOQ8
         QZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767572813; x=1768177613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SKmv9Qie7cHueSzyzaZ+QRp9Y7zf25ySeMeR1g7IWf4=;
        b=ifzQWchh1RmOIM6CXjtIeDfzmdAoJU7oDP13Qx2/UVxLzngbwpQWpVI94M4yCNY0gG
         lcMjktr7ovXySVBB5veuNr+cmy9SZhjPciIQ3rMuZfzIs6JBOWfiplEwMRjde/yp6eNQ
         jEacWWsHfU+5S0GeqXFlx8D89iyC0p+BVQaJeoOmpkN22pX2IhISArWaOYdDhk2ycKnH
         Bvi9Ei4OP2xxivjL6uT7MJDazQCr4gJOz+J7zFgKXwE85ulmP52OJjZO9wuij2Yuul8W
         SxV4w7v4FmJtftnPJv1nT77r9bEzMeQSsBHIHi6NKskIR/sfo0Ost4+VFGTqlS/1bpgA
         Xltw==
X-Forwarded-Encrypted: i=1; AJvYcCXsd9jeATOGIWNkMe26kUSe5U6dyYDozOWCasAnW7wK+Vr50RzMhZis+zNLTywKMKoCPwwUtzzLTUswbozLkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9QOj7nLXOx8nm7LUjfG84T93ra1HsPVo45POq2eUyWZSHWCPq
	9c33b6lBxP/kseI2c2Rs/fyJvj1DyjiuXApYvjTyDeeyPmsB7a8rS+dRzayHjhZk
X-Gm-Gg: AY/fxX7CxmETZjwnMYd6Tckw21TTC1Hj8Uo/4Pvl8/huztSojwqOtasVVCOq6epZUgU
	+X6zJ9JFey8rD936Ajpl8WmmNZ11o4SJrWwRR5+CTmmLQVKWfkpec9u/LM5iCd7JNxeMzt2RDbl
	drGxkOfX41B8tVe7GARbNEeSZdmZKmk0jWLKQl6u3Jc5jlGuC+0XbHZlvsB/XXGTh+CmUG5Lt35
	OVXWRQwvtP9kWoFCVM3TASXFbjnFz/8R2PzVnQUqk1rLogAlGuD90u0C+AAFbneUtiC98k2GmWC
	13Ld+23ncivl2qtPT/dpc4Ddcd5H5XnDToy6IjEv8ypKGkzogJZbfdVTSgkaTHJjPuB3/Jirwed
	oFKq0qs+REcuAaAPAOiYmclgYVX9bMF5oai1m7TnSlIG8oNORDYBuYrPZTzvuEggKRD94GxbCW0
	t0taQLwxJYFoGSkZ/9QT9wQrjeYt5gDYn4JthsoJ5RI8hP0EyycEVD7lPH57ippA8=
X-Google-Smtp-Source: AGHT+IHPaxepL+KOGt5lEUs7jq6bBXnQPyHoe1Q+qdF+4qNFKzLPWnvGSkSBMjp0qzTTzzBqY19MxA==
X-Received: by 2002:a05:7022:ef0b:b0:11b:8161:5cfc with SMTP id a92af1059eb24-12172306ccfmr47077126c88.36.1767572813355;
        Sun, 04 Jan 2026 16:26:53 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm133378109c88.8.2026.01.04.16.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:26:52 -0800 (PST)
From: Zac Bowling <zbowling@gmail.com>
To: zbowling@gmail.com
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com
Subject: [PATCH 03/17] wifi: mt76: mt7925: fix missing mutex protection in runtime PM and MLO PM
Date: Sun,  4 Jan 2026 16:26:24 -0800
Message-ID: <20260105002638.668723-4-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105002638.668723-1-zbowling@gmail.com>
References: <20260102200524.290779-1-zbowling@gmail.com>
 <20260105002638.668723-1-zbowling@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two additional code paths iterate over active interfaces and call MCU
functions without proper mutex protection:

1. mt7925_set_runtime_pm(): Called when runtime PM settings change.
   The callback mt7925_pm_interface_iter() calls mt7925_mcu_set_beacon_filter()
   which in turn calls mt7925_mcu_set_rxfilter(). These MCU functions require
   the device mutex to be held.

2. mt7925_mlo_pm_work(): A workqueue function for MLO power management.
   The callback mt7925_mlo_pm_iter() was acquiring mutex internally, which
   is inconsistent with the rest of the driver where the caller holds the
   mutex during interface iteration.

These bugs can cause deadlocks when:
- Power management settings are changed while WiFi is active
- MLO power save state transitions occur during roaming

Move the mutex to the caller in mt7925_mlo_pm_work() for consistency
with the rest of the driver, and add mutex protection in
mt7925_set_runtime_pm().

Found through static analysis (clang-tidy) and comparison with the
MT7615 driver which correctly acquires mutex before interface iteration.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Reported-by: Zac Bowling <zac@zacbowling.com>
Tested-by: Zac Bowling <zac@zacbowling.com>
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 3001a62a8b67..9f17b21aef1c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -751,9 +751,11 @@ void mt7925_set_runtime_pm(struct mt792x_dev *dev)
 	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
 
 	pm->enable = pm->enable_user && !monitor;
+	mt792x_mutex_acquire(dev);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7925_pm_interface_iter, dev);
+	mt792x_mutex_release(dev);
 	pm->ds_enable = pm->ds_enable_user && !monitor;
 	mt7925_mcu_set_deep_sleep(dev, pm->ds_enable);
 }
@@ -1301,14 +1303,12 @@ mt7925_mlo_pm_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	if (mvif->mlo_pm_state != MT792x_MLO_CHANGED_PS)
 		return;
 
-	mt792x_mutex_acquire(dev);
 	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
 		bss_conf = mt792x_vif_to_bss_conf(vif, i);
 		if (!bss_conf)
 			continue;
 		mt7925_mcu_uni_bss_ps(dev, bss_conf);
 	}
-	mt792x_mutex_release(dev);
 }
 
 void mt7925_mlo_pm_work(struct work_struct *work)
@@ -1317,9 +1317,11 @@ void mt7925_mlo_pm_work(struct work_struct *work)
 					      mlo_pm_work.work);
 	struct ieee80211_hw *hw = mt76_hw(dev);
 
+	mt792x_mutex_acquire(dev);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7925_mlo_pm_iter, dev);
+	mt792x_mutex_release(dev);
 }
 
 void mt7925_scan_work(struct work_struct *work)
-- 
2.51.0


