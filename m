Return-Path: <linux-wireless+bounces-27305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0956B5721E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 09:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41FAD1899D39
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4EA2E3397;
	Mon, 15 Sep 2025 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="MPCyjU/R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B712E9EC9
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923162; cv=none; b=t9SO2hofPmd3jEdcTIvPssroxb6GE3jPLAWk4VoxAYVRNA+Y2xV0HBctZTxE1sbIUWG1LIDdxDAigwaJzdOwi8lGlRB4d9agvEo5StUxFzWC9RG117Zq8nsvr7UZfJB3UMN5FBJgW+sRMxj14XvPbXBG0eC+Ss2jZq8pk6+6SNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923162; c=relaxed/simple;
	bh=y6yIzupDKJCFmQtD6NruKdw+sgXImBRikk+2vxvMk1c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVf3FcegDX0sMFcLabl6Y7jxZ78UXUWBDCOJI5Iemi2apyA/bJN91yblv9e8f+PHTHLn0B+nIiLEkX+9S2RWy+KFFcyiYK+SuMWRkIF5nZvJJM6yDOX96vIXGQaFzzVkINTIR0kwVo2Anf5iL8yw8o73DcKc40SkuJCdajs1YLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=MPCyjU/R; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2Gn8hV1WEd0TtsWlm/wZv0+2qqyvSqYfHIjpGqtWTEI=; b=MPCyjU/R95o97LM5eUFSez8Iik
	i9FemaXHkH7Hx7resxct6MArhOHg34xM42s30b3cfWhEsHB+t2ue6QtW+/Ebj753M1yAhFEfzQDyW
	A923ycFiATPBiTzUaNiLv/oIIaDLnKdY6P2NDsMzippijNWORXxw88tY66mxYI720Yhg=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uy47E-0078GN-2a
	for linux-wireless@vger.kernel.org;
	Mon, 15 Sep 2025 09:59:12 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH mt76 10/15] wifi: mt76: mt7996: disable promiscuous mode by default
Date: Mon, 15 Sep 2025 09:59:05 +0200
Message-ID: <20250915075910.47558-10-nbd@nbd.name>
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

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Set MT_WF_RFCR_DROP_OTHER_UC by default and disable this flag in
mt7996_set_monitor only if monitor mode is enabled.

Without this patch, the MT_WF_RFCR_DROP_OTHER_UC would not be set so the
driver would receive lots of packets meant for other devices.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 89546bf4c7aa..5e95a36b42d1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -410,6 +410,7 @@ mt7996_init_wiphy_band(struct ieee80211_hw *hw, struct mt7996_phy *phy)
 
 	phy->slottime = 9;
 	phy->beacon_rate = -1;
+	phy->rxfilter = MT_WF_RFCR_DROP_OTHER_UC;
 
 	if (phy->mt76->cap.has_2ghz) {
 		phy->mt76->sband_2g.sband.ht_cap.cap |=
-- 
2.51.0


