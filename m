Return-Path: <linux-wireless+bounces-10522-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDAD93C7BE
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 19:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBB7282EDB
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 17:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3893354759;
	Thu, 25 Jul 2024 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=zerobeat@gmx.de header.b="WQP2Kj/K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941451C286;
	Thu, 25 Jul 2024 17:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721929343; cv=none; b=dKNvA2skisJNND7B0yyYuwz2JmFcfjB6ml7FJEiu9m3BR/DBdCgtVN+Tm5fAbtehX6eHTnMToZwQnSl4wev7kUrX8wrhQ9u/QFsiJUqgdkt1NUGjfqe4jrRkeKCWJQQlYT/YjS0+GMioCEQo9OagZ03ievjyhwLXmNaEcSonVgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721929343; c=relaxed/simple;
	bh=1pwh5oFntSiibSAMxGfIX3e66UoQ153fGbSP2cd5+eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kco9pzKGXQbDplLirY9U7uYV7Ntl0b2kAYrC3JVW10nfdfth0GerkZAu6CY0GPg5nqxlkHxs9oymFT/28+imMOu4vpI0wLcdbZpr+fxIItnhoj+wrZ284YSW1Yx2rbIj+tZlGcsPua7zNGJgzuWMGvY8OgD0jXE9m0JoLrU0Q6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=zerobeat@gmx.de header.b=WQP2Kj/K; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721929332; x=1722534132; i=zerobeat@gmx.de;
	bh=1pwh5oFntSiibSAMxGfIX3e66UoQ153fGbSP2cd5+eM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WQP2Kj/KoxAOb6bSKRoaDt/qrlBIvXIb0ZVNDVUvzKceuR8PFOd6UuoIonkUgjjo
	 4YykLojqlV7GmQfkk3arJglL+53kNFNikvItmMT3VFr6AnR+1mEFmH84RKMnEmRZ/
	 bR7fKGrx0ynPhxtux8xlDktf9STnmfiXaXYfWCJiPfEKVxFQf96y9BZLIbBWDSz4u
	 zq1UAbHuODuheRR1/ApLKt+FC/Y1CY71mZ3TeQrgsNoJEwTneVRIGsZMDUbLw9U7A
	 tRwJkkskBvVuXSdcIySdrFprFtsh6yAWu8v+2CIdQcV1PVM05FNz4rgyNK27p8inO
	 FQcjzOmXfXMRFIm5pg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.2] ([79.194.93.171]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhU5b-1s1qSN1ln1-00mQfP; Thu, 25
 Jul 2024 19:42:12 +0200
Message-ID: <bfe10f6c-ccbc-47f5-b1d2-91dbd55ba434@gmx.de>
Date: Thu, 25 Jul 2024 19:42:11 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless] wifi: mac80211: use monitor sdata with driver
 only if desired
