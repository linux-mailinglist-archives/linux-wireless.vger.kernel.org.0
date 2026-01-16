Return-Path: <linux-wireless+bounces-30874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC9ED2982B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 888A23026A65
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84BA325722;
	Fri, 16 Jan 2026 01:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJCJHUET"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128E232143F
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525552; cv=none; b=BaNaoWGaVPS22hMxnFvH/Hz2t3VSUHFTDbe1PoKj75hDsu5cavs4DTHgg8BADgcqsUO1nqyH8CQ2K46NqDaxLfckFDwDmIelPhye7pS+vYvmgjGS+k+ZolJOLJCzVCV5vQjKYdbZ2NlKuH2FJeTH6LMV+Bk7kXm71YIsQMIrRH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525552; c=relaxed/simple;
	bh=2S+4CpPwY/s450vUeuQiJVlhysU5x7J8xTxoXkfRjw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKqOd2Lihoe1bROd9/g72CD31mwWg3nlKhuajOiE3cEZHTdIHweCtyKVQeA1BAmtMpXdM735kH9zB0cwpSINfIOpv48Dw6lIcberJjoa/YoTO+LJzAGWNReAIT0pbLMvWuqPCckN0ivVov4XyM1j+/4J1GTi72uBPOFwV+eSS/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJCJHUET; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b04a410f42so1852850eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525548; x=1769130348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajGEE+zV+m1fee4TbMLVvt12s4XfuElR8HLx1UKiaMk=;
        b=cJCJHUETp2L4RlLoW6LjH8Hl8Znrb4Y5bjADAiX7ym4u4obIVOVQkNvEe93oTkDlHe
         9aBLJK2Lcfy2KF7CAODuXQsVh1RQj0ExC24CulrR0cp5YR9+zkvLfBrkS+lIdtoeP4gq
         hgRe12+j/e7KN+qd0g/vo00dSkrtr89J1cHGCZL8QGVG2jk4bS3N60BZu47fPA6kWDv3
         q023U7ZmdO8Y//ZLHMGMQZVwYsBuqk8Mr/9VMQEU0kBJN3btZZYjtHDgdxyoHUsOSAo/
         +ZFRQYJKl5Qdn33mbnRVugaXGDXlgs3exL42m6SCypee592yZnXWsZNzLMLP/oSZNPF+
         NOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525548; x=1769130348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajGEE+zV+m1fee4TbMLVvt12s4XfuElR8HLx1UKiaMk=;
        b=kuAFCODS38to8DoNZ57pI+rus/LzVTw0kxPt18UA0P2EzkKYdo83N1f7A3E69mGPg4
         U8jsd7FgD4TQJDbxDqnfBLJW/ve+3S7GUc9edgi7BJZS2fRH6p5bhNbi3Nuevvhw4PF8
         QHNVtmEehw2jZomizZXAgUSpadcjaGWtfgqm8TF40qc2eRJ15hOi/R6T2i1bCLGK7ulx
         KWBozcZ2LtkvnPVN+61/JUUNVIHz2OVM+tstSPMlJv2a8pCaI+Ry+KZ/TOKpYnOihIEA
         RLn3/tSTnN7GBi7V0YvXzuUHT7h7MO4rYJD0QTlU30j3HXBNZ8JNHHIpGyJj9H03enCH
         go+w==
X-Forwarded-Encrypted: i=1; AJvYcCVcxjRyIFE5DTN6kGiBVdccHmz92KM3qgKMS5E4Nzwem7ivPldobqaYzn5f/NSotS5IEKYycFYXNddPsjD0vQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOMLX90eye3/sD/GENc9UMpmaRcROZ/77YULdXmcYdJR/SxMne
	FSNq5ebjCGg6co8bXFEbLSJDX1n7qwtyOhl3VJqssTDPRbAH/22lxJLW
X-Gm-Gg: AY/fxX6wpXjtHXJfxqjw9wC03DFHT6qjj9WMRv5tpPii0Q+ItnDcWxNgrNwPLj27Anj
	KgUxh+1GZX8spufyeBd88DewLj4mgjspOBGhuB96BLbBHr8TIWGbCnkfxVmZj6fc1aGVILS08gy
	9XE/drCFYlNdMYHXErHnOxLlYBcZE12XY8WkGW19MNYZWS3wEq5cykxDrN/KuYqo+MhQwV9S+q9
	SG6bynRcd8+52qbfIEVUSq1DMY+XCdC3FKP/gYzhYYEw+7AvM+WkvHzG2JRfFs7+0QS9D0KpE/1
	ZgRC4IqZaTvzE7R92fKY6Dlp5LpBiRga9FXCMeo0gGrbZEtBTpJjh30le0ig4mtJ024JhxbsL0o
	CcOrkptcwiAS9iBh6XNBdjkvJBW3nNnpVMU2XbFd5Y2r1hCEXa86RUs9KH8m8JAAcIhd84SZxsG
	Ng7yf17orUhNhpOqABopb31INe7U4Jb6GPVvd9E2/jz7JVq7qZEF600/YMV7+RSA==
X-Received: by 2002:a05:7301:1687:b0:2a7:83e:7b17 with SMTP id 5a478bee46e88-2b6b46e6ddfmr1326151eec.12.1768525548448;
        Thu, 15 Jan 2026 17:05:48 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f1d2:502c:a6ff:5556])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm1019884eec.32.2026.01.15.17.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:05:47 -0800 (PST)
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
Subject: [PATCH v4 17/21] wifi: mt76: mt7925: add NULL checks in link station and TX queue setup
Date: Thu, 15 Jan 2026 17:05:15 -0800
Message-ID: <20260116010519.37001-18-zac@zacbowling.com>
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

Add NULL pointer checks for mt792x_sta_to_link() and mt792x_vif_to_link()
results in critical paths to prevent kernel crashes during MLO operations.

Functions fixed:
- mt7925_mac_link_sta_add(): Check mlink and mconf before dereferencing
- mt7925_conf_tx(): Check mconf before accessing queue_params

These can be NULL during MLO link setup/teardown when mac80211 state
may not be fully synchronized with driver state.

Found through static analysis and pattern matching.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 7cf6faa1f6..81373e479a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -871,12 +871,17 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 	mlink = mt792x_sta_to_link(msta, link_id);
+	if (!mlink)
+		return -EINVAL;
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1);
 	if (idx < 0)
 		return -ENOSPC;
 
 	mconf = mt792x_vif_to_link(mvif, link_id);
+	if (!mconf)
+		return -EINVAL;
+
 	mt76_wcid_init(&mlink->wcid, 0);
 	mlink->wcid.sta = 1;
 	mlink->wcid.idx = idx;
@@ -1735,6 +1740,9 @@ mt7925_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		    [IEEE80211_AC_BK] = 1,
 	};
 
+	if (!mconf)
+		return -EINVAL;
+
 	/* firmware uses access class index */
 	mconf->queue_params[mq_to_aci[queue]] = *params;
 
-- 
2.52.0


