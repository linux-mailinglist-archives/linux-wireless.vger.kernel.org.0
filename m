Return-Path: <linux-wireless+bounces-16909-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433929FEA5F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 20:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3801161E08
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 19:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5215619ABD4;
	Mon, 30 Dec 2024 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="BmaC1sJD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C2D1925B3
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 19:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735587733; cv=none; b=DxE2U00CtAdVxJDC1t6jHUyCLdNERmym4+dLXUbdubBIz+6kIYdonnS7Shjdt+/RGeGCL7XIAqX/fXKuO9K0bWur1NSko2EendZ4MdLJMzmFSCKHq/Tl+DSa+Px1VtG+Ea8CwMog51L/wzFcN6QWHwRSSag++3d04omdIMEraMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735587733; c=relaxed/simple;
	bh=9jjXJmWyONS82fS/biyImw6Cn2XX08OEaq1Ofh+fGZg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3OnLKtFfm27rUKrapRcRyKcz8MYYHEIKkoFs9vucMG7YurtESOyYLHma29lTWwdfwZenQjON1nOjYIp8rO7V9GOkJoVd61xKkWjvP8lJcFfN0wQlsPB6TL7PHHqtQGGbvWTyzOFAR/1295fmAvxzLB6hmIPzzKog9fkaNsTVSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=BmaC1sJD; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=eK3mTxmlHNipzNKQKtbsluiT2BpiRpM9TEktoKBGdE4=; b=BmaC1sJDxFfvbCLBSckz7gHNaK
	+mt4iyJlmGAiyHmmeyiDN5IsGFvm1+/sWGintr0uNy94Ufayrb6sDQyXtEZ0MXAABLYOo43pycaVx
	AzLrI5/4YOAu+IpMQlpe4R75tuQVIioNJsCYBJ+rvsIN/oHV+8mbJnPDs531sejQS5Yo=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tSLeT-00GKzc-2g
	for linux-wireless@vger.kernel.org;
	Mon, 30 Dec 2024 20:42:09 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 04/14] wifi: mt76: mt7915: fix eifs value on older chipsets
Date: Mon, 30 Dec 2024 20:41:52 +0100
Message-ID: <20241230194202.95065-4-nbd@nbd.name>
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

Use the default firmware values

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index cf77ce0c8759..1b9dcdec142b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1163,7 +1163,7 @@ void mt7915_mac_set_timing(struct mt7915_phy *phy)
 	u32 ofdm = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 60) |
 		   FIELD_PREP(MT_TIMEOUT_VAL_CCA, 28);
 	u8 band = phy->mt76->band_idx;
-	int eifs_ofdm = 360, sifs = 10, offset;
+	int eifs_ofdm = 84, sifs = 10, offset;
 	bool a_band = !(phy->mt76->chandef.chan->band == NL80211_BAND_2GHZ);
 
 	if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
-- 
2.47.1


