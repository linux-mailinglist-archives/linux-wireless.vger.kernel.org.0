Return-Path: <linux-wireless+bounces-30334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 934C6CF17D3
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 01:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C7AE300BA27
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 00:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32AD1BEF8A;
	Mon,  5 Jan 2026 00:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV3N9+zX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D7A236A8B
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 00:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767572827; cv=none; b=Sfs5CVJtjt4ZoG+FfLyeT5L3vkUpmdn7QKet5tBgyczcE2KUD2JaKcdC7MZWMqsOIjKViNcyxEk/9pkLT29GBzLAlhaQ8awSnfy9f/UGUl1J7r1WmIc7nYE5oGUAgrw6Xxs7iBJBxMv0B/eOmWTDlODVTirav1M8Pk7stX5b9Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767572827; c=relaxed/simple;
	bh=vz3x+77kdQ8P9steLlJ4yD4DGKBh00DAeJdBPKKnDns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dch1GLQmjmOgMlamCSy/aIr0jc1h0dj96S8VcLmP3Mi9FiqzC/w1VgEfLhkYy97ceWunmoD2Guov22g/S2ZSlkTHtFzD9fJXG2QjYnMPwIRak/JuGb9/MlCKbVkSVbTgXybBV/vtmse5F4Pp1EO6ZIO5A3zLCsGctSh4HANBfHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VV3N9+zX; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b80fed1505so13246741b3a.3
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 16:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767572824; x=1768177624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XH+kUxxNmkYGglYPogPQvwZMB6lkd5MT/5/E1Mc/8s0=;
        b=VV3N9+zXrWQiKcuwE3S8bnYuenzhfPEwnKUkDk+8Q/a1D4DzVwK1NRRn8MVrfIMofo
         pRUMz564W88aak5BQ7GuVxQYy1AFxV6CtLWWZU4STX4tbxNLx5VrCgmK/5Xwa98OXEmP
         3SdFmsTjsnOQEvfKw9Koy1yt3QP+2PIyt4RFx89SpegFNQqN2sQ9eEAzivzg2iKONfD0
         D/4Q+/sthMh2VQ3kOU+Q9y8GecNKLsxQHU9+8MnvGFEU5UqYUcuFeK8gI+5T1JRk+ncz
         29ShCQvy2W0RReiQN1cj5bme331XzV6VLHyK/EKjLJjRwNEUeBdTxf70oUDFS6EepQAg
         52aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767572824; x=1768177624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XH+kUxxNmkYGglYPogPQvwZMB6lkd5MT/5/E1Mc/8s0=;
        b=aHZEOxkXVYSjZGnt6Bbc8VhfCUegDHlJS5oRoq36+6VNv2dqHJNj0/+PP8o7HkjKOo
         dljCgIPpV5lWWh3+ZkZcfvWtlFsFlpiXFy+c6kiGJRh6Wu3nRehqooidp8X8MVQWSsTe
         IHY7VhapvDU2nzladKikz7c5kDxJUSeeMgHvjgSZVkAYiVcbDdc7PDi00P1ImeCtle3p
         rdY9+cZILbJWTdV3kfZIQdUo2EgzY32EPh0NYFgJHmLlPU6L+rIZPWE0TuzxcQzpPIO1
         XSgJ805Ut1rvkF+n82ZpUE1FYfuUj+DwXIeskj+V0uA6ezaSIrGTPQoxER1E3fMmYPTm
         HVcw==
X-Forwarded-Encrypted: i=1; AJvYcCWe2k+/RJBWwBxdznMQtbaMQucZvDyZwb6KbrzzOpn1oNIeiAIFdD9RnM99Dl3Ie5ukhWdcqdz22lXgxs8eyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyX1fP+w4b1h4t4gPvcYjTN2bfjdQrccX0d9hbkehLqlQiIOgna
	9MgZkPZjvGDqYdEB+sB1FCvXv3SWdudEqxFhE5LrtBJwhA2W9JKgzk9/
