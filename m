Return-Path: <linux-wireless+bounces-11647-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A295C957AC6
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 03:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 047CCB221AD
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 01:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E860312E5B;
	Tue, 20 Aug 2024 01:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="skiwk0UO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37E41AAC4
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 01:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724116241; cv=none; b=RdSPdwJqgI7snz+FviwvopGPes/S+yAYF8kFpWs/uX3HFOVbLLmpmdJURMpbJ3sDshP6eWfyKSUAan1c9LsZhaDmB6KDH/jPV3LWzhex4xFqc4KdLGfSixf1cQv9mc0MXz5almgxF0nAEnThDexKxNsIBplfS3E0WcJWvqsfhjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724116241; c=relaxed/simple;
	bh=lT821kAhSxIre6ggVDW8peQ13ZYUr5h5y8lh3H37L74=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ue8Y9IXqW5j2Ghq8nK/hK6nQ8yLlqvqiS9gz+ePZKG5yEjIMRECWMcJHnD0U/uF4pg32DKZtIPNblBc+kBCiJir9d9a7xTZUT4b/KiWnGrP3g4D2/apJ0xn4z2rGbD1YeGN47mORsnwbvWOtuIrvF/w+768YQaF1T+W45KfoT0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=skiwk0UO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47K1AYI50767624, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724116234; bh=lT821kAhSxIre6ggVDW8peQ13ZYUr5h5y8lh3H37L74=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=skiwk0UO0SWkUuwyM2CJElhlmFMNA0rvDLOOPCfGFprfoBCDbcMy+4XmC6AVI/734
	 sYXVq5JVpRUecDcgWyak4IfiKmlz8YWmsi2xUG40No1diJR5ZhOJf937S4Ua6/Ar0q
	 0V/jGCYsKImMgxywbNqrz28bPnZuf9TNKgxSVBu7Xodb+hVQdQMKG8ZM+LQ0z8KmDj
	 z578X8A+1nuEwP2tzVY8jf0P+gMM14OKl4rSsJAZpe5DZIGnHRVyBDPdTbn9+VuSj/
	 sQWaKuwcNSVBE+QrK4IiN/tztVlbu/Dv575OENS3/YDOXOn45y8P5ELhYrApKTG1zH
	 fwPwmCn9CSC/A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47K1AYI50767624
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 09:10:34 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 09:10:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Aug 2024 09:10:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Tue, 20 Aug 2024 09:10:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 03/20] wifi: rtw88: Allow different C2H RA report sizes
Thread-Topic: [PATCH 03/20] wifi: rtw88: Allow different C2H RA report sizes
Thread-Index: AQHa7DDGvlj44vDEDUaIMp+2n642+LIn28NggAaGugCAAPvpQA==
Date: Tue, 20 Aug 2024 01:10:34 +0000
Message-ID: <840cb519e99047a5a8f3ca4a12a3fcee@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <e0de25fc-8742-4899-854e-7cbd93aaa582@gmail.com>
 <6071028680d14afa8e0eed84821f51c6@realtek.com>
 <4b7181e4-d235-4c02-8b8e-dbafbf38fa93@gmail.com>
