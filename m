Return-Path: <linux-wireless+bounces-17044-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DC2A008F0
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 12:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357F6162EA1
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 11:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ECA1F9A9F;
	Fri,  3 Jan 2025 11:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="g25HS2Vj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F7D1F9A96;
	Fri,  3 Jan 2025 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735905372; cv=none; b=G09DTGu2ow154DM0pq6AYKn3M1lZaNgEjm3zbwcb+NTI9+szE82ReewNscNmjwdLh0Q6rM7G1bqbYF9FLWrNecQ9V8VWdiOVxuMToAC8ONTxXtTM44azbJkntwyMu4T1a1GP7OvLtq2fl+XpnGXGtrGuFWnbXF0sCvYhonSjLH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735905372; c=relaxed/simple;
	bh=A9b3OFX8SaM49UKKtrDec8vKbuaH5nmSwIWCKZ98mRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STBLpE/GtF9NvrLHjhx9Rip8nGgaiwWwyrsAPZzObrKBm/dnj1MZrlKf4h6mg1Wl44r4Zt1yq6sSGWgLyYyMb8jf/Dnm71KyBfdBbpmbWFrh6G8rdA3o8n+T5gDgBRLgrONDHPk4VbWNIYECqYVelr8xm/LU2ZXatiARAhfCguc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=g25HS2Vj; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1735905356; x=1736510156; i=fiona.klute@gmx.de;
	bh=A9b3OFX8SaM49UKKtrDec8vKbuaH5nmSwIWCKZ98mRs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=g25HS2Vjmpf9y0VIOjsY/+PrVmNDOPM29oeEa8hUv7bGAWZq+8nc6ypzJ7M3/8Ki
	 Mprw8uR7OLgYxyuunWdsex0JVS4b772zmymuQf3jCj5Q7DQP4LpOhwESd6QlM1rld
	 iQ63KM6kdcZW2QhXHTSJ1FX9WEfjaTyMG6490T7rE6klRseutVEKFp86ymhMNxQP0
	 mRG2uElFz239qQEeQhG3YUVzeQqSQU+jj0G3HYJ0YHuadSKcn1bHhEar6jl4Ubbv9
	 oItzrCTxFA1RTxChGA1wTkoj9IBDFbogP/obyxXOQEEb5N6uvMWtDC8Ax13FctdJp
	 hzcKo4PnkqyhNYr71Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([84.249.220.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTiTt-1t45SQ3O0b-00R0DO; Fri, 03
 Jan 2025 12:55:55 +0100
Message-ID: <d6f4d483-6f05-4221-8412-5c245e5974b4@gmx.de>
Date: Fri, 3 Jan 2025 13:55:54 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtw88: 8703b: Fix RX/TX issues
To: Ping-Ke Shih <pkshih@realtek.com>, Vasily Khoruzhick
 <anarsoul@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250103075107.1337533-1-anarsoul@gmail.com>
 <f69874f3c11f4c7b8b0e3026796bb452@realtek.com>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <f69874f3c11f4c7b8b0e3026796bb452@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3DZztg0NQZ08amkORvwisifWC3zO7pTLBqAEckchA+Vg9kuQyNk
 5+L+9P+pKWASX6ks9gLehcpL6AKdzMzPTAtE+1/Z16k6WBcRVixSEtrVVE1dPZp4H8LwAzR
 YGyb7vVdKWbRAsR3X1Oa6YmLa5vcFkr/1Hg6ObCwitDz8uN16V9xfWLfBImDkSr/wOjmeOh
 Ihkouq1uaYAHaY889MJSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:73Hnc9kn0cI=;5qgxQvlND15ROPXQB3eS/EE/r+b
 nftamQ4BCDBS5808B0XbzzbVZCDD7m54zbqNbTMD3q2S5RX7Dq5a3UkHNyyTibrDHvzurHiUH
 khavbGc3/hdyNOSjuD795a8+yhAERR1l66tNUweWHRSmgcyPmGSw8PhYl0FrE9HJplVztW4Y3
 FYKNEtVxSw8J6+ECxTCyF+7LEPW8I0lGNeupS6W/HEvNu9mNSs0m+ONBgIG2N03MpkPNpxJpi
 Mervi2ZWYrVOHJyrXfkfzZ/0KTY4MBgRfKR0OpCetEUpQtPQPOHHlEwf/9hjSxndi/lqtYupb
 cWP6RjE/b2HKWQOKf6FMosUM/BMfgdooZYUZXKsXmpnNdxF0MoM4j1qPDg65NKMHogw201nth
 fzzzl36BAyJdNrEy7eBvU6lvvJu67nbgfP/2L3GN44ljrJzCzra17n8IoYCA+B0WEn4Q5wmGO
 pBnO9NlzdZlpKjsBfRjnY4bupMjl1SqlDhhYo/xwbyv/mbG1nodddDHmcdR/8heSU3Ku8LgCm
 GrmZCqpqx/IL5rWfBrnaxDOpMVfHstbgo7we7Q/i3F/mjQ33njAK9Lg+Nkeowtmu7fj3ZGujS
 BIyANOlxhhGm6JhlRKBJt4MC8irc7/XKM24khiq4TskbfN9BcIXe6kgY/OAEF8cGXk+Rh6+QW
 pzb35d0H58AZAxcwCiFUZVM24THOgJHuhxP4D6LINzWQA3d4OsMo4vRzgjFU2WxoNVJQH1Xa3
 Y4nefbyCaxzSaziOGu9bfKIrhYWZEmrJwRzaPsg14/lss4M66xXNddwToP+kTKtODyNvCPdbR
 effjnqWvwycddxwkNZOVPrIGbEmGoNtFkrN1IF0YpLOdok7f2/haDCi2PfxgV3c/MUzX+FAKz
 tCQuHI54kVdKg8+rkv1Wmk7NQJKpoH6UIDZ7Mk9qNwVxLpluW7uooHtP7LAlqJJNqnwhm9d+Y
 vtCDgXKkWu0/55y819Ab7bgL0GSzIXVGIRpkCrV/rzqz9bDXFqMc2U2u5vNZfBJtElWGoq1Pk
 aQay8x7+yoFq09Pp8Q0yeDlhz/YspxUe9sqCYvM7s7wQFpPRPAMXywKnOJ1L7p/ExuRDqqy0b
 nXtC2InQyrQRDATl+7V0qwr7n+ZnYC

Am 03.01.25 um 11:12 schrieb Ping-Ke Shih:
> Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>> Fix 3 typos in 8703b driver. 2 typos in calibration routines are not
>> fatal and do not seem to have any impact, just fix them to match vendor
>> driver.
>
> Just curious how you can find these typos?
>
>>
>> However the last one in rtw8703b_set_channel_bb() clears too many bits
>> in REG_OFDM0_TX_PSD_NOISE, causing TX and RX issues (neither rate goes
>> above MCS0-MCS1). Vendor driver clears only 2 most significant bits.
>>
>> With the last typo fixed, the driver is able to reach MCS7 on Pinebook
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 9bb762b3a957 ("wifi: rtw88: Add definitions for 8703b chip")
>> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>
> Is this urgent? If not, I will take this via rtw-next tree.
It's a huge performance improvement, 10x more RX throughput in Iperf
tests, not just in the reported bit rate (residential, moderately noisy
environment). TX improved too, but not as massively.

Tested-by: Fiona Klute <fiona.klute@gmx.de>

Thank you very much Vasily for digging into this!

Best regards,
Fiona


