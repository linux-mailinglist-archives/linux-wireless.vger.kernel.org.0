Return-Path: <linux-wireless+bounces-6306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5697C8A4A81
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 10:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0555B239E1
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 08:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C644139FE4;
	Mon, 15 Apr 2024 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pevogam.com header.i=@pevogam.com header.b="HvqnESG3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from argon.superhosting.bg (argon.superhosting.bg [91.196.125.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E4037142
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.196.125.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170289; cv=none; b=bzlHmYDAfVZ9x3LnU9nXpIN3d4cA4oCkTODzeMKAfaR6nUPpbhPGry8IPNIFMZFtcRR0P342EtDNGrF45wnVvpl3IQH223xQg0Qniyddtu6+5nQQvapnwaFS6ki17P7M5LyNUdl5lGoLcEEf77qslf5Y14RuS6inNNTyxzI6h08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170289; c=relaxed/simple;
	bh=WUH47SlFB/n4rxZj+WSQxlQC5WfxDUoF4wNK9F25S9M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=us5z31Au+ivWqFw8wHdrQnBT/yHY7HPW5zhZL1nWZxqGenUpPbgRhw/R0D7uzTRwcy0ZwxFEmwY0mzZQITFHE7OBT88b4wenvMH3qWHBM/KsHdZG1Z5RL7MLSPnbgt6Ko8C2Ut2bCA8WyimhQ2zoZzTcoHNr8Y7u/BRwhZe+xbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pevogam.com; spf=pass smtp.mailfrom=pevogam.com; dkim=pass (2048-bit key) header.d=pevogam.com header.i=@pevogam.com header.b=HvqnESG3; arc=none smtp.client-ip=91.196.125.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pevogam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pevogam.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pevogam.com
	; s=default; h=Content-Type:To:Subject:From:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WUH47SlFB/n4rxZj+WSQxlQC5WfxDUoF4wNK9F25S9M=; b=HvqnESG3XU2xVbYzkXNAFSmvnL
	pVX1p3rIYOkSn9YGYprE67laUaJxHWfp4HMhVawQHeruyRrCDQUVZ0Y2B4hLFmnPxaY2AUi3zhluW
	1ExvJVTZaieqYQB6np5pEGUz66KfPHSNBYzxYHvelu3lHR6awQdzizlvwgwy7RMDUDnO6GGLC6BNr
	fx6zGzFjpCno7unzH7XVisq6Ag9ziqwdNj/02rTP9Y9KYNFjKBIX6Z61git4hxgJIWjsKO0DhV6T8
	5GfL/UoLkZElYWazJ+9KUnlJ8BUyApRjSiR0gkGvbV29asXYfmpDG0+SU0qxHV8xlQTTZAs2gPSPQ
	q7IcD3AA==;
Received: from [213.91.128.111] (port=51354 helo=mark.whitetree)
	by argon.superhosting.bg with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <plamen.dimitrov@pevogam.com>)
	id 1rwHK7-000BWz-1J
	for linux-wireless@vger.kernel.org;
	Mon, 15 Apr 2024 11:04:22 +0300
Received: from localhost (mark.whitetree [127.0.0.1])
	by localhost (Postfix) with ESMTP id ED90F1F47B
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 11:04:18 +0300 (EEST)
X-Virus-Scanned: by Intra2net Mail Security (AVE=8.3.68.40,VDF=8.20.22.254)
X-Spam-Level: 0
Received: from [192.168.40.1] (unknown [192.168.40.1])
	by mark.whitetree (Postfix) with ESMTP id EC2C71F477
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 11:04:14 +0300 (EEST)
Message-ID: <7833fd15-5875-40b8-a20b-a68fa92f814f@pevogam.com>
Date: Mon, 15 Apr 2024 16:04:12 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Plamen Dimitrov <plamen.dimitrov@pevogam.com>
Subject: Problems with RTL8852BE PCIe 802.11ax Wireless Network Controller and
 Linux kernel 6.7.7-100.fc38.x86_64
