Return-Path: <linux-wireless+bounces-17850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181FBA19C26
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 02:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B267216BCCA
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 01:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EFB17741;
	Thu, 23 Jan 2025 01:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b="qNEGuA2I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33A34A1D;
	Thu, 23 Jan 2025 01:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737595353; cv=none; b=AVeXITUXThzZ/d9kqyxOfgHxdTFC2X3xqfeHoFHhn14taraLHZIbLWFb7KqVKmToMt+aZ3EcdUKwsK8yblVOFP+7vlvbypPwpg4qjVGVXewuSAOtmdWbwHVjcFfXNtmokN8PLqFi4INFtN5L5t1s5+9GGt7whCjRa1gQhb4voxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737595353; c=relaxed/simple;
	bh=TUH2pLaOatB7bgn6A5SUNauoeh7s0UFj7i7hm36aedE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hhqd87OmHTqjdIO2Y+E68xUeqCWnN8cZjjvRsSZeH9V1UpipIpZ2mj9V/FJ9TYTHsVMWhOjYsRaaafP/H7DIyZBWpZzljkBLgZKu1ic8HRySi8WhcH1+ibbm3Kk1G5DT1HtMSYgtoI12XenVW7Grv2eA948wkrkyWck9QviEl/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b=qNEGuA2I; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1737595336; x=1738200136; i=smoch@web.de;
	bh=fs4fumd2mEmOvKEdLbxT9x2Ia/T+Az6f1IjDLWSDD4k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qNEGuA2I/dVXAsM6cZ9rQcpfqVC532rEKA3kr2VpTe+bj8PQSoxs1Ven5MNIVEYJ
	 l5HHxQZwAgb9Eiv9PSQAsR5JRj0vJg5Dz2hBMgeYXnID4CBF+pE3l73bylHrA0KoO
	 d0t7iXepdjQes5kgolhgTQevPBB7RkVwxWIS1UuLd82Fvh3KOD0c3Mq7pQu2e/og8
	 7PXvdweMtHxB2zTr+M9VLQHY4FanYsH43cZXNpkCVV6mEePqkvrk9OH169J2hxJ8H
	 ai+0euTNC6pDda+FAeHrnKzf1+CuxCZ/yS9ZUHVxrCr9v1kAkRyZFJS/5cJTqQx+M
	 D/RLiV0BsMxlW2ZpCg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.1.40] ([78.54.50.138]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhWop-1sxINI4Blb-00a4ek; Thu, 23
 Jan 2025 02:22:16 +0100
Message-ID: <0fb6f633-7ce0-4229-a2fc-df65aeeefd83@web.de>
Date: Thu, 23 Jan 2025 02:22:01 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtl8xxxu: retry firmware download on error
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>, Jes Sorensen <Jes.Sorensen@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250122153156.373470-1-smoch@web.de>
 <e08051130a124fcfab8d42e6893c581a@realtek.com>
Content-Language: en-US
From: Soeren Moch <smoch@web.de>
In-Reply-To: <e08051130a124fcfab8d42e6893c581a@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:24p9W4AMc6FDTuVY35VRIOyTiIREy6UqvOaPtm+xXHaocgBv1FS
 rTMM3JmrHwFSONdLxyRwpiknRRn8DDL7K2bwXX5jvLZOv61YSQRC36q8audGto9VcyCWqkf
 4LxgPcmRaQHgWD91kP6MIYNtaVPk0dxD0BiFAc876U/F8rDbXJbjQCd0BUJC30VuMsEJi4H
 BbjOaUE9c18L2PE9/oksw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ihOiirdnoKU=;JJMWpnAG20Q9ascPIIkyAazA9eT
 nKJRQZcp88nl5Du1DT8Qinwa9m5SHX0vXNmCJXpc+0iYfDfiFNfazUEPt2NbUyQ+wI3rDkG8e
 wm+EB3EVXEA+WLFwgyJ7rc5M7AHet+It6BMmYql6wFnnEIqqDnyURGw0xGyxRGGTAqOmOEQpq
 6ATj11zWtWfA7gmf34zAVjo63ARRjZMmA9FKgTtxoanSJaRx1LFSFtigiyWoufRsJ5uCw7jnh
 F4hFgHhtJ/7FByeotcQ5P6wXJrdkg4yTdjnEPqbiiNn4pLCj7pfIM/0JUahCfeQLuQpSP/bvI
 I7/olUTCNAeZDr73WQU75qpAaEaXSfjIrb4xN4KIjj7v1OUnpt2azdqTaMjUXOJX6ZlTIMQkF
 ezueXTw1cH1aVYapE89Zm45DHGTRmogN7eRWVMl6uoSZfLPu2J6oplz+f6bED3N6XrLmBPzfH
 ecqAnbtK5hFegabGVB6pTHSGCpootuEDw+Znv6xDnwz5hGvp8UFPj8Vqnkf6XXkxLwdqo02tV
 xWjFLZHxA8W+OL6vrwYClElbAHyYVy1YXoGFGs5wTGGNMf5JEQMC4+Eynzml8QDR/OzpLOYCp
 awStQiJUZLH0vRNMMOzDjlwdY8PKnFvulzc2M8wGkR3W+efFs4jr+4j8GAAkghnaMjbJ/2DBO
 jzNw9KLWELCU1ISmRg3YxWfLiZIjvJOizMKf/SeVm5o+v755cgERzEULqnccABMbzSD31L+WH
 vcXGyCVrTga5sdQfP4/LrDxrlSqr2fPGZT0fpzvbbhOOjWGprFbZmkCrEitqFNIXV61aH6Gpv
 2K7dWcx5endyeviZynokRPUwpLLR+So/jl8rwPe9EJ0k2O540RC7ix5tHfh7L4mIbpY175nct
 cJwqqlcLo8J44RYIqn194sdGg19sNx7hwVcry3erKJOH+w5e5JBhwn8OgD/Fn2Zq1E4Rn6QB2
 q91Bdw5MYBBci9Tfea62cTGCI7MAfaSFRYlxUQAUDzgGGTdEThF7FTJ+oPpxGZNVJuxmGI9BO
 UHjV4mjq89LCzuZv0jtP1aGU2A0FuRE502hrB2YVsXUeRDUEcfiBb9OgJQ7bCNaEGmhpoMULd
 thI0/6NUaOykNKi+95bqdlPSSv5FkotKWLfQpQDd2hUtba8hCqE4lugVV96XU9WatdZhJKe8P
 BJ2zUDb+SGeiRLHTswaNt4shh6ortMVi4Fcdtkvtwmg==

On 23.01.25 01:21, Ping-Ke Shih wrote:
> Soeren Moch <smoch@web.de> wrote:
>> Occasionally there is an EPROTO error during firmware download.
>> This error is converted to EAGAIN in the download function.
>> But nobody tries again and so device probe fails.
>>
>> Implement download retry to fix this.
>>
>> Signed-off-by: Soeren Moch <smoch@web.de>
>> ---
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>
>> Cc: Kalle Valo <kvalo@kernel.org>
>> Cc: linux-wireless@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>>
>> This error was observed (and fix tested) on a tbs2910 board [1]
>> with an embedded RTL8188EU (0bda:8179) device behind a USB hub.
>>
>> [1] arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
> These can be in formal commit message.
OK, I'm happy to move this to the formal commit message if you
think this would be helpful.
>
>> ---
>>   drivers/net/wireless/realtek/rtl8xxxu/core.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/core.c
>> index 7891c988dd5f..cd7d904eae62 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
>> @@ -4064,8 +4064,14 @@ static int rtl8xxxu_init_device(struct ieee80211=
_hw *hw)
>>           */
>>          rtl8xxxu_write16(priv, REG_TRXFF_BNDY + 2, fops->trxff_boundar=
y);
>>
>> -       ret =3D rtl8xxxu_download_firmware(priv);
>> -       dev_dbg(dev, "%s: download_firmware %i\n", __func__, ret);
>> +       for (int retry =3D 5; retry ; retry--) {
>> +               ret =3D rtl8xxxu_download_firmware(priv);
>> +               dev_dbg(dev, "%s: download_firmware %i\n", __func__, re=
t);
>> +               if (ret !=3D -EAGAIN)
>> +                       break;
>> +               if (retry)
>> +                       dev_info(dev, "retry firmware download\n");
> It looks like 'if (retry)' is always true and unnecessary.
Correct. After seeing the patch in my Inbox I already realized that
the for loop should be

for (int retry =3D 5; retry >=3D 0; retry--)

This would make clearer to have a maximum of 5 retries (6 attempts in tota=
l)
and also avoid this message after the last possible retry.

> Also, this message
> isn't so important to user, so dev_dbg() is more suitable, but already p=
rinting
> "%s: download_firmware %i\n" for every retry is enough? Or move it out o=
f loop?
I think this message is important since there is the "failed to write bloc=
k"
error message before:

[=C2=A0=C2=A0=C2=A0 6.239205] usb 2-1.1: RTL8188EU rev D (TSMC) romver 0, =
1T1R, TX
queues 2, WiFi=3D1, BT=3D0, GPS=3D0, HI PA=3D0
[=C2=A0=C2=A0=C2=A0 6.248793] usb 2-1.1: RTL8188EU MAC: 00:33:0e:00:15:8e
[=C2=A0=C2=A0=C2=A0 6.254218] usb 2-1.1: rtl8xxxu: Loading firmware rtlwif=
i/rtl8188eufw.bin
[=C2=A0=C2=A0=C2=A0 6.343753] usb 2-1.1: Firmware revision 11.1 (signature=
 0x88e1)
[=C2=A0=C2=A0=C2=A0 6.374659] usb 2-1.1: rtl8xxxu_writeN: Failed to write =
block at
addr: 1c80 size: 0080
[=C2=A0=C2=A0=C2=A0 6.382894] usb 2-1.1: retry firmware download
[=C2=A0=C2=A0=C2=A0 7.221505] usbcore: registered new interface driver rtl=
8xxxu

So the retry message after the error makes clear that the error will
hopefully
be corrected.

Since rtl8xxxu_writeN is only used for firmware download, an other option
would be to downgrade both the error and the retry message to dev_dbg().

What do you think?

Regards,
Soeren

>
>> +       }
>>          if (ret)
>>                  goto exit;
>>          ret =3D rtl8xxxu_start_firmware(priv);
>> --
>> 2.43.0
>>


