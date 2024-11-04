Return-Path: <linux-wireless+bounces-14876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 577629BB408
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 12:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4CE1F22172
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 11:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31F91B395A;
	Mon,  4 Nov 2024 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="X6MHqqtS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFE71494B1;
	Mon,  4 Nov 2024 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730721580; cv=none; b=IWD4u9ybYB4DsCUmkMI/9hwKC2WQ9xugBdbduy0Q9aTuXQT/B3GK1GixGbc/NO66TprsERyE8fbUCc4/YkYr4in1b5mozuyrCdfFXgaevkY/n8mNcKqBeItE8/G5AXqxBT2Dc1oQn2mW9edZO17tjWLSVWKn/rlqN/b1UeFZy1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730721580; c=relaxed/simple;
	bh=sGKJtMWxxvXs5sFEcBa/3FeTHFjzuJv8X8Z52ULYNeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o2dFw2O5zaS0IT1oa8GOAwcGD6JNidmwKu4fmegkX7yGVIMPYkeUYMBcvjN1+Gmx5macb3bHerwvIsQrYOUbffw01piCFuZGKc0ycdB5o0KYCzupqVQjWj0fvOmW2QNCeodC1Ohwmev8wgVdAOaqXio1s9e+Ib4qLDplBnFUE3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=X6MHqqtS; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1730721568; x=1731326368; i=wahrenst@gmx.net;
	bh=sGKJtMWxxvXs5sFEcBa/3FeTHFjzuJv8X8Z52ULYNeE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=X6MHqqtS8FMXore6mcXONS5MSQouaDC7nOs1ZwIDOsxTrbSv/PzfjzNAn91/nWR/
	 KYieFCuMDRwqfa9yT2a3Ii+JACTCB3jxckoISvCN/tWCeEA6LJv2ppbLjWYTA56OL
	 tyu7tpaOU7FPyKj1WoLl+ri33byQOA/V7iHFawF407REstlCpwyON1oG3blj7OB/N
	 iCHNHgyxbmY2xSu6hCCVwNHAJ+wx+/z3YSAkqQQzo37G0fN8Hs79nX1ZDECY4gpKF
	 nvwPmkDC2mGifVZCz3wcK48gLyhrqJiaYsRxIqoQo4xGA26hdSn6x6Ujf9ahUQcOm
	 9+AV/UKMOJCS8ihUIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8XPt-1tuTuz0r4b-00qyC6; Mon, 04
 Nov 2024 12:59:28 +0100
Message-ID: <86ef2465-3b5c-47c8-9e81-ad5b545bcfe4@gmx.net>
Date: Mon, 4 Nov 2024 12:59:27 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac: error messages while entering suspend
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Arend van Spriel <aspriel@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
 SHA-cyfmac-dev-list@infineon.com, Kalle Valo <kvalo@kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>
References: <a825587c-e6f6-45f8-8ac0-a1a5642a5333@gmx.net>
 <16169285-d838-46f3-8be1-3639f573062e@broadcom.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <16169285-d838-46f3-8be1-3639f573062e@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AjFgiyDaDf5ylcrmVegqIF0rMOfd2QpbMehUKgmPr2s/GUb4hGw
 D4hTOVL2AM2m9EEkM2PSh427WENCUX+uTPnEYOwWAQSzskTiBYJ/IsqPzVgo+IB7OX47BI7
 vlP0H12dHI0kmAE/1o9vuJmS6K+08UXNuu+SxXPAjEPeJVDBAJ8oY3nECtczAPirl5+FjXc
 777a0Gug4Ixf/ORCj7KjA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oNWZOlCc22Y=;1lqqmxpicEB3A2NIs9LYwOK1S+W
 zrGyBDOomdL02xNGlO2Y6HG+sWFPQmSZ5bEiePQVIzEyPs03Pwmkr8IpeDxJOYZGcSO1QlwRd
 mJZ0tG8gzweN6xN1uTlo6mDKgI6ZgpfMxXLbC5eSjYrv0WE3/BJmIwCr8gudf9ZKpsuxHd092
 BTzLhkgi2kfeYIFWIZOJPoe1pLQ9MDX9rOJBo735Mai3CKx6FX8TJdlm0NE+tyX0WhpWFU60p
 oQOz072vlzPBNZWFuHwXSk/bZyAXgptp19/KdnnMJ7g480epUz75ymmk1z8XdLw6MkwW8uuCa
 7mtFmWVaA1xH5DB5Si2mpOw+PQYw8euxTDfhkZYnFEuarOx+P7/5Vi9478gzw7AqnmidlU0JN
 5MqfD/ka915cIan/gzQwUoFv1l3E15tk0NW2/X0uDu/S6WbdxL3i1IVrceb1HJFv3sH59NTVG
 GOY5PAffLgVJgTXUDp5qh6lr4bEiIOw6P/Hzc0PwVcJWv5FeNzCuU0ctc/yL/JmjQJYgLx1we
 32kPL4mgmiwChPY/pZREW2iCpdt2k/SYZsG5kNusS7Z8odbyyBO0f41j4aCjH4bTyI2GTwO5i
 ak5g9qmLDeJELBz25KVodO0c/7N1l19Wzlh7EGxNKdGBHG/EwcvEY8j+MvOtkI5UQ1Fn/Qy+R
 SEE66PewNL74aXNUwQScuGhXyygYnSqUwb9aMX1A/UXHILb73ugzKbO77zrhjCca+jeH/sJrl
 mUor5sTjyBY4zCIDb1srUXi05rkjfTA2IFejRd0FbUv6vg1v55hXPL45doMLCGn3f7MHUVkTm
 plK1tsB21hTBe2woDP1XYvlg==

