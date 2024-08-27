Return-Path: <linux-wireless+bounces-12039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DF1960597
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 11:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62B81C210FA
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C29719D89A;
	Tue, 27 Aug 2024 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Y0Mf/f3v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC1F19D067
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751024; cv=none; b=ouXwLlVV9pfvYshbkbH/qFE7fVQ270RJptYQSSC4BIdQuumYUzss8/jDpE2P0TDkKkFiYry9iiM1Fm6vDHFGH8V1nu0+Pr++HsAJ1Yoi1ESGur8Etc9d/8E0/brJU5gNYLkWeZeA7atnvHKQY/vFY8bBWJq0htKqN1d8VvH9jKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751024; c=relaxed/simple;
	bh=sZ1YSfDds+t5LOpbxktciuhUYF+XgU1lGA/P8x1O6oQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/ro5kSTXinxIevxKM0zNpJ3PfM3cHEmR8gxAlQLku0V9yFNoZJM/kKXLtjfOooMaxGluDcJ4RvUQxBNqzALBDVTr9bdsJetvMSELfqpdl00jTE4QH14GP0kBzQ5fxZt0Di+JD9hjGowhkLgDU65MFQGu2w221OZin5uUFdw4aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Y0Mf/f3v; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oNM4KgWf8nT8Ec1u4D961icXqT6BYIckcfRumMFQef4=; b=Y0Mf/f3vQgdTChnRuwjogtWe2W
	zP5Zm5BPIAt/jRbB6njCGivmfFEgQCJ/2ZZy99SAce59UtRx87pSzl7mVVRR2nLp7/qAfhHMpGQ5u
	lQItTj42YZu89RYxZNib7IHceL8uTAw2KInduXV0fgW1HNj8YbzmniZrqhn7P5i1sg0g=;
Received: from p57a6f9a5.dip0.t-ipconnect.de ([87.166.249.165] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sisWk-004Ww8-2l
	for linux-wireless@vger.kernel.org;
	Tue, 27 Aug 2024 11:30:14 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 07/24] wifi: mt76: mt7915: disable tx worker during tx BA session enable/disable
Date: Tue, 27 Aug 2024 11:29:54 +0200
Message-ID: <20240827093011.18621-7-nbd@nbd.name>
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

Avoids firmware race condition.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b2cad75eafb9..43f1a45b34ab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -690,13 +690,17 @@ int mt7915_mcu_add_tx_ba(struct mt7915_dev *dev,
 {
 	struct mt7915_sta *msta = (struct mt7915_sta *)params->sta->drv_priv;
 	struct mt7915_vif *mvif = msta->vif;
+	int ret;
 
+	mt76_worker_disable(&dev->mt76.tx_worker);
 	if (enable && !params->amsdu)
 		msta->wcid.amsdu = false;
+	ret = mt76_connac_mcu_sta_ba(&dev->mt76, &mvif->mt76, params,
+				     MCU_EXT_CMD(STA_REC_UPDATE),
+				     enable, true);
+	mt76_worker_enable(&dev->mt76.tx_worker);
 
-	return mt76_connac_mcu_sta_ba(&dev->mt76, &mvif->mt76, params,
-				      MCU_EXT_CMD(STA_REC_UPDATE),
-				      enable, true);
+	return ret;
 }
 
 int mt7915_mcu_add_rx_ba(struct mt7915_dev *dev,
-- 
2.46.0


