Return-Path: <linux-wireless+bounces-7580-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CB98C3DA8
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 10:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36C31C21102
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 08:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7D14206B;
	Mon, 13 May 2024 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bMFjdLmz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4605F2B9D1
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590712; cv=none; b=TIaBmSCXwV/9meeHRnALsTgdg8/NgDprS9LYFfOFQiHAmF4odfZHkEFlz1acFlDWHM4yT8Y7VHCudr02/qYkiLn9MDZvFYRILjWRuhQo5MDO44S+hrPHRAj4P7Z+oxr+d71/Lahf2npptHK0XeUcnzV47/ClaCJKVnx9UAePnMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590712; c=relaxed/simple;
	bh=dGyUKZqpBDN/CMwIYzyDdDHAeKa/o3GF0BtsDwlkiDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCFMYIccEUPpgS3TDyb2dXgmfqPhHMf8Q3IV4I2XFf3TcaTuxeS21Ax9RdtoAVfpqHVDq/ax/NFvZ+ANuS9AgACD5GDOI1uMIQnNY5RL0m2KyW6wve5LsaOmQjtZtv1eL0OGa0Jj2Z6jiLp+23/5isSpy3BVZtVwVfhBl8Os1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bMFjdLmz; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 123241BF20C;
	Mon, 13 May 2024 08:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715590707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s1xSN4hl2fRg6lqHRL3evbDa3rGly7LE7/ezLFYhDDo=;
	b=bMFjdLmzeR0WZ+ykCRTxCNhok5BaoNpvSJDWVX7rPtXgMZ8pqzVxFVvjSye1libf+T57rF
	oU1N1k3hC5h0jyy24THHDztmzDmv/hf9CqU05DbPd1oNteaaAPEoce6hM5qr9e0noAwwuX
	dwq6mwJ7fvUY3qT1fi1vVeaKCf//kuCYu/dMQRBO01QHA8D3uWTa/I6TfTtHDKr+Dohelu
	GyhFEdOYQL5Qyb/kyKQ5Cg9qs08N5/enIevBMFtYKe5I+eBymatgui2hRaDGLUGnCYBvfJ
	KuVF7NwmJSIUac+AtZPwjkOHDSSeCyjsTjtz6YHEA3RDbeHiNc1lxEgelVoprA==
Message-ID: <3c136f96-83b9-4989-92a6-9e7cf79d7e5c@bootlin.com>
Date: Mon, 13 May 2024 10:58:26 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AW: wilc1000: error when transferring large files
To: Heiko Thiery <Heiko.Thiery@kontron.com>,
 BUKSHA Kirill <kirill.buksha@axians.rs>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ajay Kathat <ajay.kathat@microchip.com>,
 "Heiko Thiery (heiko.thiery@gmail.com)" <heiko.thiery@gmail.com>,
 "kvalo@kernel.org" <kvalo@kernel.org>
References: <3b0aa2d8-4e3e-4e50-8c04-f3a2637bb18d@axians.rs>
 <PAXPR10MB4948B9B69A8D9964B60BB5F68DE52@PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <PAXPR10MB4948B9B69A8D9964B60BB5F68DE52@PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Heiko,

sorry for the late reply, I was away from computer most of the previous week.