Hi Arend,

[add Johannes]

Am 04.11.24 um 11:06 schrieb Arend van Spriel:
> On November 3, 2024 12:01:55 PM Stefan Wahren <wahrenst@gmx.net> wrote:
>
>> Hi,
>> I'm currently working on s2idle support for Raspberry Pi 3B+ (BCM43455
>> SDIO). During the tests with I noticed harmless, but annoying error
>> messages from brcmfmac like this:
>>
>> [=C2=A0 383.186640] PM: suspend entry (s2idle)
>> [=C2=A0 383.190107] Filesystems sync: 0.003 seconds
>> [=C2=A0 383.247470] Freezing user space processes
>> [=C2=A0 383.250291] Freezing user space processes completed (elapsed 0.=
002
>> seconds)
>> [=C2=A0 383.250379] OOM killer disabled.
>> [=C2=A0 383.250385] Freezing remaining freezable tasks
>> [=C2=A0 383.251677] Freezing remaining freezable tasks completed (elaps=
ed
>> 0.001 seconds)
>> [=C2=A0 384.292071] ieee80211 phy0: brcmf_fil_cmd_data: bus is down. we=
 have
>> nothing to do.
>> [=C2=A0 384.292079] ieee80211 phy0: brcmf_cfg80211_get_tx_power: error =
(-5)
>>
>> These errors are not new and I assume they have always been there. I'm
>> not an expert here, so I want to know is the problem here that the SDIO
>> interface is shutdown before brcmfmac is suspended or lies the issue
>> within brcmfmac suspend itself?
>
> Hi Stefan,
>
> Upon suspend we execute the remove path and cleaning the interfaces.
> We notify cfg80211 about the removal, which in turn will notify
> userspace, but is tries to obtain the tx power from brcmfmac. However,
> at this stage the communication with the dongle is already gone. These
> messages are also seen in the module unload scenario. It seems a bit
> redundant to query a device that is going to be removed. So it could
> be fixed by chiming down those message or avoid it completely by
> changing the behavior in cfg80211.
chiming down all the affected messages (i reported only one example
here) sounds strange to me. Maybe Johannes has also a opinion about this.

Regards
>
> Regards,
> Arend
>
>> Here is a calltrace for the error above:
>>
>> [=C2=A0 384.291308]=C2=A0 brcmf_fil_cmd_data+0xe0/0x114 [brcmfmac] (P)
>> [=C2=A0 384.291347]=C2=A0 brcmf_fil_iovar_data_get+0xcc/0x134 [brcmfmac=
] (L)
>> [=C2=A0 384.291384]=C2=A0 brcmf_fil_iovar_data_get+0xcc/0x134 [brcmfmac=
]
>> [=C2=A0 384.291420]=C2=A0 brcmf_cfg80211_get_tx_power+0x58/0xd4 [brcmfm=
ac]
>> [=C2=A0 384.291458]=C2=A0 nl80211_send_iface+0x1e8/0x584 [cfg80211]
>> [=C2=A0 384.291549]=C2=A0 nl80211_notify_iface+0x58/0xd4 [cfg80211]
>> [=C2=A0 384.291615]=C2=A0 _cfg80211_unregister_wdev+0x40/0x27c [cfg8021=
1]
>> [=C2=A0 384.291682]=C2=A0 cfg80211_unregister_wdev+0x14/0x20 [cfg80211]
>> [=C2=A0 384.291748]=C2=A0 brcmf_p2p_ifp_removed+0x6c/0x98 [brcmfmac]
>> [=C2=A0 384.291785]=C2=A0 brcmf_remove_interface+0x170/0x1ec [brcmfmac]
>> [=C2=A0 384.291822]=C2=A0 brcmf_detach+0x60/0xfc [brcmfmac]
>> [=C2=A0 384.291859]=C2=A0 brcmf_sdio_remove+0x4c/0x188 [brcmfmac]
>> [=C2=A0 384.291896]=C2=A0 brcmf_sdiod_remove+0x24/0xa4 [brcmfmac]
>> [=C2=A0 384.291933]=C2=A0 brcmf_ops_sdio_suspend+0x100/0x1c8 [brcmfmac]
>> [=C2=A0 384.291971]=C2=A0 pm_generic_suspend+0x2c/0x44
>> [=C2=A0 384.291982]=C2=A0 dpm_run_callback.constprop.0+0x74/0x134
>> [=C2=A0 384.291993]=C2=A0 device_suspend+0x110/0x3d0
>> [=C2=A0 384.292002]=C2=A0 async_suspend+0x24/0x3c
>> [=C2=A0 384.292012]=C2=A0 async_run_entry_fn+0x34/0xe0
>> [=C2=A0 384.292022]=C2=A0 process_one_work+0x150/0x294
>> [=C2=A0 384.292032]=C2=A0 worker_thread+0x2dc/0x3dc
>> [=C2=A0 384.292041]=C2=A0 kthread+0x118/0x11c
>> [=C2=A0 384.292049]=C2=A0 ret_from_fork+0x10/0x20
>>
>> Best regards
>
>


