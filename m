Return-Path: <linux-wireless+bounces-20700-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA4FA6CA85
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 15:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02CD4811FF
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 14:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053B01D5CD4;
	Sat, 22 Mar 2025 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaAOGJnR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49727BE5E;
	Sat, 22 Mar 2025 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742653168; cv=none; b=MOAD1HbgLRwC5KhIC2s8CTr4Nkn1odawr7nLe+3JJT4m/uODnEMeRihqazRXQIDUJmTUxBrQRLBx/x8ZDlc5VaVZ2yMcvVScd30lBTZ0YpeaP1UwbRUk6bDxlwKdCwWVbCBcXvlulKj4Qb6vplnz6tRjB9nxfJ+dHs9drY46++k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742653168; c=relaxed/simple;
	bh=e7A5gAVyAWGlOLtYk66PZB1lgKiQZfDK5xM+JvmHXDg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m7k8wijWVPujClI7O8S1OMNS8v191RCQTvtblpHWhZ49Q5hqiMZkYrxerU8SL22W32tDWtDSy61jrksrLZeEDP4gZAAOzQk1m24GxWtG7FCODyDwUnzxhnVj2NsL7406zqOWzsIrKBAWfjlhjshgUmx+X4BJVtxlZ/ZqmGr1R5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaAOGJnR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so25618405e9.1;
        Sat, 22 Mar 2025 07:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742653165; x=1743257965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aF+lshiTJwsEbYCiQIvW3LTB1kytaT25WY+mnoTd02w=;
        b=MaAOGJnR9aoomyKDyANoAxKaMo3eBALd7vVSTo4HmHn8RHSz2wzJQ+uKKYUm0G31HE
         Q30br9P2dB9HZkV6g7RYo6OH5XpK1fEdpivgywfPQ54BfI5iR7XdjXfVko9+TB9ra+60
         mf6/4WRMYiavxY/WTqXTS84az84ftq9x1tiTvCfYRxTH4oBUGvA1PKv8elpGBvQ6UPha
         ntU59RpdZiKRU0XzKFF7j0PoAZpcah/+XVzoKwWf8y5V9G9k60kqHQhyrEQsovQubzeL
         SJ+9eICpinv4PE67ZB0liwe2NwsKu8BPbx+nSTAXww6lJhE7jxWH+QnNZ9Fu6o+jICAz
         d6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742653165; x=1743257965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aF+lshiTJwsEbYCiQIvW3LTB1kytaT25WY+mnoTd02w=;
        b=sGx3hDHJQHvWvcvGSX810qtf+RBx/Hm/J4E1iVvSqwMX6I5K+eYpUVSUYS2+rhXOpp
         jCXa5ZwvG1eqI3itgIj3+L/XKnP2Zka2VrljyL8N46b3ALtInEfI19MF3HZoJnpWIpv+
         38kecjZnjGvk7Jgat4pg6k2yd2wIzXuRGvXR/+1F2CRtfK5M0aS3bXIm3YrBw9DTDHAI
         guUbrxfxBwPnJex9qgPoyNt50CPSQfsiyr4T0DKPJUk94SEYRD8ZYMk/v13tV0vWN8Ax
         tVXc5UkS+iaFnRDHS75bjb6XfYLWaTJba8j1War6q5sy8JirYbw729bnN/90A8qGm6jY
         NoNw==
X-Forwarded-Encrypted: i=1; AJvYcCWsORsPlRdGWrXFC9l2HXzJDZLFD978jp7nSEMfB3mPKXpJy/JkUtvVEKoiuVZIzP2dldAKaxZKQwf2K5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGogGNisqMzMTymJrCJckQfxGNhznL7kVJoDgTJhf7MkOFsuGm
	5ZiHXJq8DZgLoM6U2PNQfJYM6Y5YL5MCGzrlJXtl6s/BILSWdhSw
X-Gm-Gg: ASbGncvaMdCTez+LMM6ZvtdkFGjBZKO0KucqUwDhVf0KqUB9sJ8r5qFjakkSTwffUZs
	Z+Qy/pKfJ06cmu6VX9oKhBn2bIwIQLSlRYJ0t0nLn69YEToF11olcgDc4xRrRLx3OyTlWzNN1ip
	dYcWbDs6peRygwSok9XEF8ApTRu39OFo413xTKSm6hmcdoxUD+qKKEmWYwfpmCES33uLaIzevII
	wKat8PO394sZGrN6ZnWxNBK69awnDkpAX4+en0UFC9/Cy9y/fBoAe3dSgH3/5fQSHGKxli8W8Av
	2CJSYvB540L+bX/s9FVXquabtkDosM3BG41daLZwxNSc8z5VuatxIw6/
X-Google-Smtp-Source: AGHT+IESFJJXx1OaHEDpiDrDpp/1v/90T162quMXGMiu0ErBsYhKB7IcQbevvYKVQEpCP+boy7enFQ==
X-Received: by 2002:a5d:5989:0:b0:38a:4184:14ec with SMTP id ffacd0b85a97d-3997f8f7526mr6944813f8f.1.1742653165247;
        Sat, 22 Mar 2025 07:19:25 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:c9a5:205c:4c36:bde4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e6550sm5233487f8f.78.2025.03.22.07.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 07:19:24 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chui-hao.chiu@mediatek.com,
	Bo.Jiao@mediatek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] wifi: mt76: mt7996: avoid potential null deref in mt7996_get_et_stats()
Date: Sat, 22 Mar 2025 14:19:10 +0000
Message-Id: <20250322141910.4461-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure phy->mib is only accessed after the null sanity check for phy
otherwise the code may trigger a potential null deref.

Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 88e013577c0d..19391966ee3e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1875,7 +1875,7 @@ void mt7996_get_et_stats(struct ieee80211_hw *hw,
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_phy *phy = mt7996_vif_link_phy(&mvif->deflink);
-	struct mt76_mib_stats *mib = &phy->mib;
+	struct mt76_mib_stats *mib;
 	struct mt76_ethtool_worker_info wi = {
 		.data = data,
 		.idx = mvif->deflink.mt76.idx,
@@ -1886,6 +1886,8 @@ void mt7996_get_et_stats(struct ieee80211_hw *hw,
 	if (!phy)
 		return;
 
+	mib = &phy->mib;
+	
 	mutex_lock(&dev->mt76.mutex);
 
 	mt7996_mac_update_stats(phy);
-- 
2.39.5


