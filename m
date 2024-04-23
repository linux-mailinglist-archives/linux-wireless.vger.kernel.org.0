Return-Path: <linux-wireless+bounces-6700-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E758ADBFB
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 04:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2BC1C2103F
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 02:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E8218659;
	Tue, 23 Apr 2024 02:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pevogam.com header.i=@pevogam.com header.b="Th2A2TO7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from argon.superhosting.bg (argon.superhosting.bg [91.196.125.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB32182AE
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 02:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.196.125.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713839479; cv=none; b=mw2rMQtyBM9Ls0usKxYFI9XwThWE7s3qVszN6QkU4f2vIxzrwMTmBiKkITTe3wtBdZDVLhm70p2BKhCzn6c99OTSTRssHx1ZiWlIep7TBbUF+rVLoo0ojr6jf5oXo+fPL/gwP99qJCgyhuAGam6i3TD0EuL+q6sf94EzVEgvgwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713839479; c=relaxed/simple;
	bh=wF35FyPGM8hC3RKKa7Vj9Gr1SVOx1GgX3vMLz3WXui0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=mfmTjnQArGmbxSELtlVViFrdQZyiGfkPYb6JG6IWBdmz0H/udePqEnsJECS6doBOulSPfpSRhI2OvB+DoSVJUrZ8d7myKuM66/7JZO0nozn2P2mvNwxycijFPDqAg3okZPwieKimXJJo3P++sD0wec9N6Z+waHgW4YCZ+zxWNb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pevogam.com; spf=pass smtp.mailfrom=pevogam.com; dkim=pass (2048-bit key) header.d=pevogam.com header.i=@pevogam.com header.b=Th2A2TO7; arc=none smtp.client-ip=91.196.125.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pevogam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pevogam.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pevogam.com
	; s=default; h=Content-Type:In-Reply-To:References:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wF35FyPGM8hC3RKKa7Vj9Gr1SVOx1GgX3vMLz3WXui0=; b=Th2A2TO7REhIm9sEy6tZxgrWZR
	rKG5AOP9ruYPlzsypA+GEntTvgrMEl6WcGmOn3YaJoz96tTIVlxC6UTsOTEAlST0lstYzQj+V7u+q
	5CBCSAR9ggOZR1r2+iDR6DxxNVNWckXlUHUcZTWLrUN4VrlMTIv2EjR3YaVlbJ9l2qsKikOgWo0Lr
	6s5YXD3FRnOI37ofGoZUNXadtkMu6JSlmFhreuzDZr92pgpRcq4R0PvSbR8M5kJZfJrJnNTDLewgt
	ttFL432KhVwqlIGuju+nwjm73vyKdCZ/uOI8VeeMqaJdoFFfGNR7M5jtdQT4ioyBbyeq90PBLk3YF
	gAufpz/g==;
Received: from [213.91.128.111] (port=55358 helo=mark.whitetree)
	by argon.superhosting.bg with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <plamen.dimitrov@pevogam.com>)
	id 1rz5vy-0004NY-2n;
	Tue, 23 Apr 2024 05:31:05 +0300
Received: from localhost (mark.whitetree [127.0.0.1])
	by localhost (Postfix) with ESMTP id E0BE71F47B;
	Tue, 23 Apr 2024 05:31:01 +0300 (EEST)
X-Virus-Scanned: by Intra2net Mail Security (AVE=8.3.68.46,VDF=8.20.23.162)
X-Spam-Level: 0
Received: from [192.168.40.1] (unknown [192.168.40.1])
	by mark.whitetree (Postfix) with ESMTP id D230D1F477;
	Tue, 23 Apr 2024 05:30:58 +0300 (EEST)
Message-ID: <94f3355c-b247-4215-a046-a39293c8d03e@pevogam.com>
Date: Tue, 23 Apr 2024 10:30:55 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Plamen Dimitrov <plamen.dimitrov@pevogam.com>
Subject: Re: Problems with RTL8852BE PCIe 802.11ax Wireless Network Controller
 and Linux kernel 6.7.7-100.fc38.x86_64
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <7833fd15-5875-40b8-a20b-a68fa92f814f@pevogam.com>
 <2e67ec1dfc8b420bab05dc025c7c59cf@realtek.com>
 <f8e3d8c6-11ef-4dff-8c4e-d10e8a4006aa@pevogam.com>
 <efc3e8306e1b417cbb779109a4a5ff54@realtek.com>
