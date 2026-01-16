Return-Path: <linux-wireless+bounces-30866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 31920D297EF
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0FF43019E3B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455F3314D32;
	Fri, 16 Jan 2026 01:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNspB2JW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6E631618C
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525545; cv=none; b=X9piBEf96iS0Qa0zSbPZzz+mXMX5s1KkklmN8DNbpVAMr8zryIG4v7j3kd7svNmc37RzoRyjZuRHvfkQpnfHwDVqb3ka0nhKDO6QXLUxMgQmT72L1+pXdyWOm1pYCGL97smaiWORKBHA/8yqR7NKGTzuFSRO9amNqwNfydUtfv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525545; c=relaxed/simple;
	bh=s3ZwCB3JvlyU+vipl3q6KmMqgje/HoIfqvCD0zlfKcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2w57rCy4059dAFFOdbgop/J28ju+soYLrEOUg9n/0JHZpObwTJBAgk6+7KDKeLuFUMVg+3CHOYuKYHVLWe4dBfvKy1vfAqPOTeB6XC4CUHi9iYjNt1Ij8i3lZuvoVMJXz/e81wMClra/BFOvkpSivxklxHVKWn/waZ6SpZgC5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNspB2JW; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b1981ca515so1731855eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525533; x=1769130333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayqgJZ8LSe73VJtWRWF0cloWppdfmdK1Vbp7fAPizSU=;
        b=RNspB2JW3/dmFRSvviJwqD69xBtrbtmDmignOxG9dIullct54/pZXDIhQFWwhoBvni
         YdHAEMTWIsO83yKmb4IP+lIQR903iPP3Bhp4s3WeTbrs+SA24rk0NE7xF+GEELq3oJD2
         6RLu89NFGcI4gt9j475HEVB1iNfagRm4hH/vdq4m6D0g54go5LXrukcKgcuusUPbyZG9
         vOESys0paEBy7Qs2xRwsIhFZjQAhcwosuYdtbdVpdakFTme7lcletzydJFt/bVfTICOF
         +5XQMjvwARzA+S5+NsLX5F8JErNgjKwQu0WhftX3D3+9oc+tIq30LpyVZu+EqsO8m0RF
         2gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525533; x=1769130333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ayqgJZ8LSe73VJtWRWF0cloWppdfmdK1Vbp7fAPizSU=;
        b=E4kFLpWbvgn9glK/0eF5dXgxboE6jqTqeIcSLNgQ3KZJOZrU+Jw8ewf7Sly3YbNEYK
         FW9S7PCkQ1lS3QXdodF0Qla85MB/CUto+bYBt8tFjWgdX5XNaVJwU0lO3dDuQOagZ/7W
         8+3TcBBWOs0gwsND63AS4cCRilBRlg5n9cYBMnNgiNistKdTAq+OzP46s99fnO3MgQLD
         Sjhh43lywdb+tNd7DvWh6RAcI+mNgPJndqj/ZrUo0yKyY11DRCFD2F586IIo222tHn+A
         Rn4gwZFiXZ5MbHSSnDuNybgDIfM+yRW/u8R1SBfCLMeyP9NZ+T58C7YH6ZjutDUkeyvD
         p2/g==
X-Forwarded-Encrypted: i=1; AJvYcCVdcqbaNEOl9E/IdqHiRIbbmnK1ZPKyQznyYn1dvYOtFKuWPmavK0QxLtMxhNb7V2PeQSo774h5stW9qT5fSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEUONV8zAMDHRVkT0fubz5KLBAO5F6JwWm3atuwkteuBwb0vTt
	Ld1C7kG/6wx6iu4qeQm1p60kp3OFgnALXWZWDuM2qjYZXbm1WiSTLaQoPh+NuFOU
X-Gm-Gg: AY/fxX7ZHmBw8RbdwAHZFQD17IyCkDqo8VoxpZQW5UjGHdzB7Wku8aQE9cqMH2YnWhT
	WfiqYKpBaUAY0QnAxq6Eq4jJpUFJ3rrl9S70Ubvs1CHhE51Nq89nWLp1N4/lD93mAXfUkI4jFRd
	hiQQ6z1Aec8tGDdBiK8Z4BW/jwNFkpzRPwoaNxK8zUfENjtFw7wnNKcauEMaGYebDxIUN/T7fPs
	g6gLxzqvDijmrsj3o88Z/jJi7hBWgktrLUzQJMje1SLb5qSBmHxkHr0guIwJsk9eKsz9Gp5Jhn4
	mkdoSpDu0dEk6HmyCF8wznwiiaLv/S8UnC4J2ZsfLGsW6YIAds/lETxln61L4qHaxk7KG5TBKLX
	Mg3MkXJlbgtVxHVtYJaFoet3VRVJpAUEAbrpQjAk1u0NLyaxn91Nr3HE/J3eoSnl+ZA5JDWmvUY
	Om/un2pHGdptWpqFw6h/pgR7csICBwYck98QaTl6aIJMqWmFdkvP7LxHkmmZeFAA==
X-Received: by 2002:a05:7300:73cb:b0:2ae:614a:3307 with SMTP id 5a478bee46e88-2b6b410c29bmr1459357eec.42.1768525532104;
        Thu, 15 Jan 2026 17:05:32 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f1d2:502c:a6ff:5556])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm1019884eec.32.2026.01.15.17.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:05:31 -0800 (PST)
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
	Zac Bowling <zbowling@gmail.com>,
	Zac Bowling <zac@zacbowling.com>
Subject: [PATCH v4 06/21] wifi: mt76: mt7925: add error handling for AMPDU MCU commands
Date: Thu, 15 Jan 2026 17:05:04 -0800
Message-ID: <20260116010519.37001-7-zac@zacbowling.com>
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

From: Zac Bowling <zbowling@gmail.com>

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
index 7d3322461b..d966e5ab50 100644
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
2.52.0


