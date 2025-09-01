Return-Path: <linux-wireless+bounces-26883-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3F1B3D6D1
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 04:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B243B8AB8
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 02:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999D21DE8AE;
	Mon,  1 Sep 2025 02:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="drWOiQom"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5292F199BC
	for <linux-wireless@vger.kernel.org>; Mon,  1 Sep 2025 02:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756695077; cv=none; b=qNDN6QU+KK/DWFMwXykL6S3z1T/gU43+Hinl2d2G8u9BY849b8FK5GOCHXHIDFa+4YLvYqSzxtwjYSCd0f0oYEVQA28GUDGS4fgEC/achUBFd7B4UV8gw6ueQGWicyWfvzj01/KhNhlUUd9QzRnwEvZS04zWUoxDh/bUTswICA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756695077; c=relaxed/simple;
	bh=El6CHhhObJ9kvEiHEc103TKYF1H1uXm2DupXN8lEzo8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c+/u6ytGXT/KpAimqY3l9FOj7vT53h56xjmXuDN0Aniyc2hoEcX1KiREoCuRLDvM1alVzRxB8pi0Zfh8mGxpwCUBHm/wm1gVeX3bDTYoBh0yuP9ePomRwdthWRHx++x9Vor88lJ36VISaDii6z1yWRRL3NEtpyKL/Uj6QaU7Rc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=drWOiQom; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5812pB5s9170788, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756695071; bh=El6CHhhObJ9kvEiHEc103TKYF1H1uXm2DupXN8lEzo8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=drWOiQomnTPIWHT1oDeBqOmrZq/gxBt9XyLJxQl9YSTcVNh9IbdMht7MDyNmdWGcI
	 Lsux0VVTCHvYCkEInBAllgi1t92Pf50OrDRr6MxOtQkW1HVLJ3E8OynZAzlEvNFTSk
	 8xbJYQHe6TNEmJW8kpoOl/LFg9h5qkBuxbu0PbO9KegRoDSOP0StDbp4lzUX7qf4Yl
	 8ESBQV6NtFTvihZFN6aQIRbZX3lYaUyro1RJwbgU4+wrY5q7ifIf8RUzkkPjGsPhrx
	 J80DnNDItEu88S88zuVI06U7xS8Iyn+OzvzkQU4QaOrNqGZ2CqAUZ3TpMUb4tUVArU
	 iBqObq4dSHPKw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5812pB5s9170788
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Sep 2025 10:51:11 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 1 Sep 2025 10:51:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 1 Sep 2025 10:51:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Mon, 1 Sep 2025 10:51:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        =?utf-8?B?0JDQu9C10LrRgdC10Lkg0KHQvNC40YDQvdC+0LI=?= <debugger94@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Jes
 Sorensen" <Jes.Sorensen@gmail.com>
Subject: RE: Remove TL-WN722N V2 from untested devices
Thread-Topic: Remove TL-WN722N V2 from untested devices
Thread-Index: AQHcE0qp+1KL1vhWdkOEst7MHC1MGrRy4ccg///f4YCAAVXjEIAJl3ug
Date: Mon, 1 Sep 2025 02:51:10 +0000
Message-ID: <7b8841cc3be54bdebc09522e44a39615@realtek.com>
References: <CAAN7eZ7QKEeQgNHEBuZKy4Gqg3oqpGi6BUdOVBOxPN7dedhVJQ@mail.gmail.com>
 <6851d6d86fb84b2d8f5a787906bc58cd@realtek.com>
 <d05522ce-48e6-4e7a-bbdd-327a6fb3dd99@gmail.com>
 <1830368c466c4b17999a7f2c76b7f6c8@realtek.com>
In-Reply-To: <1830368c466c4b17999a7f2c76b7f6c8@realtek.com>
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

UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiArIEplcw0KPiANCj4g
Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+IE9u
IDI1LzA4LzIwMjUgMDg6NTcsIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPiA+INCQ0LvQtdC60YHQ
tdC5INCh0LzQuNGA0L3QvtCyIDxkZWJ1Z2dlcjk0QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPj4g
SSBoYXZlIGJlZW4gdXNpbmcgdGhpcyBXaS1GaSBkb25nbGUgZm9yIG1hbnkgeWVhcnMgbm93IGFu
ZCBoYXZlIGhhZCBubw0KPiA+ID4+IHByb2JsZW1zIHdpdGggaXQuIFRoZSBkZXZpY2UgaXMgcXVp
dGUgb2xkIGFuZCBrbm93biwgZHVtcGluZyBpdHMgZWZ1c2UgdG8NCj4gPiA+PiB0aGUgbG9nIGFu
ZCBhc2tpbmcgdGhlIHVzZXIgdG8gc2VuZCB0aGUgcmVzdWx0cyB0byBKZXMuU29yZW5zZW5AZ21h
aWwuY29tDQo+ID4gPj4gb24gZXZlcnkgYm9vdCBtYWtlcyBsaXR0bGUgc2Vuc2UuIFBsZWFzZSBh
cHBseToNCj4gPiA+DQo+ID4gPiBJJ2xsIHJlcGhyYXNlIGNvbW1pdCBtZXNzYWdlIHdoZW4gSSBt
ZXJnZSB0aGlzOg0KPiA+ID4NCj4gPiA+IHdpZmk6IHJ0bDh4eHh1OiBSZW1vdmUgVEwtV043MjJO
IFYyICgweDIzNTc6IDB4MDEwYykgZnJvbSB1bnRlc3RlZCBkZXZpY2VzDQo+ID4gPg0KPiA+ID4g
VGhpcyBXaS1GaSBkb25nbGUgaGFzIGJlZW4gdXNlZCBmb3IgbWFueSB5ZWFycyBub3cgYW5kIGhh
dmUgaGFkIG5vIHByb2JsZW1zDQo+ID4gPiB3aXRoIGl0LiBUaGUgZGV2aWNlIGlzIHF1aXRlIG9s
ZCBhbmQga25vd24sIGR1bXBpbmcgaXRzIGVmdXNlIHRvIHRoZSBsb2cgYW5kDQo+ID4gPiBhc2tp
bmcgdGhlIHVzZXIgdG8gc2VuZCB0aGUgcmVzdWx0cyB0byBKZXMuU29yZW5zZW5AZ21haWwuY29t
IG9uIGV2ZXJ5IGJvb3QNCj4gPiA+IG1ha2VzIGxpdHRsZSBzZW5zZS4NCj4gPiA+DQo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiDQkNC70LXQutGB0LXQuSDQodC80LjRgNC90L7QsiA8ZGVidWdnZXI5NEBn
bWFpbC5jb20+DQo+ID4gPiBSZXZpZXdlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRl
ay5jb20+DQo+ID4gPg0KPiA+ID4+DQo+ID4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvY29yZS5jDQo+ID4gPj4gYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0bDh4eHh1L2NvcmUuYw0KPiA+ID4+IGluZGV4IDgzMWI1MDI1YzYzNC4u
MTEzZTAxZGYwOTAyIDEwMDY0NA0KPiA+ID4+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnRsOHh4eHUvY29yZS5jDQo+ID4gPj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydGw4eHh4dS9jb3JlLmMNCj4gPiA+PiBAQCAtNzgxNSw3ICs3ODE1LDcgQEAgc3Rh
dGljIGludCBydGw4eHh4dV9wcm9iZShzdHJ1Y3QgdXNiX2ludGVyZmFjZSAqaW50ZXJmYWNlLA0K
PiA+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgIHVudGVzdGVkID0gMDsNCj4gPiA+PiAgICAg
ICAgICAgICAgICAgYnJlYWs7DQo+ID4gPj4gICAgICAgICBjYXNlIDB4MjM1NzoNCj4gPiA+PiAt
ICAgICAgICAgICAgICAgaWYgKGlkLT5pZFByb2R1Y3QgPT0gMHgwMTA5IHx8IGlkLT5pZFByb2R1
Y3QgPT0gMHgwMTM1KQ0KPiA+ID4+ICsgICAgICAgICAgICAgICBpZiAoaWQtPmlkUHJvZHVjdCA9
PSAweDAxMDkgfHwgaWQtPmlkUHJvZHVjdCA9PSAweDAxMGMNCj4gPiA+PiB8fCBpZC0+aWRQcm9k
dWN0ID09IDB4MDEzNSkNCj4gPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICB1bnRlc3RlZCA9
IDA7DQo+ID4gPj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4+ICAgICAgICAgY2FzZSAw
eDBiMDU6DQo+ID4gPg0KPiA+DQo+ID4gSSBwcm9wb3NlIHdlIHNpbXBseSByZW1vdmUgdGhlIGVu
dGlyZSBsaXN0IG9mIHRlc3RlZCBkZXZpY2VzLiBJdCdzIG5vdA0KPiA+IHBhcnRpY3VsYXJseSB1
c2VmdWwgdG8gdGVsbCBwZW9wbGUgdG8gcmVwb3J0IGlmIGEgZGV2aWNlIHdvcmtzIG9yIG5vdC4N
Cj4gPiBJZiBpdCBkb2Vzbid0IHdvcmsgdGhleSB3aWxsIHJlcG9ydCBpdCBhbnl3YXkuDQo+IA0K
PiBUaGlzIHVudGVzdGVkIGZsYWcgd2FzIGFkZGVkIHNpbmNlIDIwMTUgYXQgZmlyc3QgY29tbWl0
LCBidXQgSSB3YXNuJ3QgaGVyZQ0KPiBhdCB0aGF0IHRpbWUuIEplcywgY291bGQgeW91IHBsZWFz
ZSBjb21tZW50IHRoaXMgdW50ZXN0ZWQgcmVwb3J0IG9mIGVmdXNlDQo+IGlzIHN0aWxsIHVzZWZ1
bCBub3c/DQo+IA0KDQpJIG1lcmdlZCB0aGlzIHBhdGNoIGFoZWFkLCBhbmQgd2UgbWF5IHJlbHkg
b24gTWFydGluJ3MgcGF0Y2ggWzFdIHRvIGdldA0KZWZ1c2UgY29udGVudCwgc28gYWZ0ZXIgdGhh
dCBwYXRjaCBnZXRzIG1lcmdlZCwgdGhlICd1bnRlc3RlZCcgc3R1ZmYNCmNhbiBiZSByZW1vdmVk
IGVudGlyZWx5Lg0KDQpbMV0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xp
bnV4LXdpcmVsZXNzL3BhdGNoLzIwMjUwODI2MDkwMDE1LjE1NTI5MzktMS1tYXJ0aW4ua2Fpc3Ry
YUBsaW51dHJvbml4LmRlLw0KDQoNCg==

