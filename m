Return-Path: <linux-wireless+bounces-6802-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 901A08B1988
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 05:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0565F1F2162A
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 03:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3AB2231C;
	Thu, 25 Apr 2024 03:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pevogam.com header.i=@pevogam.com header.b="mTKMBLMQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from argon.superhosting.bg (argon.superhosting.bg [91.196.125.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F462110F
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.196.125.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015851; cv=none; b=q/eSqzOpQfKlnKFBPIXGKgKRCUY/hQXWYxdbpmks2TuoxjSOXpfhpL1qJAp/bqVbQSSIPOBXdpjZmfZxP+gpHSZnTdm1ABSGCnM79oxRPluBDhzxUKs38DtcUvWjxu5VHwSo8JrutOdabdnVa9AjXkta5RxNJt0aVVbYG7hXgII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015851; c=relaxed/simple;
	bh=krO6HvovAqZ41S5okB0aiIkyHWYRQBizz+eRg0wiS3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YN4MbYCXP5gSxClumxizrYt75cnyYXwuMVndcprCbiaSnO6WO/PDBLqirg/W9twFEjm8mG4YWkcmliDNb+o7jGXTugOTF1av1IzT7Siw7o+Nn2+qMjClNe81116tRhA/M3lpzQtn2cCw9JC/S8Nsm9SO11+r/40KfFeVeAoYsJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pevogam.com; spf=pass smtp.mailfrom=pevogam.com; dkim=pass (2048-bit key) header.d=pevogam.com header.i=@pevogam.com header.b=mTKMBLMQ; arc=none smtp.client-ip=91.196.125.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pevogam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pevogam.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pevogam.com
	; s=default; h=Content-Type:In-Reply-To:From:References:To:Subject:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=krO6HvovAqZ41S5okB0aiIkyHWYRQBizz+eRg0wiS3o=; b=mTKMBLMQn3tHTroJHvZK2uupy4
	mj0q79dyU6kH0xzrUoQPnSLFsIuNqeyauT29f2EUw2ZVadTXBuoNoh13360sCP9cKk5ukVa8IVQmU
	5Zjwiq7iQPvAPW7vJBfhfbz4TNsOeIcn0oc/1IlaEpcfnrx5VdRI3kf/GN6TcIjFOdqj/+zhCoL1i
	iZISLli9wkkQkFexD4D8zfomWiUeUpXc3Lo0c8IRStlfCoSJkYOFvtPbP2q1xHkWyMuNzqUtJPcLh
	JEGiSr7hzRFLaBRMAqQaD1vDIO+dx1x9sGSIg4tQbLnXlFcURPxnxUf9Qi6efSfMhapPgvwP+KAvr
	NcIwVVlA==;
Received: from [213.91.128.111] (port=55830 helo=mark.whitetree)
	by argon.superhosting.bg with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <plamen.dimitrov@pevogam.com>)
	id 1rzpof-00013o-16;
	Thu, 25 Apr 2024 06:30:35 +0300
Received: from localhost (mark.whitetree [127.0.0.1])
	by localhost (Postfix) with ESMTP id 5FD9F1F47B;
	Thu, 25 Apr 2024 06:30:32 +0300 (EEST)
X-Virus-Scanned: by Intra2net Mail Security (AVE=8.3.68.46,VDF=8.20.23.206)
X-Spam-Level: 0
Received: from [192.168.40.1] (unknown [192.168.40.1])
	by mark.whitetree (Postfix) with ESMTP id D63811F477;
	Thu, 25 Apr 2024 06:30:28 +0300 (EEST)
Message-ID: <89fccaa8-af18-4192-8186-f76577694b97@pevogam.com>
Date: Thu, 25 Apr 2024 11:30:26 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problems with RTL8852BE PCIe 802.11ax Wireless Network Controller
 and Linux kernel 6.7.7-100.fc38.x86_64
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <7833fd15-5875-40b8-a20b-a68fa92f814f@pevogam.com>
 <2e67ec1dfc8b420bab05dc025c7c59cf@realtek.com>
 <f8e3d8c6-11ef-4dff-8c4e-d10e8a4006aa@pevogam.com>
 <efc3e8306e1b417cbb779109a4a5ff54@realtek.com>
 <94f3355c-b247-4215-a046-a39293c8d03e@pevogam.com>
 <8fa0fcfccfe14377ba053130f95b8917@realtek.com>
Content-Language: en-US
From: Plamen Dimitrov <plamen.dimitrov@pevogam.com>
Autocrypt: addr=plamen.dimitrov@pevogam.com; keydata=
 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
 dv5WNw==