To: Johannes Berg <johannes@sipsolutions.net>
Cc: stable@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20240725184836.25d334157a8e.I02574086da2c5cf0e18264ce5807db6f14ffd9c0@changeid>
Content-Language: de-DE, en-US
From: ZeroBeat <ZeroBeat@gmx.de>
In-Reply-To: <20240725184836.25d334157a8e.I02574086da2c5cf0e18264ce5807db6f14ffd9c0@changeid>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------dYvsfvvmg4SnJjeVLDvG2VYZ"
X-Provags-ID: V03:K1:33X4TZ74RGHbrBJWfScbS5gWxrdvH/Bg/8p5bpSsPL+eg6ini/j
 mmeV13TtaL/5+ZC3QphMc63TuCO6go4js/yQCIzjt3Dq+QOuh2vLytDA/LWhs0hvJnwufXs
 ks1v5dwSN0PmEsz9f9Ei8nUTOnRNeuZCk6uM3FQIFpVbZqqZHQicRXqJnh3WofPeOcvOhCS
 MyyLM2nEdxkixa+Dfi72A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b9Lu4/x1kD8=;7eC49EQ5J1DvyWkpqAlaKMmxkAL
 h8fvPNcs25NdqVThFHRlrDBCP2O/4ciIUPz2bWqSaYckb9uoV46MkZtodKNwNN+MYORC4BkTh
 Sou4eBljDRfpsu9reberF56Ry5+WChZmIqeZr05RuMkUSplAYHCpLYh5CruUHwC93bNmExh1A
 AdGvTs18HOkUYkgEOl/r0yRLydImeYVdAb2VovXVjWsu/RgfOMEEj2t/qRDR/94xMEJV7n1rK
 ig7frALCJsa5KTGYMRY5wG/6DeUw8XwqJ73fpnijDIFLeIUzFPKMrWoO6v3nqOvzC3pyAkOHJ
 49uGzGmSkgmZK3WAFML8T40N3lK4/qUmJCExz4bvV/cnHu2DeN4FlHBMfwPUA/W0oSWaiNQWt
 5bGAz0DNRIded2Vn+j9f5GlVKcexHWulI73vXwh3hS3WYFnVd1b+9cuhOIuWvfkTLOUCgBbCF
 A5JSp2lviHyqmpqfDFJmvwQc0uRlZfNRQbWBBaaXLtdhQgu+TPc/qy7ph9Sp2xZ7pNvtP+P3i
 OTpJ0O8DBE2OjZiTit9+bzV2McAKSj4zLm/dx1DzFof/l856S56EWOEho2K8iR9T0SGYgOWM2
 Y42pKCdJxgOO7i5gB5tujLnAUkpI24WXjsGeI3B9v1UdjJjf+7I12eWYJsH/VNQLJz0RklQLY
 pUH6MsKW9zXFCKJ4ztenmUB7CR4vlqBjinh1v5IAeMaSwEGDtRtQsAy9cpPzKOVR3mcE0w7fj
 dcUInPz8IZZTMVkOk+04vFRbwLYd97hDWyWhP6WZ8OVzS6QR+GKca/lf+pIU/G+0O5BSutF2A
 pjMFP9i/Wbs7jBkYLcx5vgmw==

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------dYvsfvvmg4SnJjeVLDvG2VYZ
Content-Type: multipart/mixed; boundary="------------0FdCJ7AjhiC4fd0f0jBm4NNx";
 protected-headers="v1"
From: ZeroBeat <ZeroBeat@gmx.de>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: stable@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Message-ID: <bfe10f6c-ccbc-47f5-b1d2-91dbd55ba434@gmx.de>
Subject: Re: [PATCH wireless] wifi: mac80211: use monitor sdata with driver
 only if desired
References: <20240725184836.25d334157a8e.I02574086da2c5cf0e18264ce5807db6f14ffd9c0@changeid>
In-Reply-To: <20240725184836.25d334157a8e.I02574086da2c5cf0e18264ce5807db6f14ffd9c0@changeid>

--------------0FdCJ7AjhiC4fd0f0jBm4NNx
Content-Type: multipart/mixed; boundary="------------tBkIRvkH1CPHo1oIAaUgaX0Y"

--------------tBkIRvkH1CPHo1oIAaUgaX0Y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

