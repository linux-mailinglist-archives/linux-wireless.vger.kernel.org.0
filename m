Return-Path: <linux-wireless+bounces-30879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A747BD298AA
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A7B23126FD4
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893BA32A3D9;
	Fri, 16 Jan 2026 01:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="II8OOugC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBBC3148B6
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525560; cv=none; b=fsQO3qtIzHCOrSZiknCOWS0rjtqbSE1cdyyuyvK8SewbzOrfdULD/e1rbpqxd4ZZP+JGzqLBp2v5yi3gI2nWlX33RqqLGiJJLTooXI6KwFd4NA80AzI04Gqpf1Ltlz1d7EELnU1D3jPjrLWQERAf0/RebJIJBWjfubLem8GYSBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525560; c=relaxed/simple;
	bh=fEiRyuMj05TeICA1JoBhIIz3Ws39gKPSeCLw1wGtAFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdwKnQWxWUnIIBLbcgQFO88UvQ0iY1Up9DTkYpWO3M/5fmunJR4hpF4CpK5pE9T8Q/UkYtZ1afw7kKIsipnTDw1rZBOtnSJHqOSwgWKlaohPLe2o1WMsSH0GmGSBI3lr0ZkwhrG1OTsq0/5j9GY2PdIFLrGBVroBt9OX9NyAzus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=II8OOugC; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-121a0bcd376so3934456c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525554; x=1769130354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhC8L1hQ8dg4kLrkzny6o4mFLtnYcnvkf4rrn/bndiU=;
        b=II8OOugCRrkOTX2aQdengwtEYX0Azu2IDT/ao1Awg5f8Uvun7XFXg9Fxo17oCGcFh6
         M7phToDnzgy+qdUv6DAuoBnhetWcZXN95xZwa0lCChAt7647Rh+NsufIrNcC7z47Bugd
         +rS9JDnaGubzoQc3i/qNP+ce2lVdWVmiN+mx8rU/deuPs7sd0BSPD4xr1Dt11B/stNRe
         +RB+03FuNkJRO25qNovLlgpa/spoNpRKaMNoG67mqnS3gSHHAwbY0upzGCf2ogFz6Ymh
         Vd1NDRYuz4HXJIqfoiGhNG3DIRJv8MoR6EIZrpx+7RxcKsZwZq3exDqJ/ZU8U8FAGaQd
         r2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525554; x=1769130354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mhC8L1hQ8dg4kLrkzny6o4mFLtnYcnvkf4rrn/bndiU=;
        b=Wg+dtGJjVvVZjqgrS496qNcPS6dyDiMyajdB2E4ebB3COn5Afhj2WWct6Up953s5cQ
         r2kEQ6zVHFN5rrn4snNwt2ReOzDWPL94LMLnJDCpcpMJZ1qCSqjNSBtpLMEdnF4S/DF4
         ggJSa6P+aS9+J5JWmMWZWFzRCguoOAGEexHh/qBLKhq3W2jU0CplYb+X8RCnl2c9JlxN
         pE22ZFD26dk1G2Th1DgX4dMGo2ECXjSwaVAdMnCuIVji0wPoyGceeUgpElCvAK83bNct
         ud0rWXmoZ44/RwoRTgSHs1nLCjgbYZHpLHKFaAJiImGAOAUgAcn0hUK9Wy1WC1zUeGC3
         R3dA==
X-Forwarded-Encrypted: i=1; AJvYcCWFkclhXWP2S5BQSLX1cV1+hiEZtjRqoyV7XEO8QITL5j3MrDtmDBCqiTPx1Ifz+y4GqYinemvCM59yZOWC3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEDUrMgYFymrI6jXOV8tD5/q4UFT52dMN2PC3DfKXnXGzT+S2N
	ov7VGdQP5FkaM9x8En16M9OHRTsWzOW0ixuKPpeXeM3aGHRziZBYDv02
X-Gm-Gg: AY/fxX7RAJPX8bs9ijO9ea9aPGkoAXOpwABw+NLg8PePXPZ+SCpUQfFmlC4xNoMsvj0
	jWF9oUVSEQJ4MdsSYjq0BtVmsybMcGowB1eve7jFjVYoWePHF9riJgrIj/QF+sKOHaz3ShVKR0V
	bWrS05cYwIX3a6+LmqiGMPmEsDnROucte0Sr8ZaqS7wd4xVgvV/wxm1oZChLR/LQajsSgSoS1xG
	BPu9a6luGl+Yr2AoNe+GunoVFkf0sGtYQcpsFQi2Q+LFaRaQ4NW9aeOJm6MAapFRWF4VNwyl77b
	nK1mO9R0m6x6b1buKQbBkyIOuMv0naglSOzlf3oLkNgAa6y5rwW6e05uJeVuPR4ptKsz/mwryA/
	ZCnoXYz5xniXNRuYDLv5iumyxhj+S0D8iQt1oOgih+0R3cPpghV1WAsS9vJiOkSAVYeoQKxRG2R
	DFJFambEe8U+/rsefdL6p1EmifQKorBuh72rv6FA28xu4c9xQgGk5FbqbiH5/Wwg==
X-Received: by 2002:a05:7022:48e:b0:123:3461:99be with SMTP id a92af1059eb24-1244a6fe904mr2196015c88.21.1768525554364;
        Thu, 15 Jan 2026 17:05:54 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f1d2:502c:a6ff:5556])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm1019884eec.32.2026.01.15.17.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:05:53 -0800 (PST)
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
	Zac <zac@zacbowling.com>,
	Zac Bowling <zbowling@gmail.com>
Subject: [PATCH v4 21/21] wifi: mt76: mt7925: fix BA session teardown during beacon loss
Date: Thu, 15 Jan 2026 17:05:19 -0800
Message-ID: <20260116010519.37001-22-zac@zacbowling.com>
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

The ieee80211_stop_tx_ba_cb_irqsafe() callback was conditionally called
only when the MCU command succeeded. However, during beacon connection
loss, the MCU command may fail because the AP is no longer reachable.

If the callback is not called, mac80211's BA session state machine gets
stuck in an intermediate state. When mac80211 later tries to tear down
all BA sessions during disconnection, it hits a WARN in
__ieee80211_stop_tx_ba_session() due to the inconsistent state.

Fix by making the callback unconditional, matching the behavior of
mt7921 and mt7996 drivers. The MCU command failure is acceptable during
disconnection - what matters is that mac80211 is notified to complete
the session teardown.

Reported-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Zac Bowling <zbowling@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 81373e479a..cc7ef2c170 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1323,9 +1323,13 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
-		ret = mt7925_mcu_uni_tx_ba(dev, params, false);
-		if (!ret)
-			ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+		/* MCU command may fail during beacon loss, but callback must
+		 * always be called to complete the BA session teardown in
+		 * mac80211. Otherwise the state machine gets stuck and triggers
+		 * WARN in __ieee80211_stop_tx_ba_session().
+		 */
+		mt7925_mcu_uni_tx_ba(dev, params, false);
+		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	}
 	mt792x_mutex_release(dev);
-- 
2.52.0