To: linux-wireless@vger.kernel.org
Content-Language: en-US
Autocrypt: addr=plamen.dimitrov@pevogam.com; keydata=
 xsFNBGF0dh0BEADZIjYupssi5QD+tqV4T4hfp8aEM/ZCftDLDvZ00dkL66TwaP7P/1amyvY+
 Zn32Sf3BIvPCnfahjckzgtFi8YZGQ6S3NuzlXpEL9fSbDbjqGJEfLK49Oqxp5H6qz7JBJBLW
 +NxaecK2FAU2n9mj1jqnIClJBPK24EUI4k1WOXUxffDwcv4uNldwawsQhDQXxY88dgupDLr4
 0RbcGpPme2pnWlXUNw9jTMxRFy80jO+9SvhEz6JiIUGOgF+K6yCILRBNAxi7ptoIQtJU3skK
 i7Wk+kYuRJm3YHZcGmRJCrIEf7PED5Y4QdsWg9plDtrjavSqYDybMP0Wn5aA+dz1A3v/poeY
 6WRntiX2EiX2+pxxpjavZMFjrrzNOhNwvOue8zecWJUz1qY8ZLSybocu9+i2VHAuAt55R38O
 FtjXXz1t1bZpIQ/EeV74SXH9SiH4bmK/PEx3+Wz5Fr1aXhWhvFTBhwppo5+++FCPNCTXWiX1
 5HqA24vQpaUQgGvqALESOVxnNZ8r9+2YNe9BM40CVyMSZa2kC/O3br6lXMptzs8CaPVowNjQ
 Qx2BpK6VbgFFPBhUc4r44Vq6icEmneBouOB7jAJ/kOsc4+AHLY1gV8ZcyjGJIlxvLFmiSeQT
 seFs7lJybx6H1z69Axd8rbosAkbCHxH45lKonWU8as7ue3aIewARAQABzS1QbGFtZW4gRGlt
 aXRyb3YgPHBsYW1lbi5kaW1pdHJvdkBwZXZvZ2FtLmNvbT7CwY8EEwEIADkWIQT61bh9fNe4
 IjagUdukaWJ2zloFLQUCYXR2HgUJBaOagAIbAwULCQgHAgYVCAkKCwIFFgIDAQAACgkQpGli
 ds5aBS2iGg/+LEQfuq6uA0ClmfS783ErsYqPx7HlEUrCMgnAF8XLIzEP5T8YzPQkYug7X7Pb
 cI/3ZBU7uBpGxBVBx3NhMZzbHqQHVp+IzZiWp6Q53vMoXNEvM8/11znT/hEwR8vvDlTKcAKf
 Dz4Tj/zA6eS/zp4ucBKDwnA+22E14LOBpl8ZK9BpmMdAHjP4i1Bu3fAK6tmvgGjkwNX7a7tX
 T8a1QhgstULn216FBi2h6+Oxb3sS9tvtV/08UVMY0UGdMHnnHwRqcdIClQCU2zC3DfomZzvB
 Nubbrq23dMY3pD3nCn0XF9suj1vLzZr530I4B/qRLyxeO06qVhZUGKKZW5vxuZi+OjBW0Tlm
 XOfaClkKFTO3r2uyUW842G8N2qpCvizOFG9ttWDdZdJq/SdHsuTR0MrFr9C/EZj2Loifocx+
 JmBvctrgCkLVEd3qaAzaXaG/+XugCfVk1IdZfkwF+FFH8Kmm/rVt2dq9F9BwtT67FnByvbSm
 y+z0zcPLQZ2tP8YVdrFJJ0P/rLFjjcepkZ4Udng1m6IblVvqosn3prjWl1uVHNOTrtFj1FgX
 PYa3EUCDVXYVxUMH4iWY3inFTzRpzCDAD8UtBl8badILLOqHbJVYwkRV9fr0pHe8auYV1Bdx
 GzLg21MNFIZimM0JpnifcHxcrpNlg/R3DqHMUjdkHOYqKwXOwU0EYXR2HwEQALYvwx2b07HZ
 Q/a+aCdr1KnmSXr94RZuiKXjN6okO7UHr8ujSdViv3wFOzVw6xdSzQgPrJpHvUvUxViVujKj
 Rmb/9JlQ+nN63jupoXSBs7lzrn8+IJIgbx18qE81n4V3pRm5wiWrgHKa98LJTdqc1o/nCOAm
 kQgZJ9b7WFM6SQv0UtiIYOW7Ef/rGzyv2mfCa1LmqdnmKpR7BudOfM1QSfUsMx/NUExe0Glt
 x0NNvcosa39fLmKPxFZFiF2XYkcSGruaGeCSzIfIZN2rKaAMwp8V3c8nUMYO/snodvsDveeG
 gQLi7+SJqMD37j1R7ziDRMBPWsOGmyatt+/obg/3YAuUeNbqdxaRJw4XKhHyJZdwZLmWSrBr
 Ut796IOAcqzHJVuZgJbVHYfof8QIuG+bTimPwn/R6SLNLnDumPr+ea1uCRJTc3HiMisvSxAE
 vR2AsSebCbyEAh7yOfqJLzKp7ytNrgJ4YLAKmY8W5dsSGtFOofSLwteQZ5EBXb6nTYb+4tVt
 sFwXZyLCpbA72Bf5S4lb4h3oJxK/GEoCVodlr05bij8hFwUIafWG9+E44IwKkQrVSxiSDt3J
 OnzgIAkf8EqW42+adgefWa7SnXINGueRIZa+ASkO2bge3kosH7dVO4abOBSYwg60i7hwNQn5
 AV8hN/vCmmDojjPvyJDvAZbhABEBAAHCwXwEGAEIACYWIQT61bh9fNe4IjagUdukaWJ2zloF
 LQUCYXR2HwUJBaOagAIbDAAKCRCkaWJ2zloFLbonD/9itNSnIvipfg64JaD//Sxumdnt9/YU
 mwuCNcJOGD++3Mx9DWj+tQ9AGLAm96nHGJE/PTQXpAnwTeBWZSy/6czgJr917PXmhdbpCKlx
 Y5CPPwPA66Zv6x+x0cJLN3BJX2SOkfsZkn0X9LDzzXQYWzyOn498vQnI3KUhD3LfBcmMBG9t
 jin3PcVHohPRZ2LXhZYxeGs+FW38jJr4n9ViSBGxbv3UMUc0eBEvvsjcvaFXr14iom5PzKPz
 QuQIjoEokS8QeRgEErqR+pKy+5p6tKGjWCFespEXjmJrtTtAK8oSxqBM6mX+i5P7if/KJoHI
 aBt3oqa3TIpgXSv2qvTRagFc7NiPjFVqkn9099CbqwxBpxYlMZ8H7SHmf8GtqyyJxdAg6kTH
 SiY73XmvEKUtXVrX3MueW/0vAcdHLyWtb7vUcV4MECFCJrCPnRIRMg0Rrjkzaw6r1frlmSoi
 lqp8pihIxjbIuygZTxvz55nSGIrkqWABeyZfyX66kR1NkaI0ldRFoB1rJKtngAflmC50YpRf
 x/Nu9NfXxd1hy0zTgtZR0nDPJxoqNJiH1926ibqh8fOB5p/F2JN/QT5vb1r5/1//2lT37agw
 hkRFCRlnCugPpf/IJW+doQnSpH6SgukqDLgRtlfzYR/FuaL9fKyR4VxXE7mQtLry8AiDLf8h
 dv5WNw==
