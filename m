Return-Path: <linux-wireless+bounces-1152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1407081BC38
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 17:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AF75B24507
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 16:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF3558211;
	Thu, 21 Dec 2023 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ehR82CWT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KPGdEM8E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DC955E73
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703177042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fk7Kko4B9PudLljWtuEpsME8A5xybPiUqopIYUAP8Co=;
	b=ehR82CWTDO+W+39fktCuhSCHx4jLryJRdjboJdY11fnf6lCIyq1FbsKqnhPbMfPms4nKol
	F5uJzoGJt8lFR2lRZHYhblxvEq7StfrTW6C6ZIad99yC56c3F800go3GPs+9sulJEYxfO5
	zbqn1JcUcUW6JH/dCmet0Tld07WTu1GaLUrpaEY7nO/I8hyS3Ad155wgAXGc0LO250LRxP
	zR29pCZuUUVu41IIYevIh7m98hCwl8ADRc2J1Cv3AzyNdll3DXZynC7PboJJ9dI1oeHPMN
	WaR5hTO2CPwTEDxl7rjfKJ1A1QXWYPETSbAF2e2LRy6W08WvezS4Vn4Iq06kUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703177042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fk7Kko4B9PudLljWtuEpsME8A5xybPiUqopIYUAP8Co=;
	b=KPGdEM8EuuJlxeKMSsEyZUgZf5UkZuBdeIhuoMi4Bl7+h9H1G6jHujCGlWLWpz1w3BInz2
	Q7djI+TXDI5i+HBw==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 02/21] wifi: rtl8xxxu: prepare supporting two virtual interfaces
Date: Thu, 21 Dec 2023 17:43:34 +0100
Message-Id: <20231221164353.603258-3-martin.kaistra@linutronix.de>
In-Reply-To: <20231221164353.603258-1-martin.kaistra@linutronix.de>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for concurrent mode, add an array ("vifs") to rtl8xxxu_priv
to keep track of both interfaces.

Keep the old priv->vif as long there are still users of it and let
priv->vifs[0] point to the same location.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h      |  2 ++
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 10 +++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 4695fb4e2d2db..b63fe084de92b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1897,6 +1897,8 @@ struct rtl8xxxu_priv {
 	 * is supported and no iface_combinations are provided.
 	 */
 	struct ieee80211_vif *vif;
+
+	struct ieee80211_vif *vifs[2];
 	struct delayed_work ra_watchdog;
 	struct work_struct c2hcmd_work;
 	struct sk_buff_head c2hcmd_queue;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 2dbed43ef22a5..5b7c20970a973 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6569,10 +6569,12 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
 	int ret;
 	u8 val8;
 
-	if (!priv->vif)
+	if (!priv->vif) {
 		priv->vif = vif;
-	else
+		priv->vifs[0] = vif;
+	} else {
 		return -EOPNOTSUPP;
+	}
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_STATION:
@@ -6622,8 +6624,10 @@ static void rtl8xxxu_remove_interface(struct ieee80211_hw *hw,
 
 	dev_dbg(&priv->udev->dev, "%s\n", __func__);
 
-	if (priv->vif)
+	if (priv->vif) {
 		priv->vif = NULL;
+		priv->vifs[0] = NULL;
+	}
 }
 
 static int rtl8xxxu_config(struct ieee80211_hw *hw, u32 changed)
-- 
2.39.2


