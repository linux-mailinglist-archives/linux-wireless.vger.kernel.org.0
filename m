Return-Path: <linux-wireless+bounces-26690-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 710FBB37ECA
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 11:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202AE7C6CFB
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 09:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62AE278768;
	Wed, 27 Aug 2025 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="FGhFSP2U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF7B343D7E
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286771; cv=none; b=HCF2nfUaH87dAc2Vt3wU2cMaDhltrRqUnJ0jRS0IATzxyA4xOtNrL3kxVfJpNbos+CJ+OEP+jSZCL/nS3xfTQAlytw9eGKFSvEI7lZXDYfbpBdaDHGyZjMG16T+DZFUIPaD/2cFMpYKAruOAgM4p5JkxcEfCmyGSwx+8jASCoLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286771; c=relaxed/simple;
	bh=mfnmNsYV9rgZKWmuURIEwHl1Kyn4AxnHAen9i8vCKkE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3A3VswX6tKHHjQoVf1B/p0jxvpWPFHo8T6kugizry1MWBP9IYa4jbaCuHuhdaHyq4D0xZ22RKW4KI6XYv7bnyaPkrIkjvfLPW8Bwl1iGrKTo0PKnzQqu7RR0OM0mOIyDlwY576X7FbXN1lo8TyVb/oahGa4fMHs8PZGMtwYOqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=FGhFSP2U; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UETIllKK/f2wxmiOz/VwXAhouQ8ZQBSVr9VsXMwoRA0=; b=FGhFSP2UDAzDknlyCdbtw1k7Ce
	Zes+/9P/mn1rwhH1PV6EOrmXYe530CIRpbM12jgv4mk6601Hu+CWwN8dBvSUzZQ37JCx5h6FwUAli
	oivr01z7VSqYUhwPvp03+xQ7tlUp42hZyf3kJQv/pEHmUJzO6yyAY3tZKUk0/bRNlh+g=;
Received: from tmo-087-176.customers.d1-online.com ([80.187.87.176] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1urBum-00Fn6z-1O
	for linux-wireless@vger.kernel.org;
	Wed, 27 Aug 2025 10:53:56 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 5/6] wifi: mt76: free pending offchannel tx frames on wcid cleanup
Date: Wed, 27 Aug 2025 10:53:51 +0200
Message-ID: <20250827085352.51636-5-nbd@nbd.name>
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

Avoid leaking them or keeping the wcid on the tx list

Fixes: 0b3be9d1d34e ("wifi: mt76: add separate tx scheduling queue for off-channel tx")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 0e0d7b3bfe42..59adf3312617 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1716,6 +1716,10 @@ void mt76_wcid_cleanup(struct mt76_dev *dev, struct mt76_wcid *wcid)
 	skb_queue_splice_tail_init(&wcid->tx_pending, &list);
 	spin_unlock(&wcid->tx_pending.lock);
 
+	spin_lock(&wcid->tx_offchannel.lock);
+	skb_queue_splice_tail_init(&wcid->tx_offchannel, &list);
+	spin_unlock(&wcid->tx_offchannel.lock);
+
 	spin_unlock_bh(&phy->tx_lock);
 
 	while ((skb = __skb_dequeue(&list)) != NULL) {
-- 
2.51.0


