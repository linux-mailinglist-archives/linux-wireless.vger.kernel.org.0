Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB7C192281
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 09:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgCYIVI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 04:21:08 -0400
Received: from mail-dm6nam10on2113.outbound.protection.outlook.com ([40.107.93.113]:25385
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbgCYIVI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 04:21:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4OtHFPgsx4dKufm8nDe0sEjGKPqkWFjSiYc1VBytzT7v77t+7Z9W4mrCVg2rCPOTP2INEGjSkuDuMbbCnLmbrjWyxw1qdwXCPrSdLj958PtGz+OOUqweWnSCThCcaa8imXspAC8Kt4/NwZu8ihEggrKpVBxBY4fJ24OrP9RhSVA/oLKTmwdl9ocov4x0nbpIxH8bKyKA1MYeWtMoKCvq+IqGnz/pImY/wHehnt2A4GxZunohA5qD1zNM84De6s8CVpp01VvZ7n/ZaMmhTFJ25avkA4HPym9dq6umwp40I7BT8RSS05sTVx1kKelQ0SYRe9+t4dzY8Jk98fDK0hkWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuw8RhWao9lrRfa+OSDejbozIWpA5cQBAZoztrmqxaQ=;
 b=auMrCr00ZBAuFb23j1pme0xsAQtSLeco2acLWMl7dnK5/IfW2GunuVaPpIJn44pPJbZTpC0S/QWjkYoAeoTHnt/651PTLl1pabVIKx1axSP6tWkOC2jQN6Xorg9xu9wZ3XZJsRJq7Rsnkf1mVg4yq06FqSHZYj+TVGeSJpL7W8ounbfpZ+48SCk6ej8d0EXNxMGobA2tMTmSfUuYNuGBCXFrl3KDQr9nb+lvTxXyqJ6IRcPK4cZOG/X11s1mSQY/FMd1K8hihU/47qvr+F5v7WuCVdAmmGSZCEPHp3henSSLCLOJh/ek57S6nYT6aiTUoXRBOUVbOAhe9VSkdSVQ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuw8RhWao9lrRfa+OSDejbozIWpA5cQBAZoztrmqxaQ=;
 b=ULeWTwXQta7BxWbGQhwA8uO66rp/xc0t+RUbXV9xKM3Y2eCpHpjXnn0F8XzPOd1AeM1FUN6KgbkmEZ3E2OPLlhpCnL3KqqlGrc5eqwUAnc0d32/TyxpdNKskcJMTHh4vNA4lBGgv/28Zzya2LyO1Uab3IFG/2pBv3s+SxNhrj5M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5189.namprd06.prod.outlook.com (2603:10b6:a03:cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15; Wed, 25 Mar
 2020 08:20:57 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1%3]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 08:20:57 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V3 5/6] brcmfmac: add USB autosuspend feature support
