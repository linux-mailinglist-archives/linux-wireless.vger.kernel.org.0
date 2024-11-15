Return-Path: <linux-wireless+bounces-15311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F12819CD51A
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 02:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3E01F21F76
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 01:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6FA7FBA2;
	Fri, 15 Nov 2024 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bFzAC11C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3B12BB1B;
	Fri, 15 Nov 2024 01:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731634998; cv=none; b=nlojkvi4ec7AINNiWAP/OegM1D9ZP4U0gL8jdXgATcpebScfiETVgjiaqCJgwJHXxiuqDrcJBsphJNh0K7ay20KiQNXVDGVMCVY5NneJydf8dbLxMGbMjkynUgwT2/BLYTuGmR1mzUo0l7hKpM4ba/33jsTwsWdkuNLnr7zoYD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731634998; c=relaxed/simple;
	bh=GDlt42d7/5pNQcs675FfdtqS5zICZGcrKhjVSsY59Sg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aefM0QC0zfbUq5CdQODhAc9NMAXKdGWfX/NbJEf2yvWRUBB+N7TfMMkqdAc80CvElKR5/02doAikxE8TuJZkgjoWMyvGY3kx97R+iG9tdwjuWDDGlzb/ZC1bBu+8YM/fW4Yt6XUwtxDB/8G0lf1Zc6vnR/Y/miTlh/VRY70j7Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bFzAC11C; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AF1h5t853893230, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731634985; bh=GDlt42d7/5pNQcs675FfdtqS5zICZGcrKhjVSsY59Sg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=bFzAC11CQeCSkcEE9oc9njI7Dm4ynAl6e8Jj67BKUU9FI1uXzUZCms95RHYmVUZh0
	 jjaVc+YZ337aYj9DE+ZCvn4brbT4klbU+ouZXsL0PSnwpeVwT9+yb1m7RseCJI+P/p
	 dy95zngf7C6no85L8RjcEZ1sdMAWNFlZe9+ebmStpUYIzLmJ5kMsn4EDHV7s5nc0DP
	 vDw5ny1RRSlSb56e1Gkfaj5RYGmz8Djse4qMVYpBWxKaSG9dMkPhSMjFr8Uc/QOyEJ
	 JXJFlaxD15Tv0p/EURZF+FUSRQ1ceKJA6LvMApuEaQeg4w9C8VJLBMfOvOxcBXgVdM
	 Un2MWQpqxQRzg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AF1h5t853893230
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 09:43:05 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 09:43:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Nov 2024 09:43:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 15 Nov 2024 09:43:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Philipp Matthias Hahn <pmhahn@pmhahn.de>,
        "iwd@lists.linux.dev"
	<iwd@lists.linux.dev>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>
Subject: RE: rtw89_8852ce + iwd stuck in (dis-)connect/-auth loop
Thread-Topic: rtw89_8852ce + iwd stuck in (dis-)connect/-auth loop
Thread-Index: AQHbNnQ/ZUJD8BdTHk+7WdyaMn+QrbK3jqAw
Date: Fri, 15 Nov 2024 01:43:06 +0000
Message-ID: <eecdb8b482f947aaabd08a4a02913bfc@realtek.com>
References: <ZzW9IIrc-HYQuD6-@birdy.pmhahn.de>
In-Reply-To: <ZzW9IIrc-HYQuD6-@birdy.pmhahn.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

