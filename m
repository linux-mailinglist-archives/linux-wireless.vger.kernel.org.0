Return-Path: <linux-wireless+bounces-1224-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF66481C7F3
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 11:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4251F23DAB
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 10:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FEE12E7E;
	Fri, 22 Dec 2023 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PYkicMDK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="91dTps6o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2865311718
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
	bh=AD/UWDpvb64eNsq/DlT0s9OFs2phvtiEvsApnsLFqZU=;
	b=PYkicMDKurraPaf4k2TV8pIMdoYKk93gghKxl8jGjL9x406F8sBJAyRkvjs9Yla9MuA1ca
	qHTw69Xj/oY6RtJ2oQEORP+u+hhePDrIjZDXwSUL0M6atxWz0JQmr8PnbSfryG7OhVm5uj
	WciVJvtkylEdkj6L39i/igNpufzDIGnlLxxfxYa0c99NUCi7mu6mLnxG9mbaSy55wIAzQK
	ziGJDeFKdg82z6FWFdWHOpwfN+NdnbqH57gZ200GRgPogSZU0q+XijpmhYJdrLv385eRTB
	Jvrdsr9BSQC7hH7pPTsxBGWm3v0BnVMJ3XmbgswGzLl6C7QFdWhOFmbkYXDu3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703240087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AD/UWDpvb64eNsq/DlT0s9OFs2phvtiEvsApnsLFqZU=;
	b=91dTps6oqJadQAFG+Tn+NaP1OSzcMH9k9Y7bHN6EDoYJnCUM6TWMW5ZeNS2gcncHGycRgt
	P9wboWwRQam0t1BA==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 04/21] wifi: rtl8xxxu: 8188e: convert usage of priv->vif to priv->vifs[0]
Date: Fri, 22 Dec 2023 11:14:25 +0100
Message-Id: <20231222101442.626837-5-martin.kaistra@linutronix.de>
In-Reply-To: <20231222101442.626837-1-martin.kaistra@linutronix.de>
References: <20231222101442.626837-1-martin.kaistra@linutronix.de>
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
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
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