Date:   Wed, 25 Mar 2020 03:20:28 -0500
Message-Id: <1585124429-97371-6-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1585124429-97371-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1585124429-97371-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:a03:100::40) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR08CA0027.namprd08.prod.outlook.com (2603:10b6:a03:100::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend Transport; Wed, 25 Mar 2020 08:20:56 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: af345b62-7387-405f-108d-08d7d0957178
X-MS-TrafficTypeDiagnostic: BYAPR06MB5189:|BYAPR06MB5189:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB518937211F8F5828723B186FBBCE0@BYAPR06MB5189.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:241;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(66556008)(8676002)(81156014)(2906002)(66476007)(66946007)(81166006)(6486002)(8936002)(6916009)(16526019)(26005)(956004)(2616005)(498600001)(6666004)(54906003)(86362001)(52116002)(7696005)(186003)(36756003)(5660300002)(107886003)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5189;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N74wmAWyJNYBfuLkdwl78jZ7p62lcqTFo7f8j+Id3LKk35azpzhHRFJUKPaicEDjPTEGXSLreeUNIOQoAwTSEj+x8oBkmJQBG4MfSp5Zp4Ayf0FWA57ql6Stz6uBm5Ci55NVy0LyEVMfFceVWNufycaAZcH2w4QHMEy0p+K48t/QW9//M2to2E/R4TC14bhezTpwlczW5AjWN7IghJutuyQmNqvFZeR1X54pHl7IsjKyohohDlDFKQSxIUKDSh7cVdarHZzifYW6wTYzGbtnoxlPf6II2n2MOLg+xlzm6MGbAOH3hf3KEhZf4qLzMVRLl5xlA9TZ8LQTamAANBjqfQb9AajwwYKZmgEp2ycP7C6Z0QSUvdOiCptNGCbEuw96acviWzG0GDpJcOWDTuaA3HSfHKsAnT5wT+S3QprrbVoBtInVWZw1QAfCSJSgSHoY
X-MS-Exchange-AntiSpam-MessageData: loDYy1SOF8cFEqC3rvB7kzfLxcYCXSr2qqbZfBMq/nwhqIjFYr22uq/TnkhuvFH4GP2JB6KStBfd+Bcn6GgMQZ3UmvjeSKuyI8lZWpEN+66yFvmWgFq2v8BOY9T+h6DgPW/7Kker7xyedTPoaaQHKA==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af345b62-7387-405f-108d-08d7d0957178
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 08:20:57.3450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAtBZ6ILtn7LlQx2ZLUh5ZG3IGD9YWCS6OWGfGBEW+IrRsD+iTK6ynnULsfSMxUn9nYku+gr9whwigevxrYV1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5189
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wright Feng <wright.feng@cypress.com>

We add enable dynamic suspend (autosuspend) support in host driver, and
it can let platform cut down idle power consumption.
To support autosuspend feature in host driver, kernel need to be built
with CONFIG_USB_SUSPEND and autosuspend need to be turn on.
And we also replace wowl feature with adding "needs_remote_wakeup", so
that host still can be waken by wireless device.

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c | 121 ++++++++++++---------
 1 file changed, 71 insertions(+), 50 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 10387a7f5d56..ac5463838fcf 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -164,7 +164,6 @@ struct brcmf_usbdev_info {
 
 	struct urb *bulk_urb; /* used for FW download */
 
-	bool wowl_enabled;
 	struct brcmf_mp_device *settings;
 };
 
@@ -312,28 +311,43 @@ static int brcmf_usb_tx_ctlpkt(struct device *dev, u8 *buf, u32 len)
 	int err = 0;
 	int timeout = 0;
 	struct brcmf_usbdev_info *devinfo = brcmf_usb_get_businfo(dev);
+	struct usb_interface *intf = to_usb_interface(dev);
 
 	brcmf_dbg(USB, "Enter\n");
-	if (devinfo->bus_pub.state != BRCMFMAC_USB_STATE_UP)
-		return -EIO;
 
-	if (test_and_set_bit(0, &devinfo->ctl_op))
-		return -EIO;
+	err = usb_autopm_get_interface(intf);
+	if (err)
+		goto out;
+
+	if (devinfo->bus_pub.state != BRCMFMAC_USB_STATE_UP) {
+		err = -EIO;
+		goto fail;
+	}
+
+	if (test_and_set_bit(0, &devinfo->ctl_op)) {
+		err = -EIO;
+		goto fail;
+	}
 
 	devinfo->ctl_completed = false;
 	err = brcmf_usb_send_ctl(devinfo, buf, len);
 	if (err) {
 		brcmf_err("fail %d bytes: %d\n", err, len);
 		clear_bit(0, &devinfo->ctl_op);
-		return err;
+		goto fail;
 	}
 	timeout = brcmf_usb_ioctl_resp_wait(devinfo);
 	if (!timeout) {
 		brcmf_err("Txctl wait timed out\n");
 		usb_kill_urb(devinfo->ctl_urb);
 		err = -EIO;
+		goto fail;
 	}
 	clear_bit(0, &devinfo->ctl_op);
+
+fail:
+	usb_autopm_put_interface(intf);
+out:
 	return err;
 }
 
@@ -342,20 +356,30 @@ static int brcmf_usb_rx_ctlpkt(struct device *dev, u8 *buf, u32 len)
 	int err = 0;
 	int timeout = 0;
 	struct brcmf_usbdev_info *devinfo = brcmf_usb_get_businfo(dev);
