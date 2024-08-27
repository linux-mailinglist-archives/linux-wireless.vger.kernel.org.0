Return-Path: <linux-wireless+bounces-12052-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47474960657
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 11:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7BB3B2259C
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183E119DF60;
	Tue, 27 Aug 2024 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="iFIbbl7T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737EA19D8BE
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752526; cv=none; b=FpiVdpIdFaipYx1P37muv/U0DZfyH7ZiSSqpXwHqutOU2SDuYZQfiFW7sVvTm4s2/xiI2RzfJG6SqQ2SLiJty2v8OZ8m0AT4QbNN7tfyfJ/kNjR1nBEptu4TVj6BKaLXf/690dUDMZvpKUFxQ5GeV2K6V6/ijWxti/O6q7wFuQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752526; c=relaxed/simple;
	bh=sy3UC0jpZYvY06jJ0HSVoBLqnzOVyrUJZ0roEgf/EJ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7sxBbbAKOdynZtXVmCEpmZfp8UoLiPUF6UuIzpJ/oL4YYW5xQxSwAOI6Dd0s6eqk/rQEpQVaS62kfw7YMN7WBHNdSzEMEPJaJy4w5Xr6RRudtsl5NiErCfcj6zbwuTqepmLugzqg/Lf7SoU4B9OWCpwbFzTJMg/qyEueRmKu/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=iFIbbl7T; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=uoPXKbmZwZ+KOhTqLqZJ1bgvfMx+gMlFOmRT7urAHNE=; b=iFIbbl7TfOLnRvtQkq6QyDEJRu
	7M2vh0k5PhLVYgUdVxeM1xgAuzNhIMDoP5Nm8jGWteSXGIqmuTWdp85DhwFC0X/UcSaD/CHYzeMvC
	+S/24DfhQD3oR/l9VPI1WnHE16H0N6z9vIEJsSC3FwKAB0GcA9Va2fCz7nOD+vGWI+IM=;
Received: from p57a6f9a5.dip0.t-ipconnect.de ([87.166.249.165] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sisWo-004Ww8-0t
	for linux-wireless@vger.kernel.org;
	Tue, 27 Aug 2024 11:30:18 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 22/24] wifi: mt76: mt7915: always query station rx rate from firmware
Date: Tue, 27 Aug 2024 11:30:09 +0200
Message-ID: <20240827093011.18621-22-nbd@nbd.name>
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

When offloading is enabled, the software rx path may not have the latest
rate information.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index db2cf6e11cf3..d75e8dea1fbd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1094,8 +1094,7 @@ static void mt7915_sta_statistics(struct ieee80211_hw *hw,
 	struct rate_info *txrate = &msta->wcid.rate;
 	struct rate_info rxrate = {};
 
-	if (is_mt7915(&phy->dev->mt76) &&
-	    !mt7915_mcu_get_rx_rate(phy, vif, sta, &rxrate)) {
+	if (!mt7915_mcu_get_rx_rate(phy, vif, sta, &rxrate)) {
 		sinfo->rxrate = rxrate;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
 	}
-- 
2.46.0


