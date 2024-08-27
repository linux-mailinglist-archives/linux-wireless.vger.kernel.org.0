Return-Path: <linux-wireless+bounces-12041-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70853960599
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 11:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAFB8B22DB8
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9E819D8A2;
	Tue, 27 Aug 2024 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="AtdfIEeM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE12713BAE4
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751024; cv=none; b=CXgxPK9ywgQUGMyLPg5uB/62UhkYEXKfAORfFyg6JkJXhnXlpJ0mG1ednzmNTUyrvonQ/0hqAFuAf50D0riQ4Dz5j74vL6C+2Cw7ICCTgUaHWw5R0MhSgM+CO6B1k3HNajb5isRY/o2svEd1/+6X64RFfwWLHm8H+USXqUE/4s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751024; c=relaxed/simple;
	bh=Hxr6xP5ZLYb4U5T0pFH2Mcmr2788ZnIyHHb54Cm1o24=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHoYs5LRUJipq/sNpjI2wnS268CRmdvpwYk6p24VTk+1OPdXGDCXiYbJUXsREA22Jije6vGR7NWMQlpwGiuUsTqJyTEPhiBv7h08I5w6+/vBloXB9McbyZ0t1aQQGUa/8oaNUAGlUuOHfnCehPjt5ZXx0hcTIJwhfQnOmA+iCbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=AtdfIEeM; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7uGSrdo1hzeHNs4Iw1DBEPNqG/sXW5MvKA16zQYyQ9E=; b=AtdfIEeMMqpgJpO4XbbCyaCSDW
	cGlG/PvWhJe/bdASCCf68RQi1/XkppQSkPevXOITXeOQrDgNApfI0KjeMXxjcbKfLC/vrCm8AWhhP
	dc3WgYTU7vEfVaFk5fW9s5YB1scFx+KdC37wSsU1bIYftl7KiorbI2UZGORnSK2GdUXE=;
Received: from p57a6f9a5.dip0.t-ipconnect.de ([87.166.249.165] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sisWj-004Ww8-2O
	for linux-wireless@vger.kernel.org;
	Tue, 27 Aug 2024 11:30:13 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 02/24] wifi: mt76: mt7603: fix reading target power from eeprom
Date: Tue, 27 Aug 2024 11:29:49 +0200
Message-ID: <20240827093011.18621-2-nbd@nbd.name>
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
2.46.0


