Return-Path: <linux-wireless+bounces-35010-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMyQIyW65WmwnQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35010-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 07:31:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5711426DFC
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 07:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9114D30067BC
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4A82628D;
	Mon, 20 Apr 2026 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="KM0K5GjM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A365B40DFC4
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 05:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776663074; cv=none; b=kJwSuCiyEpHPp/uxapfZkUnFhwT/lBZKPuodojs2OFGgnS+jqVIwWX/JI4gsmoYvrAjmQhnlwET1iTzJX6K9Ehwla8qfca8rtPWUofszszfdoDgCZf8N0mAflvpkpEo112v268o1y96j7BtLL8dXFnrltcWkOgyBEw0jVZMyhis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776663074; c=relaxed/simple;
	bh=uzMWsio8EqfZo8FMEEz5C7ZBXJ8ZgzGbwXsGsK0fSBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b437d0ug0gq8lmiIMmy0rZuVvmMn2mGarK+RnFd+QDVwX2u+vDJ9ER1Tie99K4vBXvBIgKXhdc8TzXDGg/z3dfuzno0Y47+dfpEsCyoTOQNCODjBE7d7NlvZ2IfZ+tCcoZ8Veu6AFDLeMB+mfObvIYK/Ve3Y2VjgiNalTq/h/Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=KM0K5GjM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K5V3S10589524, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776663063; bh=uzMWsio8EqfZo8FMEEz5C7ZBXJ8ZgzGbwXsGsK0fSBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=KM0K5GjMig17hQiStw0kew94ihw8vn+pLIUfl2s+QcrgmhJ3aEZFcFSZ5xxEjszMv
	 Xo7jgK7lllhUzY+gT6rSbuyYjqvgL553yqvO731QcA/ySJQOQ6/Fc7pgnwy389h/yp
	 MRuQVmGovdjLg/lepuBFx3cVKLTNWEvJtJKe+Eb49mfzqvfo0cenUnA3Z9UJQqShv+
	 J4uOx/y+1YsADRnSMe+71jMusy1v4ZzBAgovW0xpVxiZ/PjTZn3kqrT+PA5SeOU4Zx
	 qCMkIL9keTElv9o2SckgZ1g591SVysFFGpgdzqvQfQmQ4NIx7Re3rOYc+1xUmUbGPq
	 pLOhoAqZdrW2Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K5V3S10589524
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 13:31:03 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 13:31:03 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Mon, 20 Apr 2026 13:31:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Tristan Madani
	<tristmd@gmail.com>
CC: Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: rtw88: fix OOB read from firmware RX descriptor
 exceeding DMA buffer
Thread-Topic: [PATCH v2] wifi: rtw88: fix OOB read from firmware RX descriptor
 exceeding DMA buffer
Thread-Index: AQHczSaqhBvUmo6aWEamddJNumcqzLXi2VmAgASYQWA=
Date: Mon, 20 Apr 2026 05:31:02 +0000
Message-ID: <e4f18297feda4056bb461b6b2516b27c@realtek.com>
References: <20260415222440.1545959-1-tristmd@gmail.com>
 <090b3c83-e3d5-4c8d-bd46-aaff692de529@gmail.com>
