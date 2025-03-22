Return-Path: <linux-wireless+bounces-20694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B6AA6C9E1
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 12:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E30D3A50C8
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 11:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981FA1F1932;
	Sat, 22 Mar 2025 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWCVK69p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33C513CA97;
	Sat, 22 Mar 2025 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742642089; cv=none; b=t8+a6YRYT3ZlJwELRkFjUJTydZiiaqEPf/STMiJrcuo/+W5WgPLuOuS0yeq7h7FCCapAgq7kWFA12BEV9JkryM6Cu/XkEw4AzvjdeqxqZiJ9CZhT/J/FjczJA+pUztu2iKA1O/mYI36wAqj3Bzz9z9823EHGtZoCD6gHWo6RiD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742642089; c=relaxed/simple;
	bh=WkJ8XS18rE5C0eRyAl8hfeBNNEHeDURwT6xhMR8HWTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bvVbDwi9FD3hT4gBz8M5zwCgZhgFkh/JYHi3pB9Q+LkF2aPYlwyqCjLYH8aIemA0Tw+6kmgcksQ9j0e1I2tnD1bzbr0AF8gvsg1erT0jcHEg9aV8+ZGXxP8TOs1Q16xBrIewbT5hMKYWjcXcOMzTetbnYgaZ5lEMIXaLucguCog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWCVK69p; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so30005665e9.3;
        Sat, 22 Mar 2025 04:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742642086; x=1743246886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YcOUVWVG1AAUU/kF4IJvSl+9zDVrwqBtFVUW2rq0rjY=;
        b=KWCVK69pbkld2tCAWyex2ruwQ79QHOeTQ3+CETgGiYJr28Dp+X57/sbLkNEr1Iw3qs
         C3HEs6fFIBsyfr4QuW4CUD2c7Y+rgN6M0dVL0oqemJ1RD4cg9OAfDDx6/39zcU6W/nJ+
         WXT7FktTSwMQGxhoYNG01ZSb6Kz5vqDNmo/LVpR/hXEcsJWN1IaNfv4DnXzUcPSmr5BN
         mQqU5Pl0plxxm1/1SlAhgHSpQz5N+nyY3SiTJhHMm6sIl0vEsVQFNC3UM/g4rxOb1X6U
         ghB2zz505hkL98o8od9V9EdO6TVz3cOo3ypMpH1Chv8Gskg0MZwKaEU9LNVQ3ofrbFQT
         1Gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742642086; x=1743246886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YcOUVWVG1AAUU/kF4IJvSl+9zDVrwqBtFVUW2rq0rjY=;
        b=v2u9hjLLzwwWBEH+z/sXfDIvXOC0GKBy0tlk/KBWp/JIn2mwvu7TSPpAyEeU6ZhU7m
         fCymFNmwan38jxn6b/JL6Z/V0Y57j08K/AbL8AEpmsY2XDRUhV1O5mlk62gJ6PjsGe5s
         +5gKk0i58/RTgihAXOUPaP2XSjQaLlxohMNzxTnBGSjIH33Vga6eA7feELH5irOaGGhU
         lYaSCMfGrXRb0Nc3iIWbnTZtzP/UN9ZtGxs/w/IwLcgBFu9tiwA+ojDqB1Wy4yMqmC+G
         thNWxwaYQc4wc0SJfooWjFOZrF2z9VtqQqi5WpZ7VcAP4a6lTTr5ZuEu7Q7HBoVbrbQM
         g0OA==
X-Forwarded-Encrypted: i=1; AJvYcCU92HFRwDjjEHe4ueXJIGjTaEXux1BhbnW3hqz3aWVahwl5USKSyUgycYvTw+ZSC6E75l6wvSBzyFBVPyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNj1WSy5UBHWxjmXiNDN5g2TSKJmIMMhzqOBmlm1jZUsk3ohJZ
	dDhcGNyAgURKKfOK9lsor39M/hipyBjTJPBHOUT+iBgW7Q+Ebq1z
X-Gm-Gg: ASbGncush78PWUpOwenrRJQeMcdi+fPlY/oMJV397mDHkjhik0jXjJPJqvjvEBSkvz/
	aGv7aZKW0rxbZh1Acy7G4NKdavBPEt1OcMnMXqsU96P7RMbZSgnwKlA2dHQcWTzKnZGzx7kqAQm
	rLKk8w9lWP1w6+n5HDGp7RIX/CnM3f0+MOk1c5q5M+AuLpcqeR8mhe/XhVJpZaDhNK6rOlChjDX
	6KYPPItm89BYr4D75F73BBO5Hjg0z3+k1ik0yVI9gznxeDVm4sXYaMCdBB91mW12uVIkMd5RhSR
	5h067XJ0OcBrcXj2LGvjRwDrsmQcTkba+isOhRU7CDcKww==
X-Google-Smtp-Source: AGHT+IGchg9n8/yPP0SuJTfuLDSM/w6Y3EW2Ar6OGCb2DW0i/FHZMr4cygIiMlkLddfSwZStNNvPnQ==
X-Received: by 2002:a05:6000:2cd:b0:391:412b:e22b with SMTP id ffacd0b85a97d-3997f903a95mr6587111f8f.18.1742642085903;
        Sat, 22 Mar 2025 04:14:45 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:924e:a190:c73a:b6bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9eff79sm4906628f8f.95.2025.03.22.04.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 04:14:45 -0700 (PDT)
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
Subject: [PATCH] wifi: mt76: mt7996: avoid null deref in mt7996_stop_phy()
Date: Sat, 22 Mar 2025 11:13:54 +0000
Message-Id: <20250322111354.23800-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mt7996_stop_phy() the mt7996_phy structure is 
dereferenced before the null sanity check which could 
lead to a null deref.

Fix by moving the dereference operation after the 
sanity check.

Fixes: 69d54ce7491d ("wifi: mt76: mt7996: switch to single multi-radio wiphy")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 66575698aef1..88e013577c0d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -68,11 +68,13 @@ static int mt7996_start(struct ieee80211_hw *hw)
 
 static void mt7996_stop_phy(struct mt7996_phy *phy)
 {
-	struct mt7996_dev *dev = phy->dev;
+	struct mt7996_dev *dev;
 
 	if (!phy || !test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
 		return;
 
+	dev = phy->dev;
+
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
 	mutex_lock(&dev->mt76.mutex);
-- 
2.39.5


