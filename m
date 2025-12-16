Return-Path: <linux-wireless+bounces-29767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C035BCC0675
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 01:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18B8B3000969
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 00:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106281487F6;
	Tue, 16 Dec 2025 00:59:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FAC502BE
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765846783; cv=none; b=k4oZP0LfzGspjzVfX12xCsm9qjZOkkI6kQ4LTK9PYTaj5KQ9E53Q+Y8OM56ly/qAnnm+Qxy3DEpBdAHcdSmhp3xURRPB7d76bVgvkgYKwFZ7tASvuDtmQwN+V5lD4seeZf1fP3CfYaAw/Qt0UtbIvNkXXZyCSUiQduiHhmTLPXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765846783; c=relaxed/simple;
	bh=lAMcxDuPKR7Gb5BRWzIwJpwzQMB2uAUIE05dUfkPxKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BmaAN0wOEM/H3RpGLXIg0N8iz4LZaVRO5JE0OQY8fpUx87euU2U9G/VFPPNTB8vBA5M4BJtmYadz0EfkdXRQEiJx4M2jNYJnSky95nMzZpAbkpjwKWxMEb6DKPW2t6Aojj9IsUFGE36UluUy6s6SDc8GABOf0itpIaPhVkpMpUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6596897c2b5so2598279eaf.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 16:59:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765846780; x=1766451580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hB6Rlz0TeuRm7o85h8oRkcQTqYWfoZxzRouu9O4pnA=;
        b=O6GxSKmA4WXQ1jHVEi83mmlgBppbUxib5RtBWtspxpF/YxBVUujAJT27A2L3SmzQgg
         PyuR/hR6Xb1+k5Gfc2Tdiev8u44iqmb4oYmCQvkjmqEZePf4/hHjMrAGYVJJ7AYM5rK7
         /rVZm2qeEn9IbLRmv8OPBJICvH0u+SYdGgor+8GeHicViuVEJY6vV5TR0MYUmAh/o6/I
         i8chTpl2s2IXo2TSaTDRON/dyxMLVm7XnuWmDoiEJDCKjAh2GOYwij/SyFxi0LCzorcH
         ZVnrkPWQ6ANlOiFSWBV47el1vIci6U9TWZgDuO1mYp0Com7CjaJG02lH7NEnvJ1foG5f
         ffZg==
X-Gm-Message-State: AOJu0YzFDz5iIOKXm+Y5BanNtxNxp5m/3yS0tQSViQiVpm3/m+hJ1DI5
	B0hr9KmKsPXCqbGb4HTf/jOm0Tu5Cma3dtuuZ5yeJ5suWx6WLmrJdHmf
X-Gm-Gg: AY/fxX4hYOcKZhkBXY0MW1NxFAntsXrexv3djZMprsDVH+f/yejh62onvFU8X8YN83/
	XQR4zTWF3i6bJwDWGdUjqa0u2I+NJiVudt6si00w0WNBPOj2wiy8oXpW/blLZYpDe9ll8ZyIbJi
	vriLhe+vjh/JHmkNS7LDc6qDSXudzx44brcDxxAv9BofuV0CaEDMVpxK+3Qj08/DzVAqmdxRfIn
	p5XFhxLMp6G21ivhTydV/RrieOctL+JC/wyDjKLQWPU16/D8RVv8RNhZqRC6Brk/4ynyq6ybAgK
	J5EgFZ9hV01cWM2TaIeIcvRjtqylObP9tlc2ezoRObEErLPtMxAM+FEVn5D17sD1byH+ot5UJio
	ljiDikzaa88qo7yP+fmfINnuJ3EThsannX+KO+MArtUdZbBJagPq5aZz9x81p2icP1dNOidwzKQ
	EQmYHapnMDCiDkQsQkL4u+GJjVD1OrA0h+s/U=
X-Google-Smtp-Source: AGHT+IFr+zNqBkl81MoHWp5u19ECMKiAxU3MfUjuUK8ZKOB8IYtwaHUFJOjVRGMGKHvM0opSoc26Hw==
X-Received: by 2002:a05:6820:2223:b0:65b:336f:f33a with SMTP id 006d021491bc7-65b45201660mr5590725eaf.38.1765846780331;
        Mon, 15 Dec 2025 16:59:40 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65b4a581cf6sm6522696eaf.5.2025.12.15.16.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 16:59:39 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921: Reset ampdu_state state in case of failure in mt76_connac2_tx_check_aggr()
Date: Mon, 15 Dec 2025 18:59:30 -0600
Message-ID: <20251216005930.9412-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Reset ampdu_state if ieee80211_start_tx_ba_session() fails in
mt76_connac2_tx_check_aggr(), otherwise the driver may incorrectly
assume aggregation is active and skip future BA setup attempts.

Fixes: 163f4d22c118 ("mt76: mt7921: add MAC support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 3304b5971be0..4ef44514d48d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -1152,8 +1152,10 @@ void mt76_connac2_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 		return;
 
 	wcid = (struct mt76_wcid *)sta->drv_priv;
-	if (!test_and_set_bit(tid, &wcid->ampdu_state))
-		ieee80211_start_tx_ba_session(sta, tid, 0);
+	if (!test_and_set_bit(tid, &wcid->ampdu_state)) {
+		if (ieee80211_start_tx_ba_session(sta, tid, 0))
+			clear_bit(tid, &wcid->ampdu_state);
+	}
 }
 EXPORT_SYMBOL_GPL(mt76_connac2_tx_check_aggr);
 
-- 
2.43.0


