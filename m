Return-Path: <linux-wireless+bounces-27219-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C9BB51A97
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 16:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B80C582458
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 14:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74326329F24;
	Wed, 10 Sep 2025 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIKmwhDQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF0C329F23
	for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515232; cv=none; b=GqiYNTyDjy9jk/yahwtGwIscuFmeGdgDCkbWEPYGpOlxXpVOOr4EXsU8YEnOT/vPDi8i1sra7v8DNYtevnmkjnm48BNKcVQeCThuBwNLw1ZRTViBfGHVAMw9Rurc5/Oti7QB9rrlOvh0icMWcajx5EY8XsrKyJWnmAFrPsro8Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515232; c=relaxed/simple;
	bh=taUPWVbgxBMKNOUuvqW/XXyWoCI/+h6dzXA1uLqvJGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WThBCqIp/Q2+5QRJm5xHggDB28GRW8mgWDNHIJD4zlcgpOXRAmeQamdbB6AgqI9SHSAg08z7Awl9igpUklaLxf+8J9087gQ9NeWxfQY3/69Boe1dB67yRInpQwkGgFt/GbXKxI8UyHaU8mMltKn+VP5JuKgeudz3ikFMxIjdMgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIKmwhDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A29C4CEF9;
	Wed, 10 Sep 2025 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515232;
	bh=taUPWVbgxBMKNOUuvqW/XXyWoCI/+h6dzXA1uLqvJGk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iIKmwhDQuH6Y22e1S1IwR90PbM6YE1ekez584C73n7Th6peFPX6lar8wwSlb6bvtr
	 YTglKglegUbNnx5I29qFNUt8/JoFmkeD7pWYp97BB3wl4pYTRO1ZMPy6R7hrJKBE9A
	 0b67c1Jx4a13z0uWbK9DaatMgv9wOxHKoCMlkPP1shD6J5EbQIRnjjb+FgIQWmFov4
	 fcfpOJurPxZupwMQJYdfUqZU5xkMsL4sbtk7HSMkE1ijGaQpA4k1lIb1Vjkr/r4jOI
	 pzVaPbN+jiUvZ/Dm+R4LKSOxOnDeyCmzG+dVeadICLa/Wrf7mczOXhwLfO2p9kDFzY
	 WCTABe+A+wTHg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 10 Sep 2025 16:40:04 +0200
Subject: [PATCH mt76 3/5] wifi: mt76: Add the capability to set TX token
 start ID
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-mt76-npu-devel-v1-3-dbde4a37b9c0@kernel.org>
References: <20250910-mt76-npu-devel-v1-0-dbde4a37b9c0@kernel.org>
In-Reply-To: <20250910-mt76-npu-devel-v1-0-dbde4a37b9c0@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

This is a preliminary patch to enable traffic forward offloading via the
Airoha NPU module available on the Airoha EN7581 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 1 +
 drivers/net/wireless/mediatek/mt76/tx.c   | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index d14baea02c48b6c40cd9fc45178aa4eba3e297f1..1b5aa311b192d78660bf2e9649d890c4b8c4fa46 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -944,6 +944,7 @@ struct mt76_dev {
 	struct idr token;
 	u16 wed_token_count;
 	u16 token_count;
+	u16 token_start;
 	u16 token_size;
 
 	spinlock_t rx_token_lock;
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index e6cf16706667e783168dbd7fefe3254f0797ae67..823386e83cd004d5c8eaa256699cb543d8f1bc8c 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -846,8 +846,10 @@ int mt76_token_consume(struct mt76_dev *dev, struct mt76_txwi_cache **ptxwi)
 
 	spin_lock_bh(&dev->token_lock);
 
-	token = idr_alloc(&dev->token, *ptxwi, 0, dev->token_size, GFP_ATOMIC);
-	if (token >= 0)
+	token = idr_alloc(&dev->token, *ptxwi, dev->token_start,
+			  dev->token_start + dev->token_size,
+			  GFP_ATOMIC);
+	if (token >= dev->token_start)
 		dev->token_count++;
 
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED

-- 
2.51.0


