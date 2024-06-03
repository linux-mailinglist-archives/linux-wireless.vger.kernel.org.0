Return-Path: <linux-wireless+bounces-8430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D808D858F
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 16:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DD91C21A66
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 14:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B183E130487;
	Mon,  3 Jun 2024 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OB+vF7Po"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68DA12FB2A
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717426573; cv=none; b=sIbZ1Jc+MKimJ9cwNjwyWIdOACiJmHGBiU5p/AO1C40evFoi//kMeuoarZgUWdjbjQ8dAc6cUOSlrSX6nNVLMPKZK9/lDZ9fSw+OAO8yrUkNCdQaDPDrnejCbISB1Ap3IlWY6+rv3AlNn8b6T4yWV+kNTgnhIFmZBhOV6RbXcKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717426573; c=relaxed/simple;
	bh=VDNZo6yk55STGUbIsHlJ9mEJzBUn/9W4PdNv5aCNqf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGADNFjcig7Tk7sKIrf75j3kAaORUAe9HUhlBpSH3etttIzlb2YBEAWI6lTlK6l0k9VBU8RRoTcKsFp2k5cYYKQ/89xy+Uil7qhj7Jt82om0YNU8WcGfA34L+Ae/2RWJcCGRlIS/lyiNv9NRA8gSr9BNzPZlUISjx0CKbBzzvwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OB+vF7Po; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a342201ebso3453905a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 03 Jun 2024 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717426569; x=1718031369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBOZPZXZwfegC0f9vFbYkNX1tuAYznPlwifqa5kbSX8=;
        b=OB+vF7PourYZwDdpKpKiAYPWPs9SGdl4D1lDZADkjRJixkBjPlhzUBljD28hgCMEVw
         FD/l0TZAkX/O4b4Wp39FWPDCHL0bN4vH3HantBzip8DdJjT19CqWervHOoD0qgZXabD+
         5KH5gyDk+PlyskU6wbko384aGlVNv6JwsjiT94pEr0TufPz7GxKDeRRp+cXILjBo4oiu
         rvGiJIZHzEkzyJQ/zaRj6k8zdSaxKiIVc29NVSc+M2UqhTM9xoAk+jcGnUxkz0Yu4yc6
         f9z6pILQPGFZ12jG1WCSTPEpOXG/i+JtRnIxi3r3dlXIiH5MsaVzTFfHMbXxHKI86LiW
         +eQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717426569; x=1718031369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBOZPZXZwfegC0f9vFbYkNX1tuAYznPlwifqa5kbSX8=;
        b=PfDDtwBMUj6N8fLNlrAFJ76tN1dqWVFORgG4VdLshVIi7n94SZG9VJXDNhq/DcugDz
         7vPY2A7x/cCfpooJ1syKSbu7q53rskubtSfHp9a5Txb4XGDcwR/BP2FBEPbtY+Wh+M4G
         +MPn6N3Dt6M49wRvLeWSny878xV7rEz7O9+4ltBTKctjA7x0Yc9pfE+leZvi/hRA6vCF
         6LjT+Z5ChLC8GR6HHc0mE7WD93C2dT5uBK6qCo5uDxKG5lOOn3Twp9IkoYBiCRjcBPru
         NPxZGrtK+qDcnI8JkCIJZyfMg14Q/bHt5wqAeuYyl7e4FL1wuKLqfyzARLvaI1Xvj43v
         a3Ow==
X-Gm-Message-State: AOJu0Yyy3ctj1oSVr9WAVq1RM4V9W459JcqlZ87FEAqjVCnEcizoA7xF
	vmUWzFqvA9pRxmJ6dqlRdssvhqVHId4iinVI9u346Mva+weOudbHJLgVsg==
X-Google-Smtp-Source: AGHT+IG23HFnSEYf9hW6HaajgKlOQ5s0XsClaI+bhYZjtJsmG6EKF1P+RmauaOaj/9BrV1PdKCkPxg==
X-Received: by 2002:a50:cd83:0:b0:57a:79c2:e9d0 with SMTP id 4fb4d7f45d1cf-57a79c2eb22mr96290a12.3.1717426569188;
        Mon, 03 Jun 2024 07:56:09 -0700 (PDT)