Disposition-Notification-To: Plamen Dimitrov <plamen.dimitrov@pevogam.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------MDkUFQ3jCVzJ00jvmMQKcC4s"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - argon.superhosting.bg
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - pevogam.com
X-Get-Message-Sender-Via: argon.superhosting.bg: authenticated_id: plamen.dimitrov@pevogam.com
X-Authenticated-Sender: argon.superhosting.bg: plamen.dimitrov@pevogam.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------MDkUFQ3jCVzJ00jvmMQKcC4s
Content-Type: multipart/mixed; boundary="------------hEgHfzSkS788LZHVmD6sXGAc";
 protected-headers="v1"
From: Plamen Dimitrov <plamen.dimitrov@pevogam.com>
To: linux-wireless@vger.kernel.org
Message-ID: <7833fd15-5875-40b8-a20b-a68fa92f814f@pevogam.com>
Subject: Problems with RTL8852BE PCIe 802.11ax Wireless Network Controller and
 Linux kernel 6.7.7-100.fc38.x86_64

--------------hEgHfzSkS788LZHVmD6sXGAc
Content-Type: multipart/mixed; boundary="------------ys06WbRP5DQJTWvalAj0O7Cu"

--------------ys06WbRP5DQJTWvalAj0O7Cu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpJIGhhZCBzb21lIHByb2JsZW1zIHdpdGggUlRMODg1MkJFIGFuZCB0cmll
ZCBhIGNvbW1vbmx5IHN1Z2dlc3RlZCBmaXgNCg0KJCBzdWRvIGNhdCAvZXRjL21vZHByb2Jl
LmQvMjAtd2lmaS5jb25mDQpvcHRpb25zIHJ0dzg5X3BjaSBkaXNhYmxlX2FzcG1fbDFzcz15
IGRpc2FibGVfYXNwbV9sMT15IGRpc2FibGVfY2xrcmVxPXkNCm9wdGlvbnMgcnR3ODlfY29y
ZSBkaXNhYmxlX3BzX21vZGU9eQ0KDQphcw0KDQokIGxzbW9kIHwgZ3JlcCBydHcNCnJ0dzg5
Xzg4NTJiZSAgICAgICAgICAgMTIyODggIDANCnJ0dzg5Xzg4NTJiICAgICAgICAgICAzNjQ1
NDQgIDEgcnR3ODlfODg1MmJlDQpydHc4OV9wY2kgICAgICAgICAgICAgIDgxOTIwICAxIHJ0
dzg5Xzg4NTJiZQ0KcnR3ODlfY29yZSAgICAgICAgICAgIDU3NzUzNiAgMiBydHc4OV84ODUy
YixydHc4OV9wY2kNCm1hYzgwMjExICAgICAgICAgICAgIDE1Njg3NjggIDIgcnR3ODlfY29y
ZSxydHc4OV9wY2kNCmNmZzgwMjExICAgICAgICAgICAgIDEzMzUyOTYgIDMgcnR3ODlfODg1
MmIscnR3ODlfY29yZSxtYWM4MDIxMQ0KDQpidXQgdGhpcyBkb2Vzbid0IGZpeCBteSBpc3N1
ZSB3aGljaCBsb29rcyBsaWtlDQoNClsgMTc5NC41NDIyNjZdIHJ0dzg5Xzg4NTJiZSAwMDAw
OjAyOjAwLjA6IEZXIGRvZXMgbm90IHByb2Nlc3MgaDJjIHJlZ2lzdGVycw0KWyAxNzk0LjU0
MjI2OV0gcnR3ODlfODg1MmJlIDAwMDA6MDI6MDAuMDogSFcgc2NhbiBmYWlsZWQgd2l0aCBz
dGF0dXM6IC0xMTANClsgMTc5NC45MzUzMjhdIHJ0dzg5Xzg4NTJiZSAwMDAwOjAyOjAwLjA6
IHh0YWwgc2kgbm90IHJlYWR5KFcpOiBvZmZzZXQ9OTAgdmFsPTEwIG1hc2s9MTANClsgMTc5
NS4wMDYzMjNdIHJ0dzg5Xzg4NTJiZSAwMDAwOjAyOjAwLjA6IHh0YWwgc2kgbm90IHJlYWR5
KFcpOiBvZmZzZXQ9OTAgdmFsPTEwIG1hc2s9MTANClsgMTc5NS4wMDYzMzBdIHJ0dzg5Xzg4
NTJiZSAwMDAwOjAyOjAwLjA6IG1hYyBpbml0IGZhaWwsIHJldDotMTEwDQoNCkkgdmVyaWZp
ZWQgdGhhdCB0aGUgY2hhbmdlcyB0YWtlIGVmZmVjdCB2aWENCg0KJCBzdWRvIG1vZHByb2Jl
IC1yIHJ0dzg5Xzg4NTJiZQ0KJCBzdWRvIG1vZHByb2JlIC1yIHJ0dzg5X2NvcmUNCiQgc3Vk
byBtb2Rwcm9iZSAtdiBydHc4OV84ODUyYmUNCg0Kd2hpY2ggcHJvZHVjZXMNCg0KaW5zbW9k
IC9saWIvbW9kdWxlcy82LjcuNC0xMDAuZmMzOC54ODZfNjQva2VybmVsL25ldC9tYWM4MDIx
MS9tYWM4MDIxMS5rby54eg0KaW5zbW9kIC9saWIvbW9kdWxlcy82LjcuNC0xMDAuZmMzOC54
ODZfNjQva2VybmVsL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcnR3ODlf
Y29yZS5rby54eiBkaXNhYmxlX3BzX21vZGU9eQ0KaW5zbW9kIC9saWIvbW9kdWxlcy82Ljcu
NC0xMDAuZmMzOC54ODZfNjQva2VybmVsL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODkvcnR3ODlfcGNpLmtvLnh6IGRpc2FibGVfYXNwbV9sMXNzPXkgZGlzYWJsZV9hc3Bt
X2wxPXkgZGlzYWJsZV9jbGtyZXE9eQ0KaW5zbW9kIC9saWIvbW9kdWxlcy82LjcuNC0xMDAu
ZmMzOC54ODZfNjQva2VybmVsL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkv
cnR3ODlfODg1MmIua28ueHoNCmluc21vZCAvbGliL21vZHVsZXMvNi43LjQtMTAwLmZjMzgu
eDg2XzY0L2tlcm5lbC9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3J0dzg5
Xzg4NTJiZS5rby54eg0KDQpIb3dldmVyLCB0aGUgYHh0YWwgaXMgbm90IHJlYWR5YCBzdGls
bCBhcHBlYXJzIGFmdGVyIHJlbG9hZGluZyBhbmQgdGhlIGRldmljZSBpcyBsaWtlbHkgaW4g
YSBiYWQgc3RhdGUgb25jZSB0aGUgZXJyb3IgaXMgYWxyZWFkeSBlbmNvdW50ZXJlZDoNCg0K
WzEyODc2LjQ3ODEzOV0gcnR3ODlfODg1MmJlIDAwMDA6MDI6MDAuMDogbG9hZGVkIGZpcm13
YXJlIHJ0dzg5L3J0dzg4NTJiX2Z3LTEuYmluDQpbMTI4NzYuNDc4MjQ5XSBydHc4OV84ODUy
YmUgMDAwMDowMjowMC4wOiBVbmFibGUgdG8gY2hhbmdlIHBvd2VyIHN0YXRlIGZyb20gRDNj
b2xkIHRvIEQwLCBkZXZpY2UgaW5hY2Nlc3NpYmxlDQpbMTI4NzYuNTI5MzI3XSBydHc4OV84
ODUyYmUgMDAwMDowMjowMC4wOiB4dGFsIHNpIG5vdCByZWFkeShSKTogb2Zmc2V0PTQxDQpb
MTI4NzYuNTI5MzM2XSBydHc4OV84ODUyYmUgMDAwMDowMjowMC4wOiBubyBzdWl0YWJsZSBm
aXJtd2FyZSBmb3VuZA0KWzEyODc2LjUyOTMzOV0gcnR3ODlfODg1MmJlIDAwMDA6MDI6MDAu
MDogZmFpbGVkIHRvIHJlY29nbml6ZSBmaXJtd2FyZQ0KWzEyODc2LjUyOTM0Ml0gcnR3ODlf
ODg1MmJlIDAwMDA6MDI6MDAuMDogZmFpbGVkIHRvIHNldHVwIGNoaXAgaW5mb3JtYXRpb24N
ClsxMjg3Ni41MzAwNzRdIHJ0dzg5Xzg4NTJiZTogcHJvYmUgb2YgMDAwMDowMjowMC4wIGZh
aWxlZCB3aXRoIGVycm9yIC0yDQoNCkRvZXMgYW55b25lIGtub3cgd2hhdCBpcyBnb2luZyBv
biBoZXJlPw0KDQpSZWdhcmRzLA0KUGxhbWVuIERpbWl0cm92DQo=
--------------ys06WbRP5DQJTWvalAj0O7Cu
Content-Type: application/pgp-keys; name="OpenPGP_0xA4696276CE5A052D.asc"
Content-Disposition: attachment; filename="OpenPGP_0xA4696276CE5A052D.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
E7mQtLry8AiDLf8hdv5WNw=3D=3D
=3Dvn6v
-----END PGP PUBLIC KEY BLOCK-----

