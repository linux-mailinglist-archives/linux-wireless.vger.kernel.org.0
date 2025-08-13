Return-Path: <linux-wireless+bounces-26362-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B29AB24941
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 14:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2D62A4D98
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 12:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3882F7441;
	Wed, 13 Aug 2025 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="mJu2R9Du"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82072F83A5
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087077; cv=none; b=bkBdrzvDZxI728w6Ma1NI4jRDZPvmaTKedleTYX1PTqCbWwMB/kVUu1a/bBM0tLSns6aMecwMkCY5kpVBQProNf8rz5IhsM6DTXSiVqMPyHgPTphZ/sId8Vfq8kZBpWeIm+d3jHctHWnbX4kSag+TeK8TxxqG6vTd604RYua8dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087077; c=relaxed/simple;
	bh=cyDBYouQfnIbvudTeqvFQUNxb82Xs3rtH3lT+rSDozU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdmzTiLLV+I3Di3d0SLCm3FsrDBA1fUoEziC6s4JqDlJy0k5mR+X4cG+jUf6iAwsyqbSQIPbASQbYiJ6WTZWL8mmg6kzfwIHDMcF8gkQyT9GQWPP5DYE2dmI+oCtt8vhvX+V0SLvrYU+RAXDS+5ecmkry7N4TuRLmrKabLwXOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=mJu2R9Du; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lRQIsznxPmUpRMmevDu0GcJ21dOlPtmGFoNxlZGuzsI=; b=mJu2R9Duy4RiZlTn+GaZCZQXj/
	JvRS1/KmvAjDXRi3GOFq17c+NQbJL3iRp/8+cfHxFIv7amblqRC1ZK82cr+FB/E8O2M9XXDmCTBq5
	tl5SkiYF3KKyfWjBcLdQHDCsNAlOFW/UwB1IMdK0I0Op22UcYocUooFvoRQVBxLLos/c=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1umAJu-009tKb-2x
	for linux-wireless@vger.kernel.org;
	Wed, 13 Aug 2025 14:11:07 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] wifi: mt76: prevent non-offchannel mgmt tx during scan/roc
Date: Wed, 13 Aug 2025 14:11:06 +0200
Message-ID: <20250813121106.81559-2-nbd@nbd.name>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813121106.81559-1-nbd@nbd.name>
References: <20250813121106.81559-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only put probe request packets in the offchannel queue if
IEEE80211_TX_CTRL_DONT_USE_RATE_MASK is set and IEEE80211_TX_CTL_TX_OFFCHAN
is unset.

Fixes: 0b3be9d1d34e ("wifi: mt76: add separate tx scheduling queue for off-channel tx")
Reported-by: Chad Monroe <chad.monroe@adtran.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/tx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index e6cf16706667..03b042fdf997 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -332,6 +332,7 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	struct mt76_wcid *wcid, struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct sk_buff_head *head;
 
 	if (mt76_testmode_enabled(phy)) {
@@ -349,7 +350,8 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, phy->band_idx);
 
 	if ((info->flags & IEEE80211_TX_CTL_TX_OFFCHAN) ||
-	    (info->control.flags & IEEE80211_TX_CTRL_DONT_USE_RATE_MASK))
+	    ((info->control.flags & IEEE80211_TX_CTRL_DONT_USE_RATE_MASK) &&
+	     ieee80211_is_probe_req(hdr->frame_control)))
 		head = &wcid->tx_offchannel;
 	else
 		head = &wcid->tx_pending;
-- 
2.50.1


