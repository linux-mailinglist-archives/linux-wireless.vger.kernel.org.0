Return-Path: <linux-wireless+bounces-12049-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA980960653
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 11:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8135F1F2209F
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139411946CC;
	Tue, 27 Aug 2024 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="nP6wtNwr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7F619B3EC
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752515; cv=none; b=jknsVBtHT0ScJvfkoSQ/pyS/8rtIoEafxl3oq3UfvOs2VVxrSKP9vc6qXjzSGamkw1Pqi8KMvoO02NXGBb6CG++vXdBgINxHJfsUw1cCeuqFnzHC/1+MUwMfuEbY0ujqgCiBBqCc7ZPSuPstnztCKqUbvSZ3ojjj1Mla4vMPNPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752515; c=relaxed/simple;
	bh=rYTd8WY34zAcE0evWwICpcbvzDMdc+3ziNuB5x2SKwY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OysID7DKsV48DAmO/RUzKQLE2GPIxOPeVZsMswMDv6OkI2RLgHV6c73sypmAhzt+CgzBARL1flwLfO4gsk9STClUZ54rUI1+h6cvnwssyjtYfereZNG6MN77A2Fk75mbZCirwnecRJC8vdGkvouhYI9z+QmKHJ0tIYYgeDby9ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=nP6wtNwr; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Umue7Dcz7MuPAF8dg/gOOkkrgwuf7AEE/+j++zCC+iM=; b=nP6wtNwrDgmlyW7Z09q7BN6BsC
	DhnlfVqyflq83dM9cgHIo2tIfhaOep+9E7aFcamiLJQ7JY98YfILQRziGeIIFSSmpFKzuxa0t9MvJ
	KIdzM+6r1P2tFNipOcNBaEpJ8OXuHd4TQGkIEID5oe2v9tVmJQk3o26aagmYOBIM4VoM=;
Received: from p57a6f9a5.dip0.t-ipconnect.de ([87.166.249.165] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sisWo-004Ww8-2F
	for linux-wireless@vger.kernel.org;
	Tue, 27 Aug 2024 11:30:18 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 24/24] wifi: mt76: mt7915: avoid long MCU command timeouts during SER
Date: Tue, 27 Aug 2024 11:30:11 +0200
Message-ID: <20240827093011.18621-24-nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827093011.18621-1-nbd@nbd.name>
References: <20240827093011.18621-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Immediately abort MCU commands when firmware requests DMA restart.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 54974ff72a5b..cf77ce0c8759 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1696,6 +1696,11 @@ void mt7915_reset(struct mt7915_dev *dev)
 		return;
 	}
 
+	if ((READ_ONCE(dev->recovery.state) & MT_MCU_CMD_STOP_DMA)) {
+		set_bit(MT76_MCU_RESET, &dev->mphy.state);
+		wake_up(&dev->mt76.mcu.wait);
+	}
+
 	queue_work(dev->mt76.wq, &dev->reset_work);
 	wake_up(&dev->reset_wait);
 }
-- 
2.46.0