Disposition-Notification-To: Plamen Dimitrov <plamen.dimitrov@pevogam.com>
In-Reply-To: <8fa0fcfccfe14377ba053130f95b8917@realtek.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------tAsByDgG0BRemhAfiGxI8CGS"
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
--------------tAsByDgG0BRemhAfiGxI8CGS
Content-Type: multipart/mixed; boundary="------------cdYOYtawoCtPlsjGDu8K8ET2";
 protected-headers="v1"
From: Plamen Dimitrov <plamen.dimitrov@pevogam.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Message-ID: <89fccaa8-af18-4192-8186-f76577694b97@pevogam.com>
Subject: Re: Problems with RTL8852BE PCIe 802.11ax Wireless Network Controller
 and Linux kernel 6.7.7-100.fc38.x86_64
References: <7833fd15-5875-40b8-a20b-a68fa92f814f@pevogam.com>
 <2e67ec1dfc8b420bab05dc025c7c59cf@realtek.com>
 <f8e3d8c6-11ef-4dff-8c4e-d10e8a4006aa@pevogam.com>
 <efc3e8306e1b417cbb779109a4a5ff54@realtek.com>
 <94f3355c-b247-4215-a046-a39293c8d03e@pevogam.com>
 <8fa0fcfccfe14377ba053130f95b8917@realtek.com>
In-Reply-To: <8fa0fcfccfe14377ba053130f95b8917@realtek.com>

--------------cdYOYtawoCtPlsjGDu8K8ET2
Content-Type: multipart/mixed; boundary="------------ZNzoWjMY2GTS2NkmU05CyCYX"

--------------ZNzoWjMY2GTS2NkmU05CyCYX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNC8yMy8yNCAxMDo0OSwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiBQbGFtZW4gRGltaXRy
b3Y8cGxhbWVuLmRpbWl0cm92QHBldm9nYW0uY29tPiAgd3JvdGU6DQo+Pj4gQW5vdGhlciB0
cnkgaXMgdG8gZGlzYWJsZSBwb3dlciBzYXZlIGJ5ICdpdycgY29tbWFuZCByaWdodCBhZnRl
ciBib290aW5nLCBsaWtlDQo+Pj4gICAgIHN1ZG8gaXcgd2xhbjAgc2V0IHBvd2VyX3NhdmUg
b2ZmDQo+PiBJIGhhZCB0byB0YWtlIGEgd2hpbGUgdG8gbWFrZSBzdXJlIHRoYXQgdGhpcyBp
bmRlZWQgd29ya2VkIGFuZCBzbyBmYXIgaXQgdG9vayBzb21lIGRheXMgd2l0aG91dCBhbnkg
ZmFpbHVyZQ0KPj4gd2hpY2ggbWFrZXMgbWUgZ3Vlc3MgdGhhdCB0aGlzIGhhcyBhY3R1YWxs
eSBoZWxwZWQuIEkgZXZlbiB0cmllZCByZWJvb3RpbmcgYWdhaW4gYW5kIHRoZSBwcm9ibGVt
IGlzIHN0aWxsDQo+PiBsaWtlbHkgZml4ZWQuIEkgd2lsbCBtb25pdG9yIHRoZSBzaXR1YXRp
b24gYnV0IGZvciB0aGUgc2FrZSBvZiBzdXN0YWluYWJsZSBzb2x1dGlvbiwgSSBndWVzcyB0
aGUgYWJvdmUNCj4+IGRvZXMgc2V0IGEgc2V0dGluZyB0aGF0IHdlIGNvdWxkIG5vdCBzZXQg
aW4gYW55IG90aGVyIHdheT8gSXQgc2VlbXMgdG8gd29yayBhbmQgdGhhdCdzIGdyZWF0LCBJ
IGp1c3Qgd29uZGVyDQo+PiBpZiBydW5uaW5nIGBzdWRvIGl3IHdsYW4wIHNldCBwb3dlcl9z
YXZlIG9mZmAgdXBvbiBlYWNoIHJlYm9vdCBvciBrZXJuZWwgdXBkYXRlIGNhbiBiZSByZXBs
YWNlZCB3aXRoIHNvbWV0aGluZw0KPj4gbW9yZSBsb25nIGxhc3RpbmcuDQo+Pg0KPiBJZiB5
b3UgdXNlIG5ldHdvcmsgbWFuYWdlciBhcyBXaUZpIGNvbnRyb2xsZXIsIHNldCAnd2lmaS5w
b3dlcnNhdmUgPSAyJyBpbiBjb25maWcgZmlsZSBbMV0uDQo+IA0KPiBbMV1odHRwczovL2dp
c3QuZ2l0aHViLmNvbS9qY2JlcnRob24vZWE4Y2ZlMjc4OTk4OTY4YmE3YzVhOTUzNDRiYzhi
NTUNCg0KU28gSSBhcHBsaWVkIHRoaXMgd2l0aCB0aGUgd2lmaSBjYXJkIGZhaWxpbmcgYWdh
aW4gd2l0aCB0aGUgYWJvdmUgZXJyb3JzLiBUaGVuIEkgdHJpZWQgdGhlIHNhbWUgTmV0d29y
a01hbmFnZXIgY29uZmlnDQpidXQgd2l0aCBhIGZ1bGwgcmVib290IGFuZCB0aGUgd2lmaSBj
cmFzaGVkIGFnYWluLiBJIHJlaXNzdWVkIHRoZSBwcmV2aW91cyBgaXdgIGNvbW1lbnQgdG8g
c2V0IHRoaXMgYnV0IHRoZW4gdGhlIHdpZmkNCmNyYXNoZWQgYWdhaW4gYmVmb3JlIGFuZCBh
ZnRlciBhZGRpdGlvbmFsIGNvbGQgcmVib290LiBJIGFtIHJlYWxseSBub3Qgc3VyZSB3aGF0
IGlzIGdvaW5nIG9uIGhlcmUuIFNob3VsZCBJIGxvb2sgZm9yDQptb3JlIGxvZ3Mgb25jZSB0
aGlzIGhhcHBlbnMgYWdhaW4gZGVzcGl0ZSB0aGUgcG93ZXJzYXZlIG1vZGU/DQoNCi0tDQpC
ZXN0LA0KUGxhbWVuIERpbWl0cm92DQoNCg==
--------------ZNzoWjMY2GTS2NkmU05CyCYX
Content-Type: application/pgp-keys; name="OpenPGP_0xA4696276CE5A052D.asc"
Content-Disposition: attachment; filename="OpenPGP_0xA4696276CE5A052D.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
E7mQtLry8AiDLf8hdv5WNw=3D=3D
=3Dvn6v
-----END PGP PUBLIC KEY BLOCK-----

