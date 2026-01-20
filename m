Return-Path: <linux-wireless+bounces-31002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E623D3BF47
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 07:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C2C6638830A
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 06:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3353392B66;
	Tue, 20 Jan 2026 06:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdZYWY0M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696AE38B9B5
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 06:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890554; cv=none; b=KpMFxtr4OQ9TLCiJAoOiUg/+Hzn2hF+Pao6GzLstZeaKzCxYlfaZeTl6NGC0F1bDj6+HwRDUCBE1TZcJQ7+IzC0OxW3ZiqFirgpJ4QDT+Qp1to+icTsgZHXVkZhchaRL4jOZwULI+KmrHapcorKbSaOfuWeygjya+Lgo//9KuMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890554; c=relaxed/simple;
	bh=Msmn00R/whpSKvYB7cyEtq9bHDCq1FKIinq7ESwlb0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgCC0+RKwNLe5ITxy9vWS5524xWsbnyb9W9AsgBCkVKzjK+oHgUT9RgEAm9dROa2EdiDf+/cN9s4aGMnm6wDJYP6VRaKt/cXBXHzaMfyNT9pmkG7zbRQg4Mo+WRNnffHQwLTr0VaohCDtZOyohKqtPz4lfp5F37OCtddta99Ios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdZYWY0M; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b6f5a9cecaso1031389eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 22:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890550; x=1769495350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhF6S0lUNMQ6iu2San+RRE4uR0QE14549Ly/QDJAGJY=;
        b=bdZYWY0MQnX439Gsqr9mhNTZ95TFGUu5Rj+o0spj358gQxqF5M2PAmVgltVjB1OEKO
         GVZyVABRVe5U1mm6ESeZDQjySwpkv4j9tN4R6eX26Jry2H6GMOCRb+6uIWT+yb4+e4R+
         PC8VsneaCHNeMErrw1o01BC0w64poyWNsZgbnwOnmHG4IlTV3dGwvrUgFmpW8dBgvdQR
         PlX2XGagVLTMMveJGD5RoGbBCLB6KzV32W0iKOg+vndK13BGXcfCXpfIxBBrdyKrAygl
         tBvbwJ6kjjMxSSIh5OBy6fp3/KG7aQIeflW/ws5OI1+Ri5j3ZeSmWCVVQLC0IXZlAUfM
         qokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890550; x=1769495350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhF6S0lUNMQ6iu2San+RRE4uR0QE14549Ly/QDJAGJY=;
        b=smpLe2TOXz3puRpPWTLRf+401b4eHtTj/OeOxcRXDw58ZuczvqrzaEecF1D2rOlkOi
         0E2h/AyXUCyUzgznDENfmk1MBQGvuCyPPUUKK9gZ+UrmvSjnFHD6h42ZqhCfWoJ2sZaf
         qzK05cYkfxseqt9FDjM/eLl1EMalYyh3SOJ6HE0XIN4JOMaUzk1HV4wV3aTTM62ZJexZ
         HNVcfMj5i2JdhRUsCI7/rMbehaP+A/k9hZx3aF84DQVZ+b1t1J0Hg6RCJtwSN7ZxKYNY
         HaCZbVeDLdJFpyzLw44H18gej0QmFbWfTVoUHSCr0Bi8NJO2XYeyMxA7dNyeOZtR0mR5
         UhHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyhzayL7AQc+Jh/AN8ChpK/6ev8o7xxGDRRObtz/f5ikWz+PHwcoKMuzGj19drtCuIH4pM9kY8zt8FCr4N5g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp7wCaonea3DXzoLovdG2l5RvcaoP/T63InIPXdIwenFhU+mnc
	Fgi/c4jsPMWDvDV5ftQFMOyLOUotWYUE2oiLp00wv7FRs82op7G4Lt+h
X-Gm-Gg: AZuq6aJE2CAOs8dtZTh2ULp/1CA3qACymGms5Q5AVNnEmGFSSDt52E43WjRQG9Oh6nN
	XNI0pXbJ0AF5wNWG2tr0wfzNyEHzAeisFasha3ZNx6XVY09Za1HFhd0pYFPRsyu/Gg9lzjQSfdo
	zTB33nPoZDx5pqqduqU+v/2Gd99/R2Kwi2h1+5OWQzklo1DFSb4/jhy18zA0h84W9o0wsJgr2cs
	/lnopCHq5vCEXeCMIirmVwgGoL7g2Is0c5IGMenTvyo5WVDCRDfHtM94qOZwm6nAI46OsQ3uv/h
	wouw/n+EzsiNAO5D3u1kPQ7py0liFe9+1wffcLaOrLuPtHTtzj74lDRiAYB9f+vc6+3FnhslSoR
	7VBNDWh5Y0Q/wroAWI6TNNxWP/goRWdH2DxWrvgEJplhC8THKC3WFi3eL25tCFKCzITcWTiejso
	23jJE/eo5dv0ZW2TFZ9fptgXV9RreEa1eSvOp4IpIt8FhUYjYLPwZtJc8NzO80iFmh3BRzJNc=
X-Received: by 2002:a05:7300:3206:b0:2b4:7c92:3f7c with SMTP id 5a478bee46e88-2b6fd623ccdmr573615eec.6.1768890550416;
        Mon, 19 Jan 2026 22:29:10 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm15706784eec.9.2026.01.19.22.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:29:10 -0800 (PST)
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
Subject: [PATCH 10/11] wifi: mt76: mt7925: fix BA session teardown during beacon loss
Date: Mon, 19 Jan 2026 22:28:53 -0800
Message-ID: <20260120062854.126501-11-zac@zacbowling.com>
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
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 81373e479abd..cc7ef2c17032 100644
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


