Return-Path: <linux-wireless+bounces-10487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D460193B4A7
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 18:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571911F2145A
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 16:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099F415D5DA;
	Wed, 24 Jul 2024 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=zerobeat@gmx.de header.b="CCGBzo6T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1BC15B551;
	Wed, 24 Jul 2024 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837553; cv=none; b=D+Pq6fUDrPXSHpF1MDYOeDKLDAdgfgqX/ujt+m2ZgkxA2HASsxcW5Ys9l7Tysh8eD3Cvw3YPp64YuFvAXPKJju3bLdzfvBcwofD6KNWlQwUoQRmz4kIox1favaJqevxhpwwhKpwjl7DFWcvI8KY4+IelhRUW6jB9lc38g1VIxQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837553; c=relaxed/simple;
	bh=3VGB3UuH10NEbvn8fY0dq4cMUNIy/Nn3YEJaZw3SlxM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=XLVEO3lGqWVPkjNkVyJIsrLG7B3aEVhd2dBVMIwDsMnBy4YPlm/lcnOKcqSCFHBTjKd17BsL2FndpvuhX3XsZk1ACZpyrE7+zVdH0v4S9UlXvmNayv5dF/ELrCldArbpU0AYCmYnfrpcIcZAAzmI9xtxV7g2bInhYt3L5z7WyJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=zerobeat@gmx.de header.b=CCGBzo6T; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721837535; x=1722442335; i=zerobeat@gmx.de;
	bh=3VGB3UuH10NEbvn8fY0dq4cMUNIy/Nn3YEJaZw3SlxM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 From:Subject:In-Reply-To:Content-Type:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CCGBzo6ToychR9F9xMbf6rGmg8WaeSBPKFJOLRjGQ1G69dRpMYvZMw4Deia3G88+
	 j+FUkwr0GyMyZJBTDrcAybksRXoPWt5/GjVYj5AvrWcv9blZJSdgbjaARFupMGLDX
	 DZ/wpjez4lbxtv2sAndtKy4BRAK5EKD7Jzlc93P2b/NxOPAUWWHaj27ehHT/SvdAX
	 ZicX3+unZ+POpGIBazJx+oMe4TrEqX229iOqdRHkQ63L7ZSVqXGUuWf+hAMn6/qCG
	 52ONslWVsDsZW8AEL8Vo5kzNPXfP6y5iYPBqRhS/J2emOL6iqizUlMvitguYD610z
	 xvtQmPM5x9oCe+Y40Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.100] ([79.194.93.171]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4Jqb-1sWNTz3TyT-00ECW6; Wed, 24
 Jul 2024 18:12:14 +0200
Message-ID: <d53b0470-21b9-4b8d-a3a6-a4a37f9ffa72@gmx.de>
Date: Wed, 24 Jul 2024 18:12:12 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Johannes Berg <johannes@sipsolutions.net>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>
References: <8c91352f-a404-4ba6-aa27-1253468c830d@leemhuis.info>
 <c4a67a0418e7068fc534f39f3c1dce21d082dd8f.camel@sipsolutions.net>
Content-Language: de-DE, en-US
From: ZeroBeat <ZeroBeat@gmx.de>
Subject: Re: [regression] mt76x2u: NULL pointer dereference since recent
 change to fix chanctx emulation for monitor mode
In-Reply-To: <c4a67a0418e7068fc534f39f3c1dce21d082dd8f.camel@sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------QSxQM5gqUQBRl0lO9MXdU1cK"
X-Provags-ID: V03:K1:IlhOVZwO2bn3UeD9TqMgju9XZNCoi9YDAvYkyLmSmKOw2hZqA62
 NY0qWOKGBi6Z6Hgfh5r6zsRqckdDn7SHvjtwZy5PRCKEUPpDMI/PUK8fsMnFqp0emOG4t2t
 JIUsoZp11GmzkCk22Kb2zUfh8S8WjdjRc0Gn/ExTFolX176m3E2KVpivTBQoOeX5pvRrYxQ
 hMVAD3D51hLvcJ7GnXM7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wBgVhMozxyU=;qp4NJDV18xq+a3W4t2miwaV4xfc
 BCLSQcWSCwmTSvawNf4KiKvnmrsEnsplAD6PS02qg2Bo6wIMwiXuEd6AZ66/beUo56q/lFZhj
 X1pe/wMkAbEdhFgCK2DwYHBuYamvbpwvq/qb2CyBJ/2O5Qpi9RKf2brUwT3TJi5b8UIgi/eFz
 Q+b5j+/36kS1qSBhNmpQWjnLpq3NawBhjIYxNcSdexbfZiMV5to2lltcmnTEfm/xEhxrax27/
 G60clqEf8iHXMSCC3gYPp2UcVWa3nhLR8ere1KhTGH++QnQK5T64L2LjgTMcvJ9AfeFlq2zMY
 RYxAOc2yPGYByjMGDxTuCeWWgpuDme/a5gGX72FrFkFDPl4DbpN5AIcIXYhB5BQb/z16QKCRX
 4HEMui1AybsrR2d+QqP9/8xtfoc/FphZ4Pvzibhk37NPjZ8CdtAxuA1By/P2oYKjtClInTc9h
 njcz3869sZu/g0xXlFk+JWclvr2CSuo7sYsBj3ECyEIOj5Mj5iE7NJyVJhkbzJy0HYddxS9HD
 KIgEBPv/RmApfoNcZugofkoAWcFIR+e66JfCnDxkycnWzKO7V9sc0z5xs4/kClYsoDtFc9CEn
 AhHYJCtocGxPQ96ddKAAgjphNOoX/PDASbJFnMnGRo0+R9PeyJ1ZmwJRXTgKuMmPuzSWam9Ur
 4JPm9nQRHHHeh6I4RL+YPdp9HE0SIqdgUd90hR1b+8eQaygLQD4AHj82JuL+9/rBdG5Q5rXoE
 DRfQmubNn4eYy7Dcu3/Z9U6T0MUUt8GZ/nWc9pjFjBB+ojSirQjSZ17eudYVOlwCgjg1mYVlG
 j5MMRa2BZHcqoYJLJ4FwFgSQ==

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------QSxQM5gqUQBRl0lO9MXdU1cK
Content-Type: multipart/mixed; boundary="------------4Aq7cjTXfEag0TUDW8UKwphi";
 protected-headers="v1"
From: ZeroBeat <ZeroBeat@gmx.de>
To: Johannes Berg <johannes@sipsolutions.net>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>
Message-ID: <d53b0470-21b9-4b8d-a3a6-a4a37f9ffa72@gmx.de>
Subject: Re: [regression] mt76x2u: NULL pointer dereference since recent
 change to fix chanctx emulation for monitor mode
References: <8c91352f-a404-4ba6-aa27-1253468c830d@leemhuis.info>
 <c4a67a0418e7068fc534f39f3c1dce21d082dd8f.camel@sipsolutions.net>
In-Reply-To: <c4a67a0418e7068fc534f39f3c1dce21d082dd8f.camel@sipsolutions.net>

--------------4Aq7cjTXfEag0TUDW8UKwphi
Content-Type: multipart/mixed; boundary="------------MxLpLOw0q0SDQ6t3NnfAoP15"

--------------MxLpLOw0q0SDQ6t3NnfAoP15
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SWYgeW91J3JlIGludGVyZXN0ZWQgaW4sIG10NzYwMXUgaXMgbm90IGFmZmVjdGVkOg0KDQpF
RElNQVggRVc3NzExVUFuIHYyDQoNCklEIDczOTI6NzcxMCBFZGltYXggVGVjaG5vbG9neSBD
by4sIEx0ZCBFZGltYXggV2ktRmkNCg0KJCBoY3hkdW1wdG9vbCAtbA0KICAgMAkgIDQJNzRk
YTM4ZjIwMzhlCTllMzYwNWQzYWIzNAkqCXdscDVzMGY0dTIgICAgICAJbXQ3NjAxdQlORVRM
SU5LDQoNCkkgaGF2ZW4ndCBmaWd1cmVkIG91dCB5ZXQgd2h5IGl0IGlzIG5vdCBhZmZlY3Rl
ZCBsaWtlIHRoZSBtdDc2IHNlcmllcy4NCg0KTWljaGFlbA0KDQoNCkFtIDI0LjA3LjI0IHVt
IDEwOjQ3IHNjaHJpZWIgSm9oYW5uZXMgQmVyZzoNCj4gT24gV2VkLCAyMDI0LTA3LTI0IGF0
IDA5OjU4ICswMjAwLCBMaW51eCByZWdyZXNzaW9uIHRyYWNraW5nIChUaG9yc3Rlbg0KPiBM
ZWVtaHVpcykgd3JvdGU6DQo+PiBIaSwgVGhvcnN0ZW4gaGVyZSwgdGhlIExpbnV4IGtlcm5l
bCdzIHJlZ3Jlc3Npb24gdHJhY2tlci4NCj4+DQo+PiBKb2hhbm5lcywgRmVsaXgsIExvcmVu
em8sIFJ5ZGVyLCBJIG5vdGljZWQgYSByZXBvcnQgYWJvdXQgYSByZWdyZXNzaW9uDQo+PiBp
biBidWd6aWxsYS5rZXJuZWwub3JnIHRoYXQgKGZvciBteSB1bnRyYWluZWQgZXllcykgYXBw
ZWFycyB0byBiZSBhIGJ1Zw0KPj4gaW4gc29tZSBjb2RlIHBhdGhzIG9mIG10NzZ4MnUgdGhh
dCB3YXMgZXhwb3NlZCBieSAwZDljMmJlZWQxMTZlNiAoIndpZmk6DQo+PiBtYWM4MDIxMTog
Zml4IG1vbml0b3IgY2hhbm5lbCB3aXRoIGNoYW5jdHggZW11bGF0aW9uIikgW3Y2LjEwLXJj
NSwNCj4+IHY2LjkuN10gZnJvbSBKb2hhbm5lcy4NCj4+DQo+PiBBcyBtYW55IChtb3N0Pykg
a2VybmVsIGRldmVsb3BlcnMgZG9uJ3Qga2VlcCBhbiBleWUgb24gdGhlIGJ1ZyB0cmFja2Vy
LA0KPj4gSSBkZWNpZGVkIHRvIHdyaXRlIHRoaXMgbWFpbC4gVG8gcXVvdGUgZnJvbQ0KPj4g
aHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTkwODYgOg0K
Pj4NCj4+PiAgIE1pY2hhZWwgMjAyNC0wNy0yMyAxNTozODo0MyBVVEMNCj4+Pg0KPj4+IEFm
dGVyIGEgdXNlciBvcGVuZWQgdGhpcyBkaXNjdXNzaW9uOg0KPj4+IGh0dHBzOi8vZ2l0aHVi
LmNvbS9aZXJCZWEvaGN4ZHVtcHRvb2wvZGlzY3Vzc2lvbnMvNDY1DQo+Pj4NCj4+PiBKdWwg
MjEgMDU6NDA6MzkgcnBpNGItYWFyY2gga2VybmVsOiBtdDc2eDJ1IDItMjoxLjAgd2xhbjE6
IGVudGVyZWQgcHJvbWlzY3VvdXMgbW9kZQ0KPj4+IEp1bCAyMSAwNTo0MDo0NSBycGk0Yi1h
YXJjaCBrZXJuZWw6IFVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJl
ZmVyZW5jZSBhdCB2aXJ0dWFsIGFkZHJlc3MgMDAwMDAwMDAwMDAwMDAwMA0KPj4+IEp1bCAy
MSAwNTo0MDo0NSBycGk0Yi1hYXJjaCBrZXJuZWw6IE1lbSBhYm9ydCBpbmZvOg0KPj4+IEp1
bCAyMSAwNTo0MDo0NSBycGk0Yi1hYXJjaCBrZXJuZWw6ICAgRVNSID0gMHgwMDAwMDAwMDk2
MDAwMDQ0DQo+Pj4gSnVsIDIxIDA1OjQwOjQ1IHJwaTRiLWFhcmNoIGtlcm5lbDogICBFQyA9
IDB4MjU6IERBQlQgKGN1cnJlbnQgRUwpLCBJTCA9IDMyIGJpdHMNCj4+PiBKdWwgMjEgMDU6
NDA6NDUgcnBpNGItYWFyY2gga2VybmVsOiAgIFNFVCA9IDAsIEZuViA9IDANCj4+PiBKdWwg
MjEgMDU6NDA6NDUgcnBpNGItYWFyY2gga2VybmVsOiAgIEVBID0gMCwgUzFQVFcgPSAwDQo+
Pj4gSnVsIDIxIDA1OjQwOjQ1IHJwaTRiLWFhcmNoIGtlcm5lbDogICBGU0MgPSAweDA0OiBs
ZXZlbCAwIHRyYW5zbGF0aW9uIGZhdWx0DQo+Pj4gSnVsIDIxIDA1OjQwOjQ1IHJwaTRiLWFh
cmNoIGtlcm5lbDogRGF0YSBhYm9ydCBpbmZvOg0KPj4+IEp1bCAyMSAwNTo0MDo0NSBycGk0
Yi1hYXJjaCBrZXJuZWw6ICAgSVNWID0gMCwgSVNTID0gMHgwMDAwMDA0NCwgSVNTMiA9IDB4
MDAwMDAwMDANCj4+PiBKdWwgMjEgMDU6NDA6NDUgcnBpNGItYWFyY2gga2VybmVsOiAgIENN
ID0gMCwgV25SID0gMSwgVG5EID0gMCwgVGFnQWNjZXNzID0gMA0KPj4+IEp1bCAyMSAwNTo0
MDo0NSBycGk0Yi1hYXJjaCBrZXJuZWw6ICAgR0NTID0gMCwgT3ZlcmxheSA9IDAsIERpcnR5
Qml0ID0gMCwgWHMgPSAwDQo+Pj4gSnVsIDIxIDA1OjQwOjQ1IHJwaTRiLWFhcmNoIGtlcm5l
bDogdXNlciBwZ3RhYmxlOiA0ayBwYWdlcywgNDgtYml0IFZBcywgcGdkcD0wMDAwMDAwMDQx
MzAwMDAwDQo+Pj4NCj4gDQo+IE5vdCB0b28gd2VsbC12ZXJzZWQgd2l0aCBBUk0sIGRvZXMg
dGhhdCB0ZWwgbWUgYW55dGhpbmcgYWJvdXQgd2hlcmUgaW4NCj4gdGhlIGNvZGUgdGhlIGNy
YXNoIHdhcz8gV2l0aG91dCBhbnkgZnVydGhlciBpbmZvcm1hdGlvbiBJIGRvbid0IHRoaW5r
IEkNCj4gY2FuIHNlZSBhbnl0aGluZyBoZXJlLCBhbmQgSSBkb24ndCBoYXZlIGFuIGFmZmVj
dGVkIGRldmljZS4NCj4gDQo+IGpvaGFubmVzDQo=
--------------MxLpLOw0q0SDQ6t3NnfAoP15
Content-Type: application/pgp-keys; name="OpenPGP_0x375516A45DB88630.asc"
Content-Disposition: attachment; filename="OpenPGP_0x375516A45DB88630.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBE5aUQ0BCADlsVJE1z92lgySX+Nro7RSqTCAd6y41EljlISd8fGCoFbu0UBO
OPHFVQ1RYvjdRf29IUqfrtGjzucMBFs0Z061rna+omw4LqwMeMlMk1GLMWttCAnm
PQIYqj5BcqtIp5jh1vRggdg3Am6DTHhjqAAnGO+94sW2XnBLESRayGdBrQtUH2UL
Qe1XvTtG066HB3RtzPNO7irB/UDBs7PfJgXmvF1sQB7UyqEMaMr1Oi5DzYGn8AVa
zWTjuN7nQ5D8w3hnGbXmtPwm8dhKUO/UQjtOty8K95/0dP4Py/roBUTbNxzrC+Iz
FAiU5t4l83T1cg8fERl9a3kBB++A0y3OFmi7ABEBAAHNGlplcm9CZWF0IDxaZXJv
QmVhdEBnbXguZGU+wsB4BBMBAgAiBQJOWlENAhsjBgsJCAcDAgYVCAIJCgsEFgID
AQIeAQIXgAAKCRA3VRakXbiGMJLfB/4uTRxIRDrMrKXoy5IshxbyPpcKPt2fFsyJ
7lwozr8bZbYJfbrdXpYH2Arzegqy+gStJ94UNw3e2heihS0x+x8ukOHJ4XmzocDT
TgQDiciLF/y/T9GwvEeHiaws024hZ729w5eA/Gaa046lkYt6eqfW9+VIkzWMAl0V
/pNa63QVfHhZWBuj8EYIyCVhysxBa0tDyRPK1Ulih42lDXWCd1yN/ddaKE+m/+Nu
yWSybV2w/yaboWLQWZNVRRLcdFnognXUo2P3+MM8XNP6EePtQgJaKQ7vfm7RmM8F
3R8gX6lOiDIPZCoatsbSyPdlQ/rVkIDZ6FT0VW9yfdkV1RRLoCd5zsBNBE5aUQ0B
CADV1OCkQeXFo+C76N4QMxGf72FGrbbdTMQcyTtVAEgMh5Kkzuuf5OfP5FCGxOtw
YVXFe8mZeO3C6RrYid2GR0HFkx/wV4w/W68bRa85Hb6hxVddgmPhwvsJQpXItTaX
AjKH5soPHBmPZcl+3KUfqfL/nA4x4JrUJeMaM/X8Gek+uVbTKhwTvObSxPG6DvOd
mfHyUM0bhFV48ooC6IIc+VaHwyY1cgCLliErHrpKhIqP/N+UZpwDtZ+r0fFYIkuw
eJvU+qJmgEgyKrSHY06GspHOMSk5OclLQ8vxvyPbTeemz7fnnYlDc+yBLUfi5/wf
hW0vBI/pAhFVIvTCOtuLbgVhABEBAAHCwF8EGAECAAkFAk5aUQ0CGwwACgkQN1UW
pF24hjC74gf/V9YDe9ZnOUobCghW5qMK0wT2EGcl85rAQ878Awt0/ZMiHaCyAvXp
gsXVKeBFwfGzLdp5RGZJGYnEv3SltrF8uPslcCVmiFe+sZzR8RP61b6fdtRj8x+u
UMKMojonhQWNbkGcFtjbFZcbL91kjTwXJP8QV/KRaw6w2BtZf8he4LiCU3Mj1VVw
DIu16iodSb84NyvRRJtoW9qRakS78aDCHhJuPV0o8dDhZie1OqJDFODrlRsfPSCK
59xYsi6FMxT1fTp9mnh52Qre1YEvOtYgaps8mvtLI0wuJ4QwLgbGPk5WJvooGkKS
9e9rzZBHTO1QuH+ZvMR4+BDER+Pj9nXw4Q=3D=3D
=3D5ikK
-----END PGP PUBLIC KEY BLOCK-----

--------------MxLpLOw0q0SDQ6t3NnfAoP15--

--------------4Aq7cjTXfEag0TUDW8UKwphi--

--------------QSxQM5gqUQBRl0lO9MXdU1cK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEWSDOHFZ5SK/SwKm3N1UWpF24hjAFAmahJ90FAwAAAAAACgkQN1UWpF24hjDP
Zwf/XpRblcHxFWAbtqCsqTvPCPeapySDwQtX6VAh/4Ou2t+OJx2rpx5fZJiO5ig6UhI1ztLu4Hq1
9VD3EYhVe85azZgwhzzKpQQQHz55vS+IYRoZJvnlop4I9RDcIjFHW4J2dIVLTqMbLx/6OWjIEqee
nCJwFYXdeEtSYJIZSgpmR82JnY1OwxAAGksyrr+7j9IJ+vJF8y3c1gzPIJESVRQkTN8ztYzynbVq
NpyxbAwxFv61cF2chUn6ocyJNQvC3WmHuMDI/zwEnHs+v7qTTOkJ02X/h5e7kOydlZgFflKZPkN+
KQVrgbIcai8Z/IXA12mJ8417O1m9d/+ionbJmx9KHw==
=bEjk
-----END PGP SIGNATURE-----

--------------QSxQM5gqUQBRl0lO9MXdU1cK--

