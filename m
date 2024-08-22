Return-Path: <linux-wireless+bounces-11769-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5572D95A8EC
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 02:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA7F283580
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 00:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76231D130C;
	Thu, 22 Aug 2024 00:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="DmzFIA88"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B781A6FB9
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286817; cv=none; b=sypHBFadnkuziyFw113RHE4iDWfstZgUqr/V+YW5r9//gb/YtRbY3GhU1jbxd40DAz/2d6E7nKsJ/2u3j5h/Unby57z6lAmbSYnYerpL0KAMOr9AGw935/GHsD4Tup35X8jed1qWcKRLpIvTgObXa1fIBUn6k40jkups9gRM/+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286817; c=relaxed/simple;
	bh=Ek3+ccZKfGcd1f6V1VK69rK/jyVpY/TbXFzofisSZG0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aFJW1yUCkzcL7W87vg8RPb1bWar7GwxM8xce4yKSlrbq6//L2kwUVzG/EESVtXd3GLOAhLejGMvHoNFE8B2gQ7Kq/e1/WPZ9sVQZNHDwVfjlzcOozwCZQubyI0qR8cutVNwJTPX3Nr6HoCbuDi0CgTwfjHjdN9atcCvDbDQFLU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=DmzFIA88; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47M0XT1i83318418, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724286809; bh=Ek3+ccZKfGcd1f6V1VK69rK/jyVpY/TbXFzofisSZG0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=DmzFIA88R19p/+uXitwzhtNSr/u9e8lQ/HbtHEnrdemNVjAaNxJLs3wS3WhcBgOHM
	 4KWQVkodT922m0LvTjqVic+XBCIBQCaSHM1dxdt9K4K2opTAB88XXLX3yMwvFC5l7s
	 S/RYd0rSMZqHQmF7jgP+fFIM53ZpGk+9pQRMdL21DRaoEJs3Gi3mIpl4xw9bl5LWeo
	 nPwWk00V7AcmxCZVbd5n1l4J9RvqGp+qnnwZNE/gcM1PGCx0iM+5ihYzqi/gUGXY2u
	 UY0FPTl03dkF5EKrWv9EXtctuj0IojyR1ESuKxjMY1Q3AIMiNjBbFwzDqGvEB0A3Wf
	 OmWxjhhCsIZOg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47M0XT1i83318418
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 08:33:29 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 08:33:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Aug 2024 08:33:29 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 22 Aug 2024 08:33:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 03/20] wifi: rtw88: Allow different C2H RA report sizes
Thread-Topic: [PATCH 03/20] wifi: rtw88: Allow different C2H RA report sizes
Thread-Index: AQHa7DDGvlj44vDEDUaIMp+2n642+LIn28NggAaGugCAAPvpQIAA11EAgACyXKCAAC+wgIABZMUQ
Date: Thu, 22 Aug 2024 00:33:29 +0000
Message-ID: <423f1f602b52464499c38459bd19cc84@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <e0de25fc-8742-4899-854e-7cbd93aaa582@gmail.com>
 <6071028680d14afa8e0eed84821f51c6@realtek.com>
 <4b7181e4-d235-4c02-8b8e-dbafbf38fa93@gmail.com>
 <840cb519e99047a5a8f3ca4a12a3fcee@realtek.com>
 <d06c7a5f-c773-45a6-98f2-30fb1d0dde94@gmail.com>
 <9456919959d94b548750f78a371f204e@realtek.com>
 <73accc26-15ee-43d9-bad2-061c42b76e0e@gmail.com>
