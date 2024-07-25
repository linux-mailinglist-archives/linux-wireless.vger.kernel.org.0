Return-Path: <linux-wireless+bounces-10520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 539F093C6EE
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 18:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23121F21B3B
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 16:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71D31990BB;
	Thu, 25 Jul 2024 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=zerobeat@gmx.de header.b="gvChuMHc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A59E12B7F;
	Thu, 25 Jul 2024 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923222; cv=none; b=kcoSrvewQm313RMk9SlAwieVoA8r8fDHenUKMKhNSIpBze9JJRChPiSVH/1+k/j3HNU4EEMBBBAKtbNBPoQBT2wCIxV6u+839/S6z06/DNA6RxhY32f4pigRQhe+CIJo+uVGqnuXa3iam5Bgpz0jLjVFca1smdV0NH2YRLpY5EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923222; c=relaxed/simple;
	bh=RNh3KEmRYU1W924T6+TJklHxaoR0AIcBRcFDWEQRhrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e93OosTBPDYo9B2p85hfQRVPuzhhl74TCYb0oaajQdTy8MNj7UIhxzTpzhrqnqBAp9oVWYRETAl03BBroHqzbICxxO2Etw1sBTYv9OcpvI693J3O2gooJds/UqclohEKPoom8sQW/tVKHfniNroBNZy5rnIXrmXfYRV7W1dmHBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=zerobeat@gmx.de header.b=gvChuMHc; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721923207; x=1722528007; i=zerobeat@gmx.de;
	bh=RNh3KEmRYU1W924T6+TJklHxaoR0AIcBRcFDWEQRhrs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gvChuMHcgcbjubk55sdJo8SinNo6+C5jhl/t2xKIHLRTmLQXvhM+/JvVtcs0z0y6
	 thV/mBKLoLJ+KASz6OFx/CgakVeiOGHIDeKZdsPEcTrDvN+Br1ystjUpj1e44VRmd
	 h0nZyxukZZ7k/PtWgkaRk2Za1OGSheTS6hxDdTFaQFdjLJeHX7DuYzFBHHgqo8tvX
	 bIIAXf+0oeT2r5kwJ1rORzl9AKFK6o8+gmeCdDf9WplyfrBKsWkjyj2CeLVMwBbZk
	 VAE0isJGRI7EXHb1/FY1U8K4ypY/i++zak29uKGJY68iNWAexlC3spomA52EUDRv4
	 /utfB/YuQdK0nPBJuw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.2] ([79.194.93.171]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DJl-1saar40hI5-00CnHX; Thu, 25
 Jul 2024 18:00:07 +0200
Message-ID: <852b737f-c158-4bb4-b5de-7b7d3d1d5331@gmx.de>
Date: Thu, 25 Jul 2024 18:00:06 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] mt76x2u: NULL pointer dereference since recent
 change to fix chanctx emulation for monitor mode
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>
References: <8c91352f-a404-4ba6-aa27-1253468c830d@leemhuis.info>
 <c4a67a0418e7068fc534f39f3c1dce21d082dd8f.camel@sipsolutions.net>
 <231c6ea5-b8a3-4500-b994-46a45b6ab515@gmx.de> <ZqJ10ZKHPGM6LbsM@lore-desk>
