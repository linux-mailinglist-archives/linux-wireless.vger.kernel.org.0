Return-Path: <linux-wireless+bounces-18657-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD68A2DA1D
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 02:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F791663DB
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 01:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2359243386;
	Sun,  9 Feb 2025 01:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vampirebyte-ro.20230601.gappssmtp.com header.i=@vampirebyte-ro.20230601.gappssmtp.com header.b="rrPs/ogG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3456FB0
	for <linux-wireless@vger.kernel.org>; Sun,  9 Feb 2025 01:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739063994; cv=none; b=r9oP/lMjPIpQBwsaXhgbhhBC2Mx0kfZNCpbh0HxvPsD3hz8CmUfHEgAmwOkj0yrh+PN2piQVq+XWr9Z8gpG87ygAKqiH3xQ3MzoaqNnUfoos0d52cLIZ3M/jB5D0Uw3RvGZRWYD5hmY99eC8jKpDwFVO/IHIPc72yI4SwYUOn5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739063994; c=relaxed/simple;
	bh=RSH7iZQ08CGiYxlazczvCAD1uUZ+E9pBNwrIDrs/gx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YpRqISgPfA5sAAHYao9p9W3lwhxR1Co0Be2vAIvfp604/+3HjjKPhJRw3jZoDcyB8MhK2UdQihRrirMFjqyN/prstO3O1UB5hrC3XMjJrY+S6aSUQq4tCr5f3ujj8nDQJrjd+XnDbRoei4gov73vnJvW3MzIphu5/LrTJ/5iFUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vampirebyte.ro; spf=pass smtp.mailfrom=vampirebyte.ro; dkim=pass (2048-bit key) header.d=vampirebyte-ro.20230601.gappssmtp.com header.i=@vampirebyte-ro.20230601.gappssmtp.com header.b=rrPs/ogG; arc=none smtp.client-ip=209.85.128.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vampirebyte.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vampirebyte.ro
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-43621d27adeso21696775e9.2
        for <linux-wireless@vger.kernel.org>; Sat, 08 Feb 2025 17:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vampirebyte-ro.20230601.gappssmtp.com; s=20230601; t=1739063992; x=1739668792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGia9R3CLZOMOH3MyriTzmbtc0AB7bby0pB+e9OzNCE=;
        b=rrPs/ogGoQsAtJsQi332ADDEm+pnN443MSBrLikzAitiHftJ39VQ/QcvECv5KwJhh9
         F6XjW+5zwzu4d4EfwV7HfxiLfjd/3HRDtKH1vAcm0d+j6/GEfGbWBUU5xeJPjZgY+m0A
         nJ8lQMPtvTvHznWQKn7FGnav9cHkVUb80PI5R1CGvYtc7ys+dDvSBf1VapDgOWRV5GnO
         XrVtqqdDYZoUr0REgBcCWs11kUeaBwq6N+uD1zfymrL5OrHHlNJEB9Wx4ie9AQQhSUUv
         WLHcQELf92qem7YNCmqEyuQCrnmrk/luN52YIm5z9VFEup5PxIBfx2HyAHzPWKOjWom8
         /m8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739063992; x=1739668792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGia9R3CLZOMOH3MyriTzmbtc0AB7bby0pB+e9OzNCE=;
        b=owp8QEddv02OlILv+NXQMg6cAf6ilkZV1BGmzOLx/QyWxrDaj0ArcXv9/3WevZt9Mk
         yqZXDAfBbr5vTNLDR9TDldz/fnpyxss65sc1/4MJAJKREfAtucmrCvPMOusr0MxvuEYP
         BwzHTxF0fmJETVxXpyotF8WCkNjTNhtt9kke0PQhjldOEwte9/kgHbRkpZnKzCEQrDlK
         HYbREXQzB/Y12IpVaTsFdrEntaJoxdk9xb7oe5RAKRHuQb6P16jwb+1fGaw6ugxZfwhV
         5pvK2VcLtavC9m4f2NncMv966Prae74/2KOHQd2t29Gc2uKj44dkO+AQUp9T//0v+/08
         UqXw==
