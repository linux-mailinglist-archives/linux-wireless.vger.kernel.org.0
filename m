Return-Path: <linux-wireless+bounces-27306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A87B5721C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 09:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C498817D67A
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 07:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB822EAB83;
	Mon, 15 Sep 2025 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="ahCuRKY8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073682E9EDF
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923162; cv=none; b=fO7cQODvmHGCvB1kEwIhOdlRI3DZJPKRbQ+LaQihXwTXkW2p8aohVEJems6RRAXIlpYOCvGWYRgQhW9Lh6+rt2QS/f0C6X7u/0wYE9Mk3xeEd6j6SAhzUvOsPEg6xTraQ66vwH1BaFJoESuybLnQePgRi0M1QJYHzU63Kgty2Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923162; c=relaxed/simple;
	bh=Qf8Mfdhn1kezPe20Dn1urrqRyzv2LxoekXmDJfeC5Vg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgNbrD4pyIVetEnXwc/v0Nuhnw/lrt73PnLR+zlq/wytVByV3n4SdhIhC0JtetH5okIXIAvZGHKCwx4gcGlcGha/e52uo3Hvruz7gz7CF7Tm6+T7cRV8WR+2UE+9x35TdRR6oodwaG/gC+yWB5i+EWIj3xYKJ1EClzJWPOLiPeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=ahCuRKY8; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fCKrzUTBUeHWBSJL7gvAe4loKJL71Lgbm6ZftOhgLYY=; b=ahCuRKY8gPl/Yif7YE5GIprTEo
	cqe5WXy4GNvaGi7whcGUD6ceeCDPTUFgKLWap8fFMzBgNpqwN79Swp22dER3qsTfAJwQkI1GATWq6
	nPHtZ7/A+e5A+OsV0r/PL/C+sb9SuXg2ua7qwdaoxmNuuimWQnYk+62ghsSrt6493x60=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uy47F-0078GN-1m
	for linux-wireless@vger.kernel.org;
	Mon, 15 Sep 2025 09:59:13 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH mt76 14/15] wifi: mt76: improve phy reset on hw restart
Date: Mon, 15 Sep 2025 09:59:09 +0200
Message-ID: <20250915075910.47558-14-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915075910.47558-1-nbd@nbd.name>
References: <20250915075910.47558-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- fix number of station accounting for scanning code.
- reset channel context

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index cc7da3d5ab08..f6a494812fe1 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -824,6 +824,8 @@ static void mt76_reset_phy(struct mt76_phy *phy)
 		return;
 
 	INIT_LIST_HEAD(&phy->tx_list);
+	phy->num_sta = 0;
+	phy->chanctx = NULL;
 }
 
 void mt76_reset_device(struct mt76_dev *dev)
-- 
2.51.0


