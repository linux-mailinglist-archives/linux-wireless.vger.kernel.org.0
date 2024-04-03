Return-Path: <linux-wireless+bounces-5806-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5704896D63
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 12:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B8D1C21FDA
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 10:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272D51411ED;
	Wed,  3 Apr 2024 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="i+bLgv9f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92D413A417
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141740; cv=none; b=jcKBgFR005k4vEqV3EtUbE1obghItdIZnTCFMPUDYuEKyx7wNbEP4uLfEHOoN5yhW2sihWnn9AME2gbKL4FJMbZgtgiq/J5FuN0koJEMKk/PwwjJr48mf/EhmjM+SbUufMZv7LczjBaztTf8pLYsboUcPAGdYvVtn36OWu3nz70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141740; c=relaxed/simple;
	bh=6ngwvnQar5wN+RcfdQ4roBn4TC4oLkrRkokmvaenSSM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMROUvG5G3kaoT7NL8yLm/kycyE5skVO3VP5jZWoiDuHd+V/qo9HQmCYJC3L1IEmF2BA5NrHjSxqZpQv6070DXhbQ7UUhXECCq+9Eh8nivsAr/UxvZRvqt03SeQH5CbubpF1x1BqWC+ik7bF0tQkYmbNqP6Ziy5Yi6zrsHumPPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=i+bLgv9f; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3cOK1xU4jM0e3YH2B3fx/aZ6qPfgBhRzi3ZbWHZeSlM=; b=i+bLgv9f8c2aENxwzbApFsr75j
	m/X3xW2HS8UKKRCgNrD2pO0pGJWCapyd6+OKvWdkT6ZzY1p687r7+M6kHT9qss9q5ErHI2OPc0nKj
	A18iDHL/aeQBLj2qgkcVuQnV1rld3P2Mq7zUm/lmJgHXFy8EVM5QW7OC8bIKhe/VHbyc=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rrxt3-00CgfA-Vt
	for linux-wireless@vger.kernel.org; Wed, 03 Apr 2024 12:30:34 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 08/13] wifi: mt76: mt7996: only set MT76_MCU_RESET for the main phy
Date: Wed,  3 Apr 2024 12:30:27 +0200
Message-ID: <20240403103032.54823-8-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403103032.54823-1-nbd@nbd.name>
References: <20240403103032.54823-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT76_MCU_RESET flag is only read on the main phy.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 0384fb059ddf..bc7111a71f98 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1655,14 +1655,10 @@ mt7996_mac_restart(struct mt7996_dev *dev)
 	set_bit(MT76_RESET, &dev->mphy.state);
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
-	if (phy2) {
+	if (phy2)
 		set_bit(MT76_RESET, &phy2->mt76->state);
-		set_bit(MT76_MCU_RESET, &phy2->mt76->state);
-	}
-	if (phy3) {
+	if (phy3)
 		set_bit(MT76_RESET, &phy3->mt76->state);
-		set_bit(MT76_MCU_RESET, &phy3->mt76->state);
-	}
 
 	/* lock/unlock all queues to ensure that no tx is pending */
 	mt76_txq_schedule_all(&dev->mphy);
-- 
2.43.0


