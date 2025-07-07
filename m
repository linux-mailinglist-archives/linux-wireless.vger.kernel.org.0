Return-Path: <linux-wireless+bounces-24880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C220AAFB7D7
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 17:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AED1162A97
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 15:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54581DE2A7;
	Mon,  7 Jul 2025 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="i+n9fIne"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9C642A99
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903233; cv=none; b=Yug6Zw/ihUhQMYy+yFRb2BwCwdFTwa+g51zyYFt9WoG00p1kqMpap5ONmQFAbujvw6oW/zf1otSK34WbDpFIboqUFSzqZAmBHAmkIX25UD/9YGJTl6iEtzP/X11zTew57cTyrKK109cZzte44aDxgfMJ1zc669Uo/Z1/rfb5pd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903233; c=relaxed/simple;
	bh=qkwotlLN6MXIcuwGwFBC8a194H2sl3dIexhFHkbY2/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2QLqu0bFGyA19HCr3Kzce42J4aE0hsxiJl/mF2v3c4iIDVrkn8wxzgHZYwr3HI70mEDDSi3LFoZAvZXvhQ3KX+y0Vcc1lv3E6rik5Jd8iCRv2ULcaqq+ZvK+vwBzfJgKQ1NLOf0kw7CAGpjpsO4PamfaTS0NgKzApX42XIpTHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=i+n9fIne; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2glOlgmI71+HnAn2rQovH2DlvZrQiB/JUMKUQpj7J0w=; b=i+n9fIne2AYvz1jtENACAhgHOQ
	onecrHYCDR1TogiSyFv+ePu7gx8H52sKIicETucsUFz42YXGM5zOWEI3Zrh2j1kJ6OGoVdZXZ0DWL
	nLPStidEIaTW3plM54IcyQ7gqMewJU0Lm1FExsvYu81K5uI5ozEycBrcoOSwyhUCVvxI=;
Received: from p5b2062ed.dip0.t-ipconnect.de ([91.32.98.237] helo=MacBookPro.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uYo3b-0081cC-13;
	Mon, 07 Jul 2025 17:47:03 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: Chad Monroe <chad.monroe@adtran.com>
Subject: [PATCH mt76 2/2] wifi: mt76: fix queue assignment for deauth packets
Date: Mon,  7 Jul 2025 17:47:02 +0200
Message-ID: <20250707154702.1726-2-nbd@nbd.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250707154702.1726-1-nbd@nbd.name>
References: <20250707154702.1726-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running in AP mode and deauthenticating a client that's in powersave
mode, the disassoc/deauth packet can get stuck in a tx queue along with
other buffered frames. This can fill up hardware queues with frames
that are only released after the WTBL slot is reused for another client.

Fix this by moving deauth packets to the ALTX queue.

Reported-by: Chad Monroe <chad.monroe@adtran.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/tx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 251ee3ce5e4d..e6cf16706667 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -615,7 +615,8 @@ mt76_txq_schedule_pending_wcid(struct mt76_phy *phy, struct mt76_wcid *wcid,
 		if ((dev->drv->drv_flags & MT_DRV_HW_MGMT_TXQ) &&
 		    !(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
 		    !ieee80211_is_data(hdr->frame_control) &&
-		    !ieee80211_is_bufferable_mmpdu(skb))
+		    (!ieee80211_is_bufferable_mmpdu(skb) ||
+		     ieee80211_is_deauth(hdr->frame_control)))
 			qid = MT_TXQ_PSD;
 
 		q = phy->q_tx[qid];
-- 
2.49.0


