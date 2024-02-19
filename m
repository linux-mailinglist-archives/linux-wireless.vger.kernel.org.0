Return-Path: <linux-wireless+bounces-3762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E00D859D2D
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 08:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D80C1F22AE0
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 07:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834A220B24;
	Mon, 19 Feb 2024 07:43:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-195.mimecast.com (us-smtp-delivery-195.mimecast.com [170.10.129.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7F020B11
	for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708328606; cv=none; b=B36tXXGRI9O3YXd0EdCYVNK/mUO+blJQ5ofWELOkLwiEQziPzbxdmU2GMOxM1IUJx9LJqSjAfbaQzQuWZztiHCn/zA+rKAPP36CZg/5S9+WvU/e3stB3+WKwAv3SdMv3HDv4UGHvwl0XWql3ylFYui1+3ow93e65wS1dF33x3mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708328606; c=relaxed/simple;
	bh=CspWxoX+5MxWTUfvwUaErl3ZF5VVTRvzZtJDKGpVefk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZXmxGpE0P0XRDvp+XTnkpSdlyCgL8IHRRf4szWzNo2GhHrh0Ha7SqrRdXQ+mV1vv7LUZs406Ll1GLaLcQPKNOooZ3HLxnjg8bhnBshGrUeB+QzT+c0Gmu1C6x1GtBy1heu5Ni+EGVx3Jw/C5dnJ/gW8k8AgcKl94jcgx85mvhT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mbari.org; spf=pass smtp.mailfrom=mbari.org; arc=none smtp.client-ip=170.10.129.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mbari.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mbari.org
Received: from sleet.shore.mbari.org (sleet.shore.mbari.org [134.89.12.10])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-dp-mKkxlNzubNEaBX-sDJw-1; Mon,
 19 Feb 2024 02:43:21 -0500
X-MC-Unique: dp-mKkxlNzubNEaBX-sDJw-1
Received: from localhost (localhost [127.0.0.1])
	by sleet.shore.mbari.org (Postfix) with ESMTP id 163CE81060205;
	Sun, 18 Feb 2024 23:43:20 -0800 (PST)
X-Virus-Scanned: amavis at sleet.shore.mbari.org
Received: from sleet.shore.mbari.org ([127.0.0.1])
 by localhost (sleet.shore.mbari.org [127.0.0.1]) (amavis, port 10026)
 with ESMTP id xx6jalnc2v3B; Sun, 18 Feb 2024 23:43:20 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by sleet.shore.mbari.org (Postfix) with ESMTP id EC75481060200;
	Sun, 18 Feb 2024 23:43:19 -0800 (PST)
Received: from [192.168.6.194] (raven.shore.mbari.org [134.89.10.221])
	by sleet.shore.mbari.org (Postfix) with ESMTPSA;
	Sun, 18 Feb 2024 23:43:19 -0800 (PST)
Subject: Re: rtw88 driver support for rtl8723ds does not work on Radxa
 RockPi-S
To: Kalle Valo <kvalo@kernel.org>, Larry Finger <Larry.Finger@lwfinger.net>
Cc: linux-wireless@vger.kernel.org, martin.blumenstingl@googlemail.com
References: <9f47e65e-35f1-b090-cad1-4d8333293b00@mbari.org>
 <9f7c6005-e9c5-4691-87c2-fee8641f02a4@lwfinger.net>
 <f8d31d74-fdfe-8706-6748-273b8c3674ca@mbari.org>
 <b9a4df4e-4b1f-436f-ae4b-90fc0c68ae81@lwfinger.net>
 <878r3hc6hy.fsf@kernel.org>
From: Brent Roman <brent@mbari.org>
Organization: MBARI
Message-ID: <42772df2-32b3-2b37-045d-b528a752bef7@mbari.org>
Date: Sun, 18 Feb 2024 23:43:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:46.0) Gecko/20100101 Firefox/46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <878r3hc6hy.fsf@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mbari.org
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable

Yes, that's all true.=A0 However...
Random MAC address assignment tends to cause devices to be assigned a=20
different IP address on each reboot.
This often doesn't play nicely with port forwarding.

It's difficult to "prove" the RK3308 cpu serial numbers are unique, but=20
they should be and the few I've tested have been.

- brent

Kalle Valo wrote:
> Larry Finger <Larry.Finger@lwfinger.net> writes:
>
>> On 2/17/24 23:13, Brent Roman wrote:
>>> Larry,
>>> Radxa confirmed that they do not program the eFUSE on these boards.
>>> We do not get a sensible MAC from the chip, so I derive a one from
>>> the CPU's unique serial number.
>>> It's a hack, but it works well and is standard's compliant.
>>> The RockPI-S a *very* inexpensive board, so I can understand Radxa
>>> wanting to minimize the time spent configuring each one.
>>> https://shop.allnetchina.cn/products/rock-pi-s
>>> The vendor driver seems to deal with this by applying typical gain
>>> parameters when the eFUSE is invalid.
>>> With that driver, this board's WiFi performs beautifully, despite
>>> the unprogrammed eFUSE.
>>> Would you accept a patch to add this logic to RTW88?
>> Of course a patch would be accepted. Ultimately, the changes should be
>> made to the wireless-next code base, and sent to this mailing list. To
>> make things easier, you can send me a patch file for the rtw88 repo,
>> and I can reformat it for wireless-next and send it to the mailing
>> list under your signed-off-by. Either one would work.
>>
>> Thanks for sorting this out. I like the idea of deriving the MAC
>> address from the CPU serial number. That is unique and reproducible.
> But make sure that the CPU serial number is really unique. If it's not
> that can cause MAC address collisions which is not good.
>
> Usually wireless drivers create a random address if a stored MAC address
> is not available.
>


--=20
  Brent Roman                                   MBARI
  Software Engineer               Tel: (831) 775-1808
  mailto:brent@mbari.org  http://www.mbari.org/~brent


