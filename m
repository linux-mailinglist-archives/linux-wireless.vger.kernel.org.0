Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7541D184546
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2020 11:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgCMKvQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Mar 2020 06:51:16 -0400
Received: from mail-dm6nam12on2136.outbound.protection.outlook.com ([40.107.243.136]:24880
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726414AbgCMKvQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Mar 2020 06:51:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hG1JbywjlP1KSyh2FOCDRX6fo0Nxt7W6TCDyFIYrFbnky4D4z1BqhcBgTom883fx5kvf7r/e6JINraj+szSNB35lac+w7jxgxHqDBTo3KRq/Pmfp5SK5Lfk8gxCnvQ67J+Si4/J9GMPLzrV9B9ermOQ6GgTJKXeP2MWH3q8k0w5o/8+D4ncfvBDAR7nv3ncwp26SrSffmZuwAlSuEATZ6CVTi66CEY5ORAQ7t6ZCId4sxZZeB9c7QcFdqv8FuD7JfuWmGSqGnWgitVZWAn2mLVWgpBystEtp8qwVnQ5Y0+1z9FQbGTYlnVZfksDJ1KfyRqD8rSecpnhnYQYyWpDzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltqeSPDyMhPoe6y58G6GBj3pDzqVbwk5BNeNhQ+8eP4=;
 b=Z0K6zru2LLqNpYy1P0r+xjGKjUeS9wFKM6SjFQXpxDqqM200J0JbJ/7qEv7Z+CeO0D77ezwWspo6mcKOsFhopO3TYqWBHKQMMEG1qJawoDehFWSDlmqIORJdanETjrJ/J0yxb63JeDdAjACvaWthfPe2ucS99yiRDSlZkEthyWMnKgjpQuM+a8VK8xrt/nqH5va4swSZ0DFYHKFdHytR+lZkM6AL0lHzl48YabRcvMZQhkyaGoYM/0jInCcCyAw/8mMXfGwmjmCGpI9bXtfTbCeQ0UZcklIlnkj0PYnrMSHUvxRQ6iHxf2xf2da0uxCf+BgEHE3w4hvhblvWHfWS0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltqeSPDyMhPoe6y58G6GBj3pDzqVbwk5BNeNhQ+8eP4=;
 b=CG/jS0ahyMnqKw0dqieYLg+DCPLYUWWEOb4FTPN0D+746SXNcqpxEZe5771LEOs9AG0UMLjuvVdRCxdSAtevlKXnPkYcKo31lrX+QnhWLMnLnTqAEUfmo9BH7gzjBWklG+e5aMRZm+bgS7m+GiT+/iZfdzMKwz97GsYceEJ0B1U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5303.namprd06.prod.outlook.com (2603:10b6:a03:cf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 10:51:12 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::3cc3:7b1a:bd7b:a0a9]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::3cc3:7b1a:bd7b:a0a9%5]) with mapi id 15.20.2793.021; Fri, 13 Mar 2020
 10:51:12 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V2 5/6] brcmfmac: add USB autosuspend feature support
