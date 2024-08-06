Return-Path: <linux-wireless+bounces-11046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB962949B3F
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 00:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578D21F234AA
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 22:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B26171E64;
	Tue,  6 Aug 2024 22:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OuvuJ/Sb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C630516EB70
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 22:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982890; cv=none; b=S1NDxxog73IUDSDIj9hVHIV/LOeq5QR3RlNIIHPseJqBHDtwdFCN94dJEPRSye0p/BwcjHkokJOyDi6bbGEnSVJGIQ1YmZel22vPVkrMVzQuoMKmsxoP2pjzhPteInQo9kRJwkb8J+QPsEU/pHALRHVgg94AcQfxVhYwmeRb5Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982890; c=relaxed/simple;
	bh=v66udmK0rRGksUFuN16ixCVyNQ5EVz1XHUvq67tEUMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FKBVqArjmhI82ZkdqscrjJgUj0BQCcLWCbpiwxwrqpCKc6VVKQ/FajCpzR4VpK6bakBYzjjkO1+2DvBRXhJ+fZElcUm+VqjrpBGOZnS37oalXN/4gtNwSwWqgKLR/8HrlyCVmgksiKr64cuoXeS43xnG4CE6BReUw0XGOD0WSLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OuvuJ/Sb; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4f52bd5b555so188615e0c.1
        for <linux-wireless@vger.kernel.org>; Tue, 06 Aug 2024 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722982887; x=1723587687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QJXkpPUC6YxA/IHuLkQwK8On6NY8CUwc3hGpVUDqevI=;
        b=OuvuJ/SbYqgZEaowQzH3i4WP9CjYgNlhRyMgmqYmaw2c5TuCqjBQ+5sovlW9mMG3sc
         e5RRm3gR1w9CexrLZGR8J1ArkxEomXNzBHR2X9nC371msmFV7JxpTGHF8XMRPSyGPLkl
         ywaE6Xado2jQmuorAMqp1NuU1PPuntYEWs0FU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722982887; x=1723587687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJXkpPUC6YxA/IHuLkQwK8On6NY8CUwc3hGpVUDqevI=;
        b=HOWGgPB/JHBeLvUtQD6QPtBUaIpH9XxpKBlkVh4BdxN0NJzCRLl8fvDTVbEn96Ri4L
         Usym3mHWv1OCUaebq8SPd4L4WspUL50WVZNXn3vsVS4ZocVwjFxaEq3+E8Knej0Yrv7V
         oh0p7H0nbHfatThbU/EAy3fjZh3jaCd+Abkp8N5Jy4XbE2DsWzpUmMbtnwp1HhXrazwm
         oCGi5KepHk2q66bLcwzhL+yCdK1wNx7RZoObjL17NVaHirmdK8S/ulDZzGP+PGQpM8/b
         fh+7/L+Q40XWjI+B0R/VOWv2XXE79L/MmFrGs+RldobdhCvLkVg4q9D0hlkurrL5w/i0
         /dEQ==
X-Gm-Message-State: AOJu0Yz7whLIsK5h+m3iO/ZI7aYxsVISUudh5bAVxaaftTxLEaNI3r/K
	T5/cJHe8Nzbj+X0U0SioVBMxOphZPOy+zAQE+BfjIwTZu4957Vj8HEvNg6xRSQ==
X-Google-Smtp-Source: AGHT+IGDw1dquZEKngoVE3CxzATiloW2KmMWUKHN7gjHVVEVKfyVwAcup9CQeWcCvnV9aLa6uRvxHA==
X-Received: by 2002:a05:6122:549:b0:4f5:24e0:26d4 with SMTP id 71dfb90a1353d-4f8f54e6eb5mr159493e0c.1.1722982887651;
        Tue, 06 Aug 2024 15:21:27 -0700 (PDT)
Received: from localhost (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-4f8a1a396c2sm1378832e0c.6.2024.08.06.15.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 15:21:27 -0700 (PDT)
From: David Ruth <druth@chromium.org>
To: nbd@nbd.name,
	lorenzo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	timvp@chromium.org,
	sean.wang@mediatek.com,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	David Ruth <druth@chromium.org>
Subject: [PATCH] wifi: mt76: mt7921: Cancel scan work on unregister.
Date: Tue,  6 Aug 2024 22:21:13 +0000
Message-ID: <20240806222113.2689446-1-druth@chromium.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change cancels delayed work on the scan_work workqueue before
the workqueue is destroyed by the call to iee80211_unregister_hw in
mt76_unregister_device.

Without this change, if the device rapidly registered and
unregistered, work will attempt to execute on the workqueue after it
is destroyed.

Signed-off-by: David Ruth <druth@chromium.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c  | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index a7430216a80d..2c89bbccce4e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -42,7 +42,9 @@ static void mt7921e_unregister_device(struct mt792x_dev *dev)
 {
 	int i;
 	struct mt76_connac_pm *pm = &dev->pm;
+	struct mt792x_phy *phy = dev->mt76.phy->priv;
 
+	cancel_delayed_work_sync(&phy->scan_work);
 	cancel_work_sync(&dev->init_work);
 	mt76_unregister_device(&dev->mt76);
 	mt76_for_each_q_rx(&dev->mt76, i)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 004d942ee11a..1bcfb6944a1f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -41,7 +41,9 @@ static void mt7921s_txrx_worker(struct mt76_worker *w)
 static void mt7921s_unregister_device(struct mt792x_dev *dev)
 {
 	struct mt76_connac_pm *pm = &dev->pm;
+	struct mt792x_phy *phy = dev->mt76.phy->priv;
 
+	cancel_delayed_work_sync(&phy->scan_work);
 	cancel_work_sync(&dev->init_work);
 	mt76_unregister_device(&dev->mt76);
 	cancel_delayed_work_sync(&pm->ps_work);
-- 
2.46.0.rc2.264.g509ed76dc8-goog


