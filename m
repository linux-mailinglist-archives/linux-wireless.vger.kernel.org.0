Return-Path: <linux-wireless+bounces-12046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D24A896059D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 11:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119241C22C31
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F1A19DF8C;
	Tue, 27 Aug 2024 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="onnU+rKA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE219199EAC
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751026; cv=none; b=gU4XVjzWnpVqB8fv8CDs383VuIfSK5jWxElneQI4I2YYN4gxa52SraZCHLTo3jDZJhSpLXKanuhuqq/rg8hZUbkz6E5X10Vj71Jk7T9zPnTX1p8WV0zjiVUmTZ3q4uYXtWumc4AOzs5WcH3xZNiFjopyFps5YrMl5tYtjdd9P1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751026; c=relaxed/simple;
	bh=syWEwJi0KB5SmZfHh1Nw6meMhNXgO2xF7zAuRHHfuRo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZTGJ/UsiMeLBUOseh5AFCep9J/WBhwe5VY5I9ruM/2t0kZFNn+XRLKSxLqUtAfcvUCNhnxlkEi8ivlIeRgDPjO0ljzHjao5ehncHqRWBjAB5ZBS2MIGtHpoUZnHYbhvKDkebvk1HhkQWagIrZkWFOLxMZQIIVFew4tnBe+ui1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=onnU+rKA; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tHe7TYRDHY51rFbEySlJbRzgO8Pwe5VJKPVrN4PAxBI=; b=onnU+rKASDT56cVivdKCV2dKxG
	/DkWXinDzBGdP7UIZ3ka897ZDP37QqObjS1Fjrtp8oVAxvTPFXA5U7fMighUlgz+g/fjQfJLmmaNU
	/EWnBg/QmV0nbQuvGYWwvxvFEg9z3xmGOSA84Kl7/3byIS8qeat2Ms8g9DFxhQcFDW38=;
Received: from p57a6f9a5.dip0.t-ipconnect.de ([87.166.249.165] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sisWk-004Ww8-0Z
	for linux-wireless@vger.kernel.org;
	Tue, 27 Aug 2024 11:30:14 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 04/24] wifi: mt76: fix mt76_get_rate
Date: Tue, 27 Aug 2024 11:29:51 +0200
Message-ID: <20240827093011.18621-4-nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827093011.18621-1-nbd@nbd.name>
References: <20240827093011.18621-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not assume that the first phy has 2 GHz support.
Check sband->band instead of accessing dev->phy.sband_2g.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index d96ee759828e..8733906fcb21 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1697,14 +1697,15 @@ int mt76_get_rate(struct mt76_dev *dev,
 		  struct ieee80211_supported_band *sband,
 		  int idx, bool cck)
 {
+	bool is_2g = sband->band == NL80211_BAND_2GHZ;
 	int i, offset = 0, len = sband->n_bitrates;
 
 	if (cck) {
-		if (sband != &dev->phy.sband_2g.sband)
+		if (!is_2g)
 			return 0;
 
 		idx &= ~BIT(2); /* short preamble */
-	} else if (sband == &dev->phy.sband_2g.sband) {
+	} else if (is_2g) {
 		offset = 4;
 	}
 
-- 
2.46.0


