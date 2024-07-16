Return-Path: <linux-wireless+bounces-10241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219F7931E67
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 03:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5438B1C2100B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 01:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAA079D1;
	Tue, 16 Jul 2024 01:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="roQqLTH5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3EE79CD
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jul 2024 01:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721092792; cv=none; b=JJjlN1Z/M+/oSc7Je5j/EfxkpdRfRcER4Nd6+CEjHJFfKm2/EXH7ZNF1RCwczmI8+LodStVYcKKR1peDiZB4SYYW/2VBR5yX+i/57hbjyg8DjutxWyQ8Alu/RjOVm1F/Tu9TPZLCLO+6QEK8GbDuTPw5siY27tQRG5ODgU+ScPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721092792; c=relaxed/simple;
	bh=WS2+xo6/EsMqPjvypFMbrCUTpqCBqnHqUZtvpLgv+e0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u/xyAVr9klBkgN1ie23q0UzHdTB2iewZ/MiS+kXrfuidqbKDt/tjDeeQyCkhvmPF8pii23cFo2rZzO0P5hniBTZRwaFo5i0yZo/mT6rWwqx77odqJK30BkStw87bM0dP1O5ewfp/7BCzxnKe7uMJx1WvWWBErrMlPn1f50jZpMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=roQqLTH5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46G1JirvE251199, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721092784; bh=WS2+xo6/EsMqPjvypFMbrCUTpqCBqnHqUZtvpLgv+e0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-ID:Content-Transfer-Encoding:MIME-Version;
	b=roQqLTH5kyQIweeW2t3U2Yyz9m2+7+3tpn6ObkSo7KaKvSikaiOJOB/yC50fWnUJK
	 JFrfIIn7JzYFngfyZNDcQp+hZIiAra0PZLcU6ZNfkQgs/96NtdnrQjOG01YI4Cz2pB
	 aJZ6EUNH8Q1ruSDsVqeNdWgiglRAPvTQdKMU2Q6Bub2zDa2B29CR9Qito04bjjW3b/
	 Phg1mL8vUn+dAkDNZSSoApvnRtC88gD9WF+LYKjVhk/m2PTy4/tJwEPGlzlUnmhDvC
	 qsqiKUqN7fPll8xbf5AmTVMw+ZR18u+NfRjGosvprd8gT9Gon4iZX/mc4QBK46pPjt
	 vGyMMt6kV5PeA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46G1JirvE251199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jul 2024 09:19:44 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 09:19:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jul 2024 09:19:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 16 Jul 2024 09:19:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Subject: Re: rtw88: The debugfs interface reads registers from the wrong device
Thread-Topic: rtw88: The debugfs interface reads registers from the wrong
 device
Thread-Index: AQHa1qbdlNhPu3M8PEuf9XqbWbxrtbH3IEAAgADosQA=
Date: Tue, 16 Jul 2024 01:19:43 +0000
Message-ID: <1d00170b5f0a39bdff6f759de300a402209ace03.camel@realtek.com>
References: <e28bbf72-678a-438b-b5dc-d4ae8b8f71f0@gmail.com>
	 <77b8adc4-daa9-4869-8773-c5de9eb84299@gmail.com>
