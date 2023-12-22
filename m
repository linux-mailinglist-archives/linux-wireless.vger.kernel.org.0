Return-Path: <linux-wireless+bounces-1223-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0155D81C7F2
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 11:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7081F21E87
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 10:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B871172C;
	Fri, 22 Dec 2023 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EPrOUD3Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qT0VPYiN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7701171B
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703240087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fk7Kko4B9PudLljWtuEpsME8A5xybPiUqopIYUAP8Co=;
	b=EPrOUD3ZtNMG+bGpUkG4zQ7wbqeNI2cSTCWl7OzdZwsWCu3K+IUY3pXLUizM/8LnH7L524
	2Q9s2PMcIvKPBLHWa0gPbH7asuIFRByMGP/wCl8m1GZZMRG+rorab9PxsDRjSX0UyTLaIL
	HAJ4+3KuygovN+GoeP9Al3310gu+kqOrd/ueDG0uvNhe4vmXYox71Kka2eY6UbuCAvartm
	ipoGYdr2Y0z/OJb+pWvSXv0U87kTkrmWGrWsLH7SXFURIAdtnMem9hOMQcWOBVhXIVzeIK
	ciKV3IZT5NFvFIEvNLdqQIDab70EBPOBnra7J6J397BfqetycG7lFICYR1GJlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703240087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fk7Kko4B9PudLljWtuEpsME8A5xybPiUqopIYUAP8Co=;
	b=qT0VPYiNfHxlP8oIDPI8ysVH3IUdfuoDAp+Tg0dqlrZ2AKB6jigHiFA4cc+uEfqtYJFgJU
	IJH4OauHTw/WaPDA==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 02/21] wifi: rtl8xxxu: prepare supporting two virtual interfaces
Date: Fri, 22 Dec 2023 11:14:23 +0100
Message-Id: <20231222101442.626837-3-martin.kaistra@linutronix.de>
In-Reply-To: <20231222101442.626837-1-martin.kaistra@linutronix.de>
References: <20231222101442.626837-1-martin.kaistra@linutronix.de>
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


