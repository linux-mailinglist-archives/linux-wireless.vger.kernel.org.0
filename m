Return-Path: <linux-wireless+bounces-27948-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DB2BD1025
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Oct 2025 03:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697173B9193
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Oct 2025 01:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46D73594F;
	Mon, 13 Oct 2025 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="r187yzH0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCE54C97;
	Mon, 13 Oct 2025 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760317206; cv=none; b=Wf3h0r/byelKTA2aZCGE4HgPQJELEjKJeaRuibnHJvykwrilUTGpRjEEaacrJKA1+0SEHnvLirbxk/MY8WKggpd3swMh1ABVxK/GpUVKE9T7bt+Fi6SUh5P2EK5JF/67JcxTfk1F3I/Db1R1vNlaIuemgWmKuHYAcMIfyb9k8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760317206; c=relaxed/simple;
	bh=a9D9IG3PSDShqFsyr2lmyTeOA5Qqin/IbeEHsmZFJeY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JJADBOG0uI7hirScVyMvk7ezLblknxvNclebFJgzDcTygfZoIEawW1y8eMuHPUucGA/aWJOFIbtjW0cDH/gv7xymQ+93gK8Aa0Xi9Y56eTh2XJMy6HgPVCuj/zIeuzAwx6+kfyXusDPIO2PF7Wr1nbef0m+2sobo6jkjZUPPSEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=r187yzH0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59D0xVcrD532587, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1760317171; bh=a9D9IG3PSDShqFsyr2lmyTeOA5Qqin/IbeEHsmZFJeY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=r187yzH0a8ToknsbEwynx0SBaWRw2PJxSreP8YsOR/7brL0MGgJT59wUGDDvSrIjt
	 Q79YesievKcHN3Z8Vpb5YvgxQyxiPetduO9nRzNiw6ueXYqT1TErIJbdcp9lz0maYj
	 tmNdphZMkwNpqOLmAo5uLun5+p3SlVqLOVTdh+QCb/BNBSQQEK0U/6A4ySDTb8A6x0
	 XNzSKcZVWQTOx+GJmkWEm+PBOczbgWYb0S9EGIx0SxxTt3qUJnbrzG75c5kwnebbKU
	 KlYQoC6nTH5e0xmay6QOC3ZwnCYhnDQdyyzGqYkU7DCyZlN2BsuNMW4dcdt1V2HSfC
	 3xXcsXN4HPkyw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59D0xVcrD532587
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 08:59:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 13 Oct 2025 08:59:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Mon, 13 Oct 2025 08:59:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Zong-Zhe Yang
	<kevin_yang@realtek.com>,
        Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw-next v2 7/7] wifi: rtw89: process TX wait skbs for USB via C2H handler
Thread-Topic: [PATCH rtw-next v2 7/7] wifi: rtw89: process TX wait skbs for
 USB via C2H handler
Thread-Index: AQHcM9il/GZvLLVcMUW99DlZMhOcmbS2QTFAgAZi/oCAAqtWwA==
Date: Mon, 13 Oct 2025 00:59:31 +0000
Message-ID: <04b364eb49a4465a826fdc92e5ca5680@realtek.com>
References: <20251002200857.657747-1-pchelkin@ispras.ru>
 <20251002200857.657747-8-pchelkin@ispras.ru>
 <d72c6bf8618b4245939fd73cd9e24acd@realtek.com>
 <20251011175758-9e1b3340d51ac93a2663a800-pchelkin@ispras>
In-Reply-To: <20251011175758-9e1b3340d51ac93a2663a800-pchelkin@ispras>
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