Content-Language: de-DE, en-US
From: ZeroBeat <ZeroBeat@gmx.de>
In-Reply-To: <ZqJ10ZKHPGM6LbsM@lore-desk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------sdDa8lv0SjGvO9cTXSM0UNI4"
X-Provags-ID: V03:K1:6ce4CIob128aIhfAWyaIT24RQC2XVRY6GM78R5YHNqwkGAUk9i4
 7wZOZBijBcrLknYcZopasmWaKXr4vRFn+xb7iPmezH+QYXQxv56YGU0KnsGgLtutTdVwyA+
 l6CqJKamjixLjhaK72c3eSCHMs4mf4GNcNYkn14q1zF6UvYXQpKa5Cexr/urKUBIg6NVBSL
 7Fu0EFtpnvg0quUsQvXfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q8SqSk5IkqU=;rGAi5a2GFprytAS2XQcHz+OyxOP
 9l+UjNSxGjzXqK325tDpSdL/aKFTNoLejqDCXRyfBWTdEsHEA1xnpw4YanBZluK/yP+0ehpr5
 xBv6OxuEC+SFxIvvaI0ZGBmQh4duCzZEqFXQ8Huv0gBUBf6ZgH9Rk5oePVAkn++VVSGy1Uu/0
 gbtRkfNv/czizu8IQ9+UKSigu2MqbyFrtQBSN9I4TgtcKy0cFP4d520fZZwE7fM6uTTOZuYbc
 Z2mKO2dQW14zlF9o5+h3Kpa/uY8U2EqPkNGJxTAdI3KRzYqNXLtUUsukVwFsHJoFNC1y1AQma
 S8oy2WChSY5WiySKMFwdfIP2CTJNUCtEm7Hltqild1uL/T9CfHTN2HHerfVuzjsovbFuZPhQm
 OYdJDY4QOCStJ1r2BIrwR4q2x19QZTBVzO+JOh6bW9Px0Z3u//qmbG1qU++NzOIrF+Q/XfVCY
 qZyEJ96sa9O/yOC8VZVVkmGX3qRjM0VGQToc+n1zVHFJGNzWeSDUb4i02UxW/KGc6ORMCDtYw
 aQhFVdQm8rftbf+eMmURGSSqrQbl9Xz5F/NkB4IWIC87CWzz6mGFHynWal15GpjI3if4yE88D
 Usg4fwJElJ+Ii163C0fhvrLj1wdlxiFQTHUZjn6U+7OBl+3c6IcKbmvF9jz00LOlj6qif416y
 W0Fu+auXaf0a2HxWUqOw+y0NFtwkm44PIGvej9Vfz/GRXU1MPCd7ldGQGwfysaj/ddayCJ1Jv
 1IxbBOiShMrvM/Vij4CMUZGgNWTiy8nhRp0Uc7eDUXuTnGjnT62B34/I5aFkxxZKMcpM/4KVO
 IDRs31jHUT22qJQv1O4Dxbng==

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------sdDa8lv0SjGvO9cTXSM0UNI4
Content-Type: multipart/mixed; boundary="------------sQfvmcqOu9sq3F56lYtANScV";
 protected-headers="v1"
From: ZeroBeat <ZeroBeat@gmx.de>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>
Message-ID: <852b737f-c158-4bb4-b5de-7b7d3d1d5331@gmx.de>
Subject: Re: [regression] mt76x2u: NULL pointer dereference since recent
 change to fix chanctx emulation for monitor mode
References: <8c91352f-a404-4ba6-aa27-1253468c830d@leemhuis.info>
 <c4a67a0418e7068fc534f39f3c1dce21d082dd8f.camel@sipsolutions.net>
 <231c6ea5-b8a3-4500-b994-46a45b6ab515@gmx.de> <ZqJ10ZKHPGM6LbsM@lore-desk>
In-Reply-To: <ZqJ10ZKHPGM6LbsM@lore-desk>

--------------sQfvmcqOu9sq3F56lYtANScV
Content-Type: multipart/mixed; boundary="------------73i5QSksggjoR90W2Pu6mhGv"

