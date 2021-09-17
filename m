Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD59E40F782
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Sep 2021 14:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243679AbhIQMcX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Sep 2021 08:32:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232338AbhIQMcW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Sep 2021 08:32:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25A406008E;
        Fri, 17 Sep 2021 12:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631881860;
        bh=N55+f+KDa6wQbbpGtxgTy4HvWMObumocgHBQqRSkLOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GH4TIrhuTL6phZUtO3ur4PCNdCjJ0umKSrSdczNyP7NLELyB33o81KkVmNodIkFdu
         GiiV7dAiBnxdwdGJsVcmJwWesmyGUHgFlyZIehlSRddFFGNjEEiu8/jKGeZsmkvzK4
         PhFanIyvPp9//jSTIJbDOPKarCbwQ0KzR7co2hOjjZgJAKRgVtXRi9DlBcO7PCbeXQ
         g9WCNCpFU//Tn93fEJfczMvOhhEfPssY54GeHUQ1Clp1HFOGbFRYOVs5Ym/god8fLL
         aGRApZWABq56rd1THS+2cOprfHoJVTUO/1PgbaNBaCBOwi8szd4lhbQhgGGRKsw+Af
         9QxnRpX+t/+JQ==
Received: by pali.im (Postfix)
        id D056E7C5; Fri, 17 Sep 2021 14:30:57 +0200 (CEST)
Date:   Fri, 17 Sep 2021 14:30:57 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jonas =?utf-8?Q?Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] Bluetooth: btusb: Lower passive lescan interval on
 Marvell 88W8897
Message-ID: <20210917123057.gqitcxvxn4ax25np@pali>
References: <20210917122718.86776-1-verdre@v0yd.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210917122718.86776-1-verdre@v0yd.nl>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Friday 17 September 2021 14:27:18 Jonas Dreßler wrote:
> The Marvell 88W8897 combined wifi and bluetooth card (pcie+usb version)
> is used in a lot of Microsoft Surface devices, and all those devices
> suffer from very low 2.4GHz wifi connection speeds while bluetooth is
> enabled.

Hello! Do you know if this issue is specific only to this one Marvell
88W8897 chip or if this issue affects also other Marvell wifi+bt combo
chips?

> The reason for that is that the default passive scanning
> interval for Bluetooth Low Energy devices is quite high on Linux
> (interval of 60 msec and scan window of 30 msec, see le_scan_interval
> and le_scan_window in hci_core.c), and the Marvell chip is known for its
> bad bt+wifi coexisting performance.
> 
> So decrease that passive scan interval and make the scan window shorter
> on this particular device to allow for spending more time transmitting
> wifi signals: The new scan interval is 250 msec (0x190 * 0.625 msec) and
> the new scan window is 6.25 msec (0xa * 0.625 msec).
> 
> This change has a very large impact on the 2.4GHz wifi speeds and gets
> it up to performance comparable with the Windows driver, which seems to
> apply a similar quirk.
> 
> The scan interval and scan window length were tested and found to work
> very well with a bunch of Bluetooth Low Energy devices, including the
> Surface Pen, a Bluetooth Speaker and two modern Bluetooth headphones.
> All devices were discovered immediately after turning them on. Even
> lower values were also tested, but these introduced longer delays until
> devices get discovered.
> 
> Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>
> ---
>  drivers/bluetooth/btusb.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 60d2fce59a71..05b11179c839 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -59,6 +59,7 @@ static struct usb_driver btusb_driver;
>  #define BTUSB_WIDEBAND_SPEECH	0x400000
>  #define BTUSB_VALID_LE_STATES   0x800000
>  #define BTUSB_QCA_WCN6855	0x1000000
> +#define BTUSB_LOWER_LESCAN_INTERVAL	0x2000000
>  #define BTUSB_INTEL_BROKEN_INITIAL_NCMD 0x4000000
>  
>  static const struct usb_device_id btusb_table[] = {
> @@ -356,6 +357,7 @@ static const struct usb_device_id blacklist_table[] = {
>  	{ USB_DEVICE(0x1286, 0x2044), .driver_info = BTUSB_MARVELL },
>  	{ USB_DEVICE(0x1286, 0x2046), .driver_info = BTUSB_MARVELL },
>  	{ USB_DEVICE(0x1286, 0x204e), .driver_info = BTUSB_MARVELL },
> +	{ USB_DEVICE(0x1286, 0x204c), .driver_info = BTUSB_LOWER_LESCAN_INTERVAL },
>  
>  	/* Intel Bluetooth devices */
>  	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_COMBINED },
> @@ -3813,6 +3815,19 @@ static int btusb_probe(struct usb_interface *intf,
>  	if (id->driver_info & BTUSB_MARVELL)
>  		hdev->set_bdaddr = btusb_set_bdaddr_marvell;
>  
> +	/* The Marvell 88W8897 combined wifi and bluetooth card is known for
> +	 * very bad bt+wifi coexisting performance.
> +	 *
> +	 * Decrease the passive BT Low Energy scan interval a bit
> +	 * (0x0190 * 0.625 msec = 250 msec) and make the scan window shorter
> +	 * (0x000a * 0,625 msec = 6.25 msec). This allows for significantly
> +	 * higher wifi throughput while passively scanning for BT LE devices.
> +	 */
> +	if (id->driver_info & BTUSB_LOWER_LESCAN_INTERVAL) {
> +		hdev->le_scan_interval = 0x0190;
> +		hdev->le_scan_window = 0x000a;
> +	}
> +
>  	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_MTK) &&
>  	    (id->driver_info & BTUSB_MEDIATEK)) {
>  		hdev->setup = btusb_mtk_setup;
> -- 
> 2.31.1
> 
