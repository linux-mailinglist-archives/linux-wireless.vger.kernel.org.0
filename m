Return-Path: <linux-wireless+bounces-26881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9121EB3D68F
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 04:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8213BC885
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 02:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40A9202997;
	Mon,  1 Sep 2025 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="nD49Cw2x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DEF207A32
	for <linux-wireless@vger.kernel.org>; Mon,  1 Sep 2025 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756692588; cv=none; b=hi22+u/NyUxUielo/M6YtT2wWtfwM6ANv41O7va15KRoGZDnCo8J2FpjskwWu1PE8t1RQaxZcCvGAp9akNrop7y/NweOrN7+XjqwHiJFZ3CSoMVFd+bA9d6FYfjaUTDLq11np8i39uYYYRXwiFJkE4toNa/q0D08G7/uQqAkx2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756692588; c=relaxed/simple;
	bh=uUqQwrwehOzh2whsFxTT8T5uxEPhzosS6F1SztdaAJU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rRjn7Lotyl8xz+SdpR/BgIpFNSpBjFunT3ESIOgxCirAxFVUKOkH8/G5sy/M5ZWc9HieOImRX+vCoMNpSnNkFKk0Jftc6A4WUiZ6e7OkTnbe+eXvgCgVZ4yKhlidSmdHH92A3pMUb8GfZ11YCTk2sQ1adtSbJozM8e4uKyzLZTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=nD49Cw2x; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58129eylE114715, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756692580; bh=uUqQwrwehOzh2whsFxTT8T5uxEPhzosS6F1SztdaAJU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=nD49Cw2x+24OLfsyJymwPkF4NMj/GcHAsPdisA3PyCJ3isHgr7AdSunCbwTc+Y1nT
	 DJOQzm0hBcz+krZRVXG55s1voJhggLQp4XOFXuiBD2D4HCd3q0FGViFBkCtSvsUOLI
	 FvBQkNnH6YwfJRQuIAjmjlOl83VEw0udxhxUWU/ycLwPjknPsep1SphyHLPF5bO1Yu
	 bb1k+37eZSok0L3OIIGEyhUz1HJynIXUJHkRPNwDNuZvYJ+e3ZHp7r/FBz5nWPiuug
	 Yc0+A4TU8h3zXYWfMy1fnimUfTY5Yh+ddZJ4jOo0SLXw7oYr3EXfzulMemPsfIjuRQ
	 7AXgIopzBhAUQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58129eylE114715
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Sep 2025 10:09:40 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 1 Sep 2025 10:09:40 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Mon, 1 Sep 2025 10:09:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v3 00/11] wifi: rtw89: Add support for RTL8852CU
Thread-Topic: [PATCH rtw-next v3 00/11] wifi: rtw89: Add support for RTL8852CU
Thread-Index: AQHcF3JiHh9TMEvBrkmiQiJfPugsk7R5KnRggAB9WACAA/F8wA==
Date: Mon, 1 Sep 2025 02:09:40 +0000
Message-ID: <1d0424c351804afaa482633bf43cab69@realtek.com>
References: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
 <a81f6725b183401d8973bc648c3ecbc2@realtek.com>
 <c59ed20f-8af9-4712-b9f5-8509b5665420@gmail.com>
