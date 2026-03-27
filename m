Return-Path: <linux-wireless+bounces-34029-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL+jGpskxmnQGwUAu9opvQ
	(envelope-from <linux-wireless+bounces-34029-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 07:32:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3A533FC5C
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 07:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5FEF30DB3D6
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 06:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D19392C5A;
	Fri, 27 Mar 2026 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="SW8/fnHA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD53A7F64
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 06:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774592637; cv=none; b=EtzfVPd/+oK0yi6fUVj4/YpMo90SLMsqDyhre98YksZD7hQphosChziyS+1T5gzq/8ResaIZUPDBiGDA4Kcy9uI79ztB0Z/Jg4x7sw6g5ZJvwUOjI4jvUDrePUgf7PBNYsE/YHx82C1LRjfeWpwhCmNXb/SqssHu2nwP3LxWM0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774592637; c=relaxed/simple;
	bh=u/5rpAuyh1/y7yyOUaht7ZpD09IZBOW9EaMJrBdlPNo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fQqHXJe22vvgnBhhmjZFf/ZaxOGtDfAffS+C0MeOQuhfWERpu7Rz55kMmQ0/8gkLblkIVNdLzSRGbWZsCEIOFobbVT7EsVkskknri9/9NvoABSA1ADWVEYGF5lctX1F9tYywg3oZZbc42oLppe0kWImIbFds5EFRki2AKGWOq/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=SW8/fnHA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62R6NigjE3201134, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774592624; bh=u/5rpAuyh1/y7yyOUaht7ZpD09IZBOW9EaMJrBdlPNo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=SW8/fnHARTIvPiXSdHd4UPZojFYBFWhE5kzXY0Y0JAg60LlrWZOJtPGGFobuEROI0
	 9V7SHn5113KztmJulafjKb0opuwFQKTaCio1RN+GmxpsFd1H73jCyrHrWXogh42Qfv
	 2Nwp+IvgO1NUZQ9Rv7ux/L/vVmsnpRhJmHoYaPErHOtaks6Wr4Dw5SYmW1DRxD8bqY
	 NT1vCBGPqLDer792VBPSPc5SwdsMzgAr2l2WunYFVWqRiXGl7mGunKYlNogAxa9FJl
	 gJuDD1/7ayQt7j5oZS7FFMGYJ16jOSM2lC5Dl69O4dLiTwveAPQHJvnnCqm8Fr60YX
	 r0CjmmVFVy5jg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62R6NigjE3201134
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 14:23:44 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 27 Mar 2026 14:23:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 27 Mar 2026 14:23:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::46e9:fab9:b2cf:c99b%10]) with mapi id
 15.02.1748.010; Fri, 27 Mar 2026 14:23:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2] wifi: rtw88: Fill fw_version member of struct
 wiphy
Thread-Topic: [PATCH rtw-next v2] wifi: rtw88: Fill fw_version member of
 struct wiphy
Thread-Index: AQHcvTQ2Po6dETgIAkqhsZ4PtASoh7XBAE+AgADoF0A=
Date: Fri, 27 Mar 2026 06:23:39 +0000
Message-ID: <4aa63ec1d1b74b7b83d1823844062885@realtek.com>
References: <3701cce1-42c4-4382-9120-cd21012c1b21@gmail.com>
 <2c90c306-f285-4ea7-b795-37a0f14ec27b@oss.qualcomm.com>