--------------73i5QSksggjoR90W2Pu6mhGv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SSd2ZSBhZGRlZCBzZXZlcmFsIGRlYnVnIHByaW50ayAtIG5vIGx1Y2ssIHlldC4NCg0KUmVn
YXJkcw0KTWlrZQ0KDQoNCkFtIDI1LjA3LjI0IHVtIDE3OjU3IHNjaHJpZWIgTG9yZW56byBC
aWFuY29uaToNCj4+IEp1c3QgdG8gbWVudGlvbiBpdCBoZXJlLiBUaGUgcmVncmVzc2lvbiBo
YXMgbm93IHJlYWNoZWQgdGhlIGxvbmd0ZXJtIGtlcm5lbDoNCj4+IGFmZmVjdGVkIGRldmlj
ZXM6IG10NzYgc2VyaWVzIChub3QgYWZmZWN0ZWQgbXQ3NjAxdSkNCj4+DQo+Pg0KPj4gYmVm
b3JlIHVwZGF0ZToNCj4+ICQgdW5hbWUgLXINCj4+IDYuNi40MC0yLWx0cw0KPj4NCj4+ICQg
c3VkbyBoY3hkdW1wdG9vbCAtaSB3bHA1czBmNHUyIC0tcmNhc2Nhbj1hY3RpdmUNCj4+IF5D
DQo+PiAzOCBQYWNrZXQocykgY2FwdHVyZWQgYnkga2VybmVsDQo+PiAwIFBhY2tldChzKSBk
cm9wcGVkIGJ5IGtlcm5lbA0KPj4gMTQgUFJPQkVSRVNQT05TRShzKSBjYXB0dXJlZA0KPj4N
Cj4+IGV4aXQgb24gc2lndGVybQ0KPj4NCj4+DQo+Pg0KPj4gYWZ0ZXIgdXBkYXRlOg0KPj4g
JCB1bmFtZSAtcg0KPj4gNi42LjQxLTEtbHRzDQo+Pg0KPj4gJCBzdWRvIGhjeGR1bXB0b29s
IC1pIHdscDQ4czBmNHUydTEgLS1yY2FzY2FuPWFjdGl2ZQ0KPj4gXkMNCj4+IDAgUGFja2V0
KHMpIGNhcHR1cmVkIGJ5IGtlcm5lbA0KPj4gMCBQYWNrZXQocykgZHJvcHBlZCBieSBrZXJu
ZWwNCj4+IFdhcm5pbmc6IHRvbyBsZXNzIHBhY2tldHMgcmVjZWl2ZWQgKG1vbml0b3IgbW9k
ZSBtYXkgbm90IHdvcmsgYXMgZXhwZWN0ZWQpDQo+PiBQb3NzaWJsZSByZWFzb25zOg0KPj4g
ICBubyB0cmFuc21pdHRlciBpbiByYW5nZQ0KPj4gICBmcmFtZXMgYXJlIGZpbHRlcmVkIG91
dCBieSBCUEYNCj4+ICAgZHJpdmVyIGlzIGJyb2tlbg0KPj4gV2FybmluZzogbm8gUFJPQkVS
RVNQT05TRVMgcmVjZWl2ZWQgKGZyYW1lIGluamVjdGlvbiBtYXkgbm90IHdvcmsgYXMgZXhw
ZWN0ZWQpDQo+PiBQb3NzaWJsZSByZWFzb25zOg0KPj4gICBubyBBUCBpbiByYW5nZQ0KPj4g
ICBmcmFtZXMgYXJlIGZpbHRlcmVkIG91dCBieSBCUEYNCj4+ICAgZHJpdmVyIGlzIGJyb2tl
bg0KPj4gICBkcml2ZXIgZG9lcyBub3Qgc3VwcG9ydCBmcmFtZSBpbmplY3Rpb24NCj4+DQo+
PiBleGl0IG9uIHNpZ3Rlcm0NCj4+DQo+Pg0KPj4gQmVzdCByZWdhcmRzDQo+PiBNaWtlDQo+
IA0KPiBIaSwNCj4gDQo+IEkgYW0gbG9va2luZyBpbnRvIGl0LiBJIHdpbGwgZ2V0IGJhY2sg
dG8geW91Lg0KPiANCj4gUmVnYXJkcywNCj4gTG9yZW56bw0KPiANCj4+DQo+Pg0KPj4NCj4+
DQo+Pg0KPj4NCj4+IEFtIDI0LjA3LjI0IHVtIDEwOjQ3IHNjaHJpZWIgSm9oYW5uZXMgQmVy
ZzoNCj4+PiBPbiBXZWQsIDIwMjQtMDctMjQgYXQgMDk6NTggKzAyMDAsIExpbnV4IHJlZ3Jl
c3Npb24gdHJhY2tpbmcgKFRob3JzdGVuDQo+Pj4gTGVlbWh1aXMpIHdyb3RlOg0KPj4+PiBI
aSwgVGhvcnN0ZW4gaGVyZSwgdGhlIExpbnV4IGtlcm5lbCdzIHJlZ3Jlc3Npb24gdHJhY2tl
ci4NCj4+Pj4NCj4+Pj4gSm9oYW5uZXMsIEZlbGl4LCBMb3JlbnpvLCBSeWRlciwgSSBub3Rp
Y2VkIGEgcmVwb3J0IGFib3V0IGEgcmVncmVzc2lvbg0KPj4+PiBpbiBidWd6aWxsYS5rZXJu
ZWwub3JnIHRoYXQgKGZvciBteSB1bnRyYWluZWQgZXllcykgYXBwZWFycyB0byBiZSBhIGJ1
Zw0KPj4+PiBpbiBzb21lIGNvZGUgcGF0aHMgb2YgbXQ3NngydSB0aGF0IHdhcyBleHBvc2Vk
IGJ5IDBkOWMyYmVlZDExNmU2ICgid2lmaToNCj4+Pj4gbWFjODAyMTE6IGZpeCBtb25pdG9y
IGNoYW5uZWwgd2l0aCBjaGFuY3R4IGVtdWxhdGlvbiIpIFt2Ni4xMC1yYzUsDQo+Pj4+IHY2
LjkuN10gZnJvbSBKb2hhbm5lcy4NCj4+Pj4NCj4+Pj4gQXMgbWFueSAobW9zdD8pIGtlcm5l
bCBkZXZlbG9wZXJzIGRvbid0IGtlZXAgYW4gZXllIG9uIHRoZSBidWcgdHJhY2tlciwNCj4+
Pj4gSSBkZWNpZGVkIHRvIHdyaXRlIHRoaXMgbWFpbC4gVG8gcXVvdGUgZnJvbQ0KPj4+PiBo
dHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxOTA4NiA6DQo+
Pj4+DQo+Pj4+PiAgICBNaWNoYWVsIDIwMjQtMDctMjMgMTU6Mzg6NDMgVVRDDQo+Pj4+Pg0K
Pj4+Pj4gQWZ0ZXIgYSB1c2VyIG9wZW5lZCB0aGlzIGRpc2N1c3Npb246DQo+Pj4+PiBodHRw
czovL2dpdGh1Yi5jb20vWmVyQmVhL2hjeGR1bXB0b29sL2Rpc2N1c3Npb25zLzQ2NQ0KPj4+
Pj4NCj4+Pj4+IEp1bCAyMSAwNTo0MDozOSBycGk0Yi1hYXJjaCBrZXJuZWw6IG10NzZ4MnUg
Mi0yOjEuMCB3bGFuMTogZW50ZXJlZCBwcm9taXNjdW91cyBtb2RlDQo+Pj4+PiBKdWwgMjEg
MDU6NDA6NDUgcnBpNGItYWFyY2gga2VybmVsOiBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBO
VUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVhbCBhZGRyZXNzIDAwMDAwMDAwMDAw
MDAwMDANCj4+Pj4+IEp1bCAyMSAwNTo0MDo0NSBycGk0Yi1hYXJjaCBrZXJuZWw6IE1lbSBh
Ym9ydCBpbmZvOg0KPj4+Pj4gSnVsIDIxIDA1OjQwOjQ1IHJwaTRiLWFhcmNoIGtlcm5lbDog
ICBFU1IgPSAweDAwMDAwMDAwOTYwMDAwNDQNCj4+Pj4+IEp1bCAyMSAwNTo0MDo0NSBycGk0
Yi1hYXJjaCBrZXJuZWw6ICAgRUMgPSAweDI1OiBEQUJUIChjdXJyZW50IEVMKSwgSUwgPSAz
MiBiaXRzDQo+Pj4+PiBKdWwgMjEgMDU6NDA6NDUgcnBpNGItYWFyY2gga2VybmVsOiAgIFNF
VCA9IDAsIEZuViA9IDANCj4+Pj4+IEp1bCAyMSAwNTo0MDo0NSBycGk0Yi1hYXJjaCBrZXJu
ZWw6ICAgRUEgPSAwLCBTMVBUVyA9IDANCj4+Pj4+IEp1bCAyMSAwNTo0MDo0NSBycGk0Yi1h
YXJjaCBrZXJuZWw6ICAgRlNDID0gMHgwNDogbGV2ZWwgMCB0cmFuc2xhdGlvbiBmYXVsdA0K
Pj4+Pj4gSnVsIDIxIDA1OjQwOjQ1IHJwaTRiLWFhcmNoIGtlcm5lbDogRGF0YSBhYm9ydCBp
bmZvOg0KPj4+Pj4gSnVsIDIxIDA1OjQwOjQ1IHJwaTRiLWFhcmNoIGtlcm5lbDogICBJU1Yg
PSAwLCBJU1MgPSAweDAwMDAwMDQ0LCBJU1MyID0gMHgwMDAwMDAwMA0KPj4+Pj4gSnVsIDIx
IDA1OjQwOjQ1IHJwaTRiLWFhcmNoIGtlcm5lbDogICBDTSA9IDAsIFduUiA9IDEsIFRuRCA9
IDAsIFRhZ0FjY2VzcyA9IDANCj4+Pj4+IEp1bCAyMSAwNTo0MDo0NSBycGk0Yi1hYXJjaCBr
ZXJuZWw6ICAgR0NTID0gMCwgT3ZlcmxheSA9IDAsIERpcnR5Qml0ID0gMCwgWHMgPSAwDQo+
Pj4+PiBKdWwgMjEgMDU6NDA6NDUgcnBpNGItYWFyY2gga2VybmVsOiB1c2VyIHBndGFibGU6
IDRrIHBhZ2VzLCA0OC1iaXQgVkFzLCBwZ2RwPTAwMDAwMDAwNDEzMDAwMDANCj4+Pj4+DQo+
Pj4NCj4+PiBOb3QgdG9vIHdlbGwtdmVyc2VkIHdpdGggQVJNLCBkb2VzIHRoYXQgdGVsIG1l
IGFueXRoaW5nIGFib3V0IHdoZXJlIGluDQo+Pj4gdGhlIGNvZGUgdGhlIGNyYXNoIHdhcz8g
V2l0aG91dCBhbnkgZnVydGhlciBpbmZvcm1hdGlvbiBJIGRvbid0IHRoaW5rIEkNCj4+PiBj
YW4gc2VlIGFueXRoaW5nIGhlcmUsIGFuZCBJIGRvbid0IGhhdmUgYW4gYWZmZWN0ZWQgZGV2
aWNlLg0KPj4+DQo+Pj4gam9oYW5uZXMNCj4gDQo+IA0KPiANCj4gDQo+IA0K
--------------73i5QSksggjoR90W2Pu6mhGv
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

