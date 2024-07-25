Return-Path: <linux-wireless+bounces-10518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B94D293C6D6
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 17:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355E21F21B4F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 15:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980A019D89C;
	Thu, 25 Jul 2024 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=zerobeat@gmx.de header.b="st+eFtrE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207FC19CCE6;
	Thu, 25 Jul 2024 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922866; cv=none; b=WdK//uPjg0BNIHpKDWqsdUzxpEWoPspRw0/ijgvsXahTsPf41wJzCmxdFjzqVEJy1VIqKuprhpdU3C1kHDMse8V83UOAl3A6CwpFjs9Fo7iesylMkWjYoiYFTon7Y4rz4L3bqFnDUCUlH4bX8XyrI8hP7Tm8AuOxfMfwXltF4b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922866; c=relaxed/simple;
	bh=bdP+YdPqiuJw1UDcTuhjsm43Pem6j3mr5KQTovbwUpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kb6Te/VqMAJpUh0+ytNA34V4bFgotnJOs4Sbuv9rH9cawE0VXHT16E+UPZaDqxRVLbnaFiXrabZso95NBY7YnUKwrBvdoEtw60LjI2CuYVTL0bi3PAQ/UMu6vxPEetaqrTUGzEjPBxs1d6sWBwECZIydotlrE9gQqImuPsFRnH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=zerobeat@gmx.de header.b=st+eFtrE; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721922848; x=1722527648; i=zerobeat@gmx.de;
	bh=bdP+YdPqiuJw1UDcTuhjsm43Pem6j3mr5KQTovbwUpg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=st+eFtrE0QbMW8s4HgnGeMM1Yause0/FzacVLMKNRQjsC/ZiyPg8sQIXF3ohlh6T
	 hVTIhaVEzcCAkFgwwK+BszV4ZzEUGoQBSzMZkarxW9KbtQGb3+h5F0mFGE3nDrH13
	 CJl7ELblO9RArKtFeqePBVXLux4/wzAwO5FUCyaG8CKm458ZKP7NC5aySg+bQCb65
	 1q2U2/YBTjBEOmUb94gyZhtBWOf9gi30zptOXwgNSlBiECSqbXiZrfoXzg54X/nnv
	 vMMNnS0k52bIFzAcrI9+hesHxZOCXvXH5OWeh8YAPGWQ2hp2cEpgyyurREzReaibb
	 Vrupiqa2bxddALN9Nw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.2] ([79.194.93.171]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwwdf-1sLndj1yWp-012CYz; Thu, 25
 Jul 2024 17:54:08 +0200
Message-ID: <231c6ea5-b8a3-4500-b994-46a45b6ab515@gmx.de>
Date: Thu, 25 Jul 2024 17:54:05 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] mt76x2u: NULL pointer dereference since recent
 change to fix chanctx emulation for monitor mode
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
In-Reply-To: <c4a67a0418e7068fc534f39f3c1dce21d082dd8f.camel@sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------JTQ8da0GOX30oJzcOgOYNLXW"
X-Provags-ID: V03:K1:PdwRORGShgBkamhFKHdlyWTp+UtlhmPPRhe2/zghnJdzFo4qJIO
 TcRUg3PyValtDnQkPYZH++qcMWiFZ8WdRBpY0Kz8lURSZ4jKWthci8r/XENo8JQJLmcGidV
 MzQVEJSn+pVtWoBVAxdQ74yViezon7t76wt4YHH9L8AVDsNIVO3CFQAcwUQX+is27C3/YhE
 PlcLCnzUFayA2AF3WG3Kg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cNmBaEELWLc=;fevnq1TPTEyONuFZQbrbmquhpQ3
 on0698T3vQvgas3n630ktq9O5dJ8GnJa8Je0tTLToyY3Ukkt4eC60J0YprCFnQyupZOIVdwjj
 TizMjaymw8oCPzNrnkSv1grxh7gt+X5ZlLR8WwTUmc6gL+FKHo72hGkgRb/G9sqpxWCkTY8dS
 +aboO1M/VbJQFqx2EBU0r5UviZud66eDOjXtnP5D1n0nGLnl3Vw/7G0hdPfZgq04iq/GhRkCH
 4h16qI4wW8XKYS+Xiql2D4eJfTsKyAO55K5n2g81m6P0zls+HyFrh2bbVDR63T8nyyaI4Zvng
 XA36tgmRozXf6AWYAkhOSBEyVk66ZXIR6rZ9/eugNwb6ztTGfZcMw6XbnTluT1u6xiSqFvAhu
 YDl5utd26EW92J4nSDg6iOhiRX7I2x54ZGes7nusexMrppnA8GrJroEESiVJos+32cf2WAKMM
 nb/uAfg06PQ0WTlhIkln2RLSbaW2RANgxh8AGHyiSBgmfMBLoVFhjFjd0uXtqQCpNb8vAAyON
 jU9gBf1ZrnwaTHJG+sM9yvc0s4iUOHySfnzE1yiPUgRpWcg6CnT0Wa+98v1YnGmsMGZh2K+4Q
 NO56UpIMLv1tV1S9AQC5EisUIZbGXZF3DyO1S7D0eJ8I6zJ/i1mBB83o4PfZWJJmozWMERxT7
 I6obHfdnmJYvizdEGXY6LfO+363kbayLO/5+Demcc4/G+BEtaadjtFXTy6z4OCai2GeL+RB5U
 xwT/nwD97iJwNN6pSyd4kSiSWNgMepC+7b8tFSD2bbdXs2FbnIi4s/wc3y1sIB1Nu9Kf27LWj
 JzrWOArRIs9AYQLg9C7Og0SQ==

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------JTQ8da0GOX30oJzcOgOYNLXW
Content-Type: multipart/mixed; boundary="------------B0KcU6ru6MVpg0ujme5EtDHi";
 protected-headers="v1"
