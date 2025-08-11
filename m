Return-Path: <linux-wireless+bounces-26249-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ADDB20822
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 13:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A897C3A43F7
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 11:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D550D1C1F05;
	Mon, 11 Aug 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="GcuXdqvL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE05A1E4BE
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754912812; cv=none; b=lvbbyxLRM7cQ8yc9Rj1j8oKxNDx0EQ557Q9rZE21vP1rUe/4zLVVudOU5yD0Dv/JnAvgNAOKCh8emdJzO11pdH+Jp9kHGiOvre2j/9tpx2xnvQjIlq25pl6C0wdHQoJwdgVTwTErz44vHVWG9Wk1J1hvW7u8dlI/1lQ9paL5pgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754912812; c=relaxed/simple;
	bh=Tk52PszOLzYnTtbNI4ZuB3wjrucuZa0vsZB6dV4sfc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D4zbDM7QOHo8Id20UdMoDYijCGDRAfWkEr1ohqlXBypuOARIjiwW27OFhm2vPzQ8rCbrY/92TEGPQ+MiqcOIABjGZt9sLxeAeSbCf/niz5tIUEIP2jsnINsZ1/YZo99HhMNPwMD8vwZDRsgXDD2bweVQJqWqqi48DZk9G+Ip2XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=GcuXdqvL; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754912807; x=1755517607; i=deller@gmx.de;
	bh=Tk52PszOLzYnTtbNI4ZuB3wjrucuZa0vsZB6dV4sfc8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GcuXdqvLg1nKRKC7W1/f32PVl72sFyWlqOLPo1fLgBuYoqqnmwQfWY5jDnBhunoA
	 dyCJd4uf7A8gGryVUyHfUl6uWg0C1ybBkbfULZABNieaqlpG0JtWFM4ZmgyBEnX5m
	 xLxfNk7wYfIiRE0n9WiHkLaIlvDsuvS7oYTCISCaxZzYwxbMzELVUO0sEdp3ABCm8
	 gcs68gB+Ie6IlcTMAoTM6urmm0771CZ2qkdVUSbBp67V55iuNVueix1L0pF9MT0hs
	 a6LioSLKCODHnDZByUxKcZC9iKKUrj1NQFej1BQ+tOGHohvDga6sUQojQXBJb6mb/
	 L3Xu3+6/mYLRd95vPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5QJJ-1umGSw1MJR-00By5P; Mon, 11
 Aug 2025 13:46:47 +0200
Message-ID: <34e345ed-a114-494a-b3f7-72dfab6b628a@gmx.de>
Date: Mon, 11 Aug 2025 13:46:45 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RTL8188S WLAN Adapter failure
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>, Jes.Sorensen@gmail.com,
 Ping-Ke Shih <pkshih@realtek.com>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <ee0acfef-a753-4f90-87df-15f8eaa9c3a8@gmx.de>
 <015e5657-d21e-4214-9854-975c32b1990f@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <015e5657-d21e-4214-9854-975c32b1990f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KeuwAm36TdLYbwwYubhJgCgva13YpdIsm6bOfjQl5nM++NdvxsJ
 aLHCYf/0S82eZN+415NVoqm/NiWkKoT/lLV0fm/u2x63lJqCQ8VXMRWVEw4so0DVCS0Qhpf
 fUF3Z04aevQyLqmWMaGfZean//4Ome8Hf6hejY7aDmojkYQrjkg0X/cCz5qumTVuXQbYgQu
 kUHGogWqenC45FCU5DvbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gfQvenOGgeU=;2oJuAAaO1XSAiyhIrH+3lRn4bJQ
 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
 tJh8YmWwouIEV83Hh6Zg==

