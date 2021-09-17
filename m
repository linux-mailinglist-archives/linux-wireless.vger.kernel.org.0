Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90FB40F7EB
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Sep 2021 14:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244422AbhIQMiV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Sep 2021 08:38:21 -0400
Received: from mout-p-201.mailbox.org ([80.241.56.171]:36390 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238634AbhIQMiU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Sep 2021 08:38:20 -0400
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Sep 2021 08:38:19 EDT
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4H9tkK153szQlWs;
        Fri, 17 Sep 2021 14:36:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Subject: Re: [PATCH] Bluetooth: btusb: Lower passive lescan interval on
 Marvell 88W8897
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
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
References: <20210917122718.86776-1-verdre@v0yd.nl>
 <20210917123057.gqitcxvxn4ax25np@pali>
From:   =?UTF-8?Q?Jonas_Dre=c3=9fler?= <verdre@v0yd.nl>
Message-ID: <1bc68568-8b9a-7a39-ed79-717e15db58d9@v0yd.nl>
Date:   Fri, 17 Sep 2021 14:36:50 +0200
MIME-Version: 1.0
In-Reply-To: <20210917123057.gqitcxvxn4ax25np@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0B404188C
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/17/21 2:30 PM, Pali Rohár wrote:
> On Friday 17 September 2021 14:27:18 Jonas Dreßler wrote:
>> The Marvell 88W8897 combined wifi and bluetooth card (pcie+usb version)
>> is used in a lot of Microsoft Surface devices, and all those devices
>> suffer from very low 2.4GHz wifi connection speeds while bluetooth is
>> enabled.
> 
> Hello! Do you know if this issue is specific only to this one Marvell
> 88W8897 chip or if this issue affects also other Marvell wifi+bt combo
> chips?

Hi! No idea, good question, but I don't own any other devices with 
Marvell chips. Maybe it's even safe to apply it to all Bluetooth 
devices, I guess less scanning load is good for everyone (as long as it 
doesn't impact the scanning results of course, so that would need testing).

> 
>> The reason for that is that the default passive scanning
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
>>   drivers/bluetooth/btusb.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 60d2fce59a71..05b11179c839 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -59,6 +59,7 @@ static struct usb_driver btusb_driver;
>>   #define BTUSB_WIDEBAND_SPEECH	0x400000
>>   #define BTUSB_VALID_LE_STATES   0x800000
>>   #define BTUSB_QCA_WCN6855	0x1000000
>> +#define BTUSB_LOWER_LESCAN_INTERVAL	0x2000000
>>   #define BTUSB_INTEL_BROKEN_INITIAL_NCMD 0x4000000
>>   
>>   static const struct usb_device_id btusb_table[] = {
>> @@ -356,6 +357,7 @@ static const struct usb_device_id blacklist_table[] = {
>>   	{ USB_DEVICE(0x1286, 0x2044), .driver_info = BTUSB_MARVELL },
>>   	{ USB_DEVICE(0x1286, 0x2046), .driver_info = BTUSB_MARVELL },
>>   	{ USB_DEVICE(0x1286, 0x204e), .driver_info = BTUSB_MARVELL },
>> +	{ USB_DEVICE(0x1286, 0x204c), .driver_info = BTUSB_LOWER_LESCAN_INTERVAL },
>>   
>>   	/* Intel Bluetooth devices */
>>   	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_COMBINED },
>> @@ -3813,6 +3815,19 @@ static int btusb_probe(struct usb_interface *intf,
>>   	if (id->driver_info & BTUSB_MARVELL)
>>   		hdev->set_bdaddr = btusb_set_bdaddr_marvell;
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
>>   	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_MTK) &&
>>   	    (id->driver_info & BTUSB_MEDIATEK)) {
>>   		hdev->setup = btusb_mtk_setup;
>> -- 
>> 2.31.1
>>

