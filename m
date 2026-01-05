Return-Path: <linux-wireless+bounces-30328-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 055C8CF17D9
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 01:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 584D7303EBB8
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 00:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47391D63F3;
	Mon,  5 Jan 2026 00:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hvotf3Vg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E111D5ACE
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 00:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767572819; cv=none; b=MkSAC/KVIjM59UPHKJ1Lbmvzo/DE7li+QA0b5jdttRv7LxGfGtA9+T6PFcwM6fv7+4oY9TH6R2KhJ7M7JWyUmYTZnxkEubKlbWk2HAT8xZ3k5ad/VnOzykrTqtnIGiWEtBqU9M2w8x2vYTufmuifXrmX7xUAX8Gyw2xJPdOz/xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767572819; c=relaxed/simple;
	bh=HZI8ymIlizZf5k6vodhsTUYOlmMNs3DVqGzzKTE1rMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZRddDtxL/rgDovFDbjH5id1uJ0K0U/2plX2KQnlP4R5K0BQIurLgXBPquGvrK/ezR48XgerUWa8+fAZhOXUQlfm8iMWtrFShSwHLWitAjYdOPUTFOJRqisBCokiqF8+ILes9EXm574rznYNKHaqYd2AxfqyJLXPDc59EvzdNGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hvotf3Vg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a0b4320665so209994785ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 16:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767572817; x=1768177617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZnhjhyPQPCObFdQCf0DoFdJ2rk+AgcVn/BEbBcwfpQ=;
        b=Hvotf3Vgv7fqZOl+wTmsUAKHzOm95uY4wf+lsMCVGD27Ut4didIHgaDD70lIqGq1np
         iXmn4YXamN6K+tOcSVDJfMMSd2x6TVsN3r599s8z+00H07ZekM7DNF9T11NsKjVrEfZS
         rGJGxH9Ag9noJfR+cDi0XOhUN0zPEUEc3gVi/iwt+46ygjyK1WH/LoM7UdkD2WBpZTgn
         QAGGiG6Ch+eZr2HFMtAdwKePiq9h82OgRmYw8jpbdC/gdVn/ffS/d3eNoom1W+1X9z6h
         r+ULX1XF9jfkhAymN/72q7lysALtbOjusV0Uy3M3XTpXVZT5Jcv1jUPaUd3brQZONU6K
         kZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767572817; x=1768177617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ZnhjhyPQPCObFdQCf0DoFdJ2rk+AgcVn/BEbBcwfpQ=;
        b=otiMAESY5oo6pGCX52X0ZQc6u6R3tDlXgXW57FR6KIvua4Uxn/lPNttfEN7tNXuhDE
         OeqKxM4Q05ZskcjD1VDCohf3Bfox42mahEJgdTAbNseY+d5KAOxAFz+5/rVFCvhVZdjp
         C2AGIYEEmGx46wYimKgj8MooIJOWFIZ9aMfjeNAPtALCIdhm3LjGsVsWVxwVpoiYuD5p
         JDtT1jREDVpyMbfT2A/Uo6kfIk/Zd48NZYtV+UgjpprM6qwdmQMTSwGL0Z2bTAa/uIlD
         zh1hUgGacEpow3H8dazZJsWm+6fqbJ/2/1wQMIZngYFOEpNt3OndltcfVXQsL/ktgyTD
         sRKA==
X-Forwarded-Encrypted: i=1; AJvYcCWbBNwmcA4H/l6mDfbBN4xCJ5AYnACZZCCYedNgRcalwwPDw3aKjOyxzzfF9U+HBuFvc2dliequB+NpdB6iFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5wBqC8SDmWHpjx8gTLJb+YFSOL8RtibVoLuk4pfcgDkbQ5cry
	U4kg14VG3ngOZRKWpMVK/KsJtC5k/PyZzW2UqB5EmGIZEuNWyqz6Hzc8
X-Gm-Gg: AY/fxX7B8RU9mU7fxoLAj06ehEkp1hQCfRrm07pp3S1dXNF5UWY3tktkzC6tnqNfi/R
	Q+cMUYICUMsjdRdABRM3xo++Md/JJKrToWmhpNgwXSkmvzquvXp/OIaXPtPzHTwglZHcDgvbjRR
	qKd+v1umSd5qzMqdEbPLl0vM1W8WT1wffadGT6zjjOwVisdZyV0uSyd/KnAe2K6UFBUME0Lq2CY
	kBefh98QMaqKIPo/OpxZCWr7piilFpOxQWrL2E5f+TGcbKtLKwctbDEqCFI1UY7ILXtJgKef5h3
	C3n/1LnKjTV655fX17lQR5CjfVKnnWZ2EQ+s8K6nF4NeAbv0VWiQUysD727aIGWBKwoBFRPg6J8
	5GTLGHKawKu/lZf0/ZAXbxMWApyTUPrXUMgooE+iLvF33XRiKA25C3VgQbGq3+j556iGDYEZ+A/
	I3NGGaSUvzvCMmyZZD3RCBZqKGDRNydxn5bMKAgsrNwdbNHuDhZOnYL/Jgckmw8T4=
X-Google-Smtp-Source: AGHT+IGN/67FaErtupyToYrJxzBUIYkl4OUOnnfqPdZ+eJIg4lHjFzD7t9gZZl1LJK6SGTTybmCpRQ==
X-Received: by 2002:a05:7022:3708:b0:11b:9386:a37d with SMTP id a92af1059eb24-1217230eaa7mr24870293c88.44.1767572816910;
        Sun, 04 Jan 2026 16:26:56 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm133378109c88.8.2026.01.04.16.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:26:56 -0800 (PST)
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
Subject: [PATCH 06/17] wifi: mt76: mt7925: add error handling for AMPDU MCU commands
Date: Sun,  4 Jan 2026 16:26:27 -0800
Message-ID: <20260105002638.668723-7-zbowling@gmail.com>
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

Check return values of mt7925_mcu_uni_rx_ba() and mt7925_mcu_uni_tx_ba()
in mt7925_ampdu_action() and propagate errors to the caller.

Previously, failures in these MCU commands were silently ignored, which
could leave block aggregation in an inconsistent state between the driver
and firmware.

For IEEE80211_AMPDU_TX_STOP_CONT, only call the completion callback
ieee80211_stop_tx_ba_cb_irqsafe() if the MCU command succeeded, to avoid
signaling completion when the firmware operation failed.

Found through code review - pattern of ignored return values throughout
AMPDU handling.

Reported-by: Zac Bowling <zac@zacbowling.com>
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
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


