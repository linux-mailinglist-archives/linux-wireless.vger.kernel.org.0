Return-Path: <linux-wireless+bounces-8135-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A92C28D08FC
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 19:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF352820C1
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 17:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4726155CA5;
	Mon, 27 May 2024 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtuqOepR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7934E6FB0;
	Mon, 27 May 2024 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716829340; cv=none; b=O8inGWK38CV4M5zMd5nDPlOhh/YiRpwDLd1FUkpHBRS0t18Fn32A1bpU6PJ8NXkgxrEO9qg0UjvO9YpTs7z9bQph4Y+cW2yk/mWchaaOcctDvHCcNJ59t9krBnTWch7Pb10My1bJajwj5jOu//XPeiuK+gGNn1wnQ7k9jFxwg/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716829340; c=relaxed/simple;
	bh=UH5jbQ1ExU6rF0ycNuWGeiHpq0CHgcaCU5amH+tnEzo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=S0Uc7g5e1aLzh+jdU82nB/AS7ebRCu5GqQ7E87bxpX33G7HSOQ0iXO+OqCVccAas+oNVySowO9y+2vKE7ndATnFhoxEhk9IOyKCFtzJgsyuFo3RNnNKmP9XK7WISMlqiTXtabosX6TOAh5LYqe0ZvyETd74ppAaujCpFIg8tiNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtuqOepR; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-529661f2552so3324045e87.2;
        Mon, 27 May 2024 10:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716829336; x=1717434136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ke2wFmW7lwdlJUKXnCszi5dmNPopJyhPXGzvDznThNk=;
        b=BtuqOepRcnq6erBpDC556K6VkX3PtzhkGMO2kfD5CN7bQ0aUvRBXGiKU7UxHM9tH0t
         byA3X6FO7wQtZkXYHOu/6lX0slJaQLhKYyr6Hhyq8q41ZcjIAQ3FIv5PWz8n4n8DTUZF
         YzuKMfL66fuftOYAAvGD5KQhpeHcV+dbPQhOv+9ZzhVns+IyNX907UKcES2sHcdQYV+H
         LqA/FUUjFRK889t/OgBSxsWVKKABv2yFlbm+A3YIvQsNQQ9NtaZMTL+V8Bq/35OSb1Ql
         i1HJF2lPLdIutdOdtK2vb5G1XHJC3wqU8OjSSROkulzVuqTI1KJhhF/JCu8egQXsAtm4
         opmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716829336; x=1717434136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ke2wFmW7lwdlJUKXnCszi5dmNPopJyhPXGzvDznThNk=;
        b=GgVvxLao+tcwgSvXPeB7C5yTETTnLbTBRykSgWw7qrgxTmnKYtbnx7Ezx7d2o7RHNJ
         QbanQnOPPem/zTQVc+lW50ljXhurjKrvRbEHik1p/tUz+iZy30L0KAwlGftW5ZIbTAUJ
         xv33LZgzG/LWfGMYvcxRT6tXj1yBLnqZPxY4NvYzWfGrnmXZBHGITjGdz4WAT4XIwfCq
         5Ccu0MwHu6XgV34pVteM+09kSqG/pRTxd9RHVHtNyLJE/vpy0DXS+dHNsLbiSKDlvKM9
         Xqn8BxsTtNSFSZSKFda/+r+E1wc5Lya7oGI7LY23tY0tr+LH5wDFmeVP2QcQu8wnwYQp
         H8Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWWoeiur/pCsk5AdWjzBuEiaWHX7kJnRQ5LizM8+5StwDLJ9WO/M/PBZxqP8T9zVteCqAH9jYlN2VleBZFOe+eVhaeM44z6gQndKrP1
X-Gm-Message-State: AOJu0Yz04bMX7q11Yvvv4drp3I1zwIZqjiEurd9Tlj23EaauGHk49rmJ
	g1uFaM9g5SWbJ1e+9x5zQMjNcE+gXB659FeztT0oDRNRbKYKnlb+vGaF92yf
