Return-Path: <linux-wireless+bounces-16914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 740EE9FEA64
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 20:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FAA61882FAD
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 19:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5004C19CC11;
	Mon, 30 Dec 2024 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Hfkwkh0o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B93118D656
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 19:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735587734; cv=none; b=I/Vj+48Uk5YOGokY6xcXQVbbejf+LMovVuctUDFwP0g7MbJ/qzSaeDTEsRrza4As9kP03M7HN+Y/gSoiC4FxoAGIj7TxqMa8LPnlcxDLzwOnAUQPaKEqvkn85R6HVxu9h0PXmYPPGIJ7b9rfrFR/tnslVAECujjTCd8ZgWlEr2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735587734; c=relaxed/simple;
	bh=0iYBlH8jBQQOpbu8wV6zhaNa2Ctv6fFilnklGBsNEO8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMTQIrnCvYwv1Mmb0f3IaVABUI2c/HEzCM3oiNl9VJFNPAUkmd4S6hH6i/2ZCduVvQjP80WVSuG1vazuifZoRVWDZs5NVulP80B9027RBjwaInN/5VhVAlnYs2eTG+D93mbX0gAsCiaXE9VqgzkJ8vbE1dy++gEI0U+bHgV2yQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Hfkwkh0o; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4gljNVcrUtbVBPH9EWnWBHtPp140L95VnmXvYGBzuxA=; b=Hfkwkh0o4ioT+vebykj6KiIOXG
	W7Utg0gJjkkE61wJZgXAGgr9uW3XmI3P1LlbLQo9fpQZcuRumPf9UJDUc5WZmmpMj9dXtjJoaP6hv
	NZtWy1av5noG5YygLiMXsWnlTdD/W+iz+gPrL/hRbKrE+H3exoNqLgA96keTJOhmY2Co=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tSLeT-00GKzc-1P
	for linux-wireless@vger.kernel.org;
	Mon, 30 Dec 2024 20:42:09 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 02/14] wifi: mt76: mt7996: remove phy->monitor_vif
Date: Mon, 30 Dec 2024 20:41:50 +0100
Message-ID: <20241230194202.95065-2-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230194202.95065-1-nbd@nbd.name>
References: <20241230194202.95065-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is unused

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 8 --------
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 2 --
 2 files changed, 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 2b34ae5e0cb5..eb2388f079d9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -188,10 +188,6 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 
 	mutex_lock(&dev->mt76.mutex);
 
-	if (vif->type == NL80211_IFTYPE_MONITOR &&
-	    is_zero_ether_addr(vif->addr))
-		phy->monitor_vif = vif;
-
 	mvif->mt76.idx = __ffs64(~dev->mt76.vif_mask);
 	if (mvif->mt76.idx >= mt7996_max_interface_num(dev)) {
 		ret = -ENOSPC;
@@ -270,10 +266,6 @@ static void mt7996_remove_interface(struct ieee80211_hw *hw,
 
 	mt7996_mcu_add_sta(dev, vif, NULL, false, false);
 	mt7996_mcu_add_bss_info(phy, vif, false);
-
-	if (vif == phy->monitor_vif)
-		phy->monitor_vif = NULL;
-
 	mt7996_mcu_add_dev_info(phy, vif, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 9aec97dd81d9..ad10329d6b44 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -246,8 +246,6 @@ struct mt7996_phy {
 
 	struct ieee80211_sband_iftype_data iftype[NUM_NL80211_BANDS][NUM_NL80211_IFTYPES];
 
-	struct ieee80211_vif *monitor_vif;
-
 	struct thermal_cooling_device *cdev;
 	u8 cdev_state;
 	u8 throttle_state;
-- 
2.47.1


