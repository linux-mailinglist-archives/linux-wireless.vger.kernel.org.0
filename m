Return-Path: <linux-wireless+bounces-20160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD28A5BE01
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 11:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6038D1898429
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 10:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855F423770A;
	Tue, 11 Mar 2025 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="qzMktbHU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A203221D595
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689411; cv=none; b=ApMw/FGh09vgJ1/7H1mgkxNFi7vnLI+rJVHnPpwUuiwiZCz+6mmUUTn9REf4ukgRsZ65Zzm+D6U2VsMLgaCSX/Qd5qG5AiijX8NZgs0mx08SvDX6pUqr4mfG6St+D1QgW46Vulo0FLb3aSYewAqAw1xSFJNHREs6bAYDczOVJZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689411; c=relaxed/simple;
	bh=Gw4S8ijClos13IW8ZiahgurKKRP9cfox8fMl50mhCoQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJNp4Vt5og0umPhqUTGWrJvX06H6wU6iV+G2oPm1Ccg1DiJ3wzQ92uLEiTFAbgpq7FTVrTgHsWj2YDUktbEUpPx/VmgZm29J7i//JIb0uYUuYymXrt+NVXNLyn8eGWclVqsFm7zmdhb1148NDM7RTiWoR1Pz0YzoBGVukMwsfEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=qzMktbHU; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Jq+zKftjKXIIJhXv5Rv3yFPYsMdU3EzFIBuM3d25TA0=; b=qzMktbHUjD2aTeKeMg4VlEpump
	uGATGB0sfPSeuDzVFxZw+IAb6Q6p0mhOdnMvYC9vyJv94kO7UjymYkzNN9gBZ1VSyWsMtVfJtnVLq
	WVFQVhUdAiOBsojJXmpI5lIMoauu0UX9d9dH74emarEUuEOeFLW9DSf+d2jfFYN9t7PE=;
Received: from p5b206ef1.dip0.t-ipconnect.de ([91.32.110.241] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1trwyd-00Ftvh-0D
	for linux-wireless@vger.kernel.org;
	Tue, 11 Mar 2025 11:36:47 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 4/8] wifi: mt76: scan: set vif offchannel link for scanning/roc
Date: Tue, 11 Mar 2025 11:36:41 +0100
Message-ID: <20250311103646.43346-4-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311103646.43346-1-nbd@nbd.name>
References: <20250311103646.43346-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver needs to know what vif link to use

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/channel.c | 3 +++
 drivers/net/wireless/mediatek/mt76/mt76.h    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/channel.c b/drivers/net/wireless/mediatek/mt76/channel.c
index 6a35c6ebd823..e7b839e74290 100644
--- a/drivers/net/wireless/mediatek/mt76/channel.c
+++ b/drivers/net/wireless/mediatek/mt76/channel.c
@@ -293,6 +293,7 @@ struct mt76_vif_link *mt76_get_vif_phy_link(struct mt76_phy *phy,
 		kfree(mlink);
 		return ERR_PTR(ret);
 	}
+	rcu_assign_pointer(mvif->offchannel_link, mlink);
 
 	return mlink;
 }
@@ -301,10 +302,12 @@ void mt76_put_vif_phy_link(struct mt76_phy *phy, struct ieee80211_vif *vif,
 			   struct mt76_vif_link *mlink)
 {
 	struct mt76_dev *dev = phy->dev;
+	struct mt76_vif_data *mvif = mlink->mvif;
 
 	if (IS_ERR_OR_NULL(mlink) || !mlink->offchannel)
 		return;
 
+	rcu_assign_pointer(mvif->offchannel_link, NULL);
 	dev->drv->vif_link_remove(phy, vif, &vif->bss_conf, mlink);
 	kfree(mlink);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 7596191252dc..c16a6743ad64 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -351,6 +351,7 @@ struct mt76_wcid {
 	u8 hw_key_idx;
 	u8 hw_key_idx2;
 
+	u8 offchannel:1;
 	u8 sta:1;
 	u8 sta_disabled:1;
 	u8 amsdu:1;
@@ -787,6 +788,7 @@ struct mt76_vif_link {
 
 struct mt76_vif_data {
 	struct mt76_vif_link __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
+	struct mt76_vif_link __rcu *offchannel_link;
 
 	struct mt76_phy *roc_phy;
 	u16 valid_links;
-- 
2.47.1


