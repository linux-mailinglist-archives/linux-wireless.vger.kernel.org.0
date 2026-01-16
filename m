Return-Path: <linux-wireless+bounces-30876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F625D29831
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D2143029130
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D06327BEE;
	Fri, 16 Jan 2026 01:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apD8G5Go"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A512318ED3
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525554; cv=none; b=NDT1gp53Bp8atZwX3vc/eLSmQtGdzhuINfbku+JA9TUj3CYAndLHjcowrkYWSSr23SIfvqJt58m4gk3AlflULIFIJ4Krec1/l6IRuRiE35z15yPawiNE+lX4so2A/y1BOQMsn2b6UNgx49uWAMm+KGQHoC7R7JWJX2zryrLb5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525554; c=relaxed/simple;
	bh=HaKBfzs+vbqcZU4vZwpXtkvIH+Urmp8bT+Ano+LNPMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S60wyXilgCaacASUVeJGIWVtNK4UNk2tbe4CxBfVJJ+y4Nhs9GXsvJS9cAw/eANEdfFhC1/cX2iUNaQEa9nPm2hWMxioVK7Y7DH4kl+KfQQrEo/zzGAnpW4k6jUk4QZjD7DPn+YvdA0HT8nXruhhuxxoep+9nD+GIohSOW7MBI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apD8G5Go; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b04fcfc0daso1838851eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525550; x=1769130350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzEynkgBJi1NWbI0Fd8DGgsgD9GPNNMBHOPHCo9YUDo=;
        b=apD8G5GowbiIhoVY8FDpNQoUbI0ZPVfE2UbF1MYEG3l17kC78fXDjjLv1VqugTRb3Z
         hJYjEGoCdtFtxYPF85aUQ1dQ5nmH6Tx8hSVWMatl7TtjsS32JGTw6ZAPtveKsrfvV5Wp
         TX76ft2MsuaFrsS5fL29aiyQZXSNlgSWW2/+xnGra3jHsD6xJMS1Z0zHhVWSDvE98tnJ
         F31OsMRbIAFEvu4p3akqxWyP+/1Wabqgf+giCn2G2JewW40q6FVH5AmDTjQhtqZgzmJx
         tE0eQl06zfc/bagqjTlGcyVTRgzj3aRMZkSIi3S7kYsEBjxm++9AXqRrveXuO9HZevez
         XCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525550; x=1769130350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzEynkgBJi1NWbI0Fd8DGgsgD9GPNNMBHOPHCo9YUDo=;
        b=oTackqrfwWz8YvCtD5BBf3Syp43tNvnIBlc0ko87IN95HpxIyEmVtylb1ozzM2Xyxb
         i/3f2LTdmygCupQnTUHG05OWp715HH57AeNrx57nJtK5MU95qQKdD0ihemBOhV76cx86
         3m4LE+erDd8TRTrEW+SUwKFGHAxUVlvX1iOBqcTou6/IGu397Ohvd3Rp2xZb7Qnqv6N/
         1kxJ9RCS7feRRcRftzAen6PE8s3DcypUw875GCjGjhoHxe9HqJKFQoifwS7ZQrvaQfd2
         QPMS2+gJTSfeBv1/t3WYqQ66YGxzcINOQtH6w4Vt1t93B/i17i/kCPDDYeRridLTNYWL
         dnbw==
X-Forwarded-Encrypted: i=1; AJvYcCVcxJVKie8vp7njQpnX314MTwYadS9wb+LB60HZvui63luQIQoOWUP643TtCFc9C7qqMDMeubFIH/BqDjJP1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLIevgJnSDmkmOcPW8gwuW3TECgU1a3LfhRcZ8bZ3DNn4jFbRE
	5sBroZmeJXq1qk8jnil9JkYGoCwbwZyB4yG7bi+rn+csBcXO9iM3yuZS
