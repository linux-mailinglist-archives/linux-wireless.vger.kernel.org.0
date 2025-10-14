Return-Path: <linux-wireless+bounces-27967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFFBBD8B9A
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 12:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DCD34F0415
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 10:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4332F1FC8;
	Tue, 14 Oct 2025 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=martyn.welch@collabora.com header.b="jBULKro9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A5F2EF65C;
	Tue, 14 Oct 2025 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437272; cv=pass; b=LP2XvXJ5u/+lD2BApbGXAjJcdAcBfDBjRl0rl5ixmnlrBr9E80UVW8OnMh3GgL3T+tZO5doibhQ6Q1ncYEY2qGex25sGO5Ul70u4a9pcB+mHauqmQAvu9qEwFwcKp+xp3RwLSwl4W3M1awvVcCFN7ii27xndAfoY17mNwwngy/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437272; c=relaxed/simple;
	bh=in3hLsBdh9+qwcKg/2PuSAiTqvF0x2syVodOcjFvtKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TW/Jnz1u0C30AsrKg4YfSQSbCZmU/LAiebn7AVYQ6OcezFF2N+uDkWSUeFIfxbM1VIcD2NjKqRdMkoGO3lvKd5lsj9/pBBAQW5OgZzLS5z4KQWRrG/un5X0TwUDE469/3o1utSRm54QN5RAxYVKCRZ2m3hU7imyZx3Ldtn+34pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=martyn.welch@collabora.com header.b=jBULKro9; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760437256; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=N45UMsbrPq2Nc6UZ7veVNt3MzI/XTA/oPGudRe6x32jIVbAlq6UIgfDTKAlOA/sFCjn0xT++G+4fhYA+LG+ykcsC8Cb995ptwT4VoBsHmIDS9m5GFW73BDl2y2UaYXpgvgWdubZtEgx4bmbEJhrneO432DYHkkmA4aV6xM/Z8jg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760437256; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ViAhFjbrUDgTrJEB/pjJ1MaP+jKQqaLZixuuaWttkbI=; 
	b=BP8mf5thQH9aHKUH9Mq+E9ag/LxnM6KJjDN4dKkWKhPG2Akih5Y7Joz3PduiaL6dHRaLPFvn/QayA6m63iwLJmhALwPrihA4OkXT/+BsOvLJLjXIz2Sr+3f5r5zVCXXBanZOLJHwgSCcyDHdM+oeEgQ73DyBQxQPGHK8NxMZPu8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=martyn.welch@collabora.com;
	dmarc=pass header.from=<martyn.welch@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760437255;
	s=zohomail; d=collabora.com; i=martyn.welch@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ViAhFjbrUDgTrJEB/pjJ1MaP+jKQqaLZixuuaWttkbI=;
	b=jBULKro95D8H98pvAbY+X8GrGu9LD4jkWH4CYn7PbbbkZIqbACj3jNaRy4oP1PUN
	XZEXymnDBGGCFmN6/ykf+FYSaqVfvxphoeHOXtLBaBCrSfDHEIgxrbxw+3Ufsi1Pi4L
	TYuycfhrT214mt90fiSwXd3UP0gTVwIpAbf2O7fc=
Received: by mx.zohomail.com with SMTPS id 1760437252221171.57739643098307;
	Tue, 14 Oct 2025 03:20:52 -0700 (PDT)
Message-ID: <83877838-1203-4e21-9612-bc43407eaa54@collabora.com>
Date: Tue, 14 Oct 2025 11:20:44 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v5 00/22] wifi: nxpwifi: create nxpwifi to
 support iw61x
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "briannorris@chromium.org" <briannorris@chromium.org>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "francesco@dolcini.it" <francesco@dolcini.it>,
 Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 Brian Hsu <brian.hsu@nxp.com>
References: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
 <164050d7-e0db-4a67-bf47-6d88e80d78ab@collabora.com>
 <aOfcb3bwacg8RidH@nxpwireless-Inspiron-14-Plus-7440>
 <7c3e9c5a-2f1f-44e7-9c99-2f0a173bd8eb@collabora.com>
 <DBBPR04MB7740C33F56C41373CE6641109CEAA@DBBPR04MB7740.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Martyn Welch <martyn.welch@collabora.com>
In-Reply-To: <DBBPR04MB7740C33F56C41373CE6641109CEAA@DBBPR04MB7740.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 13/10/2025 19:18, Jeff Chen wrote:
> Hi Martyn,
> 
> Thanks again for your detailed feedback and testing.
> 
>  From what you've described, this issue doesn't appear to be caused by the
> nxpwifi driver itself. The Wi-Fi side seems to be functioning correctly.
> 
> To simplify things and avoid firmware loading conflicts, I recommend using
> the Wi-Fi-only firmware with the nxpwifi driver, and letting the btnxpuart
> driver handle its own Bluetooth firmware loading.
> Also, I've looped in Neeraj and Amit, who are the maintainer of the btnxpuart
> driver.
> 
>  From your BT-only scenario logs:
> We can confirm that the host-to-chip communication is working correctly, and the
> firmware download completes successfully. This rules out hardware issues and
> confirms that the UART link is functional. The problem seems to occur during HCI initialization,
> where the btnxpuart driver reports repeated Frame reassembly failed (-84) errors.
> 
> We suggest that to debug this quickly, it would be very helpful if you could capture the UART
> lines (TX/RX/CTS/RTS) using a logic analyzer (e.g., Saleae) and share the trace. This would allow
> us to inspect what's happening on the wire and identify the root cause of the
> "Frame Reassembly Failed" error. There are affordable logic analyzers compatible with Saleae
> software, such as:
> https://www.amazon.in/Robodo-Electronics-USBLA24M-Analyser-Compatible/dp/B07B8KHYDD?source=ps-sl-shoppingads-lpcontext&ref_=fplfs&psc=1&smid=AJ6SIZC8YQDZX
> 