--------------ZNzoWjMY2GTS2NkmU05CyCYX--

--------------cdYOYtawoCtPlsjGDu8K8ET2--

--------------tAsByDgG0BRemhAfiGxI8CGS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE+tW4fXzXuCI2oFHbpGlids5aBS0FAmYpzlIFAwAAAAAACgkQpGlids5aBS39
cA/9HHHzN6a9nDSniSsmNVGQTfNGyEmADPRtiQyiok5vbhrO3K2i0mlDpWqVbeXy3++U0QYBPDpO
chvGiQ28j5nOqIseBt8xQwsbueCNn2s1AcA7106epZ4xp2I6bI5eahwd4Fd2Z3hWFkcV/fb6IJUl
V9Ij0S/GcIh48CcJY/E1IO/hn2qM9Zh3FCjIuggv8+9JRaIxTMNTNNGlRDNdi8Xa11ihhesIVb8r
FRiursHm6ekmDDfXlBUPrHF88Hx0xBPSfiJ+jW5/1zOlEixqieIyAwz1/bKxRfuGsCxmLN0GycyH
/WsnZcd8mDIZ+Cvdi2SrW1mEHwp3nrNmxnE5ILAMQFNyzsu/ZEekJmMddu8Yes9ajHzfaHcKPBcC
WRjoh599oyn90pzLGzJC1Jh1bU7P6Lf9G+qflZwpwNlDvBUa2dUTgiwyferuuRohO6gwCKYsG3XW
qNQ1HMy3r4XFZEQvQRjDFvlp8BUAp5a1RcHRrNggeYDpHiHnWBf042KE/aH/fJ5E7nWmd3cIu50I
qnMX75aRqVPW69+Zf2q4vbjPSvDYUZN9VI2C7f90UFZv22JQv2FvURLjhv2Aq8rYAN8KEtsoi1VH
1V3/eWKBez8Tpplvd562qqfGAV8jp9z5eebSHiQ0pshNVEyAgI45DaZUX289fmr2BTjY7hrcPiKW
x4o=
=wa8V
-----END PGP SIGNATURE-----

--------------tAsByDgG0BRemhAfiGxI8CGS--