UGhpbGlwcCBNYXR0aGlhcyBIYWhuIDxwbWhhaG5AcG1oYWhuLmRlPiB3cm90ZToNCj4gSGVsbG8s
DQo+IA0KPiBJIGZpbmFsbHkgc3dpdGNoZWQgZnJvbSBgd3BhX3N1cHBsaWNhbnRgIHRvIGBpd2Rg
IGFmdGVyIGhhdmluZyByZWd1bGFyDQo+IGlzc3VlcyB3aXRoIGNvbm5lY3Rpdml0eSBpc3N1ZXMs
IHNvIHRoZSBmb2xsb3dpbmcgcHJvYmxlbSBpcyBwcm9iYWJseQ0KPiBub3QgcmVsYXRlZCB0byBg
aXdkYCBhdCBhbGwuDQo+IA0KPiBBUHM6DQo+IC0gRlJJVFohQm94IDc0OTAgb25lDQo+ICAgLSAz
NDozMTpDNDoyNzo5OTpFRCAoMi40IEdIeikNCj4gICAtIDM0OjMxOkM0OjI3Ojk5OkVFICg1IEdo
eikNCj4gLSBGUklUWiFCb3ggNzQ5MCB0d28NCj4gICAtIEU4OkRGOjcwOjRBOjQ2OkFCICgyLjQg
R0h6KQ0KPiAgIC0gRTg6REY6NzA6NEE6NDY6QUMgKDUgR0h6KQ0KPiAtIEZSSVRaIVBvd2VybGlu
ZSAxMjYwRQ0KPiAgIC0gRjA6QjA6MTQ6ODg6QUM6NDMgKDIuNCBHSHopDQo+ICAgLSBGMDpCMDox
NDo4ODpBQzo0NyAoNSBHSHopDQo+IC0gRlJJVFohUG93ZXJsaW5lIDU0MEUNCj4gICAtIDVDOjQ5
Ojc5OkUxOkM1Ojk0ICgyLjQgR0h6KQ0KDQpJJ20gbm90IGZhbWlsaWFyIHdpdGggdGhlc2UgQVAg
YnJhbmRzLiBBcmUgdGhleSBhbGwgdGhlIHNhbWUgYnJhbmQ/DQpDYW4geW91IHRyeSBhbm90aGVy
IEFQIGJyYW5kPyBFbXBpcmljYWxseSBzb21lIEFQIHNlbmQgYmVhY29uIHdpdGggbGFyZ2VyDQp2
YXJpYW50IHRpbWluZyB0aGF0IFdpRmkgYWRhcHRlciBjYW4ndCByZWNlaXZlIGJlYWNvbiBhdCBj
b3JyZWN0IG1vbWVudC4gDQoNCj4gDQo+IERlYmlhbi0xMi1CdXN0ZXINCj4gaXdkIG9yaWdpbmFs
OiAyLjMsIG5vdzogMy4xIHNlbGYtY29tcGlsZWQNCj4gTGludXggNi4xMC4xMQ0KPiAwNDowMC4w
IEV0aGVybmV0IGNvbnRyb2xsZXIgWzAyMDBdOiBSZWFsdGVrIFNlbWljb25kdWN0b3IgQ28uLCBM
dGQuIFJUTDgxMTEvODE2OC84NDExIFBDSSBFeHByZXNzIEdpZ2FiaXQNCj4gRXRoZXJuZXQgQ29u
dHJvbGxlciBbMTBlYzo4MTY4XSAocmV2IDE1KQ0KDQpUaGlzIGlzIEV0aGVybmV0IG5vdCB3aXJl
bGVzcyBhZGFwdGVyLCBidXQgSSBjYW4gc2tpcCB0aGlzIGluZm9ybWF0aW9uIGZvciBub3cuDQoN
Cj4gDQo+IFs4NzU3Mi4wMjgwNzVdIHdsYW4wOiBhdXRoZW50aWNhdGUgd2l0aCAzNDozMTpjNDoy
Nzo5OTplZSAobG9jYWwgYWRkcmVzcz00MDoxYTo1ODpmNjpjYTo2ZikNCj4gWzg3NTcyLjAyODA3
OV0gd2xhbjA6IHNlbmQgYXV0aCB0byAzNDozMTpjNDoyNzo5OTplZSAodHJ5IDEvMykNCj4gWzg3
NTcyLjAzMTA4NV0gd2xhbjA6IGF1dGhlbnRpY2F0ZWQNCj4gWzg3NTcyLjAzNjUyN10gd2xhbjA6
IGFzc29jaWF0ZSB3aXRoIDM0OjMxOmM0OjI3Ojk5OmVlICh0cnkgMS8zKQ0KPiBbODc1NzIuMDM5
NTM0XSB3bGFuMDogUlggQXNzb2NSZXNwIGZyb20gMzQ6MzE6YzQ6Mjc6OTk6ZWUgKGNhcGFiPTB4
MTUxMSBzdGF0dXM9MCBhaWQ9MikNCj4gWzg3NTcyLjE1ODE1M10gd2xhbjA6IGFzc29jaWF0ZWQN
Cj4gWzg3NTcyLjE1ODI2NF0gd2xhbjA6IExpbWl0aW5nIFRYIHBvd2VyIHRvIDIwICgyMyAtIDMp
IGRCbSBhcyBhZHZlcnRpc2VkIGJ5IDM0OjMxOmM0OjI3Ojk5OmVlDQo+IFs4NzU4MS42ODYwMThd
IHdsYW4wOiBDb25uZWN0aW9uIHRvIEFQIDM0OjMxOmM0OjI3Ojk5OmVlIGxvc3QNCg0KSSBmZWVs
IHRoZSBjb25uZWN0aW9uIGxvc3QgYmVjYXVzZSBvZiBiZWFjb24gbG9zdCBjYXVzaW5nIGJ5IHBv
d2VyIHNhdmUuDQpQbGVhc2UgdHJ5IA0KICAgIHN1ZG8gaXcgd2xhbjAgc2V0IHBvd2VyX3NhdmUg
b2ZmDQp0byBzZWUgaWYgaXQgY2FuIGdldCBzdGFibGUuIA0KDQo+IA0KPiBJIGhhdmUgc2VlbiB0
aGF0ICJMaW1pdGluZyBUWCBwb3dlciB0byDigKYiIGJlZm9yZSB3aXRoIGB3cGFfc3VwcGxpY2Fu
dGAsDQo+IHdoaWNoIGFsc28gbGVhZCB0byBhIGRpc2Nvbm5lY3QgdGhlcmUsIHdoaWNoIHRyaWdn
ZXJlZCBtZSB0byB0cnkgYGl3ZGANCj4gbm93Lg0KDQpJIHRoaW5rIHRoZSBtZXNzYWdlIGlzIG5v
dCByZWxhdGVkIHRvIHRoaXMgcHJvYmxlbSwgYmVjYXVzZSBkcml2ZXIgaGFzIGl0cw0Kb3duIFRY
IHBvd2VyIG1hbmFnZW1lbnQuIA0KDQo+IA0KPiBMYXN0IHRpbWUgdW5sb2FkaW5nIGBydHc4OV84
ODUyY2VgIGFuZCByZS1sb2FkaW5nIGl0IGRpZCBnZXQgaXQsIGJ1dA0KPiBvbmx5IGFmdGVyIHN3
aXRjaGluZyBXaWZpIG9mZiBhbmQgb24gYWdhaW4gaW4gTmV0d29ya01hbmFnZXIuDQoNClRvIGJl
IGNsZWFyLi4uIGlzIGl0IHdvcmsgb25seSBhZnRlciBzd2l0Y2hpbmcgV2lGaSBvZmYvb24/IEl0
IGRvZXNuJ3Qgd29yaz8NCklmIHNvLCBzZWVtaW5nbHkgc29tZSBzZXR0aW5ncyBhcmUgc3RpbGwg
cGVyc2lzdGVudCB3aGVuIFdpRmkgb2ZmLg0KDQoNCg==