In-Reply-To: <2c90c306-f285-4ea7-b795-37a0f14ec27b@oss.qualcomm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34029-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:mid];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BA3A533FC5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQpKZWZmIEpvaG5zb24gPGplZmYuam9obnNvbkBvc3MucXVhbGNvbW0uY29tPiB3cm90ZToNCj4g
DQo+IE9uIDMvMjYvMjAyNiA4OjIxIEFNLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3RlOg0KPiA+IExl
dCB1c2Vyc3BhY2UgdG9vbHMgbGlrZSBsc2h3IHNob3cgdGhlIGZpcm13YXJlIHZlcnNpb24gYnkg
ZmlsbGluZyB0aGUNCj4gPiBmd192ZXJzaW9uIG1lbWJlciBvZiBzdHJ1Y3Qgd2lwaHkuDQo+ID4N
Cj4gPiBCZWZvcmU6DQo+ID4NCj4gPiBjb25maWd1cmF0aW9uOiBicm9hZGNhc3Q9eWVzIGRyaXZl
cj1ydHc4OF84ODE0YXUNCj4gPiBkcml2ZXJ2ZXJzaW9uPTYuMTkuNi1hcmNoMS0xIGZpcm13YXJl
PU4vQSBsaW5rPW5vIG11bHRpY2FzdD15ZXMNCj4gPiB3aXJlbGVzcz1JRUVFIDgwMi4xMQ0KPiA+
DQo+ID4gQWZ0ZXI6DQo+ID4NCj4gPiBjb25maWd1cmF0aW9uOiBicm9hZGNhc3Q9eWVzIGRyaXZl
cj1ydHc4OF84ODE0YXUNCj4gPiBkcml2ZXJ2ZXJzaW9uPTYuMTkuNi1hcmNoMS0xIGZpcm13YXJl
PTMzLjYuMCBsaW5rPW5vIG11bHRpY2FzdD15ZXMNCj4gPiB3aXJlbGVzcz1JRUVFIDgwMi4xMQ0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBn
bWFpbC5jb20+DQo+ID4gLS0tDQo+ID4gdjI6DQo+ID4gIC0gVXNlIGxvY2FsIHdpcGh5IHZhcmlh
YmxlLg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21h
aW4uYyB8IDYgKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21h
aW4uYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFpbi5jDQo+ID4g
aW5kZXggYzRmOTc1OGI0ZTk2Li5jZDkyNTQzNzBmY2MgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWluLmMNCj4gPiArKysgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21haW4uYw0KPiA+IEBAIC0xODA1LDYgKzE4MDUsNyBA
QCBzdGF0aWMgdm9pZCBydHdfbG9hZF9maXJtd2FyZV9jYihjb25zdCBzdHJ1Y3QgZmlybXdhcmUN
Cj4gKmZpcm13YXJlLCB2b2lkICpjb250ZXh0KQ0KPiA+ICB7DQo+ID4gICAgICAgc3RydWN0IHJ0
d19md19zdGF0ZSAqZncgPSBjb250ZXh0Ow0KPiA+ICAgICAgIHN0cnVjdCBydHdfZGV2ICpydHdk
ZXYgPSBmdy0+cnR3ZGV2Ow0KPiA+ICsgICAgIHN0cnVjdCB3aXBoeSAqd2lwaHkgPSBydHdkZXYt
Pmh3LT53aXBoeTsNCj4gPg0KPiA+ICAgICAgIGlmICghZmlybXdhcmUgfHwgIWZpcm13YXJlLT5k
YXRhKSB7DQo+ID4gICAgICAgICAgICAgICBydHdfZXJyKHJ0d2RldiwgImZhaWxlZCB0byByZXF1
ZXN0IGZpcm13YXJlXG4iKTsNCj4gPiBAQCAtMTgxOSw2ICsxODIwLDExIEBAIHN0YXRpYyB2b2lk
IHJ0d19sb2FkX2Zpcm13YXJlX2NiKGNvbnN0IHN0cnVjdCBmaXJtd2FyZQ0KPiAqZmlybXdhcmUs
IHZvaWQgKmNvbnRleHQpDQo+ID4gICAgICAgcnR3X2luZm8ocnR3ZGV2LCAiJXNGaXJtd2FyZSB2
ZXJzaW9uICV1LiV1LiV1LCBIMkMgdmVyc2lvbiAldVxuIiwNCj4gPiAgICAgICAgICAgICAgICBm
dy0+dHlwZSA9PSBSVFdfV09XTEFOX0ZXID8gIldPVyAiIDogIiIsDQo+ID4gICAgICAgICAgICAg
ICAgZnctPnZlcnNpb24sIGZ3LT5zdWJfdmVyc2lvbiwgZnctPnN1Yl9pbmRleCwNCj4gZnctPmgy
Y192ZXJzaW9uKTsNCj4gPiArDQo+ID4gKyAgICAgaWYgKGZ3LT50eXBlID09IFJUV19OT1JNQUxf
RlcpDQo+ID4gKyAgICAgICAgICAgICBzbnByaW50Zih3aXBoeS0+ZndfdmVyc2lvbiwgc2l6ZW9m
KHdpcGh5LT5md192ZXJzaW9uKSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICIldS4ldS4l
dSIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICBmdy0+dmVyc2lvbiwgZnctPnN1Yl92ZXJz
aW9uLCBmdy0+c3ViX2luZGV4KTsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBpbnQgcnR3X2xv
YWRfZmlybXdhcmUoc3RydWN0IHJ0d19kZXYgKnJ0d2RldiwgZW51bSBydHdfZndfdHlwZSB0eXBl
KQ0KPiANCj4gZ2VuZXJpY2FsbHkgc3BlYWtpbmcgaG93IHVzZWZ1bCBpcyB0aGlzPw0KPiB3aXRo
IE1MTyBhbmQgbXVsdGktcmFkaW8gd2lwaHkgdGhlcmUgY2FuIGJlIG11bHRpcGxlIHVuZGVybHlp
bmcgaGFyZHdhcmUgd2l0aA0KPiBkaWZmZXJlbnQgZmlybXdhcmUgdmVyc2lvbnMuIGluIHJlY2Vu
dCBhdGggZHJpdmVycyB3ZSBhcmUgbm90IGZpbGxpbmcgdGhpcy4NCg0KVGhhbmtzIGZvciB0aGUg
aW5mby4NCg0KUmVhbHRlayBXaUZpIGhhcyBzaW5nbGUgb25lIGZpcm13YXJlIHZlcnNpb24sIEkn
ZCBjaGVjayBmaXJtd2FyZSB2ZXJzaW9uIGJ5DQprZXJuZWwgbG9nIHBlcnNvbmFsbHkuIEJ5IGNv
bW1pdCBtZXNzYWdlLCBCaXR0ZXJibHVlIHVzZXMgbHNodyB0b29sIHRvIHJlYWQNCnRoZSB2ZXJz
aW9uLCBhbmQgSSBwZXJzb25hbGx5IGRvbid0IG9iamVjdCB0aGlzIHBhdGNoLg0KDQpQaW5nLUtl
DQoNCg==

