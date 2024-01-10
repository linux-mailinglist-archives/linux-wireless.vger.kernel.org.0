Return-Path: <linux-wireless+bounces-1658-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731B9829852
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 12:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739F41C21F30
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 11:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660B847F4B;
	Wed, 10 Jan 2024 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="FYRZuMFO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BADB40C12
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1E9ACB857A;
	Wed, 10 Jan 2024 11:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1704884697; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-language:in-reply-to:references:autocrypt;
	bh=SMN+ozlSo2BvEzBMVcFNYJsGAVlzi9Uml/WLnp2KZQo=;
	b=FYRZuMFOlUkOyj5BvegRDtObX+htgvMprkY/gaWxw6mYe0c7/fCmOTLyKXUklEZxujmBRM
	3MFLsRi5S4sP0xYznSXyWjdO6H0ARl782WwfkH0kbBa0xtZs+RIaxMeVVeK06XKLAtk1TG
	OIxi33MQ4E/4oW4zUMXCCPx8E78X5xaPqO0CdxOAKFgZzYYGtOu8NKJvIzGaVaKyP6uPRY
	FLxnnk1o7puTv1LiASJqJU0tbEBcTtrJcfQ6fQkCi6cyvtEwWRZV4Xa1AhC2cWD3TDLyRT
	+RQUvrlMjKAWMBPGpEhNkYSxw/kSgnS0oyKuPVf4Xb6UWc0muHW3GVr0LSQuVQ==
Content-Type: multipart/mixed; boundary="------------kKV0oiONhEjWyRQI4eZPmOsW"
Message-ID: <216e8522-fa56-4d54-ae32-74c6008a2075@lexina.in>
Date: Wed, 10 Jan 2024 14:04:56 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rtw88: rtl8822cs AP mode not working
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <36972ff5-0c48-4bd2-8f9a-9649bfa24225@lexina.in>
 <11c7333aee0d45fd9fbfc65f6e2a3aa2@realtek.com>
Content-Language: en-US, ru-RU
From: Viacheslav <adeep@lexina.in>
Autocrypt: addr=adeep@lexina.in; keydata=
 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
In-Reply-To: <11c7333aee0d45fd9fbfc65f6e2a3aa2@realtek.com>
X-Last-TLS-Session-Version: TLSv1.3

This is a multi-part message in MIME format.
--------------kKV0oiONhEjWyRQI4eZPmOsW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi!

10/01/2024 12.15, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Viacheslav <adeep@lexina.in>
>> Sent: Wednesday, January 10, 2024 3:07 PM
>> To: linux-wireless@vger.kernel.org
>> Cc: Ping-Ke Shih <pkshih@realtek.com>; Jernej Škrabec <jernej.skrabec@gmail.com>; Martin Blumenstingl
>> <martin.blumenstingl@googlemail.com>
>> Subject: rtw88: rtl8822cs AP mode not working
>>
>> Hello!
>>
>> We use RTL8822CS modules in our devices and we switched to rtw88 from an
>> external driver by Realtek. Suddenly we discovered that the AP mode
>> (hotspot) stopped working. The hotspot is set up, but it does not
>> authorize client connections.
>>
>> In attacments log and config files.
>>
>> client - notebook with iwlwifi 0000:00:14.3: Detected Killer(R) Wi-Fi 6E
>> AX1675i 160MHz Wireless Network Adapter (211NGW), REV=0x370
>>
> 
> It is probably because RTL8822CS doesn't issue beacon properly. Trying to
> capture air packets will be helpful to clarify the problem.

airdump-ng result in attachment.
I don't see any captured beacon packets.

BSSID 5C:C5:63:2A:70:7A
PWR -126
RXQ 100
Beacons 0
#Data 0
#/s 0
CH 6
MB 54
ENC WPA2
CIPHER CCMP
AUTH PSK
ESSID Hostspot


BSSID 5C:C5:63:2A:70:7A
STATION 5C:C5:63:2A:6F:45
PWR -38
Rate 0-1
Lost 0
Frames 7


> 
> Jan 10 09:45:57 adeepn wpa_supplicant[3326]: wlo1: Associated with 5c:c5:63:2a:70:7a
> Jan 10 09:45:58 adeepn wpa_supplicant[3326]: wlo1: CTRL-EVENT-BEACON-LOSS
> Jan 10 09:45:58 adeepn wpa_supplicant[3326]: wlo1: CTRL-EVENT-BEACON-LOSS
> Jan 10 09:45:58 adeepn wpa_supplicant[3326]: wlo1: CTRL-EVENT-BEACON-LOSS
> Jan 10 09:45:58 adeepn wpa_supplicant[3326]: wlo1: CTRL-EVENT-BEACON-LOSS
> Jan 10 09:45:59 adeepn wpa_supplicant[3326]: wlo1: CTRL-EVENT-BEACON-LOSS
> Jan 10 09:45:59 adeepn wpa_supplicant[3326]: wlo1: CTRL-EVENT-DISCONNECTED bssid=5c:c5:63:2a:70:7a reason=4 locally_generated=1
> 
> 
--------------kKV0oiONhEjWyRQI4eZPmOsW
Content-Type: application/x-compressed-tar; name="dump.tgz"
Content-Disposition: attachment; filename="dump.tgz"
Content-Transfer-Encoding: base64

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

--------------kKV0oiONhEjWyRQI4eZPmOsW--

