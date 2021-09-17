Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F1A40F822
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Sep 2021 14:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbhIQMnN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Sep 2021 08:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbhIQMnN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Sep 2021 08:43:13 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18845C061574;
        Fri, 17 Sep 2021 05:41:51 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4H9tqx4HwtzQkBK;
        Fri, 17 Sep 2021 14:41:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Subject: Re: [PATCH] Bluetooth: btusb: Lower passive lescan interval on
 Marvell 88W8897
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        linux-wireless@vger.kernel.org,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
References: <20210917122718.86776-1-verdre@v0yd.nl>
 <B9F09991-0B67-4848-86DE-C13BF3850D15@holtmann.org>
From:   =?UTF-8?Q?Jonas_Dre=c3=9fler?= <verdre@v0yd.nl>
Message-ID: <3e5b7e27-e643-ae9b-db40-d885ca441385@v0yd.nl>
Date:   Fri, 17 Sep 2021 14:41:42 +0200
MIME-Version: 1.0
In-Reply-To: <B9F09991-0B67-4848-86DE-C13BF3850D15@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5493A1848
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/17/21 2:35 PM, Marcel Holtmann wrote:
> Hi Jonas,
> 
>> The Marvell 88W8897 combined wifi and bluetooth card (pcie+usb version)
>> is used in a lot of Microsoft Surface devices, and all those devices
>> suffer from very low 2.4GHz wifi connection speeds while bluetooth is
>> enabled. The reason for that is that the default passive scanning
>> interval for Bluetooth Low Energy devices is quite high on Linux
>> (interval of 60 msec and scan window of 30 msec, see le_scan_interval
>> and le_scan_window in hci_core.c), and the Marvell chip is known for its
>> bad bt+wifi coexisting performance.
>>
>> So decrease that passive scan interval and make the scan window shorter
>> on this particular device to allow for spending more time transmitting
>> wifi signals: The new scan interval is 250 msec (0x190 * 0.625 msec) and
>> the new scan window is 6.25 msec (0xa * 0.625 msec).
>>
>> This change has a very large impact on the 2.4GHz wifi speeds and gets
>> it up to performance comparable with the Windows driver, which seems to
>> apply a similar quirk.
>>
>> The scan interval and scan window length were tested and found to work
>> very well with a bunch of Bluetooth Low Energy devices, including the
>> Surface Pen, a Bluetooth Speaker and two modern Bluetooth headphones.
>> All devices were discovered immediately after turning them on. Even
>> lower values were also tested, but these introduced longer delays until
>> devices get discovered.
>>
>> Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>
>> ---
>> drivers/bluetooth/btusb.c | 15 +++++++++++++++
>> 1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 60d2fce59a71..05b11179c839 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -59,6 +59,7 @@ static struct usb_driver btusb_driver;
>> #define BTUSB_WIDEBAND_SPEECH	0x400000
>> #define BTUSB_VALID_LE_STATES   0x800000
>> #define BTUSB_QCA_WCN6855	0x1000000
>> +#define BTUSB_LOWER_LESCAN_INTERVAL	0x2000000
>> #define BTUSB_INTEL_BROKEN_INITIAL_NCMD 0x4000000
>>
>> static const struct usb_device_id btusb_table[] = {
>> @@ -356,6 +357,7 @@ static const struct usb_device_id blacklist_table[] = {
>> 	{ USB_DEVICE(0x1286, 0x2044), .driver_info = BTUSB_MARVELL },
>> 	{ USB_DEVICE(0x1286, 0x2046), .driver_info = BTUSB_MARVELL },
>> 	{ USB_DEVICE(0x1286, 0x204e), .driver_info = BTUSB_MARVELL },
>> +	{ USB_DEVICE(0x1286, 0x204c), .driver_info = BTUSB_LOWER_LESCAN_INTERVAL },
>>
>> 	/* Intel Bluetooth devices */
>> 	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_COMBINED },
>> @@ -3813,6 +3815,19 @@ static int btusb_probe(struct usb_interface *intf,
>> 	if (id->driver_info & BTUSB_MARVELL)
>> 		hdev->set_bdaddr = btusb_set_bdaddr_marvell;
>>
>> +	/* The Marvell 88W8897 combined wifi and bluetooth card is known for
>> +	 * very bad bt+wifi coexisting performance.
>> +	 *
>> +	 * Decrease the passive BT Low Energy scan interval a bit
>> +	 * (0x0190 * 0.625 msec = 250 msec) and make the scan window shorter
>> +	 * (0x000a * 0,625 msec = 6.25 msec). This allows for significantly
>> +	 * higher wifi throughput while passively scanning for BT LE devices.
>> +	 */
>> +	if (id->driver_info & BTUSB_LOWER_LESCAN_INTERVAL) {
>> +		hdev->le_scan_interval = 0x0190;
>> +		hdev->le_scan_window = 0x000a;
>> +	}
>> +
> 
> you can not do it this way. Modifying hci_dev internals from within the driver is not acceptable.
> 
> Regards
> 
> Marcel
> 

Hi Marcel,

hmm okay, it seems to me that the intention of your commit 
bef64738e3fb87eabc6fbeededad0c44ea173384 was to allow configuring it on 
a per controller basis, also btusb changes a bunch of other hci_dev 
properties? Given that we also have to match by usb-id, I don't think 
there's another place to do that other than the usb driver, or is there?

Jonas
