Return-Path: <linux-wireless+bounces-5807-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA7B896D64
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 12:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1FB290C03
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 10:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8537013A417;
	Wed,  3 Apr 2024 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Gt/D9Fms"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065A5142E8A
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141743; cv=none; b=q+eBHCa9CDjSuo/J94jJ5ZtzyCL+zaJZrRJ6puQ+ngEwTsMfT8f3aruwBfZdw9utKO78Nup3I9IuEgXO5QYEcumwQJl7owF9yryUq7ia2DDM9Nac4eYdPsfKp6P2o0CdL144gaHA/mh2DtAzlAFYfJrt4ErtrWGkFNVbsh+wkSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141743; c=relaxed/simple;
	bh=5dBdiNKOmm4po87h+rgziAySNQ4EPLsqbsB8WlWlbEs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AU8KgE+tJkusLFRv/gP6JwYoGwrdw8XZyDv4VY9wYThsHKgIYHvzQbYXkFVm3encGJFKzNBc2HMjzk5zs7sAjuzxAanoBeGCztQv4P+28pmflPAfy+P+Td+X/asvMD+50BIhXQkAgZasLQfUI7OcaRZ4V2X0xHDoHYqSqfp93sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Gt/D9Fms; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GyxHO4ruMaPrls/wcXYeFcQWGcFTuYmmPWxU0u28oy8=; b=Gt/D9FmsQk2xhjvb32C0F3qG4g
	djqWKHFvT4igKCQEOL6CJXUgfxroAy9NWGqj2GMk8dIKspqqg/MTDJ/MnbnqsenT2iSbtvOtaKXYJ
	rV3U/KShQ106DXq/zCJ5XsdfHnYx0kMQfVpenvbBzE1nfe1H5Noppx6GIvaAJi7i40h0=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rrxt4-00CgfA-Hr
	for linux-wireless@vger.kernel.org; Wed, 03 Apr 2024 12:30:34 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 11/13] wifi: mt76: mt7915: add fallback in case of missing precal data
Date: Wed,  3 Apr 2024 12:30:30 +0200
Message-ID: <20240403103032.54823-11-nbd@nbd.name>
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

When pre-calibration data is missing, do not fail the driver probe.
Instead, just print a warning and fall back to regular calibration.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/eeprom.c    | 15 ++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7915/init.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c  |  2 +-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 5fdcbb521ff7..bfdbc15abaa9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -28,7 +28,15 @@ static int mt7915_eeprom_load_precal(struct mt7915_dev *dev)
 	if (!ret)
 		return ret;
 
-	return mt76_get_of_data_from_nvmem(mdev, dev->cal, "precal", size);
+	ret = mt76_get_of_data_from_nvmem(mdev, dev->cal, "precal", size);
+	if (!ret)
+		return ret;
+
+	dev_warn(mdev->dev, "missing precal data, size=%d\n", size);
+	devm_kfree(mdev->dev, dev->cal);
+	dev->cal = NULL;
+
+	return ret;
 }
 
 static int mt7915_check_eeprom(struct mt7915_dev *dev)
@@ -254,10 +262,7 @@ int mt7915_eeprom_init(struct mt7915_dev *dev)
 			return ret;
 	}
 
-	ret = mt7915_eeprom_load_precal(dev);
-	if (ret)
-		return ret;
-
+	mt7915_eeprom_load_precal(dev);
 	mt7915_eeprom_parse_hw_cap(dev, &dev->phy);
 	memcpy(dev->mphy.macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
 	       ETH_ALEN);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index d9e391fbb4bf..a978f434dc5e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -823,7 +823,7 @@ mt7915_init_hardware(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 	if (ret < 0)
 		return ret;
 
-	if (dev->flash_mode) {
+	if (dev->cal) {
 		ret = mt7915_mcu_apply_group_cal(dev);
 		if (ret)
 			return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 49d5b459fb44..b16a63366907 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -329,7 +329,7 @@ int mt7915_set_channel(struct mt7915_phy *phy)
 
 	mt76_set_channel(phy->mt76);
 
-	if (dev->flash_mode) {
+	if (dev->cal) {
 		ret = mt7915_mcu_apply_tx_dpd(phy);
 		if (ret)
 			goto out;
-- 
2.43.0