On 5/8/24 08:36, Heiko Thiery wrote:
> Hi Alexis,
> 
>> Hello,
>>
>> I'm part of a team working on a BSP for a board with a WILC1000 module from Microchip (connected via SDIO interface). Currently we are having issues when transferring large files over a WiFi connection. Here is our steps to reproduce:
>>
>> # generating file to transfer
>> dd if=/dev/random of=./test_300mb_file bs=1M count=300
>>
>> # transferring a file from a linux laptop to the test board
>> scp test_300mb_file user@192.168.1.25:~/
>>
>> During transmission, the connection speed drops to almost zero and returns to usual values after a while. At the moment of the drop, we see the following messages in the kernel log:
>>
>> ------------------------------------
>> [  138.016229] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
>> [  140.001682] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
>> [  140.009719] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
>> [  142.003636] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
>> [  142.011670] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
>> [  144.006676] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
>> [  144.014709] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
>> [  146.007049] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
>> [  146.015082] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
>> [  156.123890] mmc0: Timeout waiting for hardware interrupt.
>> [  156.129318] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>> [  156.135764] mmc0: sdhci: Sys addr:  0x4cef1400 | Version:  0x00000002
>> [  156.142211] mmc0: sdhci: Blk size:  0x00000170 | Blk cnt:  0x00000001
>> [  156.148655] mmc0: sdhci: Argument:  0x14000170 | Trn mode: 0x00000013
>> [  156.155102] mmc0: sdhci: Present:   0x01d88a0a | Host ctl: 0x00000013
>> [  156.161547] mmc0: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
>> [  156.167992] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x0000003f
>> [  156.174438] mmc0: sdhci: Timeout:   0x0000008f | Int stat: 0x00000000
>> [  156.180883] mmc0: sdhci: Int enab:  0x107f100b | Sig enab: 0x107f100b
>> [  156.187330] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000502
>> [  156.193776] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x0000b407
>> [  156.200223] mmc0: sdhci: Cmd:       0x0000353a | Max curr: 0x00ffffff
>> [  156.206669] mmc0: sdhci: Resp[0]:   0x00001000 | Resp[1]:  0x00000000
>> [  156.213113] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
>> [  156.219557] mmc0: sdhci: Host ctl2: 0x00000000
>> [  156.224005] mmc0: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0x40881200
>> [  156.230450] mmc0: sdhci-esdhc-imx: ========= ESDHC IMX DEBUG STATUS DUMP =========
>> [  156.238024] mmc0: sdhci-esdhc-imx: cmd debug status:  0x3100
>> [  156.243687] mmc0: sdhci-esdhc-imx: data debug status:  0x3200
>> [  156.249438] mmc0: sdhci-esdhc-imx: trans debug status:  0x3300
>> [  156.255276] mmc0: sdhci-esdhc-imx: dma debug status:  0x3400
>> [  156.260938] mmc0: sdhci-esdhc-imx: adma debug status:  0x35b4
>> [  156.266690] mmc0: sdhci-esdhc-imx: fifo debug status:  0x3610
>> [  156.272439] mmc0: sdhci-esdhc-imx: async fifo debug status:  0x3751
>> [  156.278710] mmc0: sdhci: ============================================
>> [  156.287352] wilc1000_sdio mmc0:0001:1: wilc_sdio_cmd53..failed, err(-110)
>> [  156.294177] wilc1000_sdio mmc0:0001:1: Failed cmd53 [0], bytes read...
>> ------------------------------------
> 
> since you are also using the WILC1000 device, I wanted to ask if you have ever seen such behavior?
> As Kirill wrote, with newer kernel versions it only occurs with longer transfers.

I remember having seen a few time the described behavior (speed dropping to 0,
then resuming normally during iperf sessions) but not the associated logs. Maybe
my kernel configuration is different enough from Kirill's one, especially
regarding the tick configuration. Can I have the corresponding defconfig ?

For the second part of the logs (starting from "Timeout waiting for hardware
interrupt), I have seen them, but never in "nominal" operation, only when
unplugging the module during operation (I am working with wilc1000 sd, which is
a kind of "hotpluggable" wilc 1000 in SD/MMC port).

I am wondering if this scp transfer may make the chip reach a memory limit,
especially since you observe the issue less frequently with newer kernel. I
remember some patches from Microchip team mitigating issue about this on tx side
(a08bb28f6eb6 ("wifi: wilc1000: add back-off algorithm to balance tx queue
packets")). That's only a wild thought of course, and the face issue certainly
needs some new fix even if it is indeed this patch reducing the issue frequency

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