Hi Jeff,

Thanks for the information.

I have a logic analyser, but those lines are running from BGA to a PCB 
module that's 95% canned and currently I have no access to them.

Unfortunately I can't risk breaking this device trying to access them.

Martyn

> best regards,
> 
> Jeff
>> -----Original Message-----
>> From: Martyn Welch <martyn.welch@collabora.com>
>> Sent: Saturday, October 11, 2025 12:22 AM
>>
>> On 09/10/2025 17:01, Jeff Chen wrote:
>>> On Tue, Oct 07, 2025 at 05:49:59 PM +0100, Martyn Welch wrote:
>>>> This seems to be working well for me, at least for Wifi. I'd like to
>>>> get Bluetooth up as well. The bluetooth driver (btnxpuart) doesn't
>>>> seem happy loading the bluetooh firmware:
>>>
>>
>> Yes, I'm currently using the wifi only firmware. If I'm not mistaken, that's the
>> only firmware that the NXPWifi driver will currently use. It appears that it
>> should be able to load `firmware_sdiouart`, but that doesn't appear to be set
>> anywhere and thus it's not considered. I tried to rename the combo firmware
>> to have the name used for the wifi only firmware, but that was failing for me
>> (more about that in a moment).
>>
>>> To help us reproduce and investigate further, could you please share:
>>> - Your test platform (SoC, board, etc.)
>>
>> Custom board based on Renesas RZ-G2L, using Ezurio Sona NX611 M.2 1216
>> module.
>>
>> Kernel is 6.17 with an added custom DT, a few patches for other hardware and
>> the NXPWifi patch series.
>>
>> Both btnxpuart and nxpwifi are built as modules.
>>
>> The firmware itself is what Ezurio provide in their Yocto layer:
>>
>> $ md5sum *
>> 6a9307d27c3bdb3bde800265056ab217  sd_w61x_v1.bin.se
>> 8a28ec7f1b77dbde0ac7568d0426c669  sduart_nw61x_v1.bin.se
>> d38935f03dbe6da7a9ac3daf58e640bf  uartspi_n61x_v1.bin.se
>>
>>
>> Looking a bit deeper, if I try and load the combined firmware, the bluetooth
>> modules attempts to load before the WiFi driver has had a chance to complete
>> loading the firmware which is resulting in the firmware failing.
>>
>> If I blacklist the btnxpuart module (and rename the combo firmware), it loads:
>>
>>> - Your test steps
>>
>> At the moment, booting and checking to see if the hardware has probed.
>> If it has, ensure I can connect to my wifi network and ensure that I can pass a
>> little bit of traffic.
>>
>>> - The exact firmware version you're using
>>
>> As above.
>>
>>> Also, have you tried running Bluetooth in a BT-only scenario (without
>>> loading the Wi-Fi driver)? Does that work correctly?
>>>
>>
>> I hadn't. Just gave that a go and I seem to be getting the same failure (though :
>>
>> $ sudo dmesg | grep hci0
>> [   40.859055] Bluetooth: hci0: ChipID: 7601, Version: 0
>> [   40.889487] Bluetooth: hci0: Request Firmware:
>> nxp/uartspi_n61x_v1.bin.se
>> [   42.850682] Bluetooth: hci0: FW Download Complete: 396444 bytes
>> [   42.850736] Bluetooth: hci0: Frame reassembly failed (-84)
>> [   44.222243] Bluetooth: hci0: Frame reassembly failed (-84)
>> [   44.230226] Bluetooth: hci0: Frame reassembly failed (-84)
>> [   44.237480] Bluetooth: hci0: Frame reassembly failed (-84)
>> [   44.247567] Bluetooth: hci0: Frame reassembly failed (-84)
>> [   44.254188] Bluetooth: hci0: Frame reassembly failed (-84)
>> [   44.263459] Bluetooth: hci0: Frame reassembly failed (-84)
>> [   44.269814] Bluetooth: hci0: Frame reassembly failed (-84)
>> [   46.280494] Bluetooth: hci0: Opcode 0x1002 failed: -110
>> [   46.285835] Bluetooth: hci0: command 0x1002 tx timeout
>>
> 
>> Are there any BT patches that I'm missing?
>>
>> Martyn
>>
>>> Thanks,
>>> Jeff
> 