In-Reply-To: <c59ed20f-8af9-4712-b9f5-8509b5665420@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAy
OS8wOC8yMDI1IDA5OjIzLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBBZGQgc3VwcG9ydCBmb3Ig
UlRMODg1MkNVLiBJdCB3b3JrcyB3ZWxsIGJ1dCBzb21ldGltZXMgaXQgbG9zZXMgdGhlDQo+ID4+
IGNvbm5lY3Rpb246DQo+ID4+DQo+ID4+IEp1bCAwNCAxNjowNTo1NiBpZGVhcGFkMiBrZXJuZWw6
IHdscDNzMGYzdTQ6IENvbm5lY3Rpb24gdG8gQVAgLi4uIGxvc3QNCj4gPj4gSnVsIDE0IDEzOjQ1
OjI2IGlkZWFwYWQyIGtlcm5lbDogd2xwM3MwZjN1NDogQ29ubmVjdGlvbiB0byBBUCAuLi4gbG9z
dA0KPiA+PiBKdWwgMTUgMTc6NTE6MjggaWRlYXBhZDIga2VybmVsOiB3bHAzczBmM3U0OiBDb25u
ZWN0aW9uIHRvIEFQIC4uLiBsb3N0DQo+ID4+IEp1bCAxOCAxNDo0MzozMCBpZGVhcGFkMiBrZXJu
ZWw6IHdscDNzMGYzdTQ6IENvbm5lY3Rpb24gdG8gQVAgLi4uIGxvc3QNCj4gPj4gSnVsIDI0IDE0
OjU4OjA3IGlkZWFwYWQyIGtlcm5lbDogd2xwM3MwZjN1NDogQ29ubmVjdGlvbiB0byBBUCAuLi4g
bG9zdA0KPiA+Pg0KPiA+PiBXaGVuIHRoYXQgaGFwcGVucyBpdCByZWNvbm5lY3RzIGltbWVkaWF0
ZWx5Lg0KPiA+DQo+ID4gSW50ZXJuYWwgZXhwZXJ0cyB0b2xkIG1lIHRoZXkgbmVlZCBtb3JlIGRh
dGEgdG8gYW5hbHl6ZSB0aGUgcHJvYmxlbSwgSSdsbA0KPiA+IHNoYXJlIHlvdSBhIGRlYnVnIHBh
dGNoIGxhdGVyLiBCZWZvcmUgdGhhdCwgcGxlYXNlIHJlYWQgNCBieXRlcyBvZiAweEYwIHJlZ2lz
dGVyDQo+ID4gdmlhIGRlYnVnZnMuIGkuZS4gJ2VjaG8gMHhGMCA0ID4gcmVhZF9yZWc7IGNhdCBy
ZWFkX3JlZycuDQo+ID4NCj4gPiBBbm90aGVyIHRoaW5nIGlzIHdvdWxkIHlvdSBsaWtlIG1lIG1l
cmdlIHRoaXMgcGF0Y2hzZXQgYmVmb3JlIHRoZSBwcm9ibGVtDQo+ID4gZ2V0IHJlc29sdmVkPyBJ
ZiBzbywgZW5kIHVzZXJzIG1pZ2h0IHJlcG9ydCBwcm9ibGVtcyBmcmVxdWVudGx5LiBNYXliZSwg
d2UNCj4gPiBjYW4ganVzdCBtZXJnZSBtb3N0IHBhdGNoZXMsIGJ1dCBub3QgYWN0dWFsbHkgZW5h
YmxlIFJUTDg4NTJDVSBieSB0aGUgbGFzdA0KPiA+IHBhdGNoLiBQbGVhc2UgbGV0IG1lIGtub3cg
d2hhdCB5b3UgdGhpbmsuDQo+ID4NCj4gDQo+IFBlcnNvbmFsbHksIEkgZG9uJ3QgbWluZCB1c2Vy
cyByZXBvcnRpbmcgcHJvYmxlbXMuIEJ1dCBsZWF2aW5nIHRoZSBsYXN0DQo+IHBhdGNoIGZvciBs
YXRlciBpcyBmaW5lIHRvby4NCg0KSSdkIHRha2UgdGhpcyB3aG9sZSBwYXRjaHNldCB0aGVuLiBC
dXQgYWRkICIoRVhQRVJJTUVOVEFMKSIgdG8gS2NvbmZpZw0KaXRlbSBhcw0KDQoiUmVhbHRlayA4
ODUyQ1UgVVNCIHdpcmVsZXNzIG5ldHdvcmsgKFdpLUZpIDZFKSBhZGFwdGVyIChFWFBFUklNRU5U
QUwpIg0KDQphbmQgZGVzY3JpYmUgc29tZXRoaW5nIGluIEtjb25maWcgaGVscCB0ZXh0Lg0KDQpJ
ZiB5b3Ugd2FudCwgd2UgY2FuIGFkZCBhIHdhcm5pbmcgbWVzc2FnZSBhdCB1c2IgcHJvYmUgdG8g
bm90ZSBwZW9wbGUNClJUTDg4NTJDVSBpc24ndCBmdWxseSBjb21wbGV0ZS4NCg0KDQo=

