Return-Path: <linux-wireless+bounces-27509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3A3B878A2
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 02:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 208E04E03C4
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 00:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F011B425C;
	Fri, 19 Sep 2025 00:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jys+2teh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6842734BA5A;
	Fri, 19 Sep 2025 00:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758243062; cv=none; b=TeaOQ0wIDEVLTmnAHcwrYDd2q+6MARs3LvO9wvPmMJuWJBKciTMHIhfczaIVn9m+vkZLU+rlGq5VJwN/lsuweex73eoXcoWTNbuT4nP8CsZzWd5VzUWqn6ErWiqZPuUZuWlAtREib8z/vzUic9r9FNmSMEEoMfaVcTw3doTq6kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758243062; c=relaxed/simple;
	bh=xxlnomEv4nIoxqs7NRd6I6qDcqF81xOiYQRvuJxF2d0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kl2XljHCM10mlLlP2Td/JWujm2FlyGuqKrS9raW5EE6b0JDIrNRAXbxz9d3tZ7CyMyVoIvocK/NRM9oCf+/iQ40RqeMhG0n+9PQmFbVybwJX2lVqvO6F4Xu4dEqsZhp+fSxAHJ40EQAdoOpvfAtxoVZBkSLSlzicoAmQ4nXGZtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jys+2teh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58J0oiV632871132, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758243044; bh=xxlnomEv4nIoxqs7NRd6I6qDcqF81xOiYQRvuJxF2d0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jys+2teh3KSLXov9Pen35NyYyQwsKW0ObVsS0khRc7NZp8nda7rSZjNhmIpMA5yFW
	 IrjvEX0jye5tc2XejEKYgbsZ9s8ze3UwOD5ONBV8rUDw2tQ/l5SYFXoCbxyzu0V5pK
	 jAlC1NI7mkajnb9VZh8kICPtDcbylIzAPHW30oUUF733t5Pu9zSWhO2HaNZk+uwIeH
	 RHXqi16QSXmVYoWgTuXwp+nAv/is00JkRgIZVmAuOvYm2wmt9KNbimfoR70cq7IIJh
	 IzxRz5PLR/Grm3hwGG+roq2bLLNqUgg4tN5tkIH3NgJJmgB9Zhd8dKAFvWoSEvhsX4
	 U8imc0FcI5eig==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58J0oiV632871132
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 08:50:44 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 19 Sep 2025 08:50:44 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Sep 2025 08:50:44 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Fri, 19 Sep 2025 08:50:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>
CC: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw v4 2/4] wifi: rtw89: fix tx_wait initialization race
Thread-Topic: [PATCH rtw v4 2/4] wifi: rtw89: fix tx_wait initialization race
Thread-Index: AQHcJ7j8gFkFIGygsECCjdEXp53dJbSYbw2QgAAaqwCAAR9BUIAABXPA
Date: Fri, 19 Sep 2025 00:50:43 +0000
Message-ID: <97aed12182074193b362472d32f0c9a9@realtek.com>
References: <20250917095302.2908617-1-pchelkin@ispras.ru>
 <20250917095302.2908617-3-pchelkin@ispras.ru>
 <08b25263c6874a089e4a271cb95a9cb7@realtek.com>
 <20250918173522-07abe99566c12fa46a096fc5-pchelkin@ispras>
 <7a53522bc0004a979fd78b1d6f440457@realtek.com>
In-Reply-To: <7a53522bc0004a979fd78b1d6f440457@realtek.com>
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

UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiBGZWRvciBQY2hlbGtp
biA8cGNoZWxraW5AaXNwcmFzLnJ1PiB3cm90ZToNCj4gPiBPbiBUaHUsIDE4LiBTZXAgMDU6NDcs
IFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPiA+IEZlZG9yIFBjaGVsa2luIDxwY2hlbGtpbkBpc3By
YXMucnU+IHdyb3RlOg0KPiA+ID4gPiBAQCAtMTA5NCwyMiArMTA5NCwxMyBAQCBpbnQgcnR3ODlf
Y29yZV90eF9raWNrX29mZl9hbmRfd2FpdChzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYsIHN0cnVj
dCBza19idWZmDQo+ID4gKnNrDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGludCBxc2VsLCB1bnNpZ25lZCBpbnQgdGltZW91dCkNCj4gPiA+ID4gIHsNCj4gPiA+
ID4gICAgICAgICBzdHJ1Y3QgcnR3ODlfdHhfc2tiX2RhdGEgKnNrYl9kYXRhID0gUlRXODlfVFhf
U0tCX0NCKHNrYik7DQo+ID4gPiA+IC0gICAgICAgc3RydWN0IHJ0dzg5X3R4X3dhaXRfaW5mbyAq
d2FpdDsNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgcnR3ODlfdHhfd2FpdF9pbmZvICp3YWl0ID0g
d2lwaHlfZGVyZWZlcmVuY2UocnR3ZGV2LT5ody0+d2lwaHksDQo+ID4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNrYl9kYXRh
LT53YWl0KTsNCj4gPiA+DQo+ID4gPiBDYW4ndCB3ZSBqdXN0IHBhc3MgJ3dhaXQnIGJ5IGZ1bmN0
aW9uIGFyZ3VtZW50Pw0KPiA+DQo+ID4gWWVwLg0KPiA+DQo+ID4gPg0KPiA+ID4gPiAgICAgICAg
IHVuc2lnbmVkIGxvbmcgdGltZV9sZWZ0Ow0KPiA+ID4gPiAgICAgICAgIGludCByZXQgPSAwOw0K
PiA+ID4gPg0KPiA+ID4gPiAgICAgICAgIGxvY2tkZXBfYXNzZXJ0X3dpcGh5KHJ0d2Rldi0+aHct
PndpcGh5KTsNCj4gPiA+ID4NCj4gPiA+ID4gLSAgICAgICB3YWl0ID0ga3phbGxvYyhzaXplb2Yo
KndhaXQpLCBHRlBfS0VSTkVMKTsNCj4gPiA+ID4gLSAgICAgICBpZiAoIXdhaXQpIHsNCj4gPiA+
ID4gLSAgICAgICAgICAgICAgIHJ0dzg5X2NvcmVfdHhfa2lja19vZmYocnR3ZGV2LCBxc2VsKTsN
Cj4gPiA+ID4gLSAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ID4gPiAtICAgICAgIH0NCj4g
PiA+ID4gLQ0KPiA+ID4gPiAtICAgICAgIGluaXRfY29tcGxldGlvbigmd2FpdC0+Y29tcGxldGlv
bik7DQo+ID4gPiA+IC0gICAgICAgd2FpdC0+c2tiID0gc2tiOw0KPiA+ID4gPiAtICAgICAgIHJj
dV9hc3NpZ25fcG9pbnRlcihza2JfZGF0YS0+d2FpdCwgd2FpdCk7DQo+ID4gPiA+IC0NCj4gPiA+
DQo+ID4gPiBIZXJlLCBvcmlnaW5hbCBjb2RlIHByZXBhcmVzIGNvbXBsZXRpb24gYmVmb3JlIFRY
IGtpY2sgb2ZmLiBIb3cgaXQgY291bGQNCj4gPiA+IGJlIGEgcHJvYmxlbT8gRG8gSSBtaXNzIHNv
bWV0aGluZz8NCj4gPg0KPiA+IFRoYXQncyBhIGdvb2QgcXVlc3Rpb24gYW5kIGl0IG1hZGUgbWUg
cmV0aGluayB0aGUgY2F1c2Ugb2YgdGhlIHJhY2UNCj4gPiBzY2VuYXJpby4gIEkgZGlkbid0IGlu
aXRpYWxseSB0YWtlIFRYIGtpY2sgb2ZmIGludG8gY29uc2lkZXJhdGlvbiB3aGVuDQo+ID4gaXQg
YWN0dWFsbHkgbWF0dGVycy4NCj4gDQo+IERvIGl0IG1lYW4gdGhhdCB5b3UgcGljdHVyZWQgdGhl
IHJhY2luZyBzY2VuYXJpbyBpbiBjb21taXQgbWVzc2FnZSBieQ0KPiBjb2RlIHJldmlldyBpbnN0
ZWFkIG9mIGEgcmVhbCBjYXNlIHlvdSBtZXQ/DQo+IA0KPiA+DQo+ID4gVGhlIHRoaW5nIGlzOiB0
aGVyZSBtaWdodCBoYXZlIGJlZW4gYW5vdGhlciB0aHJlYWQgaW5pdGlhdGluZyBUWCBraWNrIG9m
Zg0KPiA+IGZvciB0aGUgc2FtZSBxdWV1ZSBpbiBwYXJhbGxlbC4gIEJ1dCBubyBzdWNoIHRocmVh
ZCBleGlzdHMgYmVjYXVzZSBhIHRha2VuDQo+ID4gd2lwaHkgbG9jayBnZW5lcmFsbHkgcHJvdGVj
dHMgZnJvbSBzdWNoIHNpdHVhdGlvbnMuIHJ0dzg5X2NvcmVfdHhxX3NjaGVkdWxlKCkNCj4gPiB3
b3JrZXIgbG9va3MgbGlrZSBhIGdvb2QgY2FuZGlkYXRlIGJ1dCBpdCBkb2Vzbid0IG9wZXJhdGUg
b24gdGhlIG5lZWRlZA0KPiA+IG1hbmFnZW1lbnQgcXVldWVzLg0KPiANCj4gTGFzdCBuaWdodCBJ
IGFsc28gdGhvdWdodCBpZiBhbm90aGVyIHRocmVhZCB3b3JrcyBpbiBwYXJhbGxlbC4NCj4gTWF5
YmUgcnR3ODlfb3BzX3R4KCkgY291bGQgYmU/DQo+IA0KPiA+DQo+ID4gU28gSSBtYXkgY29uY2x1
ZGUgdGhpcyBwYXRjaCBkb2Vzbid0IGZpeCBhbnkgcmVhbCBidWcgdGhvdWdoIEknZCBwcmVmZXIg
dG8NCj4gPiBrZWVwIGl0ICh3aXRoIGRlc2NyaXB0aW9uIHJld3JpdHRlbiBvZiBjb3Vyc2UpIGJl
Y2F1c2UgaXQgaGVscHMgdG8gYXZvaWQNCj4gPiBwb3RlbnRpYWwgaXNzdWVzIGluIGZ1dHVyZS4N
Cj4gDQo+IEFncmVlLg0KPiANCg0KRm9yZ290IHRvIHNheS4gQ291bGQgeW91IG1lbnRpb24gdGhp
cyByYWNpbmcgc2NlbmFyaW8gd2FzIGZvdW5kIGJ5IGNvcmUNCnJldmlldyBhbmQgeW91ciBwZXJz
cGVjdGl2ZSBpbiBjb21taXQgbWVzc2FnZT8gDQoNCg0K