--------------73i5QSksggjoR90W2Pu6mhGv--

--------------sQfvmcqOu9sq3F56lYtANScV--

--------------sdDa8lv0SjGvO9cTXSM0UNI4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEWSDOHFZ5SK/SwKm3N1UWpF24hjAFAmaidoYFAwAAAAAACgkQN1UWpF24hjCN
AQgApUURpWG91CkBn6flRbLraJJGIJ+R+Bl3sQ6UaXwA4FwM7Z6V38yv16DelCIr/B3JJ+DYcdjz
kPDfVWXMkCDVFaSWqk/mqUx4ZWxYRx8IRR9fhqHgQRG/RsuGzRXusurMl6Kxx/64yaWHUGH9pXpN
AoqcK6yoxwnJGD0tbOV35f51zbhoh7u6Hww7tWSmZbcKSFBmfC+SVhnNpGMLJtctT+IOqUhZ+FdI
jM48UxZOLhQhVYmYfkhcYpNagwEn5s/AuWzeINoZmqZ9DuMYWlmjvQDxCBkGqE1Y9GvrmCTBWEMf
+IYBTUPWIwYTAjL0O+23Wpw0XJdhFXjKL+dd2URORQ==
=GLNm
-----END PGP SIGNATURE-----

--------------sdDa8lv0SjGvO9cTXSM0UNI4--