+	struct usb_interface *intf = to_usb_interface(dev);
 
 	brcmf_dbg(USB, "Enter\n");
-	if (devinfo->bus_pub.state != BRCMFMAC_USB_STATE_UP)
-		return -EIO;
 
-	if (test_and_set_bit(0, &devinfo->ctl_op))
-		return -EIO;
+	err = usb_autopm_get_interface(intf);
+	if (err)
+		goto out;
+
+	if (devinfo->bus_pub.state != BRCMFMAC_USB_STATE_UP) {
+		err = -EIO;
+		goto fail;
+	}
+
+	if (test_and_set_bit(0, &devinfo->ctl_op)) {
+		err = -EIO;
+		goto fail;
+	}
 
 	devinfo->ctl_completed = false;
 	err = brcmf_usb_recv_ctl(devinfo, buf, len);
 	if (err) {
 		brcmf_err("fail %d bytes: %d\n", err, len);
 		clear_bit(0, &devinfo->ctl_op);
-		return err;
+		goto fail;
 	}
 	timeout = brcmf_usb_ioctl_resp_wait(devinfo);
 	err = devinfo->ctl_urb_status;
@@ -363,12 +387,15 @@ static int brcmf_usb_rx_ctlpkt(struct device *dev, u8 *buf, u32 len)
 		brcmf_err("rxctl wait timed out\n");
 		usb_kill_urb(devinfo->ctl_urb);
 		err = -EIO;
+		goto fail;
 	}
 	clear_bit(0, &devinfo->ctl_op);
+fail:
+	usb_autopm_put_interface(intf);
 	if (!err)
 		return devinfo->ctl_urb_actual_length;
-	else
-		return err;
+out:
+	return err;
 }
 
 static struct brcmf_usbreq *brcmf_usb_deq(struct brcmf_usbdev_info *devinfo,
@@ -502,10 +529,12 @@ static void brcmf_usb_rx_complete(struct urb *urb)
 		return;
 	}
 
