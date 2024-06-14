Return-Path: <linux-wireless+bounces-9013-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEE8908B57
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 14:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF3D1F29005
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 12:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E265144D37;
	Fri, 14 Jun 2024 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQw7K2zY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAA012F5A0
	for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2024 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367241; cv=none; b=KykY7xMMXqZ7JZ4jtNAJOdz7MV4vf6EuKXgAJ4wIaX22pv/o3glD+FoooOiB6RgWR+1VfrYjYkQ+r+N9V3EhutxCBXdWLaoFhRJooy4LUzQG7x/jSZLBs6kvbygeSAfACn12+2JVFbLHODQVKsg6JZgoR1IaLIpFczKmiu+G2A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367241; c=relaxed/simple;
	bh=KHF/jLnC9vMfaKvDk1AwKMc2fISZ52nw9avlBC0H1tU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4Ic6e6kzKstCGv5YZQUXWVbZlFabLd2jmwwNl2/H3omi84zfH7PbJznlptlYriqeZibTkETb9Py78qySNU8Ojj9fn4yVGY594qwXMoLWmyqXLgug+Oh1WN/PmKQDfIfIsT7pM+2qDmndqZEM3c9L125VYrHiuuWsT4yJh/exo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQw7K2zY; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57c778b5742so2441246a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2024 05:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718367237; x=1718972037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hjff7vFeE5DGnhdVIsezWhuUbdqKBVCgEO52UjoBfyM=;
        b=JQw7K2zYH4fvkErzwfnUENOWB0g3rcoDvPAyNbbmC6QdG+wTpBIZIw063I7EfPiElR
         YfoEmLpkDigyhhU4w4tKjFDWetw9+vTyORt3iDWEJszGQaZG5m39hqOkUN5KFvppEYBQ
         8BtAMeUgn0bTHX55HpGwMVxz2GxTwKkAlYMOFTuF9W1F83CMwHlaPoybiBtH9Zm7Pvv7
         JWKfo/qn4AWBnFy0HhpZJvkgRjmWcyAePHNbWqFujwEUQndlzJl5xrxQl7/JSfZK18IR
         CHtYGakzoIWIPUmBaerhrzNqCJK/s/cViMC8pimQLWKyYwNnX+gGLOK8aqj++eKpJek8
         CKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718367237; x=1718972037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hjff7vFeE5DGnhdVIsezWhuUbdqKBVCgEO52UjoBfyM=;
        b=vJP0+hz9lOGRuFcL8PWg/re+P4Q8FRbZWC8/WqCL7kjjPKb463SoCp4mWqDtxNav8l
         zy7+AshjH9sW872HOl+RfhMuLYBFnm3NM4d1kJ71EKSdZv0PkQ9tZGuedMG6zIkzQQX+
         8+D+mB3itALARyhOY3oPDUtqixg3JzqL9s3SFs+t0Znz2pIvmAa2DmIpfL5zIg7/2J/6
         H1hJO/yJgelvWGNuv/cemfl+FOZGqu1xE7zZFHJYvNnbOqGpMXjX9CZ0NuysU15ne00q
         cFnVWfTmHF7NO99rQfSvbEmaKyamDkD7yJB/ge3RPecIW3JIT9LJ075m70YuXyaHgvhG
         pjeg==
X-Gm-Message-State: AOJu0YzIS6Wlsab6HuwlUEZkXMTQeRDootgwkHuAFXR2hZkfk5fKEp38
	28upi0d0T+8VRI11kctpl+rH4H7W8CRqRb6WrGzQHPwxMvn4TP3KDNdgCw==
X-Google-Smtp-Source: AGHT+IHCDRdzgLNxxKDbYd/km1l/zs5hIz5SAiT857b188Df9ByaqQddUm8YmYV8uwZhGBFPf0aVUw==
X-Received: by 2002:a17:906:451:b0:a6f:4954:30fb with SMTP id a640c23a62f3a-a6f60cefe08mr163489366b.2.1718367237125;
        Fri, 14 Jun 2024 05:13:57 -0700 (PDT)