X-Google-Smtp-Source: AGHT+IEcr5JzU5aF4BzGeMHHDb9m3TkWG32KGUvLhVqaPVtwcZzBrcVd8yipPSLiup6xzM3AzX+dFQ==
X-Received: by 2002:ac2:4214:0:b0:525:502a:acc6 with SMTP id 2adb3069b0e04-529668c9e48mr5908436e87.52.1716829335955;
        Mon, 27 May 2024 10:02:15 -0700 (PDT)
Received: from mslusarz-hyperv.mshome.net (1779df417e104.rev.snt.net.pl. [213.192.104.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817a98sm512017466b.37.2024.05.27.10.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 10:02:15 -0700 (PDT)
From: marcin.slusarz@gmail.com
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Marcin=20=C5=9Alusarz?= <mslusarz@renau.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Kalle Valo <kvalo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: rtw88: schedule rx work after everything is set up
Date: Mon, 27 May 2024 19:01:37 +0200
Message-Id: <20240527170137.455671-1-marcin.slusarz@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Marcin Ślusarz <mslusarz@renau.com>

Right now it's possible to hit NULL pointer dereference in
rtw_rx_fill_rx_status on hw object and/or its fields because
initialization routine can start getting USB replies before
rtw_dev is fully setup.

The stack trace looks like this:

rtw_rx_fill_rx_status
rtw8821c_query_rx_desc
rtw_usb_rx_handler
...
queue_work
rtw_usb_read_port_complete
...
usb_submit_urb
rtw_usb_rx_resubmit
rtw_usb_init_rx
rtw_usb_probe

So while we do the async stuff rtw_usb_probe continues and calls
rtw_register_hw, which does all kinds of initialization (e.g.
via ieee80211_register_hw) that rtw_rx_fill_rx_status relies on.

Fix this by moving the first usb_submit_urb after everything
is set up.

For me, this bug manifested as:
[    8.893177] rtw_8821cu 1-1:1.2: band wrong, packet dropped
[    8.910904] rtw_8821cu 1-1:1.2: hw->conf.chandef.chan NULL in rtw_rx_fill_rx_status
because I'm using Larry's backport of rtw88 driver with the NULL
checks in rtw_rx_fill_rx_status.

This should fix:
https://marc.info/?l=linux-wireless&m=167907688311943&w=2

Signed-off-by: Marcin Ślusarz <mslusarz@renau.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/wireless/realtek/rtw88/usb.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index a0188511099a..98f81e3ae13e 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -740,7 +740,6 @@ static struct rtw_hci_ops rtw_usb_ops = {
 static int rtw_usb_init_rx(struct rtw_dev *rtwdev)
 {
 	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
-	int i;
 
 	rtwusb->rxwq = create_singlethread_workqueue("rtw88_usb: rx wq");
 	if (!rtwusb->rxwq) {
@@ -752,13 +751,19 @@ static int rtw_usb_init_rx(struct rtw_dev *rtwdev)
 
 	INIT_WORK(&rtwusb->rx_work, rtw_usb_rx_handler);
 
+	return 0;
+}
+
+static void rtw_usb_setup_rx(struct rtw_dev *rtwdev)
+{
+	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
+	int i;
+
 	for (i = 0; i < RTW_USB_RXCB_NUM; i++) {
 		struct rx_usb_ctrl_block *rxcb = &rtwusb->rx_cb[i];
 
 		rtw_usb_rx_resubmit(rtwusb, rxcb);
 	}
-
-	return 0;
 }
 
 static void rtw_usb_deinit_rx(struct rtw_dev *rtwdev)
@@ -895,6 +900,8 @@ int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		goto err_destroy_rxwq;
 	}
 
+	rtw_usb_setup_rx(rtwdev);
+
 	return 0;
 
 err_destroy_rxwq:
-- 
2.25.1


