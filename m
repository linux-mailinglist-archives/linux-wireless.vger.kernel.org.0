Return-Path: <linux-wireless+bounces-29140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A59C71F30
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 04:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E46864E4899
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 03:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88678256C9E;
	Thu, 20 Nov 2025 03:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="OSoPzqG4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F372BE7DC
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 03:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763608635; cv=none; b=Eo4saD/CUB3jrbq+d6juSLlvzJrtFlblYjWe4MIesMr8vIHRImSiGf1rnWdeWfwS/nGEqr3aTXcPd11VCWSbHaXQC1JoGuypHRNijQ5E0J/I+CtxE1W5AXlWM2DtjgQ+6crfoKCjtFRoa7HxIY667rrBaM2S3PS4bueGHIjpuUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763608635; c=relaxed/simple;
	bh=vVUKBgh9MCACFqjoMlTt2RrrwRFUpunPd8Yo5TTz00w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ijDQjRwtbMY35+TfRvXxDEz/lZ0gMNH64PpwCWTf16/zHsuqGpd/eSDgDtxuzmk88m9uaO+uBQmjtAcILd+R08dyZUH14i5eE/yFfJ5Sr6o9FGsiBMzyzz4hdOwrIWjGEYjWmOaSk/XrnSrpMYPj7l17Ju/ACXLZEY+KXt2rUr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=OSoPzqG4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AK3H8tcC703062, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763608628; bh=vVUKBgh9MCACFqjoMlTt2RrrwRFUpunPd8Yo5TTz00w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=OSoPzqG4viSaZGoWOyeu0a122jwF5dl6hmEmrAOKBs0VDN4Y9zPCAgUER3VdIda83
	 Lty9acF3D30fbyvBOq9cbLB5w1mzjmInXGEnwgpCrjeGq9CChGg8CecEGmE3VpGwsJ
	 NFs8Kd1n6wyu0HTL7Gdkj//Vzs2uh8nxosclsf8W23GvaCZXURSTJfAOKLty2Y1XUn
	 vxGLYrP8mqfx+2vemEbJQW4diKyIZYTskKyTeZcFVEAvte5ezYiwvVTgL2Tm1vWnuL
	 C+E6e20bcBVogbjHcb4e9ngZ/9PfJW7jdD13Ku9ujUDcA+QNag49HiwtA849H3MW5D
	 sh1atWrY2Ve7A==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AK3H8tcC703062
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 11:17:08 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 20 Nov 2025 11:17:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 20 Nov 2025 11:17:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Thu, 20 Nov 2025 11:17:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw] wifi: rtw89: hw_scan: Don't let the operating channel
 be last
Thread-Topic: [PATCH rtw] wifi: rtw89: hw_scan: Don't let the operating
 channel be last
Thread-Index: AQHcVPCJR7vyR3KM2kO33b+/uTOxg7T3tzBQgADMU4CAAmneUA==
Date: Thu, 20 Nov 2025 03:17:05 +0000
Message-ID: <a4fa21a5b7494a439075690d7ae2b99b@realtek.com>
References: <c1e61744-8db4-4646-867f-241b47d30386@gmail.com>
 <5b0834f55d91469282a0f42c651d5441@realtek.com>
 <9e053524-3ab0-4d8f-9c08-1a2d0caa1892@gmail.com>
