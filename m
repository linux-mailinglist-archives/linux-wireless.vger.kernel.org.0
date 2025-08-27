Return-Path: <linux-wireless+bounces-26691-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3E4B37ECB
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 11:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07587C6EC3
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 09:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D85D3451B0;
	Wed, 27 Aug 2025 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="i1uysm2s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987543451A0
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286775; cv=none; b=ohTCW2GkGLUOccgYdhmz4BnD5w2zXK9VPAoy5exzWTZt+YkNWNKJze5qwOt1ha87IGppPuCADsxOuq8WSR5jr7iA5Ah6GNnnMEwuYWIU4gnIizXcykad26EPHO2RZJGSnKwVowcyrFH6Kj2uqGfYdubshKCGktcfmDVkp1feLpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286775; c=relaxed/simple;
	bh=lf5zC2G5sE2bNN67syJxcgxOK3YYSfUncXxx2pesBD8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ty0ZySExUmh/TxwX2tmVFpcAN3zqMqMb+p6caEsEjLVhbup4uQLqxd/A9rNDQr3YtJBdeheBHwHk3x/wTi3oN0S2pC8jN39ZKZ249/vA52L/cfPtsQvqUpaKncSn80L+bVhL4Bp22qws/6Bf8hMEzcsXvphjQbFNE3VAdnhpyZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=i1uysm2s; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OzedEdmh8FMOsOJAS7cEmp2uDOUGMHcNznZ2dcI/vAY=; b=i1uysm2sNcT/eX6Ng0qa5K/Gat
	FUgHAFmiHvIqTOsGPV382VqQSu+jFUfZPh8z8rkfWW8Eni54Qr2jb952ERCfA2rZz43io1DcueGBC
	fsMiZ50niBGwCsuoBlKCk+2nDftyoa6XAdAWeK09ucCsy6a1vSk6NsTn8iD6Y5VGVGWs=;
Received: from tmo-087-176.customers.d1-online.com ([80.187.87.176] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1urBum-00Fn6z-2g
	for linux-wireless@vger.kernel.org;
	Wed, 27 Aug 2025 10:53:57 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 6/6] wifi: mt76: fix linked list corruption
Date: Wed, 27 Aug 2025 10:53:52 +0200
Message-ID: <20250827085352.51636-6-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827085352.51636-1-nbd@nbd.name>
References: <20250827085352.51636-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Never leave scheduled wcid entries on the temporary on-stack list

Fixes: 0b3be9d1d34e ("wifi: mt76: add separate tx scheduling queue for off-channel tx")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/tx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 03b042fdf997..8ab5840fee57 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -646,6 +646,7 @@ mt76_txq_schedule_pending_wcid(struct mt76_phy *phy, struct mt76_wcid *wcid,
 static void mt76_txq_schedule_pending(struct mt76_phy *phy)
 {
 	LIST_HEAD(tx_list);
+	int ret = 0;
 
 	if (list_empty(&phy->tx_list))
 		return;
@@ -657,13 +658,13 @@ static void mt76_txq_schedule_pending(struct mt76_phy *phy)
 	list_splice_init(&phy->tx_list, &tx_list);
 	while (!list_empty(&tx_list)) {
 		struct mt76_wcid *wcid;
-		int ret;
 
 		wcid = list_first_entry(&tx_list, struct mt76_wcid, tx_list);
 		list_del_init(&wcid->tx_list);
 
 		spin_unlock(&phy->tx_lock);
-		ret = mt76_txq_schedule_pending_wcid(phy, wcid, &wcid->tx_offchannel);
+		if (ret >= 0)
+			ret = mt76_txq_schedule_pending_wcid(phy, wcid, &wcid->tx_offchannel);
 		if (ret >= 0 && !phy->offchannel)
 			ret = mt76_txq_schedule_pending_wcid(phy, wcid, &wcid->tx_pending);
 		spin_lock(&phy->tx_lock);
@@ -672,9 +673,6 @@ static void mt76_txq_schedule_pending(struct mt76_phy *phy)
 		    !skb_queue_empty(&wcid->tx_offchannel) &&
 		    list_empty(&wcid->tx_list))
 			list_add_tail(&wcid->tx_list, &phy->tx_list);
-
-		if (ret < 0)
-			break;
 	}
 	spin_unlock(&phy->tx_lock);
 
-- 
2.51.0


