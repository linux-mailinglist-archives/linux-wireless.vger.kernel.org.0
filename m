Return-Path: <linux-wireless+bounces-11575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B58E495506C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 19:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E499B25A0A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 17:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8A01C37B0;
	Fri, 16 Aug 2024 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="oIVjJUD6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B1A1BDAA0
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723831051; cv=none; b=S4B8bjf3IU5WvaCmpypzj1JAoWa1l9FAQXJ+Hzi+9Y5zsruM4PB8/SF/nXgLN81OcuYdX9k415Z6pom57wUSEYRoYZ5l0QdYTmr7fn9zcJ6zdsQ5gJ1GRLvuhv5ErtqDoAUbvB7mRPZ2Vx0sRYlkzvPwgCwHCGifj002o/sBJxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723831051; c=relaxed/simple;
	bh=l6ebDcsGLpXFRif8SXSlTkTuiF36QUryJS5Oxws0ptM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jds1sfhStBkvMuxFpWn4YVtAWYAA7aYCFU+54fsRQ92D7PCt+1lKlSKVZjUa+73BZ9CD2HRZ8/hwB6Kt5C1KK3vNpsUwb6FJK/+QLVmvurXC8mhuqfkCYSuIMTs4jsgCOb7tW8VfACvj7q+DbggQHys2CsD1clSyJsEbn6pVqXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=oIVjJUD6; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MyhIFIFAr46RAOhYeuvwMB/22lhvbrkZtGrKBh6Cb/I=; b=oIVjJUD6pjuTpJRy3LlG1ML1dz
	uprlCYNQ0p1OCDjXDazPUTcyV+4ydW5O4tLuZbSAa/ELHI0cf2pku2cgCqusbMJ6bFYxVCI/CpOgV
	78+ZTq+HNsP8w1mO9YoGBq4HGP9p/aEBiNAhpAHsZkg7jTsoJ4WEMJPqBw8kRb8qp6O8=;
Received: from p54ae95e7.dip0.t-ipconnect.de ([84.174.149.231] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sf0rS-000ObE-39
	for linux-wireless@vger.kernel.org;
	Fri, 16 Aug 2024 19:35:39 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 13/16] wifi: mt76: mt7915: set MT76_MCU_RESET early in mt7915_mac_full_reset
Date: Fri, 16 Aug 2024 19:35:26 +0200
Message-ID: <20240816173529.17873-13-nbd@nbd.name>
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

This avoids running into unnecessary timeouts waiting for MCU responses

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 8008ce3fa6c7..dcec27be5a40 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1448,6 +1448,7 @@ mt7915_mac_full_reset(struct mt7915_dev *dev)
 
 	dev->recovery.hw_full_reset = true;
 
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
 	ieee80211_stop_queues(mt76_hw(dev));
 	if (ext_phy)
-- 
2.44.0


