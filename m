Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8CE15BAFE
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 09:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgBMIp1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 03:45:27 -0500
Received: from mail-bn8nam11on2105.outbound.protection.outlook.com ([40.107.236.105]:59328
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729485AbgBMIp1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 03:45:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CT4jnzNA1wqbS9wJIxUXbE5xJGAUNb1DGmfPWP5A4Y5kciZchyO2/mHmH7MoSCVD9k/DbNAZ92jvnCAseRIMQrk9doxPIN2X3xCCE7HPFsJ+wfcqMXxVPRSYEEv3CXVVx9BaOMvif0MvzAbVMUi/3wXji2oT0q74oWjsnJQo6pZEUPnQx0/y+jRb6tAYEg5+RweVjxhv1/U6e+mBZqHH2Zei2PUyo0RJw87INVpHAsntXG7jHem+3CNFe4X5hEBV6YTvuFhvm7m7ktBUzaLj5rO0znCC6unTIcWi3iyagbeIETmPUxVMyPhBSUhUnrMr6+iDUGaBCNy9uYbD3gwEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dfvJm7g6YJBnL4CH5iuHvNWUwg+m+aQ+QGhl+OwLC4=;
 b=DuUBfTBzcVASi+pBxRyu/xKL+42AGVQA4/hX5HZnyFh2po+t9oMEvJX5/+EbH0uFG/PMrTVMGAdaH7lEz+loVPJJSpq/0vJLQcyYpWAMPGvZ9p9QYHJJhGcqP8GFu1CpS7kwKl6rwCfhpZAzT1J0qlgzb3A6+waHF1eQDCP1vVveGCuBAU3YLhtPSD+KtGe3Mh248sQ3wy4K8TcMbUdVSQp7JR1qx5g84VkDQiXkFl8VevegYGCYF4m/oARcQH9dGCBW4U8wjcAxJRqa//QMpD4SrhfidbHZJ72r0fcG6eA3ctFmTwItWQSCC+DXqreTM4U+dR1MsIk1mKB15yTscw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dfvJm7g6YJBnL4CH5iuHvNWUwg+m+aQ+QGhl+OwLC4=;
 b=lEhJXuYQnHMzkXRU50KHXP3+FdsUDR3kEajNEIDrsoqzy8SgYX/OWGR9lhsJ9A9UmZXEF6pAe+Qi5FI8InBkBFE1u4dDAdkJKr12xlbrv7RON2+PRXjYiUbxvawJcFF9yVYenKQbZjBkWa73PFPVVdVVHjcCit6kNtCm0hDwuX8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (20.177.184.30) by
 BYAPR06MB5623.namprd06.prod.outlook.com (20.178.196.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Thu, 13 Feb 2020 08:45:21 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::61cf:307a:df0a:c031]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::61cf:307a:df0a:c031%3]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 08:45:21 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 5/6] brcmfmac: add USB autosuspend feature support
Date:   Thu, 13 Feb 2020 02:44:35 -0600
Message-Id: <1581583476-60155-6-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1581583476-60155-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1581583476-60155-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:a03:54::27) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR02CA0050.namprd02.prod.outlook.com (2603:10b6:a03:54::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.29 via Frontend Transport; Thu, 13 Feb 2020 08:45:20 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ebb3c4c-b961-4831-ed6e-08d7b0610f06
X-MS-TrafficTypeDiagnostic: BYAPR06MB5623:|BYAPR06MB5623:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB562352D0765AD9BEB8B7AE2BBB1A0@BYAPR06MB5623.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:207;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(376002)(396003)(366004)(189003)(199004)(16526019)(478600001)(2906002)(186003)(4326008)(2616005)(316002)(26005)(5660300002)(36756003)(956004)(86362001)(6666004)(8676002)(54906003)(8936002)(66556008)(52116002)(107886003)(66476007)(81166006)(81156014)(6486002)(6916009)(7696005)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5623;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+g6VyM3D180B5WZbHA+K9ea9bFMD+OCqUrBdbxmxUCDNjc6j5eiNZJJfCHTq8TmuMliztNJ3A2isHVLFKH90jUKInCAiPimMGMv86l+7bRA7TcWxRAUqyVAMAZR/2GpkMJP7S9sQ3ZvmgFQblW/Rwa+KXMS1rBRBEIbLWuc0UKk8I7HHlZwpltrQPj0wQGIX+Kyvmfgtz/ViUnu0cX/BQ02IgV1clKYTLCi6gJFhIMN2faipuqdIG/fwfaH9U2NrlT/YRVvl+P4oO3s4uZXeqWpc72yWAHGMqEQXsG3S3PhbNNfSAMGLvsYnxHgZUUOsVmeo2LTbs02jjZp/qPxaeDxnOZYjZIu7oetryTJ5FdHoz1+gtHxUEwnCzjRls2GqGteWXyZhcQWBIRUcJFDpwlYtFAQdja4a2MpL8BzHdC9fPcDl5qrKOY5xxEMwYrz
X-MS-Exchange-AntiSpam-MessageData: M3MhQXdFCabI3U30UvjCEgEh4MT5lu2P30MU1O+9YmwRuZ5kG7FKZHYlYsOvuvyMByfS65opj4Vm71uIGkpyCn2kt3WTuC886m/pMBkxw5WnQk4B7z88LKB13jKHxfZKhtD+nj4FlJRyZPuG0PmeMQ==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebb3c4c-b961-4831-ed6e-08d7b0610f06
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 08:45:21.1320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K69/0knbMVnNpZCrwJ/Rx4/Id7lT0H5L4xIICjTlA5/tS+Bk1Y0E93GgyOdLxfhklRmjWkrSc2+iS6MXNc6gCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5623
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wright Feng <wright.feng@cypress.com>

We add enable dynamic suspend(autosuspend) support in host driver. It
can let platform cut down idle power consumption. To support autosuspend
feature in host driver. Kernel need to be build with CONFIG_USB_SUSPEND
and autosuspend need to be turn on.

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
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

