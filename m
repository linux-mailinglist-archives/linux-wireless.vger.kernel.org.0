Return-Path: <linux-wireless+bounces-12038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7BF960596
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 11:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C6C28478F
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFC019D08C;
	Tue, 27 Aug 2024 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="oI0ZhqbE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0CF7641E
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751024; cv=none; b=fRYStQH9OLqWahNZkx68sNV/KdLpOlmX5wGv3CR93sROhbYmxC1GLXcIJxdCFQ25/w7+cLQ7y1bFPGZdoK8Epn9x8ETvM8L6cYbucwoB0NZoNCYO3umQFg4HQDqaISPdhcHsNDjxZNGgdDGbv2+lSXFf/jofgQO/6Bxc8zS1ecw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751024; c=relaxed/simple;
	bh=xI2rwj1lf8VSFKA1jpsJ2XadJVnUyw3svHJOQtwkc30=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgHjc/4NIqHhJVwAUNv3IVdwwhcPn1gSeM0BzqAmZO2RS1tJbTAkxXM8ZV4++NDHYFAjjkBweoWLaX8h/+OPbTEwlftU15PKDuKJJP0OTiI9tGunHI+N4YyUpZrotmHex0UUN6A4Vx5NdZSABdPbAyH9wAfZ4fgl+r5uvkQuRX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=oI0ZhqbE; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4kbIclQ91zel2F0DJG0FsaAHDYkWeV6/ig3aWSY9/ME=; b=oI0ZhqbEbqnP577EaVgWe1SJDM
	tBcnnuf0Dcd5lMoGkxzt7gLhIYEJLGk/MK0itvibaFgl+6zXESJVbDUSiDDj5IMNr+w5d3ydOuwx3
	NszxGTUVWTCKkfoEjYV/DH8wvNBd9X6q7n1WIQnBzFAKmZKLz6L48HnGHuSY8J8U0WQs=;
Received: from p57a6f9a5.dip0.t-ipconnect.de ([87.166.249.165] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sisWj-004Ww8-36
	for linux-wireless@vger.kernel.org;
	Tue, 27 Aug 2024 11:30:14 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 03/24] wifi: mt76: mt7603: initialize chainmask
Date: Tue, 27 Aug 2024 11:29:50 +0200
Message-ID: <20240827093011.18621-3-nbd@nbd.name>
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

Fixes reported tx power by accounting for the combined output

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
index d951cb81df83..f5a6b03bc61d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
@@ -181,6 +181,7 @@ int mt7603_eeprom_init(struct mt7603_dev *dev)
 	    is_mt7688(dev))
 		dev->mphy.antenna_mask = 1;
 
+	dev->mphy.chainmask = dev->mphy.antenna_mask;
 	mt76_eeprom_override(&dev->mphy);
 
 	return 0;
-- 
2.46.0


