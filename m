Return-Path: <linux-wireless+bounces-16912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8719FEA62
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 20:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7003A2B9D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 19:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C449219B3EC;
	Mon, 30 Dec 2024 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="DPBspRar"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3651C198E6D
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735587733; cv=none; b=sIcrNAfObC0zQIVyW9OhUgBzvIcogqMYWSRBCPxtP4uB8WZ4c6LLC+l1h/2kIMaCi86S3WzwIy40JBj16BOLaliuvjRFhbrtJuQOD08GbpO+Cavya9M+Wcq22juFS9IPnuW7Aq8dTMCLvWjEuCyu87YKvQuG0LPsN7DAWnMXUHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735587733; c=relaxed/simple;
	bh=yyWn7vzP7uHwidWjyH5hDghERUeilGlOSCH9HzmBC0s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OY0E24LNEnX7i13UmfMTlC70jQt9Qlz+TRYkNQi4DphNKFRE2wIwAMgB+NS1ObSB8EvqB4LTmRyjTkhqoQE5O6SHDOmeCbEf/YHf7lJ2F80Vc3Oz5H+dCu4TUOHFNJ+PBIUesDnncG0b9NMd+7PCzi/IEPa/5wlRJXfaiPdchbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=DPBspRar; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=46Kq5Lrtw2pTBmv7OxuLvlzpXpk1LLc4pghEgVmdP44=; b=DPBspRarY+oj5+xSMEkEPiXlCg
	IxoyEnabr6vZdUKBnCD3S3aw0vSb6CcRS/YI3k5uc53JJsb91ycWHrdshILFqK/gF71xHpux+Qqgi
	3EHlIOA/JK5PPYC76ykGvfpAx6GaVnXTWNUPYDDjPRJiLtZRT64EY3DEt7NFsTntS0T8=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tSLeU-00GKzc-1z
	for linux-wireless@vger.kernel.org;
	Mon, 30 Dec 2024 20:42:10 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 08/14] wifi: mt76: only enable tx worker after setting the channel
Date: Mon, 30 Dec 2024 20:41:56 +0100
Message-ID: <20241230194202.95065-8-nbd@nbd.name>
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

Avoids sending packets too early

Fixes: 0b3be9d1d34e ("wifi: mt76: add separate tx scheduling queue for off-channel tx")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 57c7b681645a..3642c490fa6d 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -958,11 +958,11 @@ int mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
 
 	if (chandef->chan != phy->main_chan)
 		memset(phy->chan_state, 0, sizeof(*phy->chan_state));
-	mt76_worker_enable(&dev->tx_worker);
 
 	ret = dev->drv->set_channel(phy);
 
 	clear_bit(MT76_RESET, &phy->state);
+	mt76_worker_enable(&dev->tx_worker);
 	mt76_worker_schedule(&dev->tx_worker);
 
 	mutex_unlock(&dev->mutex);
-- 
2.47.1