In-Reply-To: <77b8adc4-daa9-4869-8773-c5de9eb84299@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <0250AEB40C19CC4BB424CB03D73AC5B5@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI0LTA3LTE1IGF0IDE0OjI2ICswMzAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KPiANCj4gT24gMTUvMDcvMjAyNCAxNDowNSwgQml0dGVyYmx1ZSBTbWl0aCB3cm90ZToNCj4g
PiBIaSwNCj4gPiANCj4gPiBUbyByZXByb2R1Y2UgdGhlIHByb2JsZW0sIHlvdSBuZWVkIGEgY29t
cHV0ZXIgd2l0aCB0d28gd2lmaQ0KPiA+IGRldmljZXMgc3VwcG9ydGVkIGJ5IHJ0dzg4LiBJdCdz
IGVzcGVjaWFsbHkgZWFzeSB0byBub3RpY2UNCj4gPiB0aGUgcHJvYmxlbSBpZiBvbmUgb2YgdGhl
IGRldmljZXMgaXMgVVNCIGFuZCB0aGUgb3RoZXIgaXMgUENJLA0KPiA+IGJlY2F1c2UgdGhlIFBD
SSBkZXZpY2Ugd2lsbCBoYXZlIHZhcmlvdXMgdmFsdWVzIGluIHRoZQ0KPiA+IHJlZ2lzdGVycyAw
eDMwMC4uMHgzZmYsIGJ1dCB0aGUgVVNCIGRldmljZSB3aWxsIGhhdmUgYWxsDQo+ID4gMHhlYWVh
ZWFlYSB0aGVyZS4NCj4gPiANCj4gPiAxLiBMZXQncyBhc3N1bWUgdGhlIGRyaXZlciBmb3IgdGhl
IFBDSSBkZXZpY2UgaXMgYWxyZWFkeSBsb2FkZWQuDQo+ID4gICAgSSBoYXZlIFJUTDg4MjJDRS4N
Cj4gPiANCj4gPiAyLiBNb3VudCBkZWJ1Z2ZzOg0KPiA+IA0KPiA+ICAgICMgbW91bnQgLXQgZGVi
dWdmcyBub25lIC9zeXMva2VybmVsL2RlYnVnDQo+ID4gDQo+ID4gMy4gQ2hlY2sgcGFnZSAweDMw
MDoNCj4gPiANCj4gPiAgICAjIGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy9pZWVlODAyMTEvcGh5MC9y
dHc4OC9tYWNfMw0KPiA+ICAgICAgMDAwMDAzMDAgIGY3MTM4MDAwICAgIDMzMzMwMDAwICAgIGZm
ZmZiMDAwICAgIDAwMDAwMDAwDQo+ID4gICAgICAuLi4uLg0KPiA+IA0KPiA+IDQuIFBsdWcgdGhl
IFVTQiBkZXZpY2UuIEkgdXNlZCBSVEw4ODExQ1UuDQo+ID4gDQo+ID4gNS4gQ2hlY2sgcGFnZSAw
eDMwMCBhZ2FpbjoNCj4gPiANCj4gPiAgICAjIGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy9pZWVlODAy
MTEvcGh5MC9ydHc4OC9tYWNfMw0KPiA+ICAgICAgMDAwMDAzMDAgIGVhZWFlYWVhICAgIGVhZWFl
YWVhICAgIGVhZWFlYWVhICAgIGVhZWFlYWVhDQo+ID4gICAgICAuLi4uLg0KPiA+IA0KPiA+IDYu
IEJvbnVzOiB1bmxvYWQgcnR3ODhfODgyMWN1IGFuZCBjaGVjayBwYWdlIDB4MzAwIGFnYWluIHRv
IGdldA0KPiA+ICAgIGEgbnVsbCBwb2ludGVyIGRlcmVmZXJlbmNlOg0KPiA+IA0KPiA+ICAgICMg
cm1tb2QgcnR3ODhfODgyMWN1DQo+ID4gICAgIyBjYXQgL3N5cy9rZXJuZWwvZGVidWcvaWVlZTgw
MjExL3BoeTAvcnR3ODgvbWFjXzMNCj4gDQo+IEkgZm9yZ290IHRvIHNheTogbXkga2VybmVsIGlz
IDYuOS44LWFyY2gxLTEgZnJvbSBBcmNoIExpbnV4Lg0KPiBUaGUgcHJvYmxlbSBhbHNvIGhhcHBl
bnMgd2l0aCBrZXJuZWwgNi45LjggcGx1cyBydHc4OCBmcm9tDQo+IHJ0dy1uZXh0Lg0KDQpUaGlz
IGxpbWl0YXRpb24gaXMgZXhpc3Rpbmcgc2luY2UgaW5pdGlhbCBkcml2ZXIuDQoNClRvIHJlYWQg
YSByYW5nZSBvZiBsYXJnZSByZWdpc3RlcnMgYXJlYSwgZm9yIGV4YW1wbGUsIHdlIG5lZWQgdG8N
CmEgcmFuZ2UgdmlhIHdyaXRlIG9wZXJhdGlvbiBhbmQgc3RvcmUgYXMgYSBwcml2YXRlIGRhdGEs
IGFuZA0KdGhlbiB1c2UgcmVhZCBvcGVyYXRpb24gd2l0aCBwcml2YXRlIGRhdGEgdG8gcmVhZCBy
ZWdpc3RlcnMuDQoNClRoZSBsaW1pdGF0aW9uIGlzIGJlY2F1c2UgdGhlIHByaXZhdGUgZGF0YSBp
cyBzdGF0aWMgdmFyaWFibGUuDQpBIHBvc3NpYmxlIHNvbHV0aW9uIGlzIHRvIGR1cGxpY2F0ZSBz
dGF0aWMgdmFyaWFibGUgaW50byBydHdkZXYuDQpOb3Qgc3VyZSBpZiBpdCBpcyB3b3J0aCB0byBh
ZGp1c3QgY29kZXMgZm9yIGRlYnVnIHB1cnBvc2Ugb25seS4NCg0KQW5vdGhlciBlYXNpZXIgc29s
dXRpb24gaXMgdG8gYXZvaWQgY3JlYXRpbmcgZGVidWdmcyBmb3Igc2Vjb25kDQphZGFwdGVyLiBI
b3cgZG8geW91IHRoaW5rPw0KDQoNCg==

