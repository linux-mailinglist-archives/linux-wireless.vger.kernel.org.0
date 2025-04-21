Return-Path: <linux-wireless+bounces-21786-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 444C4A95008
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 13:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 605BE169F4B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 11:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179B02627FC;
	Mon, 21 Apr 2025 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFRbZZ48"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502C9261370;
	Mon, 21 Apr 2025 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745234043; cv=none; b=C3ijyrtBH6t92GL9hLpRim2jwBaSfH/gYZLXF6w4c1BIkvKvAktSGqrlmf0KjW9O7oynhE6gUsHj8qg35QdfhjAGowaQ30js6aEko7oMfJ9fBrkpIGCP6/J17nJ0gCpYFcDEOobdBLsHdSBEKw9M/rFyIIdYg7cbKU0MK5IUOnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745234043; c=relaxed/simple;
	bh=WkJ8XS18rE5C0eRyAl8hfeBNNEHeDURwT6xhMR8HWTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IFsQbQkPA/PQJ2qw7u2sX032BIsmaFvHY8+jH/L9ZavMGkrRBjM0OVa81rRYIOiQO13+vy3cVKtjbc0/+K81JtqUKumhkHE7ZVs91+MN0dy+Uxgi43uQK+maIA8ZjKyz5hzlU2lgTQ9r2WjoL75LrS6IY12FVLwm8+UMN6zoEfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFRbZZ48; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so21775755e9.2;
        Mon, 21 Apr 2025 04:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745234038; x=1745838838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YcOUVWVG1AAUU/kF4IJvSl+9zDVrwqBtFVUW2rq0rjY=;
        b=JFRbZZ48JAHRSKkrLIITQNkhkmJ9OhPtWQYMFh+445BDH+nYsAlG2lfZllBO04hI8u
         SV3A0cV8pcVxIzcG4ksneQE+/FmDZFz9wJXUDfJ7DID7KPSxr2NP7DAxDbWsK/FPujUn
         j9yeU6zsVsJi+Qd/kTWRWKb1Ps0xtTNdF3EA6PnV9UqKTJme2hpBCc6KEjkdQ2vWEg5F
         73DvoRI1KTdvC7fk7dx+w4KFFxt1NrVP+K7cF881OuMgNvgOG3SHhmGw7XPhcQk6ymqs
         B6A3mqYQqIKnyIdlWoXwT6Fu4F1rcQxZVtpPOxO58PFGlA5Genwo431fWmtWiZ4P2eee
         IiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745234038; x=1745838838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YcOUVWVG1AAUU/kF4IJvSl+9zDVrwqBtFVUW2rq0rjY=;
        b=MO03iFcN0sIgWLq42B0LJ0HpcGp007etfOUjZuQAnZIRrl3j+EpGteZYY6tvvlJ8Jd
         vD6GE9HEvWrG9WJgYim4wAPkxzb6CC2gcdS11KiUL17XsE2VzIemUDVanF9Kq1wY3eEC
         xMBUHOnu1MfBjaz1fyFN3I7xBwxzxxn3TQhaYKUCoIJdVMVXZhIOxJKhvM7+sx3srFD6
         f9SEbPDV6L2tF+rPjy2Gi1JG+npOlwF5JXUt+wjv+XEWmaKKvvCEiuJl5pip97fnUe7Y
         QrirCMpCPGFrNmzHjGEXEBBx2uR+AKoIlfBbEdfEtbj3LwIoyyxp8P4fmlLYYlJsYLnU
         c2KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEK8HEr1lvTNBeyNjxBQhiV2kOcvCb1L0qidhu/7WP6gfaCgG1paHfpbSo4NGcscYGXzRo5oolFsWYYnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKf8aTxOuX4t9pVFmeiiKv4X7pkYZCgbpeeDa1xIl6+Ev9SJcY
	D6+rKDjEl8cDUUSS12nTAqRe84O/qNiRU3UWrCWiIWtmZU0SP6br
X-Gm-Gg: ASbGncsGnzrbGcpfldASw4eWzOG/hoBVCEukayREE4vYLipvdzi+hYt5FBnucRmQbh+
	309bOy5lTva0IZUcT3dJqskMojgJADym2+WiBZDrd4hQbdXJLzWcNnJnUPG4Z2m8g6PlrDpiyB1
	G9iIXCs3NlSjGBz6tFzqptg2ry9qID4Xu4mwCXigxgmm445gVDZITGZpWHks8WnMyETujwqU0/A
	3HqTdzbO8mwCE7B+6ayUrwEgU6YGSE+jfxkJ9HTG63icveJfzrGpOekR4eBRMAEtolpNDIhSG7A
	iWi5FTOyxaKcQnCuJOV4AH5tHMowdVKioMuomRdScAg3fo49vfMonAkMPyyCZoUcxw==
X-Google-Smtp-Source: AGHT+IGG5pvhTvxUXN9hKzMCBUViCI/TKQPbUz9Hd/bpbRnURHd9ELf6tKypqvzOgo2WE7hDsvf+gw==
X-Received: by 2002:a05:600c:358d:b0:43d:7588:6687 with SMTP id 5b1f17b1804b1-4406ab96945mr102781655e9.12.1745234038247;
        Mon, 21 Apr 2025 04:13:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:6696:8300:fc11:84a0:480d:20a0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4330d8sm11848418f8f.33.2025.04.21.04.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 04:13:57 -0700 (PDT)
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
Subject: [PATCH RESEND] wifi: mt76: mt7996: avoid null deref in mt7996_stop_phy()
Date: Mon, 21 Apr 2025 12:13:44 +0100
Message-Id: <20250421111344.11484-1-qasdev00@gmail.com>
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


