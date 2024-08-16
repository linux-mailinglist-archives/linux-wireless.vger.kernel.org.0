Return-Path: <linux-wireless+bounces-11564-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CF995500C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 19:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 464052866F8
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 17:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A411C231F;
	Fri, 16 Aug 2024 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="mp7YlBm0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B841BCA1C
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829740; cv=none; b=uXM/BVkszS808/6exJXoENbrTDA/YhDcKjgduxg4i6PSEsZjCVrhe7rbYVlQWa5UmTqO/56zPJlNXZkQZP7oklxisWiFcXBnQiGaF7gR/XCJxLRHf9NaDH+93dwpKhHn6gDiSqn8jJ8QeOOQAv9kA3sxTfY2gziS4NXtzrH+Kag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829740; c=relaxed/simple;
	bh=pXRxD0hs8PGBodHZze5uEpx1doY6kV9bNCG6iOOfIAM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjO69bvgxbIviBF01d+nzuQSyypxjQvHXfenwS98FoJrCHqVn4S4Jt/fXElR9mBiFxxpXUh69redEEwXXXY1QsuEvcGl7WaDcpdG1p/f78otsnoBKIZHkszDd7uQtcFlPsd4z9PbRvUtJ3n5s61hzc6B1nSG5OrcVBt1+giWps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=mp7YlBm0; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FKbTn6czq0t+C1FsFgjyHdB2DsogcHCw4r6pGbTbGXw=; b=mp7YlBm0leIZB8nI/oBRtjEfuf
	kD1TWxYPDq6HSB+cAyGP+KQtmMLVZRzMunNGZMjCiXdidCckq/b94mdQhQ0yDGIRLFhDfxnhRvptE
	jj3rdqNkq8RsWrYE1U1+Y1yPI5ap1ICVzESIBBO7GNs6dQOtTlguRXxuRkQML8wrfS6Y=;
Received: from p54ae95e7.dip0.t-ipconnect.de ([84.174.149.231] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sf0rQ-000ObE-2O
	for linux-wireless@vger.kernel.org;
	Fri, 16 Aug 2024 19:35:36 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 04/16] wifi: mt76: fix mt76_get_rate
Date: Fri, 16 Aug 2024 19:35:17 +0200
Message-ID: <20240816173529.17873-4-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240816173529.17873-1-nbd@nbd.name>
References: <20240816173529.17873-1-nbd@nbd.name>
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
2.44.0


