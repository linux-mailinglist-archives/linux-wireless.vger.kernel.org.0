Return-Path: <linux-wireless+bounces-14211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1268D9A3B9D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 12:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9384EB26B49
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 10:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B44C2022CC;
	Fri, 18 Oct 2024 10:32:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53E320127B;
	Fri, 18 Oct 2024 10:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247578; cv=none; b=ePd1xm/qu+jUiWiDqnLO40hiLuofz7zo+XKx3atZm9W/AwGuv162HFnjsvgzxXx+GwozDzwq94/hE6WFJB0P89p1Ntj6voe6h3+fwZli2xOz57jpxKMmW/w+q8v2elabv2eF52GiJgsLQtwvBneY6hZvB9WYOv3bcorlja6su6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247578; c=relaxed/simple;
	bh=3mz4MUIU0xE0dIGnAS6LgmmKdoQPtlgIXHC/oaFPm/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQSygmWeKZS0oe5gcAjdgbC8PjrlykXIg6aLabsvv3OkAxjptd3oHfLqK11clraFzy93wLjPcUoWumbOqbBiyDgK241GzIIww1ITNYhrD1PPzZ69VvIM4hOhBZUNTDsMnYubyd6TrzyVCOkuBpb5cmtGZR0Spk9tu2uvaQ/0eVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, <linux-wireless@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Zheyu Ma <zheyuma97@gmail.com>, Kalle Valo
	<kvalo@kernel.org>
Subject: [PATCH 5.10 1/1] wifi: rtl8xxxu: Fix the error handling of the probe function
Date: Fri, 18 Oct 2024 13:32:30 +0300
Message-ID: <20241018103230.437496-2-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241018103230.437496-1-d.dulov@aladdin.ru>
References: <20241018103230.437496-1-d.dulov@aladdin.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-04.aladdin.ru (192.168.1.104) To
 EXCH-2016-02.aladdin.ru (192.168.1.102)

From: Zheyu Ma <zheyuma97@gmail.com>

commit 13876f2a087ad352bf640a7a0a4a4229ea6e9e4f upstream.

When the driver fails at ieee80211_alloc_hw() at the probe time, the
driver will free the 'hw' which is not allocated, causing a bug.

The following log can reveal it:

[   15.981294] BUG: KASAN: user-memory-access in mutex_is_locked+0xe/0x40
[   15.981558] Read of size 8 at addr 0000000000001ab0 by task modprobe/373
[   15.982583] Call Trace:
[   15.984282]  ieee80211_free_hw+0x22/0x390
[   15.984446]  rtl8xxxu_probe+0x3a1/0xab30 [rtl8xxxu]

Fix the bug by changing the order of the error handling.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20220716130444.2950690-1-zheyuma97@gmail.com
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 5b27c22e7e58..f26b515764b0 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6641,7 +6641,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	if (!hw) {
 		ret = -ENOMEM;
 		priv = NULL;
-		goto exit;
+		goto err_put_dev;
 	}
 
 	priv = hw->priv;
@@ -6664,24 +6664,24 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 
 	ret = rtl8xxxu_parse_usb(priv, interface);
 	if (ret)
-		goto exit;
+		goto err_set_intfdata;
 
 	ret = rtl8xxxu_identify_chip(priv);
 	if (ret) {
 		dev_err(&udev->dev, "Fatal - failed to identify chip\n");
-		goto exit;
+		goto err_set_intfdata;
 	}
 
 	ret = rtl8xxxu_read_efuse(priv);
 	if (ret) {
 		dev_err(&udev->dev, "Fatal - failed to read EFuse\n");
-		goto exit;
+		goto err_set_intfdata;
 	}
 
 	ret = priv->fops->parse_efuse(priv);
 	if (ret) {
 		dev_err(&udev->dev, "Fatal - failed to parse EFuse\n");
-		goto exit;
+		goto err_set_intfdata;
 	}
 
 	rtl8xxxu_print_chipinfo(priv);
@@ -6689,12 +6689,12 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	ret = priv->fops->load_firmware(priv);
 	if (ret) {
 		dev_err(&udev->dev, "Fatal - failed to load firmware\n");
-		goto exit;
+		goto err_set_intfdata;
 	}
 
 	ret = rtl8xxxu_init_device(hw);
 	if (ret)
-		goto exit;
+		goto err_set_intfdata;
 
 	hw->wiphy->max_scan_ssids = 1;
 	hw->wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
@@ -6744,12 +6744,12 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	if (ret) {
 		dev_err(&udev->dev, "%s: Failed to register: %i\n",
 			__func__, ret);
-		goto exit;
+		goto err_set_intfdata;
 	}
 
 	return 0;
 
-exit:
+err_set_intfdata:
 	usb_set_intfdata(interface, NULL);
 
 	if (priv) {
@@ -6757,9 +6757,10 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 		mutex_destroy(&priv->usb_buf_mutex);
 		mutex_destroy(&priv->h2c_mutex);
 	}
-	usb_put_dev(udev);
 
 	ieee80211_free_hw(hw);
+err_put_dev:
+	usb_put_dev(udev);
 
 	return ret;
 }
-- 
2.25.1


