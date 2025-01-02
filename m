Return-Path: <linux-wireless+bounces-17002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E02E9FFBD2
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6678D188372D
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4986817BB32;
	Thu,  2 Jan 2025 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="GjCtEfNP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84B6156960
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835723; cv=none; b=bqNC9bDhq93fJpOlnZMtGJ2crxOVfxFh4f/Eaf2v98F7Jz4KCnCBd/UUDTjfVXsGYvUM/06dRv1yO7Ge8h494YwP2hkr+xoCxxDmakBFWiS/kagfO3i5eMDKL+Q9PzaZYHdqFeb3JakjomwDfwJONA9+5ymetewXwrInYwWDBnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835723; c=relaxed/simple;
	bh=dB6lCXP55oNpgNaUI8X8y4CB2qtrcedyv2LrtxbXLKU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlEDwwKkkNvT6d/fbOLkKXIk5KcsxTyi1V0swSWMB2S/fLPa25XJBHnSnJylD+d+pgTx56vTOYGl2B9oAEb1dNWPElI7rumncNaQTqcItz5aW4ZWtO69PZRRnCnmxJvlanFYBEa1WL8fNqWIIDy4GyUYqoqtvFNJLvELo55aQks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=GjCtEfNP; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oqcjqOUsW1hABBrcMN4Zy818V8XB8nwkwZZuNTqGWLc=; b=GjCtEfNP76+QqtJz3HF63hd5Ho
	XXdXU2B8dh5eNmp8Tf543vdszTEeRflyXgV7TvGDpuj2mTxWG3CSgEi0TKNNKd22BtX+IAYCnKVRy
	A527hRKdwFMI+szWPvE8+zZZg1nZIx6NWH1Pe96TeqFgjTGwl+fPVDYxNGbEj0mMrhn0=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAD-0008GS-1V
	for linux-wireless@vger.kernel.org;
	Thu, 02 Jan 2025 17:35:13 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 13/24] wifi: mt76: mt7996: use emulated hardware scan support
Date: Thu,  2 Jan 2025 17:34:57 +0100
Message-ID: <20250102163508.52945-13-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102163508.52945-1-nbd@nbd.name>
References: <20250102163508.52945-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preparation for supporting multiple radios on a single wiphy

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 5b23ca1554cb..1ebac1905c22 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -442,6 +442,9 @@ mt7996_init_wiphy(struct ieee80211_hw *hw, struct mtk_wed_device *wed)
 
 	wiphy->available_antennas_rx = phy->mt76->antenna_mask;
 	wiphy->available_antennas_tx = phy->mt76->antenna_mask;
+
+	wiphy->max_scan_ssids = 4;
+	wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 9f1460eca4f4..d7e33e3b04ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1522,8 +1522,8 @@ const struct ieee80211_ops mt7996_ops = {
 	.ampdu_action = mt7996_ampdu_action,
 	.set_rts_threshold = mt7996_set_rts_threshold,
 	.wake_tx_queue = mt76_wake_tx_queue,
-	.sw_scan_start = mt76_sw_scan,
-	.sw_scan_complete = mt76_sw_scan_complete,
+	.hw_scan = mt76_hw_scan,
+	.cancel_hw_scan = mt76_cancel_hw_scan,
 	.release_buffered_frames = mt76_release_buffered_frames,
 	.get_txpower = mt76_get_txpower,
 	.channel_switch_beacon = mt7996_channel_switch_beacon,
-- 
2.47.1


