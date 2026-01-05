Return-Path: <linux-wireless+bounces-30339-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBE0CF1848
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 01:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5CFF303EB9E
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 00:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A536128135D;
	Mon,  5 Jan 2026 00:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiHGmBdY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A1917BCA
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 00:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767572834; cv=none; b=YUqJh8bQs0kow/eK1v/W20FlTk5ASw3c9X0guKBe490KN0cpqMhnCPFylQw+4c3WCqHUCSeOI9tkSILzqdS2XPkHr4qaiqIRBJw5//+Or8HyE1Mf7FCCFZSL5KPqPJDXulvudqlUft+g1llSFVkYq+Mk47IOPC2hcvGCtHV5lVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767572834; c=relaxed/simple;
	bh=tzBVMM2UuxU44r818zA3Ug+gigrUDnxlT5FMH8AOwj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9bndVOfgsIqeWhbxLdmnpb11J4Pbi6FwOlZ5W4BuL3ScHCQqXaOC4UentoHz3PD+6ujHAcXY9rQRKS0PuAti6djeIwewDLM0Y50yKn17cEXo8BF4WiRJP2JFjlqayA4lB+wHzhYHS76TSZKmMiGb3TKm61NkG/kl7na561OAv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiHGmBdY; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c2af7d09533so6144708a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 16:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767572829; x=1768177629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9pZM3lVItBOVq5Rc4FqhGypr50RN8XCw42MqeJlzrY=;
        b=eiHGmBdYZQbLWcdxAIL+LAvvARyL+dYEEudPaJpOAeI0FnAvvCfUWbDUPyOnIiKaDt
         SCgBE+PxAgitdzKQ4Vu7SBw4bqEScXDVXW8SSGMLE2bW3+8mJYy+KqN4LRLPTpcPysbZ
         uzJWDhL4vqaNwDE75iYC/3xAzDR58z9Ua2QpNaji9qx3H+s9kFEuhq8N02AkEzSrjiJY
         6Y0gzRkq7q8wgMzZYSamjSJzQiaPL4Tk6LdBXjwnHwdn0ssL0rufxRyZYYHPAKmLwfBv
         FknhusmTSTwxXU9/CfrZCVheIsZZI+fPn/8w2mtG0gZpihUP3KJxkGfZx8I9t4Q2Oimu
         6SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767572829; x=1768177629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F9pZM3lVItBOVq5Rc4FqhGypr50RN8XCw42MqeJlzrY=;
        b=j55K1kBJge2htHSkw1mBi47v1Xkhl8KLFzreGE5puh72g2BxPWFoVjgZYFd+lC7p+u
         n1Fxw1+6izUcvdmjhutoGC52NEtMZMNrf/u75/SFvosz5SXP4KsVUKoDK0enkFGWwg4p
         xe5h61a/5SQh8HnG6p1TJJPDEl2gHPpE5dSLJESYzsSmNm7Z5MJw5mdR8GeOELCWvDis
         mt19SYkDMQpp/mIn4vSQujdY6ik5moo5F3y8OL/4seJDiq08Ce2kLqY2X6eUyn70KC0e
         huB80drIIysskl2B2o6Qptj+GTcIo8NihY2MBrYnDfwByTyTwO1y78NwLwUZ3MWmRg0Y
         SSDw==
X-Forwarded-Encrypted: i=1; AJvYcCWlQ+bErFeatNbF13VfEuDaoxrvOXlZZ2qlnlw+9S4SQIFkqBDSiSSsxwddELZ92H3p4DQXZkOzFiA+b7ptPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzPiLMxmeVD6XcWSRtiJu4cjjQNM59QgZm/+/dzJz1uJyoC7dM
	psoGJ/SthlOUqMGjmXDShpxrwBVh9l9XnvoWIP/qh3UA8KMdHLbbfyXt
X-Gm-Gg: AY/fxX7J3LJ7lr84iJRbD9Q2txH74QYj20eM+xHC8GqphfNYbB3GgbHdH2iGQQjBYXK
	0ihFKkzEhzaCYseyczd13XQ09LbQYMlXyDLVDLduH6mdYuDXmcSpvir0QFXpUmf4l7pjwIxZCOC
	fCaT0W7qSOGGs7eGAtNNChw9C1rzsrjDiAzNE/VhMh2HmPeoA6rkI2aeaPJaZJ+5TlvPiZSAaN3
	P6SvSKRxv/699aWO9cMTeQRxTPjExeuFvVKuiw4Pq4sr6ZUmhtx+mnn961MiH4Tx9twP6sC2l0m
	DAR0IRaxf93+1RfJyvRnDYxMId/iHlCEQFLqLT420oVOAZEza3YhdT9ZujCY9PIV6JsEwICqU6w
	VspKawWXvuHg1hDnCgqP4ldirKLm/bNovckL7DZH1u3S6xyYV6XpQ0RdvCZHVt4s7COhLMwKNri
	KSyEIAYTUdIX4rY7YQknvxp5LXv9kyYBgPWovHc09e7jErrBeOVGU2qQ89Do2wHiA=
X-Google-Smtp-Source: AGHT+IG7x1Ymdyvu9lCiNZWjm0VKOPz4jnCYI4WRlVDYrDXMAI2/7wPYk6ox4CoZIXyf7ZKZ1JhkhQ==
X-Received: by 2002:a05:7022:218:b0:119:e56c:18a9 with SMTP id a92af1059eb24-121722b4f87mr46583592c88.17.1767572829297;
        Sun, 04 Jan 2026 16:27:09 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm133378109c88.8.2026.01.04.16.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:27:08 -0800 (PST)
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
Subject: [PATCH 17/17] wifi: mt76: mt7925: add NULL checks in link station and TX queue setup
Date: Sun,  4 Jan 2026 16:26:38 -0800
Message-ID: <20260105002638.668723-18-zbowling@gmail.com>
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
index 7cf6faa1f6f4..81373e479abd 100644
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
2.51.0


