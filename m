Return-Path: <linux-wireless+bounces-6356-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 953708A6103
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 04:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216A11F20F2B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 02:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702FD11181;
	Tue, 16 Apr 2024 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pevogam.com header.i=@pevogam.com header.b="XcySFC1t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from argon.superhosting.bg (argon.superhosting.bg [91.196.125.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5717BFC1F
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 02:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.196.125.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713234199; cv=none; b=iIfpt3EkFisT0sK3gM6v0KtHa3UTntl/sgYAc453TOreLrrLZ9+vVuWikqLj/Z3P8/kcbenSEruds6Ok3KmhmVQ6RR/CzLmESUmhLIYpyUX8j/2VkoU9gff4OX6fy7DwWFH+N/UsWC0AyXvyTC3B0N34pJY56jwB5hrKbn2yZlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713234199; c=relaxed/simple;
	bh=TWdrFYrGT49jslF7HaCW8tNh7UQTw5iLoYHGd736tj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ArqvXw7jyjdK9MrSYWLMwVGp/3yJilQHektNMC+6+upiGFOp0oxXn7N3EGrcP4ZV4UkJvt8nOVY/mcB8EYhYICiCIwfeI3KwBJnAUFVCA0DtQ579cx7EDzvr/9hjBDhMqzptT2hABJvBpU5BTGgz3dxxtDz6fIpDEe0FYC1D6iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pevogam.com; spf=pass smtp.mailfrom=pevogam.com; dkim=pass (2048-bit key) header.d=pevogam.com header.i=@pevogam.com header.b=XcySFC1t; arc=none smtp.client-ip=91.196.125.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pevogam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pevogam.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pevogam.com
	; s=default; h=Content-Type:In-Reply-To:From:References:To:Subject:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TWdrFYrGT49jslF7HaCW8tNh7UQTw5iLoYHGd736tj4=; b=XcySFC1tJsJlniuk9a7grcKOnh
	5PIm1R/w9VM5G8pYQtNZ07nJiEdoYBqXukhWQK6F2tBAQIc8qFGi+lBR1aznoW70pcmHPWpbDtwpC
	gwyFTtbA9AJNI/x+kHT8wKk7uuph5bwRPrcLJmLJrlA8K07FNDW8cThJnbak6jKETOS660htbu133
	+yI/oAW/ENg5qsd8ueisB0mYdA+8RKTXSZzDNGeC8jwNQe4U6ep7NGp/EN4vBrHLNildVmm5BxUfj
	PynP6tdGY7bnBupYwwnbQrFc8HgeVoXTFnF4MwkujriKGe6tgVJ82KdSIFtd+6Jto57z6HojhxN7f
	Dhsjmb8g==;
Received: from [213.91.128.111] (port=34036 helo=mark.whitetree)
	by argon.superhosting.bg with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <plamen.dimitrov@pevogam.com>)
	id 1rwYTU-00056n-38;
	Tue, 16 Apr 2024 05:23:11 +0300
Received: from localhost (mark.whitetree [127.0.0.1])
	by localhost (Postfix) with ESMTP id ECE281F47B;
	Tue, 16 Apr 2024 05:23:07 +0300 (EEST)
X-Virus-Scanned: by Intra2net Mail Security (AVE=8.3.68.40,VDF=8.20.23.12)
X-Spam-Level: 0
Received: from [192.168.40.1] (unknown [192.168.40.1])
	by mark.whitetree (Postfix) with ESMTP id 476A81F477;
	Tue, 16 Apr 2024 05:23:03 +0300 (EEST)
Message-ID: <f8e3d8c6-11ef-4dff-8c4e-d10e8a4006aa@pevogam.com>
Date: Tue, 16 Apr 2024 10:23:01 +0800
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
Content-Language: en-US
From: Plamen Dimitrov <plamen.dimitrov@pevogam.com>
Autocrypt: addr=plamen.dimitrov@pevogam.com; keydata=
 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
 dv5WNw==