Content-Language: en-US
Autocrypt: addr=plamen.dimitrov@pevogam.com; keydata=
 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
 dv5WNw==
Disposition-Notification-To: Plamen Dimitrov <plamen.dimitrov@pevogam.com>
In-Reply-To: <efc3e8306e1b417cbb779109a4a5ff54@realtek.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------GzUEHounSQugDt7Gfov8Silf"
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
--------------GzUEHounSQugDt7Gfov8Silf
Content-Type: multipart/mixed; boundary="------------RFRaGdlRxbjRv3VKgXXjPtQx";
 protected-headers="v1"
From: Plamen Dimitrov <plamen.dimitrov@pevogam.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Message-ID: <94f3355c-b247-4215-a046-a39293c8d03e@pevogam.com>
Subject: Re: Problems with RTL8852BE PCIe 802.11ax Wireless Network Controller
 and Linux kernel 6.7.7-100.fc38.x86_64
References: <7833fd15-5875-40b8-a20b-a68fa92f814f@pevogam.com>
 <2e67ec1dfc8b420bab05dc025c7c59cf@realtek.com>
 <f8e3d8c6-11ef-4dff-8c4e-d10e8a4006aa@pevogam.com>
 <efc3e8306e1b417cbb779109a4a5ff54@realtek.com>
In-Reply-To: <efc3e8306e1b417cbb779109a4a5ff54@realtek.com>

--------------RFRaGdlRxbjRv3VKgXXjPtQx
Content-Type: multipart/mixed; boundary="------------0jUGabKClZV9sHShGDRR11EE"

--------------0jUGabKClZV9sHShGDRR11EE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNC8xNi8yNCAxMDozMSwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiBQbGFtZW4gRGltaXRy
b3Y8cGxhbWVuLmRpbWl0cm92QHBldm9nYW0uY29tPiAgd3JvdGU6DQo+IA0KPj4gSW5kZWVk
LCBJIGhhZCB0cmllZCB0aGlzIGJlZm9yZSBidXQgZGlkIG5vdCBpbmNsdWRlIGl0IGluIG15
IHJlcG9ydC4gTm93IEkgZGVjaWRlZCB0byByZWRvIGV2ZXJ5dGhpbmcNCj4+IGp1c3QgaW4g
Y2FzZSBhbmQgdGhlIFdpRmkgc3RpbGwgZGlzYXBwZWFycyB3aXRoaW4gYSBmZXcgbWludXRl
cyB3aXRoIGxvZ3MgbGlrZQ0KPiBEaWQgeW91IG1lYW4gaXQgd29ya3MgaW5pdGlhbGx5IGJ1
dCBXaUZpIGdvdCBsb3N0IGFmdGVyIGEgd2hpbGU/DQoNCkV4YWN0bHkuIFNvbWV0aW1lcyBp
dCBtYXkgZXZlbiB3b3JrIGZvciBob3VycyBiZWZvcmUgSSBoaXQgdGhlIGlzc3VlLCByaWdo
dCBub3cgSSB0cmllZCB3aXRoIGtlcm5lbA0KDQo2LjcuMTEtMTAwLmZjMzgueDg2XzY0DQoN
CmFuZCB0aGUgaXNzdWUgaGFwcGVucyBhZnRlciBhIGZldyBtaW51dGVzLg0KDQo+IFBsZWFz
ZSBhdHRhY2ggeW91ciBmdWxsIGxvZyBmcm9tIGJvb3QgKHZpYSBwcml2YXRlIG1haWwgaWYg
eW91IGhhdmUgY29uY2VybikuDQo+IA0KPiBBbm90aGVyIHRyeSBpcyB0byBkaXNhYmxlIHBv
d2VyIHNhdmUgYnkgJ2l3JyBjb21tYW5kIHJpZ2h0IGFmdGVyIGJvb3RpbmcsIGxpa2UNCj4g
ICAgc3VkbyBpdyB3bGFuMCBzZXQgcG93ZXJfc2F2ZSBvZmYNCg0KSSBoYWQgdG8gdGFrZSBh
IHdoaWxlIHRvIG1ha2Ugc3VyZSB0aGF0IHRoaXMgaW5kZWVkIHdvcmtlZCBhbmQgc28gZmFy
IGl0IHRvb2sgc29tZSBkYXlzIHdpdGhvdXQgYW55IGZhaWx1cmUNCndoaWNoIG1ha2VzIG1l
IGd1ZXNzIHRoYXQgdGhpcyBoYXMgYWN0dWFsbHkgaGVscGVkLiBJIGV2ZW4gdHJpZWQgcmVi
b290aW5nIGFnYWluIGFuZCB0aGUgcHJvYmxlbSBpcyBzdGlsbA0KbGlrZWx5IGZpeGVkLiBJ
IHdpbGwgbW9uaXRvciB0aGUgc2l0dWF0aW9uIGJ1dCBmb3IgdGhlIHNha2Ugb2Ygc3VzdGFp
bmFibGUgc29sdXRpb24sIEkgZ3Vlc3MgdGhlIGFib3ZlDQpkb2VzIHNldCBhIHNldHRpbmcg
dGhhdCB3ZSBjb3VsZCBub3Qgc2V0IGluIGFueSBvdGhlciB3YXk/IEl0IHNlZW1zIHRvIHdv
cmsgYW5kIHRoYXQncyBncmVhdCwgSSBqdXN0IHdvbmRlcg0KaWYgcnVubmluZyBgc3VkbyBp
dyB3bGFuMCBzZXQgcG93ZXJfc2F2ZSBvZmZgIHVwb24gZWFjaCByZWJvb3Qgb3Iga2VybmVs
IHVwZGF0ZSBjYW4gYmUgcmVwbGFjZWQgd2l0aCBzb21ldGhpbmcNCm1vcmUgbG9uZyBsYXN0
aW5nLg0KDQpCZXN0LA0KUGxhbWVuIERpbWl0cm92DQoNCg0K
--------------0jUGabKClZV9sHShGDRR11EE
Content-Type: application/pgp-keys; name="OpenPGP_0xA4696276CE5A052D.asc"
Content-Disposition: attachment; filename="OpenPGP_0xA4696276CE5A052D.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
E7mQtLry8AiDLf8hdv5WNw=3D=3D
=3Dvn6v
-----END PGP PUBLIC KEY BLOCK-----