X-Gm-Message-State: AOJu0Yzx3yxKJGknk8hV3OIr2D/vGI3IXWrn+oFsIgXZPY9WWIWScqHc
	kh1KYBHY92vSw9qZTzPiBELFN7BLnfVeXc3U9WLSzprlgz8eoc+HXeacu5EZ6GLvow/295wNIqc
	fG0CyOcVr7Ab+mr0XfjMuEfiRBaq1EyiEdq4D3xZS
X-Gm-Gg: ASbGncvxzMtOu7hjasjNxWdEYpSystMMywfETWiGNKPUi2l3d0VGMxnuzd5qv6U/orH
	rPJ2GFbte30gxAXTxorvL+tA9/1E6QP7QW0hch4DaTSqyytNWbqIY2cm/WjHo9b/5pT5djVJCs+
	JbgPbj+6Y5GUANHZdnHkC0DImxRY7DxttFk4R6GqGRFqyQxLcOMIDF7ntVUrqa4UcXoLb4MR4tT
	T6aopGMhIktLRTPWjakPtMWastGnj723RaR14zTgxgY4ysQR0mnbAjxiCxBHfhsWZQL+3BQOzkT
	FhxiRQ+ICTWOTrOEeofFwU4CsJ2WyQ==
X-Google-Smtp-Source: AGHT+IEPLwl2LgXrlPom96yKFBQCQwPboziJbNjY4H44ZGhDK7kjNSk2vxC8tHk0nMuT+c5ZFds3mojI+pnO
X-Received: by 2002:a05:600c:1911:b0:439:34d3:63c0 with SMTP id 5b1f17b1804b1-43934d365ebmr24417125e9.16.1739063991611;
        Sat, 08 Feb 2025 17:19:51 -0800 (PST)
Received: from orin60.vampirebyte.net ([82.77.132.211])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-38dd6880056sm149536f8f.16.2025.02.08.17.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 17:19:51 -0800 (PST)
X-Relaying-Domain: vampirebyte.ro
From: Razvan Grigore <razvan.grigore@vampirebyte.ro>
To: linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Razvan Grigore <razvan.grigore@vampirebyte.ro>
Subject: [PATCH 2/4] wifi: mt76: mt7921: fix returned txpower
Date: Sun,  9 Feb 2025 01:18:54 +0000
Message-Id: <20250209011856.6726-3-razvan.grigore@vampirebyte.ro>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250209011856.6726-1-razvan.grigore@vampirebyte.ro>
References: <20250209011856.6726-1-razvan.grigore@vampirebyte.ro>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bug was noticed by me and confirmed by many more people using this chipset with openwrt: https://github.com/openwrt/mt76/issues/783

It seems that for this particular chipset the mt76_phy->txpower_cur is never set, like in the case of other chipsets like mt7603, mt7615, etc. The driver is correctly calculating the TX power adjustment based on the number of antennas. However, the base TX power (phy->txpower_cur) is not being properly initialized or set to a meaningful value. It's starting at 0, so the final result is just the antenna gain compensation divided by 2.

Signed-off-by: Razvan Grigore <razvan.grigore@vampirebyte.ro>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 13e58c328aff..9e8961533fd1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1251,6 +1251,8 @@ int mt7921_set_tx_sar_pwr(struct ieee80211_hw *hw,
 			  const struct cfg80211_sar_specs *sar)
 {
 	struct mt76_phy *mphy = hw->priv;
+	int tx_power;
+	struct mt76_power_limits limits_array;
 
 	if (sar) {
 		int err = mt76_init_sar_power(hw, sar);
@@ -1260,6 +1262,11 @@ int mt7921_set_tx_sar_pwr(struct ieee80211_hw *hw,
 	}
 	mt792x_init_acpi_sar_power(mt792x_hw_phy(hw), !sar);
 
+	tx_power = mt76_get_power_bound(mphy, hw->conf.power_level);
+	tx_power = mt76_get_rate_power_limits(mphy, mphy->chandef.chan,
+					      &limits_array, tx_power);
+	mphy->txpower_cur = tx_power;
+
 	return mt76_connac_mcu_set_rate_txpower(mphy);
 }
 
-- 
2.34.1