Date:   Fri, 13 Mar 2020 05:50:19 -0500
Message-Id: <1584096620-101123-6-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1584096620-101123-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1584096620-101123-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:207:3d::31) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BL0PR02CA0054.namprd02.prod.outlook.com (2603:10b6:207:3d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17 via Frontend Transport; Fri, 13 Mar 2020 10:51:10 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7f45370f-9bee-41b9-23ce-08d7c73c71bf
X-MS-TrafficTypeDiagnostic: BYAPR06MB5303:|BYAPR06MB5303:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB53035FAC784F541FCC69C650BBFA0@BYAPR06MB5303.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:241;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(136003)(199004)(6486002)(2906002)(54906003)(107886003)(4326008)(5660300002)(316002)(2616005)(66946007)(66556008)(956004)(66476007)(6916009)(8936002)(81156014)(8676002)(81166006)(478600001)(26005)(36756003)(86362001)(52116002)(7696005)(186003)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5303;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P3FHZGkUvF5+1v96r823HsJcFsdDyTMHiG0BXaSpZViQTJtMR5DnuRnUyrMkTXGPeYbvijOHXkhdGevNIXa5Vxxss7oahhCQEyqVeFBOxpJhYoWDaRM+qe69gLMXRRfeYmN9iTL1mFoNnmi9PgyY8MiCjr/h349diSBJQYjjnB/HCUTOGouKjwkwVAD/4nzYOkmnxb+sP2Ak2FsHAZxqnFVcW4xTTI+y1O8vralY3KTwOUVzAjxOzTreN3tllA5eJjl1rN6Y7MrebTmdnBHJuTelS7C0S2McBapfWNBZusNBamS980h/2/IlYSCOvBSV6P0pK1a9GPWAUiv/QOAynRKk5WHias83Wa9Gr5h79Gm5Myg4/5mIrWYgYDkz/L11IUxBSdODEobi/tXw+PP82GadTx261fcip5O8B629VCErCEyTqg0lLAkQ5egcLoTR
X-MS-Exchange-AntiSpam-MessageData: egMhr7E/8Dp0iYUibA6+DhwnX2sHTpIwF3w8Q0p03G9PqLvliRrYL40c0EyOZapxUaZsIF0n0Z/RMJwsL48XKn5eEnketAuu/egImM61OtFdsdLHRgBj+ud65Apha2ExUz8pZpmNXU3GEHN7VKD10A==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f45370f-9bee-41b9-23ce-08d7c73c71bf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 10:51:12.1478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DrvDwcPXe0bJMQYaB3006oqwI8+A0Nm22D9ZKUNZDh1Ztx9x9evuCAmkHK17dMY/6xfT5dBN3p3HMYt5kIl04Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5303
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
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c | 120 ++++++++++++---------
 1 file changed, 70 insertions(+), 50 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 10387a7f5d56..1108414c4c8f 100644
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
@@ -363,12 +387,14 @@ static int brcmf_usb_rx_ctlpkt(struct device *dev, u8 *buf, u32 len)
 		brcmf_err("rxctl wait timed out\n");
 		usb_kill_urb(devinfo->ctl_urb);
 		err = -EIO;
+		goto fail;
 	}
 	clear_bit(0, &devinfo->ctl_op);
+	usb_autopm_put_interface(intf);
 	if (!err)
 		return devinfo->ctl_urb_actual_length;
-	else
-		return err;
+out:
+	return err;
 }
 
 static struct brcmf_usbreq *brcmf_usb_deq(struct brcmf_usbdev_info *devinfo,
@@ -502,10 +528,12 @@ static void brcmf_usb_rx_complete(struct urb *urb)
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
@@ -589,6 +617,11 @@ static int brcmf_usb_tx(struct device *dev, struct sk_buff *skb)
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
@@ -627,9 +660,10 @@ static int brcmf_usb_tx(struct device *dev, struct sk_buff *skb)
 		devinfo->tx_flowblock = true;
 	}
 	spin_unlock_irqrestore(&devinfo->tx_flowblock_lock, flags);
-	return 0;
 
 fail:
+	usb_autopm_put_interface(intf);
+out:
 	return ret;
 }
 
@@ -993,20 +1027,32 @@ static int
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
 
@@ -1107,18 +1153,6 @@ struct brcmf_usbdev *brcmf_usb_attach(struct brcmf_usbdev_info *devinfo,
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
@@ -1145,7 +1179,6 @@ static const struct brcmf_bus_ops brcmf_usb_bus_ops = {
 	.txdata = brcmf_usb_tx,
 	.txctl = brcmf_usb_tx_ctlpkt,
 	.rxctl = brcmf_usb_rx_ctlpkt,
-	.wowl_config = brcmf_usb_wowl_config,
 	.get_fwname = brcmf_usb_get_fwname,
 };
 
@@ -1334,6 +1367,8 @@ brcmf_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 
 	usb_set_intfdata(intf, devinfo);
 
+	intf->needs_remote_wakeup = 1;
+
 	/* Check that the device supports only one configuration */
 	if (usb->descriptor.bNumConfigurations != 1) {
 		brcmf_err("Number of configurations: %d not supported\n",
@@ -1447,12 +1482,8 @@ static int brcmf_usb_suspend(struct usb_interface *intf, pm_message_t state)
 
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
 
@@ -1465,22 +1496,10 @@ static int brcmf_usb_resume(struct usb_interface *intf)
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
 
@@ -1537,6 +1556,7 @@ static struct usb_driver brcmf_usbdrvr = {
 	.suspend = brcmf_usb_suspend,
 	.resume = brcmf_usb_resume,
 	.reset_resume = brcmf_usb_reset_resume,
+	.supports_autosuspend = true,
 	.disable_hub_initiated_lpm = 1,
 };
 
-- 
2.1.0

