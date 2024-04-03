Return-Path: <linux-wireless+bounces-5802-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAD0896D5F
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 12:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512911F2E8A0
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 10:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2342136989;
	Wed,  3 Apr 2024 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="bR02LTfM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F171411F0
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141725; cv=none; b=DmkQdpIa0zXTMDNBho8UQrniqONfUKk3GWx9rgnlggrohiR15dyEdTr05TDQA3ejEYMKDaIesz28RTutb6EyFwXhmw0BSp/1GWuBmGpIrWIjrY4n/OGUx6h+ZK5j195eGL8g85h3zkxE2LAZTVmcGPKjQ9P3hZyYPAc4k7D57mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141725; c=relaxed/simple;
	bh=Cx46qIRZhwhYPjCcGGxM7VUI2f+02o2x+njiup04PDU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okiXVRPiSTuCu7f6Rou11n+6KAFovAEoPhbGjGLMZPEvncRkVrGmVukcyL+iYQ4anpqGhvJTQwWnTnN7thu8LhJv8jOjt+PnHqlH9HWlKs6anY9kLaeDehPfS84gtDmFw0beNM4dQpHsZyeWHjTP9sN1p1txBQxP1SkVnlZTbPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=bR02LTfM; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oXttf9KHJqxJzjNqpvFFvl+Tzz7NR3cA/kIZ5dMzYi4=; b=bR02LTfMNtGDumNiiGFQBDvlGE
	72a5xMFZTVb5GFvrBJrIeGRXgQXIReay4HlzeJYQ2ncHJ3Phg4bTJyQbwJbIHDknxdqh6aZ1lAmfQ
	hkeGbYVjtU9PvbsYf/FfYmoq/PGygpyIetsQfAV1DIhz4yRXxqKOdldsvaJeegVh+5nU=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rrxt3-00CgfA-GF
	for linux-wireless@vger.kernel.org; Wed, 03 Apr 2024 12:30:33 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 05/13] wifi: mt76: mt7915: fix bogus Tx/Rx airtime duration values
Date: Wed,  3 Apr 2024 12:30:24 +0200
Message-ID: <20240403103032.54823-5-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403103032.54823-1-nbd@nbd.name>
References: <20240403103032.54823-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Henry Yen <henry.yen@mediatek.com>

Do not report measurements if the airtime counter was cleared since the
last update (possibly by firmware)

Signed-off-by: Henry Yen <henry.yen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index e45361111f9b..f350b3f7a0bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -140,8 +140,15 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 			msta->airtime_ac[i] = mt76_rr(dev, addr);
 			msta->airtime_ac[i + 4] = mt76_rr(dev, addr + 4);
 
-			tx_time[i] = msta->airtime_ac[i] - tx_last;
-			rx_time[i] = msta->airtime_ac[i + 4] - rx_last;
+			if (msta->airtime_ac[i] <= tx_last)
+				tx_time[i] = 0;
+			else
+				tx_time[i] = msta->airtime_ac[i] - tx_last;
+
+			if (msta->airtime_ac[i + 4] <= rx_last)
+				rx_time[i] = 0;
+			else
+				rx_time[i] = msta->airtime_ac[i + 4] - rx_last;
 
 			if ((tx_last | rx_last) & BIT(30))
 				clear = true;
-- 
2.43.0