R3JlYXQgd29yay4gVGhhbmtzLg0KDQokIHVuYW1lIC1yDQo2LjEwLjAtMS1naXQtMTIyNDYt
Zzc4NmM4MjQ4ZGJkMy1kaXJ0eQ0KDQokIHN1ZG8gaGN4ZHVtcHRvb2wgLWkgd2xwNXMwZjR1
MiAtLXJjYXNjYW49YWN0aXZlDQoNCl5DDQoyNCBQYWNrZXQocykgY2FwdHVyZWQgYnkga2Vy
bmVsDQowIFBhY2tldChzKSBkcm9wcGVkIGJ5IGtlcm5lbA0KMTQgUFJPQkVSRVNQT05TRShz
KSBjYXB0dXJlZA0KDQoNCkJlc3QgcmVnYXJkcw0KTWljaGFlbA0KDQoNCg0KQW0gMjUuMDcu
MjQgdW0gMTg6NDggc2NocmllYiBKb2hhbm5lcyBCZXJnOg0KPiBGcm9tOiBKb2hhbm5lcyBC
ZXJnIDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT4NCj4gDQo+IEluIGNvbW1pdCAwZDljMmJl
ZWQxMTYgKCJ3aWZpOiBtYWM4MDIxMTogZml4IG1vbml0b3IgY2hhbm5lbA0KPiB3aXRoIGNo
YW5jdHggZW11bGF0aW9uIikgSSBjaGFuZ2VkIG1hYzgwMjExIHRvIGFsd2F5cyBoYXZlIGFu
DQo+IGludGVybmFsIG1vbml0b3Jfc2RhdGEgdG8gaGF2ZSBzb21ldGhpbmcgdG8gaGF2ZSB0
aGUgY2hhbmN0eA0KPiBib3VuZCB0by4NCj4gDQo+IEhvd2V2ZXIsIGlmIHRoZSBkcml2ZXIg
ZGlkbid0IGFsc28gaGF2ZSB0aGUgV0FOVF9NT05JVE9SIGZsYWcNCj4gdGhpcyB3b3VsZCBj
YXVzZSBtYWM4MDIxMSB0byBhbGxvY2F0ZSBpdCB3aXRob3V0IHRlbGxpbmcgdGhlDQo+IGRy
aXZlciAod2hpY2ggd2FzIGludGVudGlvbmFsKSBidXQgYWxzbyB1c2UgaXQgZm9yIGxhdGVy
IEFQSXMNCj4gdG8gdGhlIGRyaXZlciB3aXRob3V0IGl0IGV2ZXIgaGF2aW5nIGtub3duIGFi
b3V0IGl0IHdoaWNoIHdhcw0KPiBfbm90XyBpbnRlbnRpb25hbC4NCj4gDQo+IENoZWNrIHRo
cm91Z2ggdGhlIGNvZGUgYW5kIG9ubHkgdXNlIHRoZSBtb25pdG9yX3NkYXRhIGluIHRoZQ0K
PiByZWxldmFudCBwbGFjZXMgKFRYLCBNVS1NSU1PIGZvbGxvdyBzZXR0aW5ncywgVFggcG93
ZXIsIGFuZA0KPiBpbnRlcmZhY2UgaXRlcmF0aW9uKSB3aGVuIHRoZSBXQU5UX01PTklUT1Ig
ZmxhZyBpcyBzZXQuDQo+IA0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBGaXhl
czogMGQ5YzJiZWVkMTE2ICgid2lmaTogbWFjODAyMTE6IGZpeCBtb25pdG9yIGNoYW5uZWwg
d2l0aCBjaGFuY3R4IGVtdWxhdGlvbiIpDQo+IFJlcG9ydGVkLWJ5OiBaZXJvQmVhdCA8WmVy
b0JlYXRAZ214LmRlPg0KPiBDbG9zZXM6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9z
aG93X2J1Zy5jZ2k/aWQ9MjE5MDg2DQo+IFRlc3RlZC1ieTogTG9yZW56byBCaWFuY29uaSA8
bG9yZW56b0BrZXJuZWwub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBCZXJnIDxq
b2hhbm5lcy5iZXJnQGludGVsLmNvbT4NCj4gLS0tDQo+ICAgbmV0L21hYzgwMjExL2NmZy5j
ICB8IDcgKysrKystLQ0KPiAgIG5ldC9tYWM4MDIxMS90eC5jICAgfCA1ICsrKy0tDQo+ICAg
bmV0L21hYzgwMjExL3V0aWwuYyB8IDIgKy0NCj4gICAzIGZpbGVzIGNoYW5nZWQsIDkgaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvbWFj
ODAyMTEvY2ZnLmMgYi9uZXQvbWFjODAyMTEvY2ZnLmMNCj4gaW5kZXggODVjYjcxZGUzNzBm
Li5iMDJiODRjZTIxMzAgMTAwNjQ0DQo+IC0tLSBhL25ldC9tYWM4MDIxMS9jZmcuYw0KPiAr
KysgYi9uZXQvbWFjODAyMTEvY2ZnLmMNCj4gQEAgLTExNCw3ICsxMTQsNyBAQCBzdGF0aWMg
aW50IGllZWU4MDIxMV9zZXRfbW9uX29wdGlvbnMoc3RydWN0IGllZWU4MDIxMV9zdWJfaWZf
ZGF0YSAqc2RhdGEsDQo+ICAgDQo+ICAgCS8qIGFwcGx5IGFsbCBjaGFuZ2VzIG5vdyAtIG5v
IGZhaWx1cmVzIGFsbG93ZWQgKi8NCj4gICANCj4gLQlpZiAobW9uaXRvcl9zZGF0YSkNCj4g
KwlpZiAobW9uaXRvcl9zZGF0YSAmJiBpZWVlODAyMTFfaHdfY2hlY2soJmxvY2FsLT5odywg
V0FOVF9NT05JVE9SX1ZJRikpDQo+ICAgCQlpZWVlODAyMTFfc2V0X211X21pbW9fZm9sbG93
KG1vbml0b3Jfc2RhdGEsIHBhcmFtcyk7DQo+ICAgDQo+ICAgCWlmIChwYXJhbXMtPmZsYWdz
KSB7DQo+IEBAIC0zMDUzLDYgKzMwNTMsOSBAQCBzdGF0aWMgaW50IGllZWU4MDIxMV9zZXRf
dHhfcG93ZXIoc3RydWN0IHdpcGh5ICp3aXBoeSwNCj4gICAJCXNkYXRhID0gSUVFRTgwMjEx
X1dERVZfVE9fU1VCX0lGKHdkZXYpOw0KPiAgIA0KPiAgIAkJaWYgKHNkYXRhLT52aWYudHlw
ZSA9PSBOTDgwMjExX0lGVFlQRV9NT05JVE9SKSB7DQo+ICsJCQlpZiAoIWllZWU4MDIxMV9o
d19jaGVjaygmbG9jYWwtPmh3LCBXQU5UX01PTklUT1JfVklGKSkNCj4gKwkJCQlyZXR1cm4g
LUVPUE5PVFNVUFA7DQo+ICsNCj4gICAJCQlzZGF0YSA9IHdpcGh5X2RlcmVmZXJlbmNlKGxv
Y2FsLT5ody53aXBoeSwNCj4gICAJCQkJCQkgIGxvY2FsLT5tb25pdG9yX3NkYXRhKTsNCj4g
ICAJCQlpZiAoIXNkYXRhKQ0KPiBAQCAtMzExNSw3ICszMTE4LDcgQEAgc3RhdGljIGludCBp
ZWVlODAyMTFfc2V0X3R4X3Bvd2VyKHN0cnVjdCB3aXBoeSAqd2lwaHksDQo+ICAgCWlmICho
YXNfbW9uaXRvcikgew0KPiAgIAkJc2RhdGEgPSB3aXBoeV9kZXJlZmVyZW5jZShsb2NhbC0+
aHcud2lwaHksDQo+ICAgCQkJCQkgIGxvY2FsLT5tb25pdG9yX3NkYXRhKTsNCj4gLQkJaWYg
KHNkYXRhKSB7DQo+ICsJCWlmIChzZGF0YSAmJiBpZWVlODAyMTFfaHdfY2hlY2soJmxvY2Fs
LT5odywgV0FOVF9NT05JVE9SX1ZJRikpIHsNCj4gICAJCQlzZGF0YS0+ZGVmbGluay51c2Vy
X3Bvd2VyX2xldmVsID0gbG9jYWwtPnVzZXJfcG93ZXJfbGV2ZWw7DQo+ICAgCQkJaWYgKHR4
cF90eXBlICE9IHNkYXRhLT52aWYuYnNzX2NvbmYudHhwb3dlcl90eXBlKQ0KPiAgIAkJCQl1
cGRhdGVfdHhwX3R5cGUgPSB0cnVlOw0KPiBkaWZmIC0tZ2l0IGEvbmV0L21hYzgwMjExL3R4
LmMgYi9uZXQvbWFjODAyMTEvdHguYw0KPiBpbmRleCA3MmE5YmE4YmM1ZmQuLmVkYmE0YTMx
ODQ0ZiAxMDA2NDQNCj4gLS0tIGEvbmV0L21hYzgwMjExL3R4LmMNCj4gKysrIGIvbmV0L21h
YzgwMjExL3R4LmMNCj4gQEAgLTE3NjgsNyArMTc2OCw3IEBAIHN0YXRpYyBib29sIF9faWVl
ZTgwMjExX3R4KHN0cnVjdCBpZWVlODAyMTFfbG9jYWwgKmxvY2FsLA0KPiAgIAkJCWJyZWFr
Ow0KPiAgIAkJfQ0KPiAgIAkJc2RhdGEgPSByY3VfZGVyZWZlcmVuY2UobG9jYWwtPm1vbml0
b3Jfc2RhdGEpOw0KPiAtCQlpZiAoc2RhdGEpIHsNCj4gKwkJaWYgKHNkYXRhICYmIGllZWU4
MDIxMV9od19jaGVjaygmbG9jYWwtPmh3LCBXQU5UX01PTklUT1JfVklGKSkgew0KPiAgIAkJ
CXZpZiA9ICZzZGF0YS0+dmlmOw0KPiAgIAkJCWluZm8tPmh3X3F1ZXVlID0NCj4gICAJCQkJ
dmlmLT5od19xdWV1ZVtza2JfZ2V0X3F1ZXVlX21hcHBpbmcoc2tiKV07DQo+IEBAIC0zOTU3
LDcgKzM5NTcsOCBAQCBzdHJ1Y3Qgc2tfYnVmZiAqaWVlZTgwMjExX3R4X2RlcXVldWUoc3Ry
dWN0IGllZWU4MDIxMV9odyAqaHcsDQo+ICAgCQkJYnJlYWs7DQo+ICAgCQl9DQo+ICAgCQl0
eC5zZGF0YSA9IHJjdV9kZXJlZmVyZW5jZShsb2NhbC0+bW9uaXRvcl9zZGF0YSk7DQo+IC0J
CWlmICh0eC5zZGF0YSkgew0KPiArCQlpZiAodHguc2RhdGEgJiYNCj4gKwkJICAgIGllZWU4
MDIxMV9od19jaGVjaygmbG9jYWwtPmh3LCBXQU5UX01PTklUT1JfVklGKSkgew0KPiAgIAkJ
CXZpZiA9ICZ0eC5zZGF0YS0+dmlmOw0KPiAgIAkJCWluZm8tPmh3X3F1ZXVlID0NCj4gICAJ
CQkJdmlmLT5od19xdWV1ZVtza2JfZ2V0X3F1ZXVlX21hcHBpbmcoc2tiKV07DQo+IGRpZmYg
LS1naXQgYS9uZXQvbWFjODAyMTEvdXRpbC5jIGIvbmV0L21hYzgwMjExL3V0aWwuYw0KPiBp
bmRleCBjZWQxOWNlN2M1MWEuLmM3YWQ5YmM1OTczYSAxMDA2NDQNCj4gLS0tIGEvbmV0L21h
YzgwMjExL3V0aWwuYw0KPiArKysgYi9uZXQvbWFjODAyMTEvdXRpbC5jDQo+IEBAIC03NzYs
NyArNzc2LDcgQEAgc3RhdGljIHZvaWQgX19pdGVyYXRlX2ludGVyZmFjZXMoc3RydWN0IGll
ZWU4MDIxMV9sb2NhbCAqbG9jYWwsDQo+ICAgCXNkYXRhID0gcmN1X2RlcmVmZXJlbmNlX2No
ZWNrKGxvY2FsLT5tb25pdG9yX3NkYXRhLA0KPiAgIAkJCQkgICAgICBsb2NrZGVwX2lzX2hl
bGQoJmxvY2FsLT5pZmxpc3RfbXR4KSB8fA0KPiAgIAkJCQkgICAgICBsb2NrZGVwX2lzX2hl
bGQoJmxvY2FsLT5ody53aXBoeS0+bXR4KSk7DQo+IC0JaWYgKHNkYXRhICYmDQo+ICsJaWYg
KHNkYXRhICYmIGllZWU4MDIxMV9od19jaGVjaygmbG9jYWwtPmh3LCBXQU5UX01PTklUT1Jf
VklGKSAmJg0KPiAgIAkgICAgKGl0ZXJfZmxhZ3MgJiBJRUVFODAyMTFfSUZBQ0VfSVRFUl9S
RVNVTUVfQUxMIHx8ICFhY3RpdmVfb25seSB8fA0KPiAgIAkgICAgIHNkYXRhLT5mbGFncyAm
IElFRUU4MDIxMV9TREFUQV9JTl9EUklWRVIpKQ0KPiAgIAkJaXRlcmF0b3IoZGF0YSwgc2Rh
dGEtPnZpZi5hZGRyLCAmc2RhdGEtPnZpZik7DQo=
--------------tBkIRvkH1CPHo1oIAaUgaX0Y
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