--------------0jUGabKClZV9sHShGDRR11EE--

--------------RFRaGdlRxbjRv3VKgXXjPtQx--

--------------GzUEHounSQugDt7Gfov8Silf
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE+tW4fXzXuCI2oFHbpGlids5aBS0FAmYnHV8FAwAAAAAACgkQpGlids5aBS0J
qBAAo+k6Aeag1PR1izV4B3ck4k7eBlqCXZsJNtHrvK/Weixi+olyN8MB/2vpi1QHV+elI3zQ+pB7
Qs0b5cAE+KBo3vdgG7hVnV6PgmeCgXJc9OmqZvW0kzxFDZglgdb5agaV/07mt28aESiAk6VvkeAq
6my2akOH4a6IcJUnTftxiDiNxD7AsLLbo1i2pqkDMgkyb398FHRC79XbzxIY9SEMLUQfPoB4ZGnm
BVMQE/EBiUkvmHwJg24EwLwvansUVKqDzSDvP6XqD/DqAFWD47seDzJuvfA9MJj+ei1IrbEiiwGK
+stskbeG0RxhYNB9enOxCPPOKN3/sRcWAx3CqAvoRBjum+3O6QC3NUgWQp+hmFf8ECPzFUnHwS96
UZ21oh8tQbphQG1TkXVeGeLHAevqzHVUaUBmrzf15RsZOfUtyfLbUmLdykla2t4PkhI6xiSfIcQ0
hIKS8RYwF9s6//yDzoJJMzp0OhBeYG3UGtqwMKDLocCcT7N0c0OMC3wlinT9/oPIFSaukGBTFfKM
+XaqZEicGd3wJp5+tk0ZBgbX+OkIAzJGnH/xxXCyXjsMCugf4AesJSV9KLT6r5/69FENwI5oe19C
O0yzAm4r7Cl2mP0ip9H9uB6p7Z3hI8klKUjUPMZHiQepj8vypsoJ+oWMspEpSH25Hi5q1jqpkgfD
NsU=
=XwZY
-----END PGP SIGNATURE-----

--------------GzUEHounSQugDt7Gfov8Silf--

