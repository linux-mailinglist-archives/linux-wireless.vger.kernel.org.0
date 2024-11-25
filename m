Return-Path: <linux-wireless+bounces-15686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412029D849C
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 12:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D385016805D
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 11:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A98B185949;
	Mon, 25 Nov 2024 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="JE9zZ2Ix"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B3B191F7E
	for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2024 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534663; cv=none; b=WG4LjhiU3frN852XJy08unWD40Kn0SU6dM36mGXZHJMnry6vTnpryoym5xn/LwvWTw3VtOoxfVTmyFKFKj6ndrhULrp71zr0czQIhFyvKX3gslj64Ku3sQgnPVsCU/7sK7IWjUlF7g7y0zy6gObyw+Nvna1bNlwixiJU7/8Loho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534663; c=relaxed/simple;
	bh=h8yNl3ZZNPgh25II343/EA8Mi16OOKk+oH8Z+iJWUNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+OlXaq6AR9Mlx9mb3AFXTWiJv+2U9oX4u7+N5E6ciFWpuSwte3OKKnTftScrzUKeW9/7yLKFYR9KZVdEwuHX5XveqK32gRYqDckDAI+QpXMEhZdBE2w3ZvEQJCzJqIOG6pGAoS8KGfcsb+hsmyDNwkzG1J6vS96uo/5BSNInOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=JE9zZ2Ix; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1732534644; x=1733139444; i=wahrenst@gmx.net;
	bh=h8yNl3ZZNPgh25II343/EA8Mi16OOKk+oH8Z+iJWUNA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JE9zZ2IxhqTtsrvaxqosQsRo4jK4EKPs+ehbcb8YbxMWxYIKRfyBhQydM/u+4u76
	 rKUwm3Pj1Z6w4VySrTeirGMzSdsmWfAc5GjdG3fBkECKMh31HoYCNAh5kdLJB8jv6
	 Fz8SzeulRMscu1NMoX1QPm+xkKeld7ZT/Xc5OidK1btXa/d+XKnr9InGZpWqL/bAj
	 uGe9db8GD1gxqkOY5QaAvPstk5txZjhsEFM/6YPbDJPiaHsUp8WLU/2fL8kpk5hU3
	 UFPpoTD5Id3EBftWhWsGNSsGZ3RrOT0l+g0pcgVCQ1GGZrxaFKnfPueTaVFcPx3/M
	 lvffgyCBpz/3LlOTLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.251.153]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSc1L-1t97KX34Qb-00LJ8y; Mon, 25
 Nov 2024 12:37:24 +0100
Message-ID: <59c2ab2f-57e5-4196-a7ba-5db066d38958@gmx.net>
Date: Mon, 25 Nov 2024 12:37:23 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail,
 reason -52 - Part 2
To: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>,
 arend.vanspriel@broadcom.com
Cc: SHA-cyfmac-dev-list@infineon.com, aspriel@gmail.com,
 brcm80211-dev-list.pdl@broadcom.com, franky.lin@broadcom.com,
 hante.meuleman@broadcom.com, johannes@sipsolutions.net, kvalo@kernel.org,
 linux-wireless@vger.kernel.org, marcan@marcan.st
References: <19358720a28.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <20241125064940.11746-1-renjaya.zenta@formulatrix.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241125064940.11746-1-renjaya.zenta@formulatrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gLM7Lck9WB/So9DsPkMJfZLM0Ol/tvr3d+7DcRvOPntsBmvJ6P4
 4flMDo2wlQrJOT1iAhW4MuDRp/uM6juGDgttblMKjmv7NGgwlJ5ueugc/g1L97Ds1nz0c4s
 WnBpe01DJwfSBRbxVFRjV/uuDYZkzVuEYFkRK7hoqazKsSmLX2UxcS1xabXVTQZEEU0e7eX
 SlykW0MbDCkxm0cck4J3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F2yt84AnJ/U=;UF1UW1Pxu/NV5twJaQIJG+U8y71
 +U3pS35GfjDITKUgkYEUOnfmMDY/ErJC5Xj8mnG98UhxtqVxzW7VfNz1TE9SrKXmm3VhF8DQj
 E5O0zELyOc5qGu5MdIeQFetZnLmyoGZNeKy5VIyeb3cNtY93znxDSVKZfi8VugHFGo1hn9ZlM
 EIj2baRotrJHXYfbhcaq8rQDDhJYTQmuzHu0RN5V9w2xSVfgFWrcJyhaVSBMzUlnkY2py33hw
 ipkf+mhWbviaLS0AMCO2fxAHmyUdVcqlKIpxiRbK5pa4mZ5f1zBWfkNiM2cC5ADTcxxDuZcf0
 kmekC+tvCbxjBIwhEgUnERu6LKNkTqWnaVlLiDpjPKli0+sWhwsxg3ADtjRNNvjkVzQnVclUy
 Cov2NMkyFLWYKuYlfRvDf7Z3/JJZOZ7c78fEolnZW0XGlPixKaPmvE+t4TLoGV1nsdA33zw6b
 f723OgLuIZMaR5lxaavAieKWPSFz4wf8SO9cwBRBuhO7QoZvHD7ZQrKkVqsd01PaqeFRCND/x
 OkBbkHENOcAbAdPP+GFGnz6zciZTwTtdZlmKAecyqN6Nk6PER7spAfuITb5ddoH9AvwuoN2TG
 zkPrUdWyp9Q0hT5jjEOS6ZAfTbaeCC/J6ih128RcdVI2TW+X7hlTDz1SfboQUEOHy6rhmWFeT
 szJAB7YMF5f1coMO/dGajj+6WZgu4KFjWgyyPwV8UGtvl1ODP2WqAKPf58EmpKo5oOGKcuaj+
 SZjEIhU45CWlXbNixu4vXyFSG8eSn495OrFEgFAj6wSsK1Vp0bOx66+QSd4PAHyhwOjjN7mRI
 Ft5n4nDHIheBY4xDCnED1e1lFoa/AQQ8rgJXosm/wd/Dy2RN8y2wmv2BMNBa551o9XnGK2rbj
 26oBmN3Ck1ENqQqxaPgZTmMYY6WPHk8gjOJUlUoV3PKhwVrjdaWlVSYdX

Am 25.11.24 um 07:49 schrieb Renjaya Raga Zenta:
> On 11/23/24 4:54 PM, Arend Van Spriel wrote:
>
>> This was reported earlier by Stefan Wahren, but the thread ran dry.
> Yes, I've read the whole thread. I guess what I've found is similar
> to what Stefan found. Those channels are disabled by the driver in
> brcmf_construct_chaninfo() but are re-enabled in reg.c.
>
> I see there hasn't been any conclusion yet, so I just bumped this thread=
.
>
> Stefan did a workaround by modifying brcmf_construct_chaninfo() to store
> the IEEE80211_CHAN_DISABLED flag within orig_flags in case the flags had
> it. I see no further ACK, so I think that's not the proper solution.
Unfortunately I'm don't have much Wifi knowledge & time to push this
further. So I'm would be happy, if someone take care of about this
annoyance.
>> So what changed a couple of days ago? System upgrade?
> Well, I use the latest OS from Raspberry Pi, it still uses 6.6.51. I gue=
ss
> there is no significant changes from what Stefan tried.
I think it should be mentioned, there is no usable Raspberry Pi 5
support in Mainline yet. So the mention version is a vendor kernel tree.

Regards
>
> Regards,
> Renjaya


