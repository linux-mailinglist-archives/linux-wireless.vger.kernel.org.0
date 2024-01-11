Return-Path: <linux-wireless+bounces-1737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69B282B317
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 17:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D371C1C226A4
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 16:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77AF50250;
	Thu, 11 Jan 2024 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hnG0n5sY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1x7AAn3R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834874F8A1
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704990995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OB0s/z6bnRI4QKf5W1H9548PCsW6sTwDXG17hcGIWs=;
	b=hnG0n5sYQolgavuPaOKmw5Zk8bg3cxASArzLCtdjRRdHGM8qYniWWAR1d4ItAeE0rrsmL6
	A80iQ/zz9pc93fw05C3Q5ThrT/Niz+4ugzgPx0thNfNGe1zyd3l/Ai187fn+1upcchq8+a
	ndsad3xgg5bJ7sWUF0+LAJunAVV1LHlhD5GWHk4uxBSSSgnJRj9omHKBXxQ5n3NEcpXYlp
	4QiKPRbF4d+pyYRnTeVkl5tw0G4HORKD+1bR+FbNYOY//DZmDSKmeLbdAMw7c2yotsSPD1
	kyaREnk67BASKKphHp50Tkm2fZtI3lA8emzJeKIdwBUAYhJaWhTTKJ/8b7VjGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704990995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OB0s/z6bnRI4QKf5W1H9548PCsW6sTwDXG17hcGIWs=;
	b=1x7AAn3RYlhI+eZtMTWLVr56HgoFIYN9IQuUtdrLzqakvEjs9oHuSiVzU3hS6x5Ge3SXPd
	yW45nfmLz/8mWlBw==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 1/2] wifi: rtl8xxxu: add cancel_work_sync() for c2hcmd_work
Date: Thu, 11 Jan 2024 17:36:27 +0100
Message-Id: <20240111163628.320697-2-martin.kaistra@linutronix.de>
In-Reply-To: <20240111163628.320697-1-martin.kaistra@linutronix.de>
References: <20240111163628.320697-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The workqueue might still be running, when the driver is stopped. To
avoid a use-after-free, call cancel_work_sync() in rtl8xxxu_stop().

Fixes: e542e66b7c2e ("rtl8xxxu: add bluetooth co-existence support for single antenna")
Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index aac5940936290..757ebd46452eb 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7480,6 +7480,7 @@ static void rtl8xxxu_stop(struct ieee80211_hw *hw)
 	if (priv->usb_interrupts)
 		rtl8xxxu_write32(priv, REG_USB_HIMR, 0);
 
+	cancel_work_sync(&priv->c2hcmd_work);
 	cancel_delayed_work_sync(&priv->ra_watchdog);
 
 	rtl8xxxu_free_rx_resources(priv);
-- 
2.39.2