From: ZeroBeat <ZeroBeat@gmx.de>
To: Johannes Berg <johannes@sipsolutions.net>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>
Message-ID: <231c6ea5-b8a3-4500-b994-46a45b6ab515@gmx.de>
Subject: Re: [regression] mt76x2u: NULL pointer dereference since recent
 change to fix chanctx emulation for monitor mode
References: <8c91352f-a404-4ba6-aa27-1253468c830d@leemhuis.info>
 <c4a67a0418e7068fc534f39f3c1dce21d082dd8f.camel@sipsolutions.net>
In-Reply-To: <c4a67a0418e7068fc534f39f3c1dce21d082dd8f.camel@sipsolutions.net>

--------------B0KcU6ru6MVpg0ujme5EtDHi
Content-Type: multipart/mixed; boundary="------------u5J9N4P8a0mmp1CeE9Xac3Go"

--------------u5J9N4P8a0mmp1CeE9Xac3Go
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SnVzdCB0byBtZW50aW9uIGl0IGhlcmUuIFRoZSByZWdyZXNzaW9uIGhhcyBub3cgcmVhY2hl
ZCB0aGUgbG9uZ3Rlcm0ga2VybmVsOg0KYWZmZWN0ZWQgZGV2aWNlczogbXQ3NiBzZXJpZXMg
KG5vdCBhZmZlY3RlZCBtdDc2MDF1KQ0KDQoNCmJlZm9yZSB1cGRhdGU6DQokIHVuYW1lIC1y
DQo2LjYuNDAtMi1sdHMNCg0KJCBzdWRvIGhjeGR1bXB0b29sIC1pIHdscDVzMGY0dTIgLS1y
Y2FzY2FuPWFjdGl2ZQ0KXkMNCjM4IFBhY2tldChzKSBjYXB0dXJlZCBieSBrZXJuZWwNCjAg
UGFja2V0KHMpIGRyb3BwZWQgYnkga2VybmVsDQoxNCBQUk9CRVJFU1BPTlNFKHMpIGNhcHR1
cmVkDQoNCmV4aXQgb24gc2lndGVybQ0KDQoNCg0KYWZ0ZXIgdXBkYXRlOg0KJCB1bmFtZSAt
cg0KNi42LjQxLTEtbHRzDQoNCiQgc3VkbyBoY3hkdW1wdG9vbCAtaSB3bHA0OHMwZjR1MnUx
IC0tcmNhc2Nhbj1hY3RpdmUNCl5DDQowIFBhY2tldChzKSBjYXB0dXJlZCBieSBrZXJuZWwN
CjAgUGFja2V0KHMpIGRyb3BwZWQgYnkga2VybmVsDQpXYXJuaW5nOiB0b28gbGVzcyBwYWNr
ZXRzIHJlY2VpdmVkIChtb25pdG9yIG1vZGUgbWF5IG5vdCB3b3JrIGFzIGV4cGVjdGVkKQ0K
UG9zc2libGUgcmVhc29uczoNCiAgbm8gdHJhbnNtaXR0ZXIgaW4gcmFuZ2UNCiAgZnJhbWVz
IGFyZSBmaWx0ZXJlZCBvdXQgYnkgQlBGDQogIGRyaXZlciBpcyBicm9rZW4NCldhcm5pbmc6
IG5vIFBST0JFUkVTUE9OU0VTIHJlY2VpdmVkIChmcmFtZSBpbmplY3Rpb24gbWF5IG5vdCB3
b3JrIGFzIGV4cGVjdGVkKQ0KUG9zc2libGUgcmVhc29uczoNCiAgbm8gQVAgaW4gcmFuZ2UN
CiAgZnJhbWVzIGFyZSBmaWx0ZXJlZCBvdXQgYnkgQlBGDQogIGRyaXZlciBpcyBicm9rZW4N
CiAgZHJpdmVyIGRvZXMgbm90IHN1cHBvcnQgZnJhbWUgaW5qZWN0aW9uDQoNCmV4aXQgb24g
c2lndGVybQ0KDQoNCkJlc3QgcmVnYXJkcw0KTWlrZQ0KDQoNCg0KDQoNCg0KQW0gMjQuMDcu
MjQgdW0gMTA6NDcgc2NocmllYiBKb2hhbm5lcyBCZXJnOg0KPiBPbiBXZWQsIDIwMjQtMDct
MjQgYXQgMDk6NTggKzAyMDAsIExpbnV4IHJlZ3Jlc3Npb24gdHJhY2tpbmcgKFRob3JzdGVu
DQo+IExlZW1odWlzKSB3cm90ZToNCj4+IEhpLCBUaG9yc3RlbiBoZXJlLCB0aGUgTGludXgg
a2VybmVsJ3MgcmVncmVzc2lvbiB0cmFja2VyLg0KPj4NCj4+IEpvaGFubmVzLCBGZWxpeCwg
TG9yZW56bywgUnlkZXIsIEkgbm90aWNlZCBhIHJlcG9ydCBhYm91dCBhIHJlZ3Jlc3Npb24N
Cj4+IGluIGJ1Z3ppbGxhLmtlcm5lbC5vcmcgdGhhdCAoZm9yIG15IHVudHJhaW5lZCBleWVz
KSBhcHBlYXJzIHRvIGJlIGEgYnVnDQo+PiBpbiBzb21lIGNvZGUgcGF0aHMgb2YgbXQ3Nngy
dSB0aGF0IHdhcyBleHBvc2VkIGJ5IDBkOWMyYmVlZDExNmU2ICgid2lmaToNCj4+IG1hYzgw
MjExOiBmaXggbW9uaXRvciBjaGFubmVsIHdpdGggY2hhbmN0eCBlbXVsYXRpb24iKSBbdjYu
MTAtcmM1LA0KPj4gdjYuOS43XSBmcm9tIEpvaGFubmVzLg0KPj4NCj4+IEFzIG1hbnkgKG1v
c3Q/KSBrZXJuZWwgZGV2ZWxvcGVycyBkb24ndCBrZWVwIGFuIGV5ZSBvbiB0aGUgYnVnIHRy
YWNrZXIsDQo+PiBJIGRlY2lkZWQgdG8gd3JpdGUgdGhpcyBtYWlsLiBUbyBxdW90ZSBmcm9t
DQo+PiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxOTA4
NiA6DQo+Pg0KPj4+ICAgTWljaGFlbCAyMDI0LTA3LTIzIDE1OjM4OjQzIFVUQw0KPj4+DQo+
Pj4gQWZ0ZXIgYSB1c2VyIG9wZW5lZCB0aGlzIGRpc2N1c3Npb246DQo+Pj4gaHR0cHM6Ly9n
aXRodWIuY29tL1plckJlYS9oY3hkdW1wdG9vbC9kaXNjdXNzaW9ucy80NjUNCj4+Pg0KPj4+
IEp1bCAyMSAwNTo0MDozOSBycGk0Yi1hYXJjaCBrZXJuZWw6IG10NzZ4MnUgMi0yOjEuMCB3
bGFuMTogZW50ZXJlZCBwcm9taXNjdW91cyBtb2RlDQo+Pj4gSnVsIDIxIDA1OjQwOjQ1IHJw
aTRiLWFhcmNoIGtlcm5lbDogVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVy
IGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAwMDAwMDAwDQo+Pj4g
SnVsIDIxIDA1OjQwOjQ1IHJwaTRiLWFhcmNoIGtlcm5lbDogTWVtIGFib3J0IGluZm86DQo+
Pj4gSnVsIDIxIDA1OjQwOjQ1IHJwaTRiLWFhcmNoIGtlcm5lbDogICBFU1IgPSAweDAwMDAw
MDAwOTYwMDAwNDQNCj4+PiBKdWwgMjEgMDU6NDA6NDUgcnBpNGItYWFyY2gga2VybmVsOiAg
IEVDID0gMHgyNTogREFCVCAoY3VycmVudCBFTCksIElMID0gMzIgYml0cw0KPj4+IEp1bCAy
MSAwNTo0MDo0NSBycGk0Yi1hYXJjaCBrZXJuZWw6ICAgU0VUID0gMCwgRm5WID0gMA0KPj4+
IEp1bCAyMSAwNTo0MDo0NSBycGk0Yi1hYXJjaCBrZXJuZWw6ICAgRUEgPSAwLCBTMVBUVyA9
IDANCj4+PiBKdWwgMjEgMDU6NDA6NDUgcnBpNGItYWFyY2gga2VybmVsOiAgIEZTQyA9IDB4
MDQ6IGxldmVsIDAgdHJhbnNsYXRpb24gZmF1bHQNCj4+PiBKdWwgMjEgMDU6NDA6NDUgcnBp
NGItYWFyY2gga2VybmVsOiBEYXRhIGFib3J0IGluZm86DQo+Pj4gSnVsIDIxIDA1OjQwOjQ1
IHJwaTRiLWFhcmNoIGtlcm5lbDogICBJU1YgPSAwLCBJU1MgPSAweDAwMDAwMDQ0LCBJU1My
ID0gMHgwMDAwMDAwMA0KPj4+IEp1bCAyMSAwNTo0MDo0NSBycGk0Yi1hYXJjaCBrZXJuZWw6
ICAgQ00gPSAwLCBXblIgPSAxLCBUbkQgPSAwLCBUYWdBY2Nlc3MgPSAwDQo+Pj4gSnVsIDIx
IDA1OjQwOjQ1IHJwaTRiLWFhcmNoIGtlcm5lbDogICBHQ1MgPSAwLCBPdmVybGF5ID0gMCwg
RGlydHlCaXQgPSAwLCBYcyA9IDANCj4+PiBKdWwgMjEgMDU6NDA6NDUgcnBpNGItYWFyY2gg
a2VybmVsOiB1c2VyIHBndGFibGU6IDRrIHBhZ2VzLCA0OC1iaXQgVkFzLCBwZ2RwPTAwMDAw
MDAwNDEzMDAwMDANCj4+Pg0KPiANCj4gTm90IHRvbyB3ZWxsLXZlcnNlZCB3aXRoIEFSTSwg
ZG9lcyB0aGF0IHRlbCBtZSBhbnl0aGluZyBhYm91dCB3aGVyZSBpbg0KPiB0aGUgY29kZSB0
aGUgY3Jhc2ggd2FzPyBXaXRob3V0IGFueSBmdXJ0aGVyIGluZm9ybWF0aW9uIEkgZG9uJ3Qg
dGhpbmsgSQ0KPiBjYW4gc2VlIGFueXRoaW5nIGhlcmUsIGFuZCBJIGRvbid0IGhhdmUgYW4g
YWZmZWN0ZWQgZGV2aWNlLg0KPiANCj4gam9oYW5uZXMNCg==
--------------u5J9N4P8a0mmp1CeE9Xac3Go
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

