Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 114BBC0094
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 10:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfI0IDK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Sep 2019 04:03:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40788 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfI0IDJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Sep 2019 04:03:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4608E3082E44;
        Fri, 27 Sep 2019 08:03:06 +0000 (UTC)
Received: from localhost (unknown [10.40.205.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C34C8600CE;
        Fri, 27 Sep 2019 08:03:05 +0000 (UTC)
Date:   Fri, 27 Sep 2019 10:03:04 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Anton Olsson <exuvo@exuvo.se>
Cc:     linux-wireless@vger.kernel.org,
        Helmut Schaa <helmut.schaa@googlemail.com>
Subject: Re: rt2x00 regression
Message-ID: <20190927080303.GA7667@redhat.com>
References: <bff7d309-a816-6a75-51b6-5928ef4f7a8c@exuvo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bff7d309-a816-6a75-51b6-5928ef4f7a8c@exuvo.se>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 27 Sep 2019 08:03:09 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Sep 26, 2019 at 06:32:23PM +0200, Anton Olsson wrote:
> Hello I have a USB based ID 148f:3070 Ralink Technology, Corp. RT2870/RT3070 Wireless Adapter, that stops working with recent kernels. It works on kernel 5.1.15 and does not work with 5.2.7 or 5.3.1 (I have not tested other versions). I use it in AP mode.
> 
> I found this similar bug report https://marc.info/?l=linux-wireless&m=156630037103575&w=2 but that did not have related error messages so I assume this is different?
> 
> Logs of working kernel 5.1.15-arch1-1-ARCH.
> [   78.680555] ieee80211 phy0: rt2x00_set_rt: Info - RT chipset 3070, rev 0201 detected
> [   78.690992] ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0005 detected
> [   78.799625] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
> sep 26 17:13:03 kernel: usbcore: registered new interface driver rt2800usb
> sep 26 17:13:03 systemd[1]: Found device RT2870/RT3070 Wireless Adapter.
> [  113.812454] ieee80211 phy0: rt2x00lib_request_firmware: Info - Loading firmware file 'rt2870.bin'
> [  113.905279] ieee80211 phy0: rt2x00lib_request_firmware: Info - Firmware detected - version: 0.36
> [  114.028703] ieee80211 phy0: rt2x00usb_vendor_request: Error - Vendor Request 0x06 failed for offset 0x0404 with error -71
> 
> The last error there does not seem to affect the operation of the device.
> 
> Logs of not working with kernel 5.3.1, 5.2.7 has similar output.
> sep 26 17:06:12 kernel: ieee80211 phy0: rt2x00_set_rt: Info - RT chipset 3070, rev 0201 detected
> sep 26 17:06:12 kernel: ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0005 detected
> sep 26 17:06:12 kernel: ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
> sep 26 17:06:12 kernel: usbcore: registered new interface driver rt2800usb
> sep 26 17:06:12 systemd[1]: Found device RT2870/RT3070 Wireless Adapter.
> sep 26 17:06:21 ieee80211 phy0: rt2x00lib_request_firmware: Info - Loading firmware file 'rt2870.bin'
> sep 26 17:06:21 ieee80211 phy0: rt2x00lib_request_firmware: Info - Firmware detected - version: 0.36
> sep 26 17:06:21 ieee80211 phy0: rt2x00usb_vendor_request: Error - Vendor Request 0x06 failed for offset 0x0404 with>
> sep 26 17:06:22 ieee80211 phy0: rt2800_wait_csr_ready: Error - Unstable hardware
> sep 26 17:06:22 ieee80211 phy0: rt2800usb_set_device_state: Error - Device failed to enter state 4 (-5)
> 
> Unable to bring up the network interface here.

This most likely is the problem introduced by commit:

commit e383c70474db32b9d4a3de6dfbd08784d19e6751
Author: Stanislaw Gruszka <sgruszka@redhat.com>
Date:   Tue Mar 12 10:51:42 2019 +0100

    rt2x00: check number of EPROTO errors

Plase check below patch that increase number of EPROTO checks 
before marking device removed. If it does not help, plese
check if reverting above commits helps.

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
index bc2dfef0de22..215c3f092306 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
@@ -30,7 +30,7 @@ static bool rt2x00usb_check_usb_error(struct rt2x00_dev *rt2x00dev, int status)
 	else
 		rt2x00dev->num_proto_errs = 0;
 
-	if (rt2x00dev->num_proto_errs > 3)
+	if (rt2x00dev->num_proto_errs > 8)
 		return true;
 
 	return false;
