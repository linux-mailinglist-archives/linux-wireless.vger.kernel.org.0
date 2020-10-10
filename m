Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BABB289D20
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Oct 2020 03:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgJJBhN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Oct 2020 21:37:13 -0400
Received: from netrider.rowland.org ([192.131.102.5]:58101 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729433AbgJJBIT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Oct 2020 21:08:19 -0400
Received: (qmail 557695 invoked by uid 1000); 9 Oct 2020 21:08:17 -0400
Date:   Fri, 9 Oct 2020 21:08:17 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+f5378bcf0f0cab45c1c6@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, ath9k-devel@qca.qualcomm.com,
        eli.billauer@gmail.com, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, oneukum@suse.com,
        syzkaller-bugs@googlegroups.com, tiwai@suse.de
Subject: Re: WARNING in hif_usb_send/usb_submit_urb
Message-ID: <20201010010817.GA557391@rowland.harvard.edu>
References: <20201010004944.GB557008@rowland.harvard.edu>
 <000000000000ef564605b1468771@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ef564605b1468771@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Oct 09, 2020 at 05:56:09PM -0700, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:

Oops.  One more try, with the typos fixed.

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v5.9-rc8

Index: usb-devel/drivers/net/wireless/ath/ath9k/hif_usb.c
===================================================================
--- usb-devel.orig/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ usb-devel/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -1307,6 +1307,20 @@ static int ath9k_hif_usb_probe(struct us
 	struct usb_device *udev = interface_to_usbdev(interface);
 	struct hif_device_usb *hif_dev;
 	int ret = 0;
+	struct usb_host_interface *alt;
+	struct usb_endpoint_descriptor *epd;
+
+	/* Verify the expected endpoints are present */
+	alt = interface->cur_altsetting;
+	if (!usb_find_int_in_endpoint(alt, &epd) ||
+			usb_endpoint_num(epd) != USB_REG_IN_PIPE ||
+	    !usb_find_int_out_endpoint(alt, &epd) ||
+			usb_endpoint_num(epd) != USB_REG_OUT_PIPE ||
+	    !usb_find_bulk_in_endpoint(alt, &epd) ||
+			usb_endpoint_num(epd) != USB_WLAN_RX_PIPE ||
+	    !usb_find_bulk_out_endpoint(alt, &epd) ||
+			usb_endpoint_num(epd) != USB_WLAN_TX_PIPE)
+		return -ENODEV;
 
 	if (id->driver_info == STORAGE_DEVICE)
 		return send_eject_command(interface);

