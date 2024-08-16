Return-Path: <linux-wireless+bounces-11567-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EF6955010
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 19:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AAD31F22A6D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 17:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051E11BCA1C;
	Fri, 16 Aug 2024 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="PN6LywC8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A5528FF
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829741; cv=none; b=TpFDwagBoNjWq102mwUehdT/pb4KRRiItz9Osicz46XlgYP/o8SStqChi4524qRNE3juCzO/Rq6Jpju+l0mFPa7J77zOZFCrIuVgMH0FBJuBmugwIEGboyQkzId9FVNHXVtXBk5lBEMknry4CSXY04WXbNbdAD+3C7y678viaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829741; c=relaxed/simple;
	bh=2LOV+1WzlZlL2XqqUwDZtO1qpBt+E2VgUCTGb+7JV3M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dncydtHcuAgWPxMeyWpi0yEt2L+7Lyb4hCLwCvuUiUM/40JgW4GAaqUYcbH7q2T9y9tlQrOvSVEDJbPu8PL3p/NH3lkJDU24v3iiX0GgppmsGbtzfc0F4Tw1uLRQRGR7kifxLXqYpQ0fB+EbHiWg3qLwWzfGM7UfGUt/xYC8tQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=PN6LywC8; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=IPOp5fyW+dLR8CGG0TNfuWJy6SMrZD7jpLSGrqgL4nU=; b=PN6LywC8uDWY/UgwuhzEUgC/WZ
	5/35scQo42rVbW6Vk9eEyZbgmDGyZE5FdC4DbNH8SNNQz4fIUVKqtM8iLJiAy4zkZpk675gLnMo60
	xov/ol0IQppJ7Ogh/CF5lntCpLrs2GhYcK33Na7VRQ4jgju1cAzIcXHrARvjmeKvctqk=;
Received: from p54ae95e7.dip0.t-ipconnect.de ([84.174.149.231] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sf0rQ-000ObE-0k
	for linux-wireless@vger.kernel.org;
	Fri, 16 Aug 2024 19:35:36 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 02/16] wifi: mt76: mt7603: fix reading target power from eeprom
Date: Fri, 16 Aug 2024 19:35:15 +0200
Message-ID: <20240816173529.17873-2-nbd@nbd.name>
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

If the ext-PA target power is unset, fall back to the standard EEPROM value.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/init.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 6c55c72f28a2..f84c9a06af75 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -456,11 +456,13 @@ mt7603_init_txpower(struct mt7603_dev *dev,
 	int target_power = eeprom[MT_EE_TX_POWER_0_START_2G + 2] & ~BIT(7);
 	u8 *rate_power = &eeprom[MT_EE_TX_POWER_CCK];
 	bool ext_pa = eeprom[MT_EE_NIC_CONF_0 + 1] & BIT(1);
+	u8 ext_pa_pwr;
 	int max_offset, cur_offset;
 	int i;
 
-	if (ext_pa && is_mt7603(dev))
-		target_power = eeprom[MT_EE_TX_POWER_TSSI_OFF] & ~BIT(7);
+	ext_pa_pwr = eeprom[MT_EE_TX_POWER_TSSI_OFF];
+	if (ext_pa && is_mt7603(dev) && ext_pa_pwr != 0 && ext_pa_pwr != 0xff)
+		target_power = ext_pa_pwr & ~BIT(7);
 
 	if (target_power & BIT(6))
 		target_power = -(target_power & GENMASK(5, 0));
-- 
2.44.0