Disposition-Notification-To: Plamen Dimitrov <plamen.dimitrov@pevogam.com>
In-Reply-To: <2e67ec1dfc8b420bab05dc025c7c59cf@realtek.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------CFDBpHGb0cpB3Bv2k6D6AFV9"
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
--------------CFDBpHGb0cpB3Bv2k6D6AFV9
Content-Type: multipart/mixed; boundary="------------at6xmPjdZm2U0mFH54WiN3dL";
 protected-headers="v1"
From: Plamen Dimitrov <plamen.dimitrov@pevogam.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Message-ID: <f8e3d8c6-11ef-4dff-8c4e-d10e8a4006aa@pevogam.com>
Subject: Re: Problems with RTL8852BE PCIe 802.11ax Wireless Network Controller
 and Linux kernel 6.7.7-100.fc38.x86_64
References: <7833fd15-5875-40b8-a20b-a68fa92f814f@pevogam.com>
 <2e67ec1dfc8b420bab05dc025c7c59cf@realtek.com>
In-Reply-To: <2e67ec1dfc8b420bab05dc025c7c59cf@realtek.com>

--------------at6xmPjdZm2U0mFH54WiN3dL
Content-Type: multipart/mixed; boundary="------------itjGOe2V9lM7qBrfmJ5wxg20"