--------------tBkIRvkH1CPHo1oIAaUgaX0Y--

--------------0FdCJ7AjhiC4fd0f0jBm4NNx--

--------------dYvsfvvmg4SnJjeVLDvG2VYZ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEWSDOHFZ5SK/SwKm3N1UWpF24hjAFAmaijnQFAwAAAAAACgkQN1UWpF24hjDx
7wf/cGaWBgYj0u717ed9gUryWczAbrDu3LeqMfAuJyrYjKLZ6Qypiyu5F1sN9Kbtgx+5wTw/T4qT
zrGwrdr7TtnG+VS4Mu8OVTg/vOojMeXKpjZg9OFklj6iK00/pXYfeGmeQjQomSU/BfI4SkEUYVsK
0noQrVAbjnAW/LRMWkswBHkev4vjKp7987ufhT7pjCEkNgUMKgIR16+06K2SGLlo/6qZYt5N/3vg
vlOC8lLV/GWJo8WAeiULpCtcX6rEFKjurULdsx50bNDiTQxhyHLvn4jzHxzDTOW8SoKJEeT5mj16
BN6An1+G0e7hMnBlqyZAaSa4sdgeIPgHAO6wt5z5gg==
=osLf
-----END PGP SIGNATURE-----

--------------dYvsfvvmg4SnJjeVLDvG2VYZ--

