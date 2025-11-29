Return-Path: <linux-wireless+bounces-29423-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 52369C936E3
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Nov 2025 03:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F06513414CE
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Nov 2025 02:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C466218CBE1;
	Sat, 29 Nov 2025 02:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="ZyuQ4RBJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93BD1EB1AA
	for <linux-wireless@vger.kernel.org>; Sat, 29 Nov 2025 02:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764384310; cv=none; b=THNZvpuSD6bs4WPPmJ+xfsm7316d6H9H7I66Piq8qQoAoq5BErQo8K1h6BOVZ5VoKW/VyESooS/cJj0ogtezPkLN4PkrDTt8LgJdRRogV7BCCi8Cj7iJ8aiR1FGwnxQ5RZkKFltlZCc0IOVsLAl6kDl7ObxkmE1x2J/vPC/EzA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764384310; c=relaxed/simple;
	bh=r+TbYhbumj1LE8b1/7eJFLcgqdgfk2pwXQgbmKsupuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qp0PKRsHN8qugAEwUms2LM8uJNIXwcBuJQ4is8auHcxYomfaD2Z4JUpU29fvQSE4Gz6tUp6Dl0yOJLVvBu4iDWfgO+O9iN6wkVOecg6vUYj3gRz5Z/igNVXvuc+4ilxwwUv/v3kXRrIfZU80qQaho2yYts9FnaGlUNSCat5dwrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=ZyuQ4RBJ; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id 200A360B9E
	for <linux-wireless@vger.kernel.org>; Sat, 29 Nov 2025 03:39:14 +0100 (CET)
Received: (qmail 7459 invoked by uid 988); 29 Nov 2025 02:39:14 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.0.1) with ESMTPSA; Sat, 29 Nov 2025 03:39:13 +0100
From: David Bauer <mail@david-bauer.net>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH mt76] wifi: mt76: mt76x02: wake queues after reconfig
Date: Sat, 29 Nov 2025 03:39:02 +0100
Message-ID: <20251129023904.288484-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-2.999999) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -0.099999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=r+TbYhbumj1LE8b1/7eJFLcgqdgfk2pwXQgbmKsupuw=;
	b=ZyuQ4RBJKyUA52XzcpBJ26EPkdMekw9p6Bem8sCEckOnqLoU5lOpVspUv5jatMkVYaLf2nfCzd
	rfPgNtHA3ihFfsc+fRXrieV+Co2ZgOJ9ahaP369qXv5z2bA/UXKOsAh3lLu53WdidtKShM8WznPz
	WwFGhVyza0nuZdbOgQ9wXX7ZmI8AHOAXuLg1yaPniWOGXq5vTA+VI71XiEqssDmPjnc4YXbe58aj
	1pKocbb9eH1VX5cF8oQutygWasZFPB+v0jxD0qeZN5GFujDPWihlegGkIRQ5NJ9X3YXWS/L0crd5
	DYfvTDtFXgfAE+C/8g5PzHnN5Ra40Cz9lkGxnW/ishU/4QWYrugGCwt5CcvaXY9AmoNRqj2lQAYU
	jFcgtjcqcDN36CEGQKfDctVyCQgeZL9sLpejrUPLAAFJJCluj8NHGNwbI2ezTMOIJ4NKnjelwH0/
	f76XnovaeViSjESw00+6jlJ4pUjqsE65RI76wjMVewCf37o9XloKN3O+CHSYWtr3Qv59Sz2Di0kb
	9XxMdx7WDJ3fIy/nrR5LLzqoo+0eI61QDQYGXgZk01khhTPjqaP/PAINiWpo590fdOQrFRIs0eki
	OooHEtIqMY2wHvyfrSBBOG3RgOjWAh1agyv2Hw0Tfzi+paYgJfFQW92CI4qxVhu9YjeJJwwpsaE1
	U=

The shared reset procedure of MT7610 and MT7612 stop all queues before
starting the reset sequence.

They however never restart these like other supported mt76 chips
do in the reconfig_complete call. This leads to TX not continuing
after the reset.

Restart queues in the reconfig_complete callback to restore
functionality after the reset.

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index dd71c1c95cc9b..dc7c03d231238 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -534,6 +534,7 @@ void mt76x02_reconfig_complete(struct ieee80211_hw *hw,
 		return;
 
 	clear_bit(MT76_RESTART, &dev->mphy.state);
+	ieee80211_wake_queues(hw);
 }
 EXPORT_SYMBOL_GPL(mt76x02_reconfig_complete);
 
-- 
2.51.0


