Return-Path: <linux-wireless+bounces-21680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E75E9A92D4D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 00:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131D8171AA5
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 22:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B972144B9;
	Thu, 17 Apr 2025 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="A3bMACpV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0C020FAA4;
	Thu, 17 Apr 2025 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744929436; cv=none; b=WcE3I0dfb/XewB6Z6oKkZYRH1KiYpECR+zyumM7GfCCVV78pdIFv7Ah35qMJuHnUauCHIo4RQK/fN/VIsu4VPnig3Ch4FrJoo27dmnFnpgps6BgC6vyoXINKvGeeGR9r2mE90jXYJftgWRXAybHeECpDvMoT4wcCXiExpwMZxW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744929436; c=relaxed/simple;
	bh=0C1IbJciboKJBLSmDSL2zFC6VQpBwexg4CkdM4KE5v4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uhlqRurXOmp8ttKP4VmbNm74z7WvLH9HLTYGej8XCkSsKeUSAmFxqbJ+CVxvAomwHeumXKq5OC2yNa/ooDl5CP5i0r2ANw50sFAT9nRFxY7ezZNHReOj5lc6OEbYevnQo9vCywv216x36xSp3V17CfKDXj1TTqzN/uMMl7pzsIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=A3bMACpV; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 5XiQuDWqjETiN5XiTu2OP2; Fri, 18 Apr 2025 00:28:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1744928899;
	bh=s81pV5jIkn/GlgtQ08lcgCCxshbcpxyENaufyDqFoXU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=A3bMACpVFPDO5ND/TN1ebf1eXSQbRYcajI4fSEkK2EuoyaXRJJCMQ0DKuRg2pLwbo
	 VS1SzNTDU/QGlLRK48q+hfy70nXkrjVOqvXJKy6cLUbuEmyYjeKVb4yZiNp4q4xI9z
	 b0dPos/V77rW4wUyHfKM78m5ODsUUU5X9kN0umDf6ayTHUVAoBfriVwuJe26uXzeSx
	 IUjLF5Hup2fcvgXBmGKCEY1Oslxt/Kb+scpWif99qpgTVtRXPtI6FNJkgekmY1blZT
	 Bj0fQxlre8TwyfBdis+sqsWCTNYZkwGVlZXi4+paEie7bjPRQMN1PR2mw+jQefOL/+
	 jJjypGAjhMriA==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 18 Apr 2025 00:28:19 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] wifi: mt76: Remove an unneeded local variable in mt76x02_dma_init()
Date: Fri, 18 Apr 2025 00:28:01 +0200
Message-ID: <e86d5602bdd8b6bd22258ee69536992f39470bf5.1744928865.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove 't' which is unneeded since commit f3950a414143 ("mt76: set
txwi_size according to the driver value")

This slightly simplifies the code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index a82c75ba26e6..a683d53c7ceb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -174,7 +174,6 @@ static int mt76x02_poll_tx(struct napi_struct *napi, int budget)
 
 int mt76x02_dma_init(struct mt76x02_dev *dev)
 {
-	struct mt76_txwi_cache __maybe_unused *t;
 	int i, ret, fifo_size;
 	struct mt76_queue *q;
 	void *status_fifo;
-- 
2.49.0


