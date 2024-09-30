Return-Path: <linux-wireless+bounces-13317-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F37989D40
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 10:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9BAE280E2E
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 08:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5143B17A5A7;
	Mon, 30 Sep 2024 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yDQ0qU7D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lepPxfJE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BAD13DB92
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686206; cv=none; b=GaEw6XGgqckHBvy6ON+GDZ20qnTZEWDp7LMoKjmaxX/1bHF1kpfM3+Tc7YaRsxDkeXj9H4dZFybdBTKRudARufKzksIHDyuYGzNWUcwh+7rwSIuk9NCremYIbYc0gDBoRp3MjLJ38xttzywI2VFFIlGDL+drb/yEju3pPUgCS34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686206; c=relaxed/simple;
	bh=xpuNvtbie8KRHvHviAeyKrcJoFgn2ujGgkdiXYHW55s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TheWssjB7OD+7Eede2Kf8sH/pEZIEfy9RqMuuPsckzS3UDOfp5QLcqNizJsDz+vbaskQwPkLwbM5n8ZapWKbaAlKScQWv+uafbcBfyPUbjnTUrXHXoGdNuZPKkgcF41XejpndlNAFzkOj6KmHz0yluMQLOZGEBWbcEbr0piY71Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yDQ0qU7D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lepPxfJE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727686201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ckv9nAlTD6BnATcKYD5DwGaJEX2aVRsjR9zKuct5KDg=;
	b=yDQ0qU7DqmUcX008OwqPzNFJs9Pkr8oV1t1ojO0zawxd8RkbmxRGnFFhV65wd5GsGDuw7X
	212JBP9a8f8A7DkEyBdAXigdcGTYsPhSzWmR6Ii+//8wx5L+5dPQ/qRPfqyDiOM3L1Hq5i
	ycfTSgn2vxB+XLzt9rjjAuPyiLLEPsQEeyttu3tp49442joZmzZgxRjJCQ9b9cEmL5cCPh
	QKKvk8UVVuUAAjEY626kf8n9Mcc4/bBic+xcvWOyIZywLFXB8JNuJSr9nZib6e/6irKY3/
	XMxEZp3rGyvM/OCPdOZ5n8UBMMIyQwR9YtgKGSY6twYwjjdOavQlp7H2lzPbjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727686201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ckv9nAlTD6BnATcKYD5DwGaJEX2aVRsjR9zKuct5KDg=;
	b=lepPxfJE0TWt0JuB+VfIGW7IgMhMXMD55z1w/PiFi5pHrJdGck80sRIFkS8tg2whCqzVH1
	txzHJp71gY7L07CA==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: Perform update_beacon_work when beaconing is enabled
Date: Mon, 30 Sep 2024 10:49:55 +0200
Message-Id: <20240930084955.455241-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In STA+AP concurrent mode, performing a scan operation on one vif
temporarily stops beacons on the other. When the scan is completed,
beacons are enabled again with BSS_CHANGED_BEACON_ENABLED.

We can observe that no beacons are being sent when just
rtl8xxxu_start_tx_beacon() is being called.

Thus, also perform update_beacon_work in order to restore beaconing.

Fixes: cde8848cad0b ("wifi: rtl8xxxu: Add beacon functions")
Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 7891c988dd5f0..f95898f68d68a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -5058,10 +5058,12 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	}
 
 	if (changed & BSS_CHANGED_BEACON_ENABLED) {
-		if (bss_conf->enable_beacon)
+		if (bss_conf->enable_beacon) {
 			rtl8xxxu_start_tx_beacon(priv);
-		else
+			schedule_delayed_work(&priv->update_beacon_work, 0);
+		} else {
 			rtl8xxxu_stop_tx_beacon(priv);
+		}
 	}
 
 	if (changed & BSS_CHANGED_BEACON)
-- 
2.39.5