In-Reply-To: <9e053524-3ab0-4d8f-9c08-1a2d0caa1892@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAx
OC8xMS8yMDI1IDA0OjE3LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBTY2FubmluZyBjYW4gYmUg
b2ZmbG9hZGVkIHRvIHRoZSBmaXJtd2FyZS4gVG8gdGhhdCBlbmQsIHRoZSBkcml2ZXINCj4gPj4g
cHJlcGFyZXMgYSBsaXN0IG9mIGNoYW5uZWxzIHRvIHNjYW4sIGluY2x1ZGluZyBwZXJpb2RpYyB2
aXNpdHMgYmFjayB0bw0KPiA+PiB0aGUgb3BlcmF0aW5nIGNoYW5uZWwsIGFuZCBzZW5kcyB0aGUg
bGlzdCB0byB0aGUgZmlybXdhcmUuDQo+ID4+DQo+ID4+IFdoZW4gdGhlIGNoYW5uZWwgbGlzdCBp
cyB0b28gbG9uZyB0byBmaXQgaW4gYSBzaW5nbGUgSDJDIG1lc3NhZ2UsIHRoZQ0KPiA+PiBkcml2
ZXIgc3BsaXRzIHRoZSBsaXN0LCBzZW5kcyB0aGUgZmlyc3QgcGFydCwgYW5kIHRlbGxzIHRoZSBm
aXJtd2FyZSB0bw0KPiA+PiBzY2FuLiBXaGVuIHRoZSBzY2FuIGlzIGNvbXBsZXRlLCB0aGUgZHJp
dmVyIHNlbmRzIHRoZSBuZXh0IHBhcnQgb2YgdGhlDQo+ID4+IGxpc3QgYW5kIHRlbGxzIHRoZSBm
aXJtd2FyZSB0byBzY2FuLg0KPiA+Pg0KPiA+PiBXaGVuIHRoZSBsYXN0IGNoYW5uZWwgdGhhdCBm
aXQgaW4gdGhlIEgyQyBtZXNzYWdlIGlzIHRoZSBvcGVyYXRpbmcNCj4gPj4gY2hhbm5lbCBzb21l
dGhpbmcgc2VlbXMgdG8gZ28gd3JvbmcgaW4gdGhlIGZpcm13YXJlLiBJdCB3aWxsDQo+ID4+IGFj
a25vd2xlZGdlIHJlY2VpdmluZyB0aGUgbGlzdCBvZiBjaGFubmVscyBidXQgYXBwYXJlbnRseSBp
dCB3aWxsIG5vdA0KPiA+PiBkbyBhbnl0aGluZyBtb3JlLiBUaGUgQVAgY2FuJ3QgYmUgcGluZ2Vk
IGFueW1vcmUuIFRoZSBkcml2ZXIgc3RpbGwNCj4gPj4gcmVjZWl2ZXMgYmVhY29ucywgdGhvdWdo
Lg0KPiA+Pg0KPiA+PiBPbmUgd2F5IHRvIGF2b2lkIHRoaXMgaXMgdG8gc3BsaXQgdGhlIGxpc3Qg
b2YgY2hhbm5lbHMgYmVmb3JlIHRoZQ0KPiA+PiBvcGVyYXRpbmcgY2hhbm5lbC4NCj4gPj4NCj4g
Pj4gQWZmZWN0ZWQgZGV2aWNlczoNCj4gPj4NCj4gPj4gKiBSVEw4ODUxQlUgd2l0aCBmaXJtd2Fy
ZSAwLjI5LjQxLjMNCj4gPj4gKiBSVEw4ODMyQlUgd2l0aCBmaXJtd2FyZSAwLjI5LjI5LjgNCj4g
Pj4gKiBSVEw4ODUyQlUgd2l0aCBmaXJtd2FyZSAwLjI5LjI5LjgNCj4gDQo+IEkgbWFkZSBhIG1p
c3Rha2UgaGVyZS4gSXQgc2hvdWxkIGJlOg0KPiANCj4gUlRMODg1MUJVDQo+IFJUTDg4MzJCVQ0K
PiBSVEw4ODUyQkUNCg0KSSdsbCByZS1zcGluIGNvbW1pdCBtZXNzYWdlIHdpdGggdGhpcyBpbmZv
cm1hdGlvbi4NCg0KPiANCj4gVGhlIHJlcG9ydCBhYm91dCB0aGUgUlRMODg1MkJFIGNhbWUgZnJv
bSBhIHVzZXIgd2hvIGRvZXNuJ3QgaGF2ZSB0aGUNCj4gY2FyZCBhbnltb3JlLCB1bmZvcnR1bmF0
ZWx5Lg0KPiANCj4gQWN0dWFsbHksIHNpbmNlIEkgd3JvdGUgdGhhdCBjb21taXQgbWVzc2FnZSBJ
IGFjcXVpcmVkIFJUTDg4NTFCRSBhbmQNCj4gSSBjYW4gcmVwcm9kdWNlIHRoZSBwcm9ibGVtIHdp
dGggdGhhdC4NCj4gDQoNCkkgZG9uJ3Qga25vdyB3aHkgb3VyIHNpdGUgY2FuJ3QgcmVwcm9kdWNl
IHRoaXMgaXNzdWUuIFNpbmNlIHRoaXMgcGF0Y2gNCmNhbiBoZWxwIHlvdXIgYW5kIG5vIG9idmlv
dXMgaW5jcmVhc2luZyBzY2FuIHRpbWUsIEkgd2lsbCB0YWtlIHRoaXMNCnBhdGNoIGFuZCBzZW5k
IHB1bGwtcmVxdWVzdCB0byA2LjE4LXJjNi4NCg0K