Received: from mslusarz-hyperv.mshome.net (078088142095.jeleniagora.vectranet.pl. [78.88.142.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da4136sm181082466b.36.2024.06.14.05.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 05:13:56 -0700 (PDT)
From: "=?UTF-8?q?Marcin=20=C5=9Alusarz?=" <marcin.slusarz@gmail.com>
X-Google-Original-From: =?UTF-8?q?Marcin=20=C5=9Alusarz?= <mslusarz@renau.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Marcin=20=C5=9Alusarz?= <mslusarz@renau.com>
Subject: [PATCH v2 2/2] wifi: rtw88/usb: stop rx work before potential power off
Date: Fri, 14 Jun 2024 14:13:39 +0200
Message-Id: <20240614121339.525935-2-mslusarz@renau.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240614121339.525935-1-mslusarz@renau.com>
References: <CA+GA0_tK_+Rsj0FAxO-_VXBLLFMoxW9FHsWhL6gEoWaOMKwWrA@mail.gmail.com>
 <20240614121339.525935-1-mslusarz@renau.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If power off is disabled (like on 8821CU after previous patch),
the hardware can still fire and deliver data. This may have
undersired impact on the networking stack (e.g.
WARN_ON(!local->started) in ieee80211_rx_list), because hw is
not supposed to do that after power off.

So to prevent that, cancel any pending RX URBs to stop the
completion handlers from being called.

Signed-off-by: Marcin Ślusarz <mslusarz@renau.com>
---
v2: start_rx/stop_rx cbs can be NULL; rx_enabled check added to stop_rx
---
 drivers/net/wireless/realtek/rtw88/hci.h  | 14 ++++++++
 drivers/net/wireless/realtek/rtw88/main.c |  7 +++-
 drivers/net/wireless/realtek/rtw88/usb.c  | 44 ++++++++++++++++-------
 drivers/net/wireless/realtek/rtw88/usb.h  |  1 +
 4 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/hci.h b/drivers/net/wireless/realtek/rtw88/hci.h
index 830d7532f2a3..839b9161014f 100644
--- a/drivers/net/wireless/realtek/rtw88/hci.h
+++ b/drivers/net/wireless/realtek/rtw88/hci.h
@@ -18,6 +18,8 @@ struct rtw_hci_ops {
 	void (*deep_ps)(struct rtw_dev *rtwdev, bool enter);
 	void (*link_ps)(struct rtw_dev *rtwdev, bool enter);
 	void (*interface_cfg)(struct rtw_dev *rtwdev);
+	void (*stop_rx)(struct rtw_dev *rtwdev);
+	void (*start_rx)(struct rtw_dev *rtwdev);
 
 	int (*write_data_rsvd_page)(struct rtw_dev *rtwdev, u8 *buf, u32 size);
 	int (*write_data_h2c)(struct rtw_dev *rtwdev, u8 *buf, u32 size);
@@ -57,6 +59,18 @@ static inline void rtw_hci_stop(struct rtw_dev *rtwdev)
 	rtwdev->hci.ops->stop(rtwdev);
 }
 
+static inline void rtw_hci_start_rx(struct rtw_dev *rtwdev)
+{
+	if (rtwdev->hci.ops->start_rx)
+		rtwdev->hci.ops->start_rx(rtwdev);
+}
+
+static inline void rtw_hci_stop_rx(struct rtw_dev *rtwdev)
+{
+	if (rtwdev->hci.ops->stop_rx)
+		rtwdev->hci.ops->stop_rx(rtwdev);
+}
+
 static inline void rtw_hci_deep_ps(struct rtw_dev *rtwdev, bool enter)
 {
 	rtwdev->hci.ops->deep_ps(rtwdev, enter);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index a48e919adddb..bb0122d19416 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1357,7 +1357,7 @@ static int rtw_power_on(struct rtw_dev *rtwdev)
 	int ret;
 
 	if (rtwdev->always_power_on && test_bit(RTW_FLAG_POWERON, rtwdev->flags))
-		return 0;
+		goto success;
 
 	ret = rtw_hci_setup(rtwdev);
 	if (ret) {
@@ -1407,6 +1407,9 @@ static int rtw_power_on(struct rtw_dev *rtwdev)
 	rtw_coex_power_on_setting(rtwdev);
 	rtw_coex_init_hw_config(rtwdev, wifi_only);
 
+success:
+	rtw_hci_start_rx(rtwdev);
+
 	return 0;
 
 err_off:
@@ -1509,6 +1512,8 @@ int rtw_core_start(struct rtw_dev *rtwdev)
 
 static void rtw_power_off(struct rtw_dev *rtwdev)
 {
+	rtw_hci_stop_rx(rtwdev);
+
 	if (rtwdev->always_power_on)
 		return;
 
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 28ff46e96604..8e784c357ee2 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -713,6 +713,34 @@ static void rtw_usb_interface_cfg(struct rtw_dev *rtwdev)
 	/* empty function for rtw_hci_ops */
 }
 
+static void rtw_usb_stop_rx(struct rtw_dev *rtwdev)
+{
+	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
+
+	if (!rtwusb->rx_enabled)
+		return;
+
+	rtw_usb_cancel_rx_bufs(rtwusb);
+	rtwusb->rx_enabled = false;
+}
+
+static void rtw_usb_start_rx(struct rtw_dev *rtwdev)
+{
+	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
+	int i;
+
+	if (rtwusb->rx_enabled)
+		return;
+
+	for (i = 0; i < RTW_USB_RXCB_NUM; i++) {
+		struct rx_usb_ctrl_block *rxcb = &rtwusb->rx_cb[i];
+
+		rtw_usb_rx_resubmit(rtwusb, rxcb);
+	}
+
+	rtwusb->rx_enabled = true;
+}
+
 static struct rtw_hci_ops rtw_usb_ops = {
 	.tx_write = rtw_usb_tx_write,
 	.tx_kick_off = rtw_usb_tx_kick_off,
@@ -722,6 +750,8 @@ static struct rtw_hci_ops rtw_usb_ops = {
 	.deep_ps = rtw_usb_deep_ps,
 	.link_ps = rtw_usb_link_ps,
 	.interface_cfg = rtw_usb_interface_cfg,
+	.stop_rx = rtw_usb_stop_rx,
+	.start_rx = rtw_usb_start_rx,
 
 	.write8  = rtw_usb_write8,
 	.write16 = rtw_usb_write16,
@@ -751,18 +781,6 @@ static int rtw_usb_init_rx(struct rtw_dev *rtwdev)
 	return 0;
 }
 
-static void rtw_usb_setup_rx(struct rtw_dev *rtwdev)
-{
-	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
-	int i;
-
-	for (i = 0; i < RTW_USB_RXCB_NUM; i++) {
-		struct rx_usb_ctrl_block *rxcb = &rtwusb->rx_cb[i];
-
-		rtw_usb_rx_resubmit(rtwusb, rxcb);
-	}
-}
-
 static void rtw_usb_deinit_rx(struct rtw_dev *rtwdev)
 {
 	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
@@ -900,7 +918,7 @@ int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		goto err_destroy_rxwq;
 	}
 
-	rtw_usb_setup_rx(rtwdev);
+	rtw_usb_start_rx(rtwdev);
 
 	return 0;
 
diff --git a/drivers/net/wireless/realtek/rtw88/usb.h b/drivers/net/wireless/realtek/rtw88/usb.h
index 86697a5c0103..a6b004d4f74e 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.h
+++ b/drivers/net/wireless/realtek/rtw88/usb.h
@@ -82,6 +82,7 @@ struct rtw_usb {
 	struct rx_usb_ctrl_block rx_cb[RTW_USB_RXCB_NUM];
 	struct sk_buff_head rx_queue;
 	struct work_struct rx_work;
+	bool rx_enabled;
 };
 
 static inline struct rtw_usb_tx_data *rtw_usb_get_tx_data(struct sk_buff *skb)
-- 
2.25.1


