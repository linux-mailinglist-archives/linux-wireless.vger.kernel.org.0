Return-Path: <linux-wireless+bounces-912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E63BA8173BE
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 15:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484562813B9
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 14:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90AF3064A;
	Mon, 18 Dec 2023 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b+3Tnurs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zkuVj1Qp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815823786E
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702910227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzsqM0SUc/jjw0gmWP1m/hJ9HqquK8z8C1PFOnd93Ng=;
	b=b+3TnursnHhGpupeFQ1iYliO0l65IYK4vEqnmNPS7PQbwHLiltlsmRK0qGKrh9YyI7DvaS
	Qe8Z0QkbCRHVUxXlBowToPrrjcMlIikXbKbglO1oFga3mdiCyt4vyQNxg51P7Jrzm0Q3da
	MLCFh39Yg4+Puhuu6qlAObSDJ291d/ZKi+VqR4UzzI6f0zr3JWPI907HKZsiT1TVAVgtOP
	1VS5g4TVYlmf3IYbFlj9I8wPekji7t/RWg7CY73Zbjq4BCv0dTVwUKNr3Pq5mYEQjpITWH
	ZfWxh/MYJFSkeW/IrsMfHlpNfFzGL6MCNHOWpN0cpKtNfJEYlCbxft/goKcSUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702910227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzsqM0SUc/jjw0gmWP1m/hJ9HqquK8z8C1PFOnd93Ng=;
	b=zkuVj1QpInfPj8UXMf7ZUE0FO9b/qQjOzdrdDvBzMxJJD+GvmE7S2dElrDtcrqTuyDAv/o
	u/ZkYSeiuqFFjsAQ==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 04/20] wifi: rtl8xxxu: 8188e: convert usage of priv->vif to priv->vifs[0]
Date: Mon, 18 Dec 2023 15:36:29 +0100
Message-Id: <20231218143645.433356-5-martin.kaistra@linutronix.de>
In-Reply-To: <20231218143645.433356-1-martin.kaistra@linutronix.de>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently does not support AP or concurrent mode for 8188e,
so just use priv->vifs[0] instead of priv->vif for now.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
index 6d0f975f891b7..cbeac9386ae51 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
@@ -1699,7 +1699,7 @@ void rtl8188e_handle_ra_tx_report2(struct rtl8xxxu_priv *priv, struct sk_buff *s
 	/* We only use macid 0, so only the first item is relevant.
 	 * AP mode will use more of them if it's ever implemented.
 	 */
-	if (!priv->vif || priv->vif->type == NL80211_IFTYPE_STATION)
+	if (!priv->vifs[0] || priv->vifs[0]->type == NL80211_IFTYPE_STATION)
 		items = 1;
 
 	for (macid = 0; macid < items; macid++) {
-- 
2.39.2


