Return-Path: <linux-wireless+bounces-11565-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E6895500E
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 19:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E74286EBB
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 17:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181D21C233A;
	Fri, 16 Aug 2024 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="HBB/lDm+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9A41BE24F
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829741; cv=none; b=ZFo4DlRVgho4zTNSJcPZEUz5Y798G7VZk8Yb3lOJrW5PZ7QOw7UooTnX+C3zFL25JhhODS6L2jpNUHLEx4RXYQJF2AS2WxAGM5QyaQvIYwvJFxKlSkfibx962tN7NAX+KfjIF+zWa1zj4NHyH5F1tnBHjDR7Uk+GEuzh7B89Kw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829741; c=relaxed/simple;
	bh=khgwVqU6ePQ9Rsax6Kp6zXV7/S8fc5PXcrNL7mU8yXU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8sFB5y3GMPQ8DCYTn9b2Mds0oMfw9jEEc1AtYaC//h5GNoxIVD5AjeUrQaqE5k7mrVtbmUzQchtWAfyEOVC5f8NooPJraLFjBRI4n0kFfM4A+6s+S+Bq0LlMwzOMcLI9b5m81h9t84vDbD6jIsBeFF1kSGQG7RXV8EHS1qLTeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=HBB/lDm+; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yXS4AA7Jmflfu5awFX7g0Xh/LpaKU68N7eoIa8leBDY=; b=HBB/lDm+szq13B4BYSfrqsTy6n
	W2LegXKRAOvKNGFgbH+DnHlxc11PiaTUJY5rRbR/FNMIis5XoSrkgCjuo/FeB0xMVNCE8KDSi8QsH
	bbnkUpjwM68JypT54qnKxPw0PRQNxDe1TIzPU+lmqwaeUWR8zyFfOiEUep9WbpQ7NNH0=;
Received: from p54ae95e7.dip0.t-ipconnect.de ([84.174.149.231] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sf0rR-000ObE-1T
	for linux-wireless@vger.kernel.org;
	Fri, 16 Aug 2024 19:35:37 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 07/16] wifi: mt76: mt7915: disable tx worker during tx BA session enable/disable
Date: Fri, 16 Aug 2024 19:35:20 +0200
Message-ID: <20240816173529.17873-7-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240816173529.17873-1-nbd@nbd.name>
References: <20240816173529.17873-1-nbd@nbd.name>
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
2.44.0