--------------itjGOe2V9lM7qBrfmJ5wxg20
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgYWdhaW4sDQoNCk9uIDQvMTYvMjQgMDg6MzEsIFBpbmctS2UgU2hpaCB3cm90ZToNCj4+
DQo+PiBbIDE3OTQuNTQyMjY2XSBydHc4OV84ODUyYmUgMDAwMDowMjowMC4wOiBGVyBkb2Vz
IG5vdCBwcm9jZXNzIGgyYyByZWdpc3RlcnMNCj4+IFsgMTc5NC41NDIyNjldIHJ0dzg5Xzg4
NTJiZSAwMDAwOjAyOjAwLjA6IEhXIHNjYW4gZmFpbGVkIHdpdGggc3RhdHVzOiAtMTEwDQo+
PiBbIDE3OTQuOTM1MzI4XSBydHc4OV84ODUyYmUgMDAwMDowMjowMC4wOiB4dGFsIHNpIG5v
dCByZWFkeShXKTogb2Zmc2V0PTkwIHZhbD0xMCBtYXNrPTEwDQo+PiBbIDE3OTUuMDA2MzIz
XSBydHc4OV84ODUyYmUgMDAwMDowMjowMC4wOiB4dGFsIHNpIG5vdCByZWFkeShXKTogb2Zm
c2V0PTkwIHZhbD0xMCBtYXNrPTEwDQo+PiBbIDE3OTUuMDA2MzMwXSBydHc4OV84ODUyYmUg
MDAwMDowMjowMC4wOiBtYWMgaW5pdCBmYWlsLCByZXQ6LTExMA0KPiANCj4gVGhlc2UgbG9n
cyBzYWlkIHRoYXQgaXQgY2FuIGRvd25sb2FkIGZpcm13YXJlIHN1Y2Nlc3NmdWxseSwgYnV0
IHRpbWVkIG91dCB0bw0KPiBhc2sgZmlybXdhcmUgdG8gZG8gc2Nhbi4gSSB3b3VsZCB0cnkg
bW9kdWxlIHBhcmFtZXRlcnMgbGlrZSB5b3UgZGlkLCBidXQNCj4gcGxlYXNlIGRvICJjb2xk
IHJlYm9vdCIgdG8gdGFrZSBlZmZlY3QgdGhlIHBhcmFtZXRlcnMsIGJlY2F1c2UgaGFyZHdh
cmUNCj4gaGFzIGJlZW4gZ290dGVuIGludG8gYWJub3JtYWwgc3RhdGUuDQoNCkluZGVlZCwg
SSBoYWQgdHJpZWQgdGhpcyBiZWZvcmUgYnV0IGRpZCBub3QgaW5jbHVkZSBpdCBpbiBteSBy
ZXBvcnQuIE5vdyBJIGRlY2lkZWQgdG8gcmVkbyBldmVyeXRoaW5nDQpqdXN0IGluIGNhc2Ug
YW5kIHRoZSBXaUZpIHN0aWxsIGRpc2FwcGVhcnMgd2l0aGluIGEgZmV3IG1pbnV0ZXMgd2l0
aCBsb2dzIGxpa2UNCg0KYGBgDQpBcHIgMTYgMTA6MTQ6MjIgdmFncmFudC53aGl0ZXRyZWUg
a2VybmVsOiBydHc4OV84ODUyYmUgMDAwMDowMjowMC4wOiByZWFkIHJmIGJ1c3kgc3dzaQ0K
QXByIDE2IDEwOjE0OjIyIHZhZ3JhbnQud2hpdGV0cmVlIGtlcm5lbDogcnR3ODlfODg1MmJl
IDAwMDA6MDI6MDAuMDogd3JpdGUgcmYgYnVzeSBzd3NpDQpBcHIgMTYgMTA6MTQ6MjIgdmFn
cmFudC53aGl0ZXRyZWUga2VybmVsOiBydHc4OV84ODUyYmUgMDAwMDowMjowMC4wOiB3cml0
ZSByZiBidXN5IHN3c2kNCkFwciAxNiAxMDoxNDoyMiB2YWdyYW50LndoaXRldHJlZSBrZXJu
ZWw6IHJ0dzg5Xzg4NTJiZSAwMDAwOjAyOjAwLjA6IHdyaXRlIHJmIGJ1c3kgc3dzaQ0KQXBy
IDE2IDEwOjE0OjIyIHZhZ3JhbnQud2hpdGV0cmVlIGtlcm5lbDogcnR3ODlfODg1MmJlIDAw
MDA6MDI6MDAuMDogd3JpdGUgcmYgYnVzeSBzd3NpDQpBcHIgMTYgMTA6MTQ6MjIgdmFncmFu
dC53aGl0ZXRyZWUga2VybmVsOiBydHc4OV84ODUyYmUgMDAwMDowMjowMC4wOiByZWFkIHJm
IGJ1c3kgc3dzaQ0KQXByIDE2IDEwOjE0OjIyIHZhZ3JhbnQud2hpdGV0cmVlIGtlcm5lbDog
cnR3ODlfODg1MmJlIDAwMDA6MDI6MDAuMDogd3JpdGUgcmYgYnVzeSBzd3NpDQpBcHIgMTYg
MTA6MTQ6MjIgdmFncmFudC53aGl0ZXRyZWUga2VybmVsOiBydHc4OV84ODUyYmUgMDAwMDow
MjowMC4wOiBGVyBkb2VzIG5vdCBwcm9jZXNzIGgyYyByZWdpc3RlcnMNCkFwciAxNiAxMDox
NDoyMiB2YWdyYW50LndoaXRldHJlZSBrZXJuZWw6IHJ0dzg5Xzg4NTJiZSAwMDAwOjAyOjAw
LjA6IEhXIHNjYW4gZmFpbGVkIHdpdGggc3RhdHVzOiAtMTEwDQouLi4NCkFwciAxNiAxMDox
NDoyMyB2YWdyYW50LndoaXRldHJlZSBrZXJuZWw6IHJ0dzg5Xzg4NTJiZSAwMDAwOjAyOjAw
LjA6IHh0YWwgc2kgbm90IHJlYWR5KFcpOiBvZmZzZXQ9OTAgdmFsPTEwIG1hc2s9MTANCkFw
ciAxNiAxMDoxNDoyMyB2YWdyYW50LndoaXRldHJlZSBrZXJuZWw6IHJ0dzg5Xzg4NTJiZSAw
MDAwOjAyOjAwLjA6IHh0YWwgc2kgbm90IHJlYWR5KFcpOiBvZmZzZXQ9OTAgdmFsPTEwIG1h
c2s9MTANCkFwciAxNiAxMDoxNDoyMyB2YWdyYW50LndoaXRldHJlZSBrZXJuZWw6IHJ0dzg5
Xzg4NTJiZSAwMDAwOjAyOjAwLjA6IG1hYyBpbml0IGZhaWwsIHJldDotMTEwDQpBcHIgMTYg
MTA6MTQ6MjMgdmFncmFudC53aGl0ZXRyZWUga2VybmVsOiBydHc4OV84ODUyYmUgMDAwMDow
MjowMC4wOiB4dGFsIHNpIG5vdCByZWFkeShXKTogb2Zmc2V0PTkwIHZhbD0xMCBtYXNrPTEw
DQpBcHIgMTYgMTA6MTQ6MjMgdmFncmFudC53aGl0ZXRyZWUga2VybmVsOiBydHc4OV84ODUy
YmUgMDAwMDowMjowMC4wOiB4dGFsIHNpIG5vdCByZWFkeShXKTogb2Zmc2V0PTkwIHZhbD0x
MCBtYXNrPTEwDQpBcHIgMTYgMTA6MTQ6MjMgdmFncmFudC53aGl0ZXRyZWUga2VybmVsOiBy
dHc4OV84ODUyYmUgMDAwMDowMjowMC4wOiBtYWMgaW5pdCBmYWlsLCByZXQ6LTExMA0KQXBy
IDE2IDEwOjE0OjIzIHZhZ3JhbnQud2hpdGV0cmVlIGtlcm5lbDogcnR3ODlfODg1MmJlIDAw
MDA6MDI6MDAuMDogeHRhbCBzaSBub3QgcmVhZHkoVyk6IG9mZnNldD05MCB2YWw9MTAgbWFz
az0xMA0KQXByIDE2IDEwOjE0OjIzIHZhZ3JhbnQud2hpdGV0cmVlIGtlcm5lbDogcnR3ODlf
ODg1MmJlIDAwMDA6MDI6MDAuMDogeHRhbCBzaSBub3QgcmVhZHkoVyk6IG9mZnNldD05MCB2
YWw9MTAgbWFzaz0xMA0KQXByIDE2IDEwOjE0OjIzIHZhZ3JhbnQud2hpdGV0cmVlIGtlcm5l
bDogcnR3ODlfODg1MmJlIDAwMDA6MDI6MDAuMDogbWFjIGluaXQgZmFpbCwgcmV0Oi0xMTAN
CkFwciAxNiAxMDoxNDoyMyB2YWdyYW50LndoaXRldHJlZSBrZXJuZWw6IHJ0dzg5Xzg4NTJi
ZSAwMDAwOjAyOjAwLjA6IHh0YWwgc2kgbm90IHJlYWR5KFcpOiBvZmZzZXQ9OTAgdmFsPTEw
IG1hc2s9MTANCkFwciAxNiAxMDoxNDoyMyB2YWdyYW50LndoaXRldHJlZSBrZXJuZWw6IHJ0
dzg5Xzg4NTJiZSAwMDAwOjAyOjAwLjA6IHh0YWwgc2kgbm90IHJlYWR5KFcpOiBvZmZzZXQ9
OTAgdmFsPTEwIG1hc2s9MTANCkFwciAxNiAxMDoxNDoyMyB2YWdyYW50LndoaXRldHJlZSBr
ZXJuZWw6IHJ0dzg5Xzg4NTJiZSAwMDAwOjAyOjAwLjA6IG1hYyBpbml0IGZhaWwsIHJldDot
MTEwDQpBcHIgMTYgMTA6MTQ6MjQgdmFncmFudC53aGl0ZXRyZWUga2VybmVsOiBydHc4OV84
ODUyYmUgMDAwMDowMjowMC4wOiB4dGFsIHNpIG5vdCByZWFkeShXKTogb2Zmc2V0PTkwIHZh
bD0xMCBtYXNrPTEwDQpBcHIgMTYgMTA6MTQ6MjQgdmFncmFudC53aGl0ZXRyZWUga2VybmVs
OiBydHc4OV84ODUyYmUgMDAwMDowMjowMC4wOiB4dGFsIHNpIG5vdCByZWFkeShXKTogb2Zm
c2V0PTkwIHZhbD0xMCBtYXNrPTEwDQpBcHIgMTYgMTA6MTQ6MjQgdmFncmFudC53aGl0ZXRy
ZWUga2VybmVsOiBydHc4OV84ODUyYmUgMDAwMDowMjowMC4wOiBtYWMgaW5pdCBmYWlsLCBy
ZXQ6LTExMA0KQXByIDE2IDEwOjE0OjI0IHZhZ3JhbnQud2hpdGV0cmVlIGtlcm5lbDogcnR3
ODlfODg1MmJlIDAwMDA6MDI6MDAuMDogeHRhbCBzaSBub3QgcmVhZHkoVyk6IG9mZnNldD05
MCB2YWw9MTAgbWFzaz0xMA0KQXByIDE2IDEwOjE0OjI0IHZhZ3JhbnQud2hpdGV0cmVlIGtl
cm5lbDogcnR3ODlfODg1MmJlIDAwMDA6MDI6MDAuMDogeHRhbCBzaSBub3QgcmVhZHkoVyk6
IG9mZnNldD05MCB2YWw9MTAgbWFzaz0xMA0KQXByIDE2IDEwOjE0OjI0IHZhZ3JhbnQud2hp
dGV0cmVlIGtlcm5lbDogcnR3ODlfODg1MmJlIDAwMDA6MDI6MDAuMDogbWFjIGluaXQgZmFp
bCwgcmV0Oi0xMTANCmBgYA0KVGhpcyByZWNvbmZpcm1lZCBteSBwcmV2aW91cyBjb25jbHVz
aW9uIHRoYXQgdGhlIHNldHRpbmdzIGRpZCBub3QgaGVscC4gUGVyaGFwcyB0aGVyZSBpcyBz
b21lIG90aGVyIHVzZWZ1bCBpbmZvDQpJIGNvdWxkIHByb3ZpZGUgYW5kIHNob3VsZCBpbnZl
c3RpZ2F0ZT8NCg0KUmVnYXJkcywNClBsYW1lbiBEaW1pdHJvdg0KDQo=
--------------itjGOe2V9lM7qBrfmJ5wxg20
Content-Type: application/pgp-keys; name="OpenPGP_0xA4696276CE5A052D.asc"
Content-Disposition: attachment; filename="OpenPGP_0xA4696276CE5A052D.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
E7mQtLry8AiDLf8hdv5WNw=3D=3D
=3Dvn6v
-----END PGP PUBLIC KEY BLOCK-----