X-Gm-Gg: AY/fxX5m5+kLBAirdztvtddWGumFKmDJUVbiU38/WSVfTIz+g+heqvE6MMCs6CjQwbh
	EFQW03axWAHIRmUBLVvzn62u8YQoyWrKhZo6KZggdG3OWrpTjd1/fqbzMIbLeqFjaFzIh0/Tx/0
	lbQxvW+1oifLK31LorD1EpAJH7SRQOqR0xw2yNJyALXaRliLoNoD9EIlJsqZMj71b+7ZQKfAZM1
	6Q84npp1PK/jp2Z1VsA6PfxjYobUCBoFdy+0u2fnnGfowFzuYVwOxxEss4nWhAK+jCguGoHp5+s
	QCSptS0AiTShfuzkWVclFAHnE3djQC2naXguH8kzn72gPDSmbOqW+uS1va7mbp3x22MYiW+iuTV
	jT6PGJTUMM46au7IRKj0rmYArf6McGjTMy1WLGpEBdagFtD29wtOyUGLqshNtnmNeZTSAaAO5br
	Qp6n2N6yD4CV936iEbEn78BCBxoXk5u1cfiaJORbGnTc3HqiUs+49pg/Z/ghvF6w==
X-Received: by 2002:a05:7301:678f:b0:2b0:4fe2:6a2e with SMTP id 5a478bee46e88-2b6b3f05fd8mr1663499eec.9.1768525549846;
        Thu, 15 Jan 2026 17:05:49 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f1d2:502c:a6ff:5556])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm1019884eec.32.2026.01.15.17.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:05:49 -0800 (PST)
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
	linux@frame.work,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	Zac <zac@zacbowling.com>
Subject: [PATCH v4 18/21] wifi: mt76: mt7921: fix missing mutex protection in multiple paths
Date: Thu, 15 Jan 2026 17:05:16 -0800
Message-ID: <20260116010519.37001-19-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116010519.37001-1-zac@zacbowling.com>
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
 <20260116010519.37001-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add mt792x_mutex_acquire/release around ieee80211_iterate_*() calls in
MT7921 driver to prevent race conditions:

- mt7921_roc_abort_sync(): protect ROC abort iteration
- mt7921_set_runtime_pm(): protect runtime PM iteration
- mt7921_regd_set_6ghz_power_type(): protect 6GHz power type iteration
- mt7921_mac_reset_work(): protect vif reconnect iteration after reset

These paths were missing the mutex protection that is required when
calling ieee80211_iterate_* functions with ITER_RESUME_ALL flag.

Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c  | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 03b4960db7..f5c882e45b 100644
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
index 5fae9a6e27..8fc3770d1b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -373,10 +373,13 @@ void mt7921_roc_abort_sync(struct mt792x_dev *dev)
 
 	timer_delete_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
-	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state)) {
+		mt792x_mutex_acquire(dev);
 		ieee80211_iterate_interfaces(mt76_hw(dev),
 					     IEEE80211_IFACE_ITER_RESUME_ALL,
 					     mt7921_roc_iter, (void *)phy);
+		mt792x_mutex_release(dev);
+	}
 }
 EXPORT_SYMBOL_GPL(mt7921_roc_abort_sync);
 
@@ -619,9 +622,11 @@ void mt7921_set_runtime_pm(struct mt792x_dev *dev)
 	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
 
 	pm->enable = pm->enable_user && !monitor;
+	mt792x_mutex_acquire(dev);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7921_pm_interface_iter, dev);
+	mt792x_mutex_release(dev);
 	pm->ds_enable = pm->ds_enable_user && !monitor;
 	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
 }
@@ -765,9 +770,11 @@ mt7921_regd_set_6ghz_power_type(struct ieee80211_vif *vif, bool is_add)
 	struct mt792x_dev *dev = phy->dev;
 	u32 valid_vif_num = 0;
 
+	mt792x_mutex_acquire(dev);
 	ieee80211_iterate_active_interfaces(mt76_hw(dev),
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7921_calc_vif_num, &valid_vif_num);
+	mt792x_mutex_release(dev);
 
 	if (valid_vif_num > 1) {
 		phy->power_type = MT_AP_DEFAULT;
-- 
2.52.0