In-Reply-To: <73accc26-15ee-43d9-bad2-061c42b76e0e@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAy
MS8wOC8yMDI0IDAzOjMxLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBPbiAyMC8wOC8yMDI0IDA0
OjEwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4+PiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIx
Y2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4+Pj4gT24gMTUvMDgvMjAyNCAwOToxNCwgUGlu
Zy1LZSBTaGloIHdyb3RlOg0KPiA+Pj4+PiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUy
QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4+Pj4+PiBUaGUgUlRMODgyMUFVIGFuZCBSVEw4ODEyQVUg
aGF2ZSBzbWFsbGVyIFJBIHJlcG9ydCBzaXplLCBvbmx5IDQgYnl0ZXMuDQo+ID4+Pj4+PiBBdm9p
ZCB0aGUgImludmFsaWQgcmEgcmVwb3J0IGMyaCBsZW5ndGgiIGVycm9yLg0KPiA+Pj4+Pj4NCj4g
Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21h
aWwuY29tPg0KPiA+Pj4+Pj4gLS0tDQo+ID4+Pj4+PiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydHc4OC9mdy5jICAgICAgIHwgOCArKysrKystLQ0KPiA+Pj4+Pj4gIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFpbi5oICAgICB8IDEgKw0KPiA+Pj4+Pj4gIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnR3ODcwM2IuYyB8IDEgKw0KPiA+Pj4+Pj4g
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnR3ODcyM2QuYyB8IDEgKw0KPiA+
Pj4+Pj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnR3ODgyMWMuYyB8IDEg
Kw0KPiA+Pj4+Pj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnR3ODgyMmIu
YyB8IDEgKw0KPiA+Pj4+Pj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnR3
ODgyMmMuYyB8IDEgKw0KPiA+Pj4+Pj4gIDcgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4gPj4+Pj4+DQo+ID4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9mdy5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OC9mdy5jDQo+ID4+Pj4+PiBpbmRleCA3ODJmMzc3NmUwYTAuLmFjNTNlM2Uz
MGFmMCAxMDA2NDQNCj4gPj4+Pj4+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODgvZncuYw0KPiA+Pj4+Pj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OC9mdy5jDQo+ID4+Pj4+PiBAQCAtMTU3LDcgKzE1NywxMCBAQCBzdGF0aWMgdm9pZCBydHdf
ZndfcmFfcmVwb3J0X2l0ZXIodm9pZCAqZGF0YSwgc3RydWN0IGllZWU4MDIxMV9zdGEgKnN0YSkN
Cj4gPj4+Pj4+DQo+ID4+Pj4+PiAgICAgICAgIHJhdGUgPSBHRVRfUkFfUkVQT1JUX1JBVEUocmFf
ZGF0YS0+cGF5bG9hZCk7DQo+ID4+Pj4+PiAgICAgICAgIHNnaSA9IEdFVF9SQV9SRVBPUlRfU0dJ
KHJhX2RhdGEtPnBheWxvYWQpOw0KPiA+Pj4+Pj4gLSAgICAgICBidyA9IEdFVF9SQV9SRVBPUlRf
QlcocmFfZGF0YS0+cGF5bG9hZCk7DQo+ID4+Pj4+PiArICAgICAgIGlmIChzaS0+cnR3ZGV2LT5j
aGlwLT5jMmhfcmFfcmVwb3J0X3NpemUgPCA3KQ0KPiA+Pj4+Pg0KPiA+Pj4+PiBFeHBsaWNpdGx5
IHNwZWNpZnkgJz09IDQnIGZvciB0aGUgY2FzZSBvZiBSVEw4ODIxQVUgYW5kIFJUTDg4MTJBVS4N
Cj4gPj4+Pj4NCj4gPj4+Pj4+ICsgICAgICAgICAgICAgICBidyA9IHNpLT5id19tb2RlOw0KPiA+
Pj4+Pj4gKyAgICAgICBlbHNlDQo+ID4+Pj4+PiArICAgICAgICAgICAgICAgYncgPSBHRVRfUkFf
UkVQT1JUX0JXKHJhX2RhdGEtPnBheWxvYWQpOw0KPiA+Pj4+Pj4NCj4gPj4+Pj4NCj4gPj4+Pj4N
Cj4gPj4+Pg0KPiA+Pj4+IFdvdWxkIHRoYXQgbWFrZSBzZW5zZT8gSSBjaGVjayBmb3IgbGVzcyB0
aGFuIDcgYmVjYXVzZSB0aGUgc2l6ZQ0KPiA+Pj4+IGhhcyB0byBiZSBhdCBsZWFzdCA3IGluIG9y
ZGVyIHRvIGFjY2VzcyBwYXlsb2FkWzZdIChHRVRfUkFfUkVQT1JUX0JXKS4NCj4gPj4+DQo+ID4+
PiBBcyB5b3UgZGlkICJXQVJOKGxlbmd0aCA8IHJ0d2Rldi0+Y2hpcC0+YzJoX3JhX3JlcG9ydF9z
aXplKSIsIEkgYXNzdW1lIHlvdQ0KPiA+Pj4gZXhwZWN0ICI8IDciIGNhc2VzIGlzIG9ubHkgZm9y
IGNvbWluZyBjaGlwcyBSVEw4ODIxQVUgYW5kIFJUTDg4MTJBVS4NCj4gPj4+DQo+ID4+PiBNYXli
ZSBleHBsaWNpdGx5IHNwZWNpZnlpbmcgY2hpcHMgSUQgd291bGQgYmUgZWFzaWVyIHRvIHVuZGVy
c3RhbmQ6DQo+ID4+PiAgICAgICAgIGlmIChjaGlwID09IFJUTDg4MjFBIHx8IGNoaXAgPT0gUlRM
ODgxMkEpDQo+ID4+PiAgICAgICAgICAgICAgICBidyA9IHNpLT5id19tb2RlOw0KPiA+Pj4gICAg
ICAgICBlbHNlDQo+ID4+PiAgICAgICAgICAgICAgICBidyA9IEdFVF9SQV9SRVBPUlRfQlcocmFf
ZGF0YS0+cGF5bG9hZCk7DQo+ID4+Pg0KPiA+Pj4gVGhhdCdzIHdoeSBJIHdhbnQgIj09IDQiLiAo
YnV0IGl0IHNlZW1zIGltcGxpY2l0bHkgbm90IGV4cGxpY2l0bHkgdGhvdWdoLikNCj4gPj4+DQo+
ID4+DQo+ID4+IEkganVzdCBjaGVja2VkLCB0aGUgUkEgcmVwb3J0IHNpemUgb2YgUlRMODgxNEFV
IGlzIDYuDQo+ID4NCj4gPiBDb3VsZCB5b3UgYWxzbyBjaGVjayBpZiB0aGUgcmVwb3J0IGZvcm1h
dCBpcyBjb21wYXRpYmxlPw0KPiA+IEkgbWVhbiBkZWZpbml0aW9uIG9mIGZpcnN0IDQgYnl0ZXMg
YXJlIHRoZSBzYW1lIGZvciBhbGwgY2hpcHM/IGFuZA0KPiA+IGRlZmluaXRpb24gb2YgZmlyc3Qg
NiBieXRlcyBhcmUgdGhlIHNhbWUgZm9yIFJUTDg4MTRBVSBhbmQgY3VycmVudA0KPiA+IGV4aXRp
bmcgY2hpcHM/DQo+ID4NCj4gPiBCeSB0aGUgd2F5LCBJIHRoaW5rIHdlIHNob3VsZCBzdHJ1Y3Qg
d2l0aCB3MCwgdzEsIC4uLiBmaWVsZHMgaW5zdGVhZC4NCj4gPiAgICAgc3RydWN0IHJ0d19yYV9y
ZXBvcnQgew0KPiA+ICAgICAgICAgX19sZTMyIHcwOw0KPiA+ICAgICAgICAgX19sZTMyIHcxOw0K
PiA+ICAgICAgICAgX19sZTMyIHcyOw0KPiA+ICAgICAgICAgX19sZTMyIHczOw0KPiA+ICAgICAg
ICAgX19sZTMyIHc0Ow0KPiA+ICAgICAgICAgX19sZTMyIHc1Ow0KPiA+ICAgICAgICAgX19sZTMy
IHc2Ow0KPiA+ICAgICB9IF9fcGFja2VkOw0KPiA+DQo+ID4gVGhlbiwgd2UgY2FuIGJlIGVhc2ll
ciB0byBhdm9pZCBhY2Nlc3Npbmcgb3V0IG9mIHJhbmdlLiBHRVRfUkFfUkVQT1JUX0JXKCkNCj4g
PiBoaWRlcyBzb21ldGhpbmcsIG5vIGhlbHAgdG8gcmVhZCB0aGUgY29kZS4NCj4gPg0KPiANCj4g
VGhlIHJlcG9ydCBmb3JtYXQgbG9va3MgY29tcGF0aWJsZS4NCj4gDQo+IEknbSBub3Qgc3VyZSBo
b3cgYSBzdHJ1Y3Qgd2l0aCBfX2xlMzIgbWVtYmVycyB3b3VsZCBoZWxwIGhlcmUuDQo+IEkgYWdy
ZWUgdGhhdCB0aGUgY3VycmVudCBtYWNyb3MgaGlkZSB0aGluZ3MuIFdlIGNvdWxkIGFjY2VzcyBw
YXlsb2FkDQo+IGRpcmVjdGx5LiBUaGUgdmFyaWFibGUgbmFtZXMgYWxyZWFkeSBtYWtlIGl0IGNs
ZWFyIHdoYXQgZWFjaCBieXRlIGlzOg0KPiANCj4gICAgICAgICBtYWNfaWQgPSByYV9kYXRhLT5w
YXlsb2FkWzFdOw0KPiAgICAgICAgIGlmIChzaS0+bWFjX2lkICE9IG1hY19pZCkNCj4gICAgICAg
ICAgICAgICAgIHJldHVybjsNCj4gDQo+ICAgICAgICAgc2ktPnJhX3JlcG9ydC50eHJhdGUuZmxh
Z3MgPSAwOw0KPiANCj4gICAgICAgICByYXRlID0gdThfZ2V0X2JpdHMocmFfZGF0YS0+cGF5bG9h
ZFswXSwgR0VOTUFTSyg2LCAwKSk7DQo+ICAgICAgICAgc2dpID0gdThfZ2V0X2JpdHMocmFfZGF0
YS0+cGF5bG9hZFswXSwgQklUKDcpKTsNCj4gICAgICAgICBpZiAoc2ktPnJ0d2Rldi0+Y2hpcC0+
YzJoX3JhX3JlcG9ydF9zaXplID49IDcpDQo+ICAgICAgICAgICAgICAgICBidyA9IHJhX2RhdGEt
PnBheWxvYWRbNl07DQo+ICAgICAgICAgZWxzZQ0KPiAgICAgICAgICAgICAgICAgYncgPSBzaS0+
YndfbW9kZTsNCg0KWWVzLCB0aGlzIGlzIGFsc28gY2xlYXIgdG8gbWUgdG8gYXZvaWQgYWNjZXNz
aW5nIG91dCBvZiByYW5nZS4gDQpBbm90aGVyIGFkdmFudGFnZSBvZiBhIHN0cnVjdCBpcyB0byBl
eHBsaWNpdGx5IHRlbGwgdXMgdGhlIHRvdGFsIHNpemUgb2YgYQ0KQzJIIGV2ZW50Lg0KDQoNCg==