In-Reply-To: <090b3c83-e3d5-4c8d-bd46-aaff692de529@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35010-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: E5711426DFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
T24gMTYvMDQvMjAyNiAwMToyNCwgVHJpc3RhbiBNYWRhbmkgd3JvdGU6DQo+ID4gRnJvbTogVHJp
c3RhbiBNYWRhbmkgPHRyaXN0YW5AdGFsZW5jZXNlY3VyaXR5LmNvbT4NCj4gPg0KPiA+IEluIHJ0
d19wY2lfcnhfbmFwaSgpLCBuZXdfbGVuIGlzIGNvbXB1dGVkIGFzIHRoZSBzdW0gb2YgcGt0X2xl
biAoMTQtYml0DQo+ID4gZGVzY3JpcHRvciBmaWVsZCwgbWF4IDE2MzgzKSBhbmQgcGt0X29mZnNl
dCAoZHJ2X2luZm9fc3ogKyBzaGlmdCwgYm90aA0KPiA+IGZpcm13YXJlLWNvbnRyb2xsZWQpLiBU
aGUgcmVzdWx0IGNhbiBleGNlZWQgUlRLX1BDSV9SWF9CVUZfU0laRSAoMTE0NzgpLA0KPiA+IGNh
dXNpbmcgYW4gb3V0LW9mLWJvdW5kcyByZWFkIGZyb20gdGhlIHByZS1hbGxvY2F0ZWQgRE1BIGJ1
ZmZlciB3aGVuDQo+ID4gc2tiX3B1dF9kYXRhIGNvcGllcyBuZXdfbGVuIGJ5dGVzLiBUaGUgVVNC
IHRyYW5zcG9ydCBhbHJlYWR5IHZhbGlkYXRlcw0KPiA+IHRoaXMgKHJ0d191c2JfcnhfZGF0YV9w
dXQgY2hlY2tzIGFnYWluc3QgUlRXX1VTQl9NQVhfUkVDVkJVRl9TWik7IHRoZQ0KPiA+IFBDSWUg
cGF0aCBkb2VzIG5vdC4NCj4gPg0KPiA+IEFkZCBhIGNoZWNrIHRoYXQgbmV3X2xlbiBkb2VzIG5v
dCBleGNlZWQgdGhlIERNQSBidWZmZXIgc2l6ZS4NCj4gPg0KPiA+IEZpeGVzOiBlMzAzNzQ4NWM2
OGUgKCJydHc4ODogbmV3IFJlYWx0ZWsgODAyLjExYWMgZHJpdmVyIikNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBUcmlzdGFuIE1hZGFuaSA8dHJpc3RhbkB0YWxlbmNlc2VjdXJpdHkuY29tPg0KPiA+IC0t
LQ0KPiA+IE5vdGU6IHYyIHJlc3VibWlzc2lvbiAtLSBvcmlnaW5hbCBzZW50IHZpYSBHbWFpbCBo
YWQgSFRNTCByZW5kZXJpbmcNCj4gPiBpc3N1ZXMuIFRoaXMgdmVyc2lvbiB1c2VzIGdpdCBzZW5k
LWVtYWlsIGZvciBwbGFpbi10ZXh0IGZvcm1hdHRpbmcuDQo+ID4NCj4gPiBDaGFuZ2VzIGluIHYy
Og0KPiA+ICAgLSB2MjogY2xhcmlmeSBmaWVsZCB3aWR0aHMgYW5kIG1heGltdW0gbmV3X2xlbiBk
ZXJpdmF0aW9uIGluIGNvbW1pdA0KPiA+ICAgICBtZXNzYWdlLCBwZXIgUGluZy1LZSBTaGloJ3Mg
ZmVlZGJhY2suDQo+ID4NCj4gPiBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3Bj
aS5jIHwgNSArKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9wY2ku
YyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcGNpLmMNCj4gPiBpbmRleCBY
WFhYWFhYLi5YWFhYWFhYIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODgvcGNpLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0dzg4L3BjaS5jDQo+ID4gQEAgLTEwNzgsNiArMTA3OCwxMSBAQCBzdGF0aWMgaW50IHJ0d19w
Y2lfcnhfbmFwaShzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LCBzdHJ1Y3QgcnR3X3BjaSAqcnR3cGNp
LA0KPiA+ICAgICAgICAgICAgICAgbmV3X2xlbiA9IHBrdF9zdGF0LnBrdF9sZW4gKyBwa3Rfb2Zm
c2V0Ow0KPiA+ICsgICAgICAgICAgICAgaWYgKG5ld19sZW4gPiBSVEtfUENJX1JYX0JVRl9TSVpF
KSB7DQoNClNpbmNlIHRoaXMgaXMgZGF0YSAoaG90KSBwYXRoLCBJJ2QgcHJlZmVyIHVubGlrZWx5
KG5ld19sZW4gPiBSVEtfUENJX1JYX0JVRl9TSVpFKS4NCg0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICBydHdfZGJnKHJ0d2RldiwgUlRXX0RCR19SWCwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAib3ZlcnNpemVkIFJYIHBhY2tldDogJXVcbiIsIG5ld19sZW4pOw0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICBnb3RvIG5leHRfcnA7DQo+ID4gKyAgICAgICAgICAgICB9DQo+
ID4gICAgICAgICAgICAgICBuZXcgPSBkZXZfYWxsb2Nfc2tiKG5ld19sZW4pOw0KPiA+ICAgICAg
ICAgICAgICAgaWYgKFdBUk5fT05DRSghbmV3LCAicnggcm91dGluZSBzdGFydmF0aW9uXG4iKSkN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgZ290byBuZXh0X3JwOw0KPiA+DQo+ID4NCj4gDQo+
IEknbSB3b3JraW5nIG9uIGEgcGF0Y2ggd2hpY2ggd2lsbCBpbXBsZW1lbnQgdGhlIHNhbWUgdmFs
aWRhdGlvbg0KPiBpbiBydHdfcnhfcXVlcnlfcnhfZGVzYygpLCBhbG9uZyB3aXRoIHR3byBvdGhl
ciBjaGVja3MuIEkgZ290IGENCj4gcmVwb3J0IGFib3V0IHRvbyBzaG9ydCBwYWNrZXRzIGZyb20g
UlRMODgxNEFVLCBzbyBVU0IgZGV2aWNlcw0KPiBjYW4gYWxzbyBiZW5lZml0IGZyb20gY2hlY2tp
bmcgcGt0X2xlbi4gSXQgd2lsbCBtYWtlIHRoaXMgcGF0Y2gNCj4gcmVkdW5kYW50Lg0KDQpCaXR0
ZXJibHVlLCBpZiB5b3UgY2FuIHRha2UgdGhlIGNoYW5nZSBvZiB0aGlzIHBhdGNoIGludG8geW91
cg0KcGF0Y2gsIEknZCBza2lwIHRoaXMgcGF0Y2guIFBsZWFzZSBsZXQgbWUga25vdyB5b3VyIHRo
b3VnaHQuDQoNCj4gDQo+IFdlbGwsIGtpbmQgb2YuIE1heWJlIFJUS19QQ0lfUlhfQlVGX1NJWkUg
aXMgdG9vIHNtYWxsPyAxMTQ1NCArIDI0DQo+IGRvZXNuJ3QgdGFrZSBpbnRvIGFjY291bnQgdGhl
IFBIWSBpbmZvIHNpemUuDQoNCkluIHJ0d19wY2lfc3luY19yeF9kZXNjX2RldmljZSgpLCBkcml2
ZXIgZG9lcw0KICAgIGJ1Zl9kZXNjLT5idWZfc2l6ZSA9IGNwdV90b19sZTE2KFJUS19QQ0lfUlhf
QlVGX1NJWkUpOw0KDQpUaGlzIGlzIHRvIHRlbGwgaGFyZHdhcmUgdGhlIHNpemUgb2YgUlggRE1B
IGJ1ZmZlci4gSSB0aGluayBoYXJkd2FyZQ0KY2FuJ3QgRE1BIGRhdGEgb3ZlciB0aGlzIHNpemUu
DQoNClBpbmctS2UNCg0K