--------------u5J9N4P8a0mmp1CeE9Xac3Go--

--------------B0KcU6ru6MVpg0ujme5EtDHi--

--------------JTQ8da0GOX30oJzcOgOYNLXW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEWSDOHFZ5SK/SwKm3N1UWpF24hjAFAmaidR0FAwAAAAAACgkQN1UWpF24hjDS
ZAf+P/uys0piTjGwodfdcKLWla4myTMpicw7TE0hEHIL0Ztc7r3dzVpuoUNwju5wMYuWf+IE2/be
S0DNVCiJfUJUixDKDPxlbl4rBf1bTpIoHeWvS6uAJicYhpvg+DboG7QS2iQo99wejzvamPv+neEa
TzVTiKTioJmslVxauImOgm/19XHYQ7nRvhbiedaKaoSkpzzDDx21KKxN8xvSoZ/ZmV0ZdmAhyEdC
iMsMXSyxezeA2hVFEoxaEYf0LI6FGQnrGBlmo/cvtvt2oPm33maLbSeQzICdzSMTg8pdFiVL20Jv
fb0BiKbjUYA9dyHKy0WQnKkRL3q5JjdH0HWLYstVMA==
=/sFZ
-----END PGP SIGNATURE-----

--------------JTQ8da0GOX30oJzcOgOYNLXW--

