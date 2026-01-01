Return-Path: <linux-wireless+bounces-30260-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF90FCECD97
	for <lists+linux-wireless@lfdr.de>; Thu, 01 Jan 2026 07:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E0033027DA4
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jan 2026 06:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC98223DC0;
	Thu,  1 Jan 2026 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGBOrCJz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2777D21FF2A
	for <linux-wireless@vger.kernel.org>; Thu,  1 Jan 2026 06:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767248729; cv=none; b=cu+3YRReAEdYtOZpRmL8Ai8sGuf/tS2MvIAueW6dzJzS1tOTmkKqDwEg6ZIMfJdRC6+vdGTMYWN2hMr+6AV+BuPQBWvB3apAHz3gxcIEYrFuXlLreQpaCf6wRTpl4BXYLAw6d5GW2o/iZvSYiJzBR8+jZ3o5hIBdsCP8bQuJxJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767248729; c=relaxed/simple;
	bh=QSZI7jO5BapLRoqhUDo8JZG2X/Z+7TwscOVAO6700lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvTV+1WKvMJpRjpsdwJBSMZkxd2z4YVIMIF/an92pk9fRBbCjdON5E4s3VLwCqjZ7mPFTNCV5YwVmYu5IN3nW8CAGFhP8KxDxJS1Wq8vo9cuUSbTCAU4O4eQw47qD6CgO+HO4aXFHvNRt7mwufdbNRvt1MNRb6iCXb1WlFNOapM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGBOrCJz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7ade456b6abso9131456b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 22:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767248727; x=1767853527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fQX3XjClGYHMJYLD0S4wnHpCEAj+Lkoo18KPH1N6VQ=;
        b=jGBOrCJzj4qUxYZQ9xnX1zygV2wsEBK3y4kBlRTSUjXxWgGTrf1Ry/UwHrTw8etA3N
         6fKWqTau3KAbVRNj8OXaiR/Y3zZo4JFN/tVzusQsNfhDuyVo1UQCp8W5px/Qv+n9XnDl
         nZpNwQK+jKHGBGZbOhGRXmGQy8SX/qzRNEIsNZm9ANgle0K6fTQKdNtPVJZziaWREBfH
         fGwPwyIaLy0WlLgVYbxzLbs4K3U+tP75DMC2qOCy9k/ZlU4kltomuwvmjotmjR643y3e
         9YVb+4ZKVyjJTQfKxYsnse9FslB+q5N00zaaFi0AZnlDRzlfByDjFGYJB5zm4za8rGg5
         FBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767248727; x=1767853527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3fQX3XjClGYHMJYLD0S4wnHpCEAj+Lkoo18KPH1N6VQ=;
        b=jEikDsn6fqSiIJhLXCgh8VPu1ZSA6vTminaa6E/sMpkXoruN3+xtchzSgvS6Ap79l6
         7VfhoJNWs+rwPER7tiKQUO8JZuqBsuOetizFfoe2SlCECnxRrvuFv3peqlLrRbSQy++o
         vC23v4NRQBfkrbrwoUUf1PRRXPBMq2YvUMxGfOmPx3MSjisSbmvH2YKLNOOsjY8PvJJO
         TYRSIcYF80viGJB6b2M12PsU3bQSUsGY37GU1fWJnkHAfc90vqoQL8NwJ3G1Pi0jrwaJ
         PHi3vdVS/GzGkgwYPdnSzvk8df6R+Dz1Juz4jyPKPrPgxFsyF1FrFOH9rr1SCbjoiXq4
         qFDQ==
X-Gm-Message-State: AOJu0Yy3HezUEYOmjK9/PKwxwPUespENXiPE3by968vslOABmTLf+QbL
	mahrl4Ldah6CFH5Xgig4N71/3Q6MyxPZn0/+Y89q7CN18/HjWyjXBWQM7u/uYuEY
