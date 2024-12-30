Return-Path: <linux-wireless+bounces-16908-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF3E9FEA5E
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 20:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC4E3A2AB0
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 19:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282EB199EBB;
	Mon, 30 Dec 2024 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="QIjsfXhi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B997191F74
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 19:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735587733; cv=none; b=HpwRKtd2IBRvhrMnre8cB+HFF8X8eNQso1jAHRRSSZLtzv0x29x2a9xvS7/Rw4ABu5Wit4WS+nQBPXT/QZw71PCZJViRMMFO3RlP7EkhMmZL3ruodu1aWXrjUVrHEKMhPuaY8jRMmkmeiHCnpZtAnnBB19E1Uk8yjPQO/Ob6gqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735587733; c=relaxed/simple;
	bh=jntnnUTJmqpJWqAwpcqlgeTwV4Ma28sBQE8LMGLa9Os=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9axLBxtDEeIGCwYlsGoFDQ2Nst8JjVE8yBLVAyjdnauYcTE22LYB9Ut7r7o6Fm/0t2LESf7fPYAWeBuZxdOrr1fZ/RW9c+2yzfK//rkl14vSMaqaiPkniT6rnHXeE62CBPc0rdCJ2fD0jzOUYOrgZB9Ij0mIBbTNsEfwx9l1oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=QIjsfXhi; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZK+IUM4FCS6qnCBNU/j5ZloNC5CxklKIWH6xWiCPIh8=; b=QIjsfXhim1GtLotYeUVH/X4b5a
	6DjJVsWRXGVpi0d5WnRPtpO+te/2pDQXv0qocl29XzTXUJIcjz3UGZcxoWhTIIxKxWDmbPc3aIkcI
	2oSQf7MSOS0vwRrtOj38q/CB+x8F0rnyQUkuKgmUftKmgwkHqcQJMumtT5dyzefVzmjI=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tSLeT-00GKzc-22
	for linux-wireless@vger.kernel.org;
	Mon, 30 Dec 2024 20:42:09 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 03/14] wifi: mt76: mt7915: fix slot time for 5/6GHz
Date: Mon, 30 Dec 2024 20:41:51 +0100
Message-ID: <20241230194202.95065-3-nbd@nbd.name>
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

It should only be set to 20 for long slot time on 2.4 GHz

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 351285daac99..2d4457fbb5ab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -634,7 +634,11 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 		mt7915_mac_enable_rtscts(dev, vif, info->use_cts_prot);
 
 	if (changed & BSS_CHANGED_ERP_SLOT) {
-		int slottime = info->use_short_slot ? 9 : 20;
+		int slottime = 9;
+
+		if (phy->mt76->chandef.chan->band == NL80211_BAND_2GHZ &&
+		    !info->use_short_slot)
+			slottime = 20;
 
 		if (slottime != phy->slottime) {
 			phy->slottime = slottime;
-- 
2.47.1


