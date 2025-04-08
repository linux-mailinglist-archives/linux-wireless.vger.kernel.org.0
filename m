Return-Path: <linux-wireless+bounces-21276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 784BEA81444
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 20:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC084A6B05
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 18:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5EB23CF0B;
	Tue,  8 Apr 2025 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC617HC6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E030155398;
	Tue,  8 Apr 2025 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744135727; cv=none; b=gk3EH1FExJi1DwBF8vN9D85oAnhwZzO6UA9P65B74ljGB+0Om30hLntBhXa0EOo+TvaZSXhLy8clrpMDTxHwp3vUGc9xaF7xObDB5/TR537HAKq6Kp5y0roxg5Sl+GZCFBdKI51UAfDDvf+G8WW8AB9GBjwp8vIBc0oEYQfRnTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744135727; c=relaxed/simple;
	bh=JYyPCCShCHfqLDYAr7Vse/ZmJyZOdOWrV3Z1YVZd7hM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ssh1eZsjWknfsfzxA2BlawK28XTWRdzmQ6R0lgmOGdaQhN9+upLQ2wpD5fIXm2HWYX+UmkwESXq7XdOboFoGVZbhCLigr5Pz6VstegXHW6QVFhmq83gsdrS1w+tZsj88iTKbfxgOqaa8NNtSZaujlTjqrsoHxqhGRPpA1dnCwJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eC617HC6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso39787985e9.2;
        Tue, 08 Apr 2025 11:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744135724; x=1744740524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KrpT+jmLuV0pMig4xoM27D18t14gkY3tPjFQzNc4T6g=;
        b=eC617HC6sbyP9aeKBqkHec3/F71cHGBDl36D+Bb4EG7HsYO3Z7RB3E/ajdF9HRwQAv
         ed7jJEVF+didJKIUFvZOBm85KX+1Kv7FW+qJ+eUgjtcv7+6HkpNSYcrKqn54aT5xMDLa
         PNPZBDhVAl+AvREaU9woJRr+WTsLPhhGOCtCYz6pQ7fWw9mzNg8LoTuLTM1hd71WUWod
         RC2GDsmShOQG9HB1uo8NbLkmYmnPym737ncB8Vq+LDveD02aJn6TO5tjsZG5rMOpmHqM
         gNuIYawXUOK5CZ/uAnapYnAhbD5IIFODpBGEnrm3tRK27UQDbuiOrH0bNjdhdSgnoVE0
         RVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744135724; x=1744740524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KrpT+jmLuV0pMig4xoM27D18t14gkY3tPjFQzNc4T6g=;
        b=BYBl06OIIq7ZZb5atahJVbK12hZ6Sk1o/8MZ2Kb44QvzuDncaHylUNufFGEoufTInz
         5CIE4Vpodv5VQyOqZV1xXeYWb5+BGu4p3znI59Xh0X7fr7DeAS3ojBZ45ceCtI+rVLgP
         FRQt4lFiDmBuSS/K+i+8L7Se3MbxEkvcxJ5LEKtAAQJGukHkjUj4eWsGq/RECnOFdUb0
         hNqpWaSN8csNCl2SCwLOnJZyLwQv1lj2RzIbhVvxNWqlbLEzD6HbwKr84dcPqz5s+wMq
         IcaT0P0dYmi7Edcex7qjJCYYAQWMtc+ikCR0QWpicWbsnhOGOetfa+ziccEs9RK1f5Yu
         2a3A==
X-Forwarded-Encrypted: i=1; AJvYcCXrepi2gEtfrb9cqZxU/FA0h3UTJF3WZvlc1+A1ZVJs+rfnp+6yOGHjnYIeeJhLmgQuM8rEP7sNv4qNwXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1gzf0dr0GO4EjJP1+zNzF5E+LPuSTfpK9Bl04Ej33V0dEUMQo
	fYlq5tc94YO61d7/hxsrGXI+EaE7ky/MFBE9u57awTlxv+EeLsib
X-Gm-Gg: ASbGncvhEzFMLKAd4bxcwcYI4h5jL/MRQ3vYw5D5qEFe+HqP35BAU1A6g7z52ifm7CB
	wDPsTQbsT0CHF6qmkbsrvVGrbUkcSgiX8PezxUFinum2eyN0nK3VazN96CSZ7/PsniQQpMwF2Qe
	8z9JEMBDbRWZTA3SchF7Wk0S2SxEDL+rMT3lLahNpmZQQ2x0R1F/77qaWNxfJHih3Otq5H+ii05
	LTmo0RBxD3qH2OvepDeDqAy09ZcTzlT125vE7CnwaeTn7F9Iajd5UVX9UUffbg3W8/Bkmw4iy1X
	J8nzbGeuOSE+tT0IQMxTsvG38ENQjPDGlOrtawFla7IttUeDitOQPsWd
X-Google-Smtp-Source: AGHT+IGyH8xe4Xn7pdARQCUYSDd+37MKMCz08gGeVjeUKpJyPaAluAtZl33+vtBRvWnulgqkjovgyQ==
X-Received: by 2002:a05:600c:5104:b0:43d:ed:ad07 with SMTP id 5b1f17b1804b1-43f1ed671edmr789965e9.29.1744135724433;
        Tue, 08 Apr 2025 11:08:44 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:5b45:5642:beb0:688f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226dfesm15864058f8f.97.2025.04.08.11.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 11:08:44 -0700 (PDT)
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
Subject: [PATCH RESEND] wifi: mt76: mt7996: avoid NULL pointer dereference in mt7996_set_monitor()
Date: Tue,  8 Apr 2025 19:08:39 +0100
Message-Id: <20250408180839.19997-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function mt7996_set_monitor() dereferences phy before 
the NULL sanity check.

Fix this to avoid NULL pointer dereference by moving the 
dereference after the check.

Fixes: 69d54ce7491d ("wifi: mt76: mt7996: switch to single multi-radio wiphy")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 91c64e3a0860..66575698aef1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -414,11 +414,13 @@ static void mt7996_phy_set_rxfilter(struct mt7996_phy *phy)
 
 static void mt7996_set_monitor(struct mt7996_phy *phy, bool enabled)
 {
-	struct mt7996_dev *dev = phy->dev;
+	struct mt7996_dev *dev;
 
 	if (!phy)
 		return;
 
+	dev = phy->dev;
+	
 	if (enabled == !(phy->rxfilter & MT_WF_RFCR_DROP_OTHER_UC))
 		return;
 
-- 
2.39.5