On 8/11/25 00:12, Bitterblue Smith wrote:
> On 10/08/2025 23:36, Helge Deller wrote:
>> The USB dongle which came with my DreamBox DM7020HD years ago seems to =
fail now.
>> Any idea or suggestion what I should try?
>>
>> [427792.562049] usb 3-7: new high-speed USB device number 56 using xhci=
_hcd
>> [427792.689358] usb 3-7: New USB device found, idVendor=3D07b8, idProdu=
ct=3D8188, bcdDevice=3D 2.00
>> [427792.689376] usb 3-7: New USB device strings: Mfr=3D1, Product=3D2, =
SerialNumber=3D3
>> [427792.689381] usb 3-7: Product: RTL8188S WLAN Adapter
>> [427792.689385] usb 3-7: Manufacturer: Manufacturer Realtek
>> [427792.689388] usb 3-7: SerialNumber: 00e04c000001
>> [427792.695145] usb 3-7: This Realtek USB WiFi dongle (0x07b8:0x8188) i=
s untested!
>> [427792.695151] usb 3-7: Please report results to Jes.Sorensen@gmail.co=
m
>> [427792.934142] usb 3-7: Dumping efuse for RTL8188CU (0x200 bytes):
>> [427792.934151] 00000000: 29 81 00 00 a9 16 00 00 b8 07 88 81 90 85 62 =
9c=C2=A0 ).............b.
>> [427792.934155] 00000010: 06 00 ec f0 0e 16 44 3f 17 03 4d 61 6e 75 66 =
61=C2=A0 ......D?..Manufa
>> [427792.934157] 00000020: 63 74 75 72 65 72 20 52 65 61 6c 74 65 6b 20 =
18=C2=A0 cturer Realtek .
>> [427792.934159] 00000030: 03 52 54 4c 38 31 38 38 53 20 57 4c 41 4e 20 =
41=C2=A0 .RTL8188S WLAN A
>> [427792.934160] 00000040: 64 61 70 74 65 72 20 00 00 00 00 00 00 00 00 =
00=C2=A0 dapter .........
>> [427792.934162] 00000050: 06 02 00 00 00 24 24 24 00 00 00 26 26 26 00 =
00=C2=A0 .....$$$...&&&..
>> [427792.934163] 00000060: 00 00 00 00 00 00 00 00 12 00 00 09 0d 00 00 =
00=C2=A0 ................
>> [427792.934164] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00=C2=A0 ................
>> [427792.934166] 00000080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934167] 00000090: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934168] 000000a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934170] 000000b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934171] 000000c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934172] 000000d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934174] 000000e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934175] 000000f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934176] 00000100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934178] 00000110: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934179] 00000120: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934180] 00000130: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934182] 00000140: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934183] 00000150: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934184] 00000160: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934186] 00000170: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934187] 00000180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934188] 00000190: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934190] 000001a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934191] 000001b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934192] 000001c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934193] 000001d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934195] 000001e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934196] 000001f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff=C2=A0 ................
>> [427792.934198] usb 3-7: RTL8188CU rev A (TSMC) romver 0, 1T1R, TX queu=
es 3, WiFi=3D1, BT=3D0, GPS=3D0, HI PA=3D0
>> [427792.934203] usb 3-7: RTL8188CU MAC: 44:3f:17:03:4d:61
>> [427792.934206] usb 3-7: rtl8xxxu: Loading firmware rtlwifi/rtl8192cufw=
_TMSC.bin
>> [427792.938371] usb 3-7: Firmware revision 88.2 (signature 0x88c1)
>> [427792.939417] rtl8192cu_power_on: Enabling LDOV12D (24)
>> [427793.115145] rtl8192cu_power_on: FSMCO_MAC_ENABLE poll failed
>> [427793.115156] usb 3-7: rtl8xxxu_init_device: Failed power on
>> [427793.116003] rtl8xxxu 3-7:1.0: probe with driver rtl8xxxu failed wit=
h error -16
>>
>=20
> Your dongle has the RTL8188SU chip inside. rtl8xxxu and rtl8192cu
> are not the right drivers.
>=20
> The right driver is r8712u, but it was removed in kernel 6.13.

Ah, ok.

> You can use kernel 6.12. Or you can compile r8712u for your current
> kernel. Maybe r8712u could even be accepted back in the kernel if
> you convert it to use mac80211/cfg80211.
> https://lore.kernel.org/linux-staging/20241020144933.10956-1-philipp.g.h=
ortmann@gmail.com/

According to that commit message, a replacement with MAC80211 support
is available at https://github.com/chunkeey/rtl8192su
But development on it seems to have stopped some years ago.
Is there any specific reason for this?
I have no clue on wireless development, so if I'm willing to test this
driver and provide feedback, would someone be interested and may help to b=
ring
it upstream? Or doesn't it make sense to invest the time in that?

Helge