X-Gm-Gg: AY/fxX5ErHP5wUyUY8u2s1IW0nGfrWpwiGDFwYqK/E5kV3cysMWAW2bxYcBKBYpzREF
	fXCGDbf0IPeb/mSNP9XzdINBiYx0CQZcSOfzA4Osiz6DLBgo2P1ntk+oUa2JcOfRNDfWqC8/WFc
	3fBtFGs08cY4/nGscsqyD41vsk1Z4kdWgFsHY/PUwQHC1cuhCkBVduqp+VQGgukLaEcRjah9ZBz
	Ehwe2P5S7TZtACEiDrGA1uBgee8l13SHVVH0KuiSYs6dAJSygLL6EkwbshPC0iyx33XAzjV8RBb
	XYaIpCZvkzhW8G+0f5r90rf+l2Ux/Ruo0YPT7Qcxh+wgoXNpynj3nAnwTHTX7J9f+qPVzXHQe0T
	JYXtpJcLdQAZSIrc66Z1sh0LAmaxxe/ZxQFFPa82KPZu5zeG2VV23k2Qv6NmPmJ3pTLVdn4uiPN
	ZKt5hRZSUy08z4Q+ZS3PtckhLMx4G9mjIKd9D0n5dc57XF2x0eBiDTcSB4390Rsw==
X-Google-Smtp-Source: AGHT+IHNHRrjwP/J1xNE9ra/NusfYhUBwbj+0R4XP+dQskrbGT/ub95rsw9PxwoTEkG2747s582cyQ==
X-Received: by 2002:a05:7022:62a0:b0:11a:342e:8a98 with SMTP id a92af1059eb24-12172136c4emr41995730c88.0.1767248726773;
        Wed, 31 Dec 2025 22:25:26 -0800 (PST)
Received: from zubuntu.home.zacbowling.com ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm144361662c88.4.2025.12.31.22.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 22:25:26 -0800 (PST)
From: Zac Bowling <zbowling@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	ryder.lee@mediatek.com
Subject: [PATCH] wifi: mt76: mt7925: add error handling for AMPDU MCU commands
Date: Wed, 31 Dec 2025 22:25:23 -0800
Message-ID: <20260101062525.186192-1-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAOFcj8Sad3pLohFfRdj5jzK3Zs3FAjFVBuzH=80i_m1YqSbpfA@mail.gmail.com>
References: <CAOFcj8Sad3pLohFfRdj5jzK3Zs3FAjFVBuzH=80i_m1YqSbpfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

Check return values of mt7925_mcu_uni_rx_ba() and mt7925_mcu_uni_tx_ba()
in mt7925_ampdu_action() and propagate errors to the caller.

Previously, failures in these MCU commands were silently ignored, which
could leave block aggregation in an inconsistent state between the driver
and firmware.

For IEEE80211_AMPDU_TX_STOP_CONT, only call the completion callback
ieee80211_stop_tx_ba_cb_irqsafe() if the MCU command succeeded, to avoid
signaling completion when the firmware operation failed.

Reported-by: Zac Bowling <zac@zacbowling.com>
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 7d3322461bcf..d966e5ab50ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1271,22 +1271,22 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_RX_START:
 		mt76_rx_aggr_start(&dev->mt76, &msta->deflink.wcid, tid, ssn,
 				   params->buf_size);
-		mt7925_mcu_uni_rx_ba(dev, params, true);
+		ret = mt7925_mcu_uni_rx_ba(dev, params, true);
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
 		mt76_rx_aggr_stop(&dev->mt76, &msta->deflink.wcid, tid);
-		mt7925_mcu_uni_rx_ba(dev, params, false);
+		ret = mt7925_mcu_uni_rx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
 		mtxq->aggr = true;
 		mtxq->send_bar = false;
-		mt7925_mcu_uni_tx_ba(dev, params, true);
+		ret = mt7925_mcu_uni_tx_ba(dev, params, true);
 		break;
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
-		mt7925_mcu_uni_tx_ba(dev, params, false);
+		ret = mt7925_mcu_uni_tx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_START:
 		set_bit(tid, &msta->deflink.wcid.ampdu_state);
@@ -1295,8 +1295,9 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
-		mt7925_mcu_uni_tx_ba(dev, params, false);
-		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+		ret = mt7925_mcu_uni_tx_ba(dev, params, false);
+		if (!ret)
+			ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	}
 	mt792x_mutex_release(dev);
-- 
2.51.0