X-Gm-Gg: AY/fxX4kFyNBD7RpONLA68xTda2XfFRihSdsoBpmgvtaZpJRNtaAvWYYV7HQKilmR0m
	zRnIbVXDlgEFw+LNRd271I2TsK14wkjvezMxKwj2LItMZV2YnAEswSb8UEOXQnJBXY5det2yXge
	Oec4CiC+7AsMaLK58dxovXO8961ThA+GX9WRmT2JnAcHlcFful4ynMu8lGSfA7+ncnGu9CINMeX
	1mZkPYiTARpXW3nswSrLDg9oPQE9wrxdrbXnKMSbL+JKhqTe04Vwmz3N4TXu9HsPvLnxTLpHMft
	NYihckMFMhZIq+aHK0SwIsRCNLuIBFMaMpSfClMlPanA1D1dqFWuzp8cNulBQG391KUDIFbEeNm
	lgNKA/2G6Y4SO1TjpsvEVA+QBsluMIadYPkd/L1nY+gzVZsO3inNo/m1//GfC44tUCiypiSU8cl
	Qh4FFB73sRpQM0eeT1/Zb0waWYlOEyo8RuT0DZBt7+BFa7ep7ypuaWLwWu/9ht38HvUROt1Pc/r
	w==
X-Google-Smtp-Source: AGHT+IHlVitLt85bPnu8RzuCU7BAPGF8BkeHdJkRJzJ94cVKx159KPw5GrT2Tq1B7JMG8uWETW358Q==
X-Received: by 2002:a05:7022:370f:b0:11a:b04b:3c2e with SMTP id a92af1059eb24-121722f3affmr27965097c88.29.1767572823527;
        Sun, 04 Jan 2026 16:27:03 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm133378109c88.8.2026.01.04.16.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:27:03 -0800 (PST)
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
Subject: [PATCH 12/17] wifi: mt76: mt7925: fix key removal failure during MLO roaming
Date: Sun,  4 Jan 2026 16:26:33 -0800
Message-ID: <20260105002638.668723-13-zbowling@gmail.com>
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

During MLO roaming, mac80211 may request key removal after the link state
has already been torn down. The current code returns -EINVAL when
link_conf, mconf, or mlink is NULL, causing 'failed to remove key from
hardware (-22)' errors in the kernel log.

This is a race condition where:
1. MLO link teardown begins, cleaning up driver state
2. mac80211 requests group key removal for the old link
3. mt792x_vif_to_bss_conf() or related functions return NULL
4. Driver returns -EINVAL, confusing upper layers

Observed kernel log errors during roaming:
  wlp192s0: failed to remove key (1, ff:ff:ff:ff:ff:ff) from hardware (-22)
  wlp192s0: failed to remove key (4, ff:ff:ff:ff:ff:ff) from hardware (-22)

And associated wpa_supplicant warnings:
  nl80211: kernel reports: link ID must for MLO group key

The fix: When removing a key (cmd != SET_KEY), if the link state is
already gone, return success (0) instead of error. The key is effectively
removed when the link was torn down.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Reported-by: Zac Bowling <zac@zacbowling.com>
Tested-by: Zac Bowling <zac@zacbowling.com>
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 852cf8ff842f..7cf6faa1f6f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -605,8 +605,15 @@ static int mt7925_set_link_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	mconf = mt792x_vif_to_link(mvif, link_id);
 	mlink = mt792x_sta_to_link(msta, link_id);
 
-	if (!link_conf || !mconf || !mlink)
+	if (!link_conf || !mconf || !mlink) {
+		/* During MLO roaming, link state may be torn down before
+		 * mac80211 requests key removal. If removing a key and
+		 * the link is already gone, consider it successfully removed.
+		 */
+		if (cmd != SET_KEY)
+			return 0;
 		return -EINVAL;
+	}
 
 	wcid = &mlink->wcid;
 	wcid_keyidx = &wcid->hw_key_idx;
-- 
2.51.0