In-Reply-To: <4b7181e4-d235-4c02-8b8e-dbafbf38fa93@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAx
NS8wOC8yMDI0IDA5OjE0LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBUaGUgUlRMODgyMUFVIGFu
ZCBSVEw4ODEyQVUgaGF2ZSBzbWFsbGVyIFJBIHJlcG9ydCBzaXplLCBvbmx5IDQgYnl0ZXMuDQo+
ID4+IEF2b2lkIHRoZSAiaW52YWxpZCByYSByZXBvcnQgYzJoIGxlbmd0aCIgZXJyb3IuDQo+ID4+
DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21h
aWwuY29tPg0KPiA+PiAtLS0NCj4gPj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODgvZncuYyAgICAgICB8IDggKysrKysrLS0NCj4gPj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODgvbWFpbi5oICAgICB8IDEgKw0KPiA+PiAgZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OC9ydHc4NzAzYi5jIHwgMSArDQo+ID4+ICBkcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0dzg4L3J0dzg3MjNkLmMgfCAxICsNCj4gPj4gIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL3JlYWx0ZWsvcnR3ODgvcnR3ODgyMWMuYyB8IDEgKw0KPiA+PiAgZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4ODIyYi5jIHwgMSArDQo+ID4+ICBkcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4MjJjLmMgfCAxICsNCj4gPj4gIDcgZmlsZXMgY2hh
bmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvZncuYyBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvZncuYw0KPiA+PiBpbmRleCA3ODJmMzc3NmUwYTAu
LmFjNTNlM2UzMGFmMCAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydHc4OC9mdy5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODgvZncuYw0KPiA+PiBAQCAtMTU3LDcgKzE1NywxMCBAQCBzdGF0aWMgdm9pZCBydHdfZndf
cmFfcmVwb3J0X2l0ZXIodm9pZCAqZGF0YSwgc3RydWN0IGllZWU4MDIxMV9zdGEgKnN0YSkNCj4g
Pj4NCj4gPj4gICAgICAgICByYXRlID0gR0VUX1JBX1JFUE9SVF9SQVRFKHJhX2RhdGEtPnBheWxv
YWQpOw0KPiA+PiAgICAgICAgIHNnaSA9IEdFVF9SQV9SRVBPUlRfU0dJKHJhX2RhdGEtPnBheWxv
YWQpOw0KPiA+PiAtICAgICAgIGJ3ID0gR0VUX1JBX1JFUE9SVF9CVyhyYV9kYXRhLT5wYXlsb2Fk
KTsNCj4gPj4gKyAgICAgICBpZiAoc2ktPnJ0d2Rldi0+Y2hpcC0+YzJoX3JhX3JlcG9ydF9zaXpl
IDwgNykNCj4gPg0KPiA+IEV4cGxpY2l0bHkgc3BlY2lmeSAnPT0gNCcgZm9yIHRoZSBjYXNlIG9m
IFJUTDg4MjFBVSBhbmQgUlRMODgxMkFVLg0KPiA+DQo+ID4+ICsgICAgICAgICAgICAgICBidyA9
IHNpLT5id19tb2RlOw0KPiA+PiArICAgICAgIGVsc2UNCj4gPj4gKyAgICAgICAgICAgICAgIGJ3
ID0gR0VUX1JBX1JFUE9SVF9CVyhyYV9kYXRhLT5wYXlsb2FkKTsNCj4gPj4NCj4gPg0KPiA+DQo+
IA0KPiBXb3VsZCB0aGF0IG1ha2Ugc2Vuc2U/IEkgY2hlY2sgZm9yIGxlc3MgdGhhbiA3IGJlY2F1
c2UgdGhlIHNpemUNCj4gaGFzIHRvIGJlIGF0IGxlYXN0IDcgaW4gb3JkZXIgdG8gYWNjZXNzIHBh
eWxvYWRbNl0gKEdFVF9SQV9SRVBPUlRfQlcpLg0KDQpBcyB5b3UgZGlkICJXQVJOKGxlbmd0aCA8
IHJ0d2Rldi0+Y2hpcC0+YzJoX3JhX3JlcG9ydF9zaXplKSIsIEkgYXNzdW1lIHlvdQ0KZXhwZWN0
ICI8IDciIGNhc2VzIGlzIG9ubHkgZm9yIGNvbWluZyBjaGlwcyBSVEw4ODIxQVUgYW5kIFJUTDg4
MTJBVS4NCg0KTWF5YmUgZXhwbGljaXRseSBzcGVjaWZ5aW5nIGNoaXBzIElEIHdvdWxkIGJlIGVh
c2llciB0byB1bmRlcnN0YW5kOg0KICAgICAgICBpZiAoY2hpcCA9PSBSVEw4ODIxQSB8fCBjaGlw
ID09IFJUTDg4MTJBKQ0KICAgICAgICAgICAgICAgYncgPSBzaS0+YndfbW9kZTsNCiAgICAgICAg
ZWxzZQ0KICAgICAgICAgICAgICAgYncgPSBHRVRfUkFfUkVQT1JUX0JXKHJhX2RhdGEtPnBheWxv
YWQpOw0KDQpUaGF0J3Mgd2h5IEkgd2FudCAiPT0gNCIuIChidXQgaXQgc2VlbXMgaW1wbGljaXRs
eSBub3QgZXhwbGljaXRseSB0aG91Z2guKQ0KDQoNCg==