--------------ys06WbRP5DQJTWvalAj0O7Cu--

--------------hEgHfzSkS788LZHVmD6sXGAc--

--------------MDkUFQ3jCVzJ00jvmMQKcC4s
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE+tW4fXzXuCI2oFHbpGlids5aBS0FAmYc330FAwAAAAAACgkQpGlids5aBS2+
ZRAApRcjKiuM+f3Lmuvb+spSMYU9fBysIlxbqjVPK48AmC+YED1cDlx2xJ2XDDTrz4D2757oY3wF
yJXbc/fwXc5/egrkPD9QErmR867NW+zi5Wx78EtjjcjdE/EGPRaTCTvH00oszCkS/jWoVBZEMr5k
rBLvGMJyw2mmnwT35ZdBpgvyFHvT+MzEkW91ln6Dd4xNj6W/c22kpYiNYDDfU6p20UNf165HIgh5
WhzcYHJhBU8j1GCRGMj8TVPS4NJi53tYa3laXQ7imJ7Zn0qcnsMLPME9+g812ZKyWNcMsvrQO/dQ
AR4WeSTaVgqKHgmEyyedwvAcy89FbxKlAL45E4qQR5MWn5mzFU5aT21DowuduUE9tyUHMsAlE+hk
/O+7NWhkURTQe+dQ9pry1Vcj2ur5f9YsB+Xen7SO2TOcMUeNoE7S3ppFTWxYMJKEtXJeQQhZP7gB
6HOEJsl8LUjrpOBr2Q+3HR9g47+7Oi8iIxEJ3GavTmfXeCIF5acWZ/eY6rNm3R3fOpNc3FH23ikm
xCfGr44uLl74NRM1E8YSUkgjsMvE9iGk7kBjsBF1478gtjJsWGCtVYhdrQiAPe4ciLWok9K+I5iK
U8ARURIbgCdB3G8LiIFoZA5u4jkULXn08YP9NBtu9h1t2TsYv2FTQYULSY1MooPf4tVWzCHBcERn
Lz8=
=n2PF
-----END PGP SIGNATURE-----

--------------MDkUFQ3jCVzJ00jvmMQKcC4s--

