Return-Path: <linux-wireless+bounces-27307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F20B5721F
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 09:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFDE17BD7F
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 07:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB972EB5C0;
	Mon, 15 Sep 2025 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="SqCZ18Sk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76332E9ECF
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923163; cv=none; b=pq036dn/DOP2gmSHTa246h2l4ALYebIuWMNMocpFlj127VWmLC9m3MxUSBuFSCGggfrXRL40w0xTBF8BVECCIoyAtXJmBCpb1GDBUWNpBmJyZ05gPcP6bjfWdGa7Ji5vGZ+YxGknC2lCVMOi6Jd/xepj8kjQAZ8O2haxIAdwM+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923163; c=relaxed/simple;
	bh=o5pP2A5Sk0ND80TbBB+dSCCX7AOuLUjT7MHHm0AaRFY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIZh5IRSLzkZZBj1judLximMxcGmVMse3lSvhrP/FNxreTonDJewzBdQltSUT25sNQyrr1qMvTThZ0Ku0ZDmcEMxL4UTIqOlyoIZQRifmvpZ9t6rhGRfjRi3kfAF9qF6Agjc1Gh6Xy0a/KBkbGFmKae8G6SIFzcHrToSm5/RnLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=SqCZ18Sk; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MMG00asalskz+LG1TkKGEE5uA/Jpa+sgn2ezOPcdCsY=; b=SqCZ18Sk/sBrr7wQWllEww1qOe
	uE9PSQfIm3SKRRIZ0BFOZXULzeT0odpdsH1eDDliEkOyROx3CPqkbQU7Fq94Jlw92cUOsJ7wAzkJo
	qgT9w/Ztov4lpIk7z4fTaZSPCIJ1jNKMU0kNEHSozzFvdsCKvsbbMHetsBCu0n3xlINE=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uy47E-0078GN-21
	for linux-wireless@vger.kernel.org;
	Mon, 15 Sep 2025 09:59:12 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH mt76 09/15] wifi: mt76: use altx queue for offchannel tx on connac+
Date: Mon, 15 Sep 2025 09:59:04 +0200
Message-ID: <20250915075910.47558-9-nbd@nbd.name>
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

This ensures that packets are sent out immediately and are not held by
firmware internal buffering.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/tx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 8ab5840fee57..b78ae6a34b65 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -618,7 +618,8 @@ mt76_txq_schedule_pending_wcid(struct mt76_phy *phy, struct mt76_wcid *wcid,
 		    !(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
 		    !ieee80211_is_data(hdr->frame_control) &&
 		    (!ieee80211_is_bufferable_mmpdu(skb) ||
-		     ieee80211_is_deauth(hdr->frame_control)))
+		     ieee80211_is_deauth(hdr->frame_control) ||
+		     head == &wcid->tx_offchannel))
 			qid = MT_TXQ_PSD;
 
 		q = phy->q_tx[qid];
-- 
2.51.0