RmVkb3IgUGNoZWxraW4gPHBjaGVsa2luQGlzcHJhcy5ydT4gd3JvdGU6DQo+IE9uIFR1ZSwgMDcu
IE9jdCAwODowNywgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IEZlZG9yIFBjaGVsa2luIDxwY2hl
bGtpbkBpc3ByYXMucnU+IHdyb3RlOg0KPiA+ID4gQEAgLTExNzMsNyArMTE3Myw4IEBAIGludCBy
dHc4OV9jb3JlX3R4X2tpY2tfb2ZmX2FuZF93YWl0KHN0cnVjdCBydHc4OV9kZXYgKnJ0d2Rldiwg
c3RydWN0IHNrX2J1ZmYgKnNrDQo+ID4gPg0KPiA+ID4gICAgICAgICBpZiAodGltZV9sZWZ0ID09
IDApIHsNCj4gPiA+ICAgICAgICAgICAgICAgICByZXQgPSAtRVRJTUVET1VUOw0KPiA+ID4gLSAg
ICAgICAgICAgICAgIGxpc3RfYWRkX3RhaWwoJndhaXQtPmxpc3QsICZydHdkZXYtPnR4X3dhaXRz
KTsNCj4gPiA+ICsgICAgICAgICAgICAgICBpZiAoIXJ0d2Rldi0+aGNpLnR4X3JwdF9lbmFibGUp
DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBsaXN0X2FkZF90YWlsKCZ3YWl0LT5saXN0
LCAmcnR3ZGV2LT50eF93YWl0cyk7DQo+ID4NCj4gPiBPaC4gWW91IGF2b2lkIHVzaW5nIHJ0d2Rl
di0+dHhfd2FpdHMgZm9yIFVTQi4gQnV0IEknZCBsaWtlIHRvIGhhdmUgdGhlIHNhbWUNCj4gPiBi
ZWhhdmlvciBhcyBQQ0lFLg0KPiANCj4gSSBtYXkgYmUgY29uZnVzZWQgYnV0IGRvZXNuJ3QgaXQg
Y29uZmxpY3Qgd2l0aCB0aGUgY29tbWVudCBbMV0geW91J3ZlDQo+IHBvc3RlZCB0byB0aGUgcHJl
dmlvdXMgdmVyc2lvbj8gIEkndmUgdHJlYXRlZCB0aGF0IGFzIHdlIHNob3VsZCB1c2UNCj4gcnR3
ZGV2LT50eF9ycHRfcXVldWUgZm9yIGJvdGggVFggd2FpdCBhbmQgSUVFRTgwMjExX1RYX0NUTF9S
RVFfVFhfU1RBVFVTDQo+IGZyYW1lcy4uLg0KDQpZZXMuIEkgZ290IHRoaXMgdGhvdWdodCBhZnRl
ciByZXZpZXdpbmcgd2hvbGUgdjIuDQoNCj4gDQo+IEknbSBhbGwgZm9yIGZvbGxvd2luZyB0aGUg
UENJZS1zdHlsZSBhcyBwb3NzaWJsZSwgdG9vLCBidXQgdGhlbiBpbml0aWFsDQo+IGNvbW1lbnQg
WzFdIGJlY29tZXMgaXJyZWxldmFudCwgcmlnaHQ/DQo+IA0KPiBbMV06IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzL2MyYzQwYmVkMzExYzRmMDU5NDhjZjI1NDFjNjRlYTMw
QHJlYWx0ZWsuY29tLw0KDQpBdCB0aGUgWzFdLCBJIHdhbnRlZCB0byBpdGVyYXRlIHNrYidzIGlu
IHJ0d2Rldi0+dHhfcnB0X3F1ZXVlLCBhbmQgdGhlbiBjYWxsDQpydHc4OV9jb3JlX3R4X3dhaXRf
Y29tcGxldGUoKSBpZiAnd2FpdCcgZXhpc3RpbmcgaW4gUlRXODlfVFhfU0tCX0NCKCkuDQoNCkkg
dGhpbmsgdGhlIGlkZWEgaXMgc2ltaWxhciwgYnV0IEkgbWlnaHQgbm90IGhhdmUgY2xlYXIgcGlj
dHVyZSBhdCB2MSByZXZpZXcuDQpJZiB5b3UgZmVlbCB0aGV5IGFyZSBjb25mbGljdCwganVzdCBj
aGVjayBhbmQgZGlzY3VzcyB3aXRoIG5ldyBjb21tZW50cy4NCg0K