-	if (devinfo->bus_pub.state == BRCMFMAC_USB_STATE_UP) {
+	if (devinfo->bus_pub.state == BRCMFMAC_USB_STATE_UP ||
+	    devinfo->bus_pub.state == BRCMFMAC_USB_STATE_SLEEP) {
 		skb_put(skb, urb->actual_length);
 		brcmf_rx_frame(devinfo->dev, skb, true);
 		brcmf_usb_rx_refill(devinfo, req);
+		usb_mark_last_busy(urb->dev);
 	} else {
 		brcmu_pkt_buf_free_skb(skb);
 		brcmf_usb_enq(devinfo, &devinfo->rx_freeq, req, NULL);
@@ -589,6 +618,11 @@ static int brcmf_usb_tx(struct device *dev, struct sk_buff *skb)
 	struct brcmf_usbreq  *req;
 	int ret;
 	unsigned long flags;
+	struct usb_interface *intf = to_usb_interface(dev);
+
+	ret = usb_autopm_get_interface(intf);
+	if (ret)
+		goto out;
 
 	brcmf_dbg(USB, "Enter, skb=%p\n", skb);
 	if (devinfo->bus_pub.state != BRCMFMAC_USB_STATE_UP) {
@@ -627,9 +661,10 @@ static int brcmf_usb_tx(struct device *dev, struct sk_buff *skb)
 		devinfo->tx_flowblock = true;
 	}
 	spin_unlock_irqrestore(&devinfo->tx_flowblock_lock, flags);
-	return 0;
 
 fail:
+	usb_autopm_put_interface(intf);
+out:
 	return ret;
 }
 
@@ -993,20 +1028,32 @@ static int
 brcmf_usb_fw_download(struct brcmf_usbdev_info *devinfo)
 {
 	int err;
+	struct usb_interface *intf;
 
 	brcmf_dbg(USB, "Enter\n");
-	if (devinfo == NULL)
-		return -ENODEV;
+	if (!devinfo) {
+		err = -ENODEV;
+		goto out;
+	}
 
 	if (!devinfo->image) {
 		brcmf_err("No firmware!\n");
-		return -ENOENT;
+		err = -ENOENT;
+		goto out;
 	}
 
+	intf = to_usb_interface(devinfo->dev);
+	err = usb_autopm_get_interface(intf);
+	if (err)
+		goto out;
+
 	err = brcmf_usb_dlstart(devinfo,
 		(u8 *)devinfo->image, devinfo->image_len);
 	if (err == 0)
 		err = brcmf_usb_dlrun(devinfo);
+
+	usb_autopm_put_interface(intf);
+out:
 	return err;
 }
 
@@ -1107,18 +1154,6 @@ struct brcmf_usbdev *brcmf_usb_attach(struct brcmf_usbdev_info *devinfo,
 	return NULL;
 }
 
-static void brcmf_usb_wowl_config(struct device *dev, bool enabled)
-{
-	struct brcmf_usbdev_info *devinfo = brcmf_usb_get_businfo(dev);
-
-	brcmf_dbg(USB, "Configuring WOWL, enabled=%d\n", enabled);
-	devinfo->wowl_enabled = enabled;
-	if (enabled)
-		device_set_wakeup_enable(devinfo->dev, true);
-	else
-		device_set_wakeup_enable(devinfo->dev, false);
-}
-
 static
 int brcmf_usb_get_fwname(struct device *dev, const char *ext, u8 *fw_name)
 {
@@ -1145,7 +1180,6 @@ static const struct brcmf_bus_ops brcmf_usb_bus_ops = {
 	.txdata = brcmf_usb_tx,
 	.txctl = brcmf_usb_tx_ctlpkt,
 	.rxctl = brcmf_usb_rx_ctlpkt,
-	.wowl_config = brcmf_usb_wowl_config,
 	.get_fwname = brcmf_usb_get_fwname,
 };
 
@@ -1334,6 +1368,8 @@ brcmf_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 
 	usb_set_intfdata(intf, devinfo);
 
+	intf->needs_remote_wakeup = 1;
+
 	/* Check that the device supports only one configuration */
 	if (usb->descriptor.bNumConfigurations != 1) {
 		brcmf_err("Number of configurations: %d not supported\n",
@@ -1447,12 +1483,8 @@ static int brcmf_usb_suspend(struct usb_interface *intf, pm_message_t state)
 
 	brcmf_dbg(USB, "Enter\n");
 	devinfo->bus_pub.state = BRCMFMAC_USB_STATE_SLEEP;
-	if (devinfo->wowl_enabled) {
-		brcmf_cancel_all_urbs(devinfo);
-	} else {
-		brcmf_detach(&usb->dev);
-		brcmf_free(&usb->dev);
-	}
+	brcmf_cancel_all_urbs(devinfo);
+	device_set_wakeup_enable(devinfo->dev, true);
 	return 0;
 }
 
@@ -1465,22 +1497,10 @@ static int brcmf_usb_resume(struct usb_interface *intf)
 	struct brcmf_usbdev_info *devinfo = brcmf_usb_get_businfo(&usb->dev);
 
 	brcmf_dbg(USB, "Enter\n");
-	if (!devinfo->wowl_enabled) {
-		int err;
-
-		err = brcmf_alloc(&usb->dev, devinfo->settings);
-		if (err)
-			return err;
-
-		err = brcmf_attach(devinfo->dev);
-		if (err) {
-			brcmf_free(devinfo->dev);
-			return err;
-		}
-	}
 
 	devinfo->bus_pub.state = BRCMFMAC_USB_STATE_UP;
 	brcmf_usb_rx_fill_all(devinfo);
+	device_set_wakeup_enable(devinfo->dev, false);
 	return 0;
 }
 
@@ -1537,6 +1557,7 @@ static struct usb_driver brcmf_usbdrvr = {
 	.suspend = brcmf_usb_suspend,
 	.resume = brcmf_usb_resume,
 	.reset_resume = brcmf_usb_reset_resume,
+	.supports_autosuspend = true,
 	.disable_hub_initiated_lpm = 1,
 };
 
-- 
2.1.0