Received: from mslusarz-hyperv.mshome.net (1779df417e104.rev.snt.net.pl. [213.192.104.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c6d330sm5325213a12.67.2024.06.03.07.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 07:56:08 -0700 (PDT)
From: =?UTF-8?q?Marcin=20=C5=9Alusarz?= <marcin.slusarz@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Marcin=20=C5=9Alusarz?= <mslusarz@renau.com>
Subject: [PATCH] wifi: rtw88/usb: stop rx work before potential power off
Date: Mon,  3 Jun 2024 16:55:35 +0200
Message-Id: <20240603145535.1858856-1-marcin.slusarz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CA+GA0_v1rpoFrRVxpKpYqOrjdxEecn_m3+RKwxYc9H761dpMvw@mail.gmail.com>
References: <CA+GA0_v1rpoFrRVxpKpYqOrjdxEecn_m3+RKwxYc9H761dpMvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Marcin Ślusarz <mslusarz@renau.com>

Avoids WARN_ON(!local->started) in ieee80211_rx_list, after
the patch that disables power management of 8821CU.

Signed-off-by: Marcin Ślusarz <mslusarz@renau.com>
---
 drivers/net/wireless/realtek/rtw88/hci.h  | 12 +++++++
 drivers/net/wireless/realtek/rtw88/main.c |  7 +++-
 drivers/net/wireless/realtek/rtw88/pci.c  |  6 ++++
 drivers/net/wireless/realtek/rtw88/sdio.c |  6 ++++
 drivers/net/wireless/realtek/rtw88/usb.c  | 40 +++++++++++++++--------
 drivers/net/wireless/realtek/rtw88/usb.h  |  1 +
 6 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/hci.h b/drivers/net/wireless/realtek/rtw88/hci.h
index 830d7532f2a3..d1b38b34fdd0 100644
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
@@ -57,6 +59,16 @@ static inline void rtw_hci_stop(struct rtw_dev *rtwdev)
 	rtwdev->hci.ops->stop(rtwdev);
 }
 
+static inline void rtw_hci_start_rx(struct rtw_dev *rtwdev)
+{
+	rtwdev->hci.ops->start_rx(rtwdev);
+}
+
+static inline void rtw_hci_stop_rx(struct rtw_dev *rtwdev)
+{
+	rtwdev->hci.ops->stop_rx(rtwdev);
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
 
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 7a093f3d5f74..0a3ec94f6ab2 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1590,6 +1590,10 @@ static void rtw_pci_destroy(struct rtw_dev *rtwdev, struct pci_dev *pdev)
 	rtw_pci_io_unmapping(rtwdev, pdev);
 }
 
+static void rtw_pci_nop(struct rtw_dev *rtwdev)
+{
+}
+
 static struct rtw_hci_ops rtw_pci_ops = {
 	.tx_write = rtw_pci_tx_write,
 	.tx_kick_off = rtw_pci_tx_kick_off,
@@ -1600,6 +1604,8 @@ static struct rtw_hci_ops rtw_pci_ops = {
 	.deep_ps = rtw_pci_deep_ps,
 	.link_ps = rtw_pci_link_ps,
 	.interface_cfg = rtw_pci_interface_cfg,
+	.stop_rx = rtw_pci_nop,
+	.start_rx = rtw_pci_nop,
 
 	.read8 = rtw_pci_read8,
 	.read16 = rtw_pci_read16,
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 0cae5746f540..4a7923851c81 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1147,6 +1147,10 @@ static void rtw_sdio_declaim(struct rtw_dev *rtwdev,
 	sdio_release_host(sdio_func);
 }
 
+static void rtw_sdio_nop(struct rtw_dev *rtwdev)
+{
+}
+
 static struct rtw_hci_ops rtw_sdio_ops = {
 	.tx_write = rtw_sdio_tx_write,
 	.tx_kick_off = rtw_sdio_tx_kick_off,
@@ -1156,6 +1160,8 @@ static struct rtw_hci_ops rtw_sdio_ops = {
 	.deep_ps = rtw_sdio_deep_ps,
 	.link_ps = rtw_sdio_link_ps,
 	.interface_cfg = rtw_sdio_interface_cfg,
+	.stop_rx = rtw_sdio_nop,
+	.start_rx = rtw_sdio_nop,
 
 	.read8 = rtw_sdio_read8,
 	.read16 = rtw_sdio_read16,
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index e1b66f339cca..d5cf3eb51c8a 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -716,6 +716,30 @@ static void rtw_usb_interface_cfg(struct rtw_dev *rtwdev)
 	/* empty function for rtw_hci_ops */
 }
 
+static void rtw_usb_stop_rx(struct rtw_dev *rtwdev)
+{
+	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
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
@@ -725,6 +749,8 @@ static struct rtw_hci_ops rtw_usb_ops = {
 	.deep_ps = rtw_usb_deep_ps,
 	.link_ps = rtw_usb_link_ps,
 	.interface_cfg = rtw_usb_interface_cfg,
+	.stop_rx = rtw_usb_stop_rx,
+	.start_rx = rtw_usb_start_rx,
 
 	.write8  = rtw_usb_write8,
 	.write16 = rtw_usb_write16,
@@ -754,18 +780,6 @@ static int rtw_usb_init_rx(struct rtw_dev *rtwdev)
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
@@ -903,7 +917,7 @@ int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
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