--------------itjGOe2V9lM7qBrfmJ5wxg20--

--------------at6xmPjdZm2U0mFH54WiN3dL--

--------------CFDBpHGb0cpB3Bv2k6D6AFV9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE+tW4fXzXuCI2oFHbpGlids5aBS0FAmYd4QUFAwAAAAAACgkQpGlids5aBS3k
Ug//R7XeT6tHdq+AJ2J7I6ZNcOnsObj6+KqTZTxrAqeJ8W4Fvwz0L0gi5DS5WJse3RtzCI5KpZ1e
VzHhqn0/yYLhTHe61rQwD7rDh78CJACHzJun+L08+mqUOE8sFtrjbmb2gx/Ua6u6L8NwiWrSe7eX
rF/KCvYpsYH4TEpvwcl/6/wkJTMOguRS7YCgCRyLlqExu9ZJwEUX4ZnNdys3kqRDeFhayXQWT3Tj
bWAKnWx1i7fZcwWoU5XZzaDb5FxO8kh4RUD8pyJBNaBr3R4RMsGtF8zECywZkdQS+LyH6Cr4m2OH
MZdbnJYGSk5ND6mPJEY+J4vKdGj+SrGNj4Ft+g5y4g3ISPBfQaJ/9BJXJ7+Xv9cYyhx6m/KtfJmD
fzQ3LO7nptJGYtH18ENiqgcZHFGWrBKPkaGw7PDOcSctMoSNQzhAaUk4vAJB5eFo8jjjjj6Ri2RJ
UuvmCaYCJW3KbxDt7Ie/u9ROHEkr+OqH1xZ434BAtG54RmLeYH4HWqqLphfg8I8mNF3gCWmJiZqX
aPBUCty2yKfovoy3upLhb/50lXkbxEUkZLxguldqpuwA2iggHQ4OLaIpfxHCzJbl3OAyh4kIyQYU
h5uL469Ecowc+qEpJxJu6W96iEPq9trct7tRRmZ7VMH+jWsOFnt+rxgsNe2MiC+oOkQS4JJ5Pyzp
5ZM=
=vvh+
-----END PGP SIGNATURE-----

--------------CFDBpHGb0cpB3Bv2k6D6AFV9--

