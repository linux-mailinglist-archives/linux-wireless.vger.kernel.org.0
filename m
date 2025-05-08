Return-Path: <linux-wireless+bounces-22725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DC0AAF175
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 05:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 420BB7B2509
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 03:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FB44B1E5E;
	Thu,  8 May 2025 03:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bOHtEAvs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3182720ED
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 03:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746673887; cv=none; b=CeFDpop45EGDedpoDVtnzpwXeSX6+qAILNikgy9JYAlGhxXWfPe3zYqHC4QiOmvSiH/dTQqVAmd0A8rpDTKWmdp7Jav1ILHnw92qYpuf/UCtjQvdpOxV2LIr5fRKbnFl38fEtsxOph/E3cn5znoPiAfXA7HpsukdAwAgmWtZjKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746673887; c=relaxed/simple;
	bh=VBNR19Cmd4d5gP4nNFECsJqdGc4C6szVZ2RUoaaVGLQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gGKesf1gVTkjQYgDVJHmDgTTMUzcd//DM4zhlhAZ7Irrx7oAI9Fk/CaIvNfPbjOKGijdk6riILuMxbqyZXO0wGCrNXgP90EhM9mQSQkTqUBVamIZEHy+MnNLoFAdaee0KVw54rJeq04vZuETN991ujMay4Tj6Z5PVDI2v+/D5XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bOHtEAvs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5483BFnB41454235, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746673876; bh=VBNR19Cmd4d5gP4nNFECsJqdGc4C6szVZ2RUoaaVGLQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=bOHtEAvsIAtYMtSd7/VoRO4IJtOtrBDpGx/kt2H7c9L8AHdBD0YWFjndsYDwaP5Go
	 FN1MipZrzTHgc/JIK5457Ba3b8a18wgpfsj5+wTiZJEMTP/9lfOYR92U1JgDPkNQlL
	 8Tqi4ubMpmtS3bMzGAyfGNrIzK6oodXeQLU9yjw6PQ/Rmz9TUYihDSrImyV1/0et51
	 iQpAXnJXO0Hn7U/CQph6DJoRuUcw4jJbOcSA4YPrvGpPMe31CZeF2D4BfhgbvtGYre
	 pY8jg1+4zO3doDMsBGLXlga20gn2SIu1N/CAnkRXuF48FPECo94mFDwaPzVwXuZ/xY
	 swyguDh7VQ3mA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5483BFnB41454235
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 May 2025 11:11:16 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 May 2025 11:11:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 May 2025 11:11:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 8 May 2025 11:11:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 1/2] wifi: rtw88: usb: Reduce control message timeout to 500 ms
Thread-Topic: [PATCH rtw-next 1/2] wifi: rtw88: usb: Reduce control message
 timeout to 500 ms
Thread-Index: AQHbv1Bpyfh3T69s/06CxnCyOORzIbPIDrzw
Date: Thu, 8 May 2025 03:11:14 +0000
Message-ID: <d661841634644d089c3250fda7ae43be@realtek.com>
References: <af4d2d58-f567-4bdf-841b-8345d21f7035@gmail.com>
In-Reply-To: <af4d2d58-f567-4bdf-841b-8345d21f7035@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBSVEw4
ODExQVUgc3RvcHMgcmVzcG9uZGluZyBkdXJpbmcgdGhlIGZpcm13YXJlIGRvd25sb2FkIG9uIHNv
bWUgc3lzdGVtczoNCj4gDQo+IFsgIDgwOS4yNTY0NDBdIHJ0d184ODIxYXUgNS0yLjE6MS4wOiBG
aXJtd2FyZSB2ZXJzaW9uIDQyLjQuMCwgSDJDIHZlcnNpb24gMA0KPiBbICA4MTIuNzU5MTQyXSBy
dHdfODgyMWF1IDUtMi4xOjEuMCB3bHA0OHMwZjR1MnUxOiByZW5hbWVkIGZyb20gd2xhbjANCj4g
WyAgODM3LjMxNTM4OF0gcnR3Xzg4MjFhdSAxLTQ6MS4wOiB3cml0ZSByZWdpc3RlciAweDFlZjQg
ZmFpbGVkIHdpdGggLTExMA0KPiBbICA4NjcuNTI0MjU5XSBydHdfODgyMWF1IDEtNDoxLjA6IHdy
aXRlIHJlZ2lzdGVyIDB4MWVmOCBmYWlsZWQgd2l0aCAtMTEwDQo+IFsgIDg2OC45MzA5NzZdIHJ0
d184ODIxYXUgNS0yLjE6MS4wIHdscDQ4czBmNHUydTE6IGVudGVyZWQgcHJvbWlzY3VvdXMgbW9k
ZQ0KPiBbICA4OTcuNzMwOTUyXSBydHdfODgyMWF1IDEtNDoxLjA6IHdyaXRlIHJlZ2lzdGVyIDB4
MWVmYyBmYWlsZWQgd2l0aCAtMTEwDQo+IA0KPiBFYWNoIHdyaXRlIHRha2VzIDMwIHNlY29uZHMg
dG8gZmFpbCBiZWNhdXNlIHRoYXQncyB0aGUgdGltZW91dCBjdXJyZW50bHkNCj4gdXNlZCBmb3Ig
Y29udHJvbCBtZXNzYWdlcyBpbiBydHdfdXNiX3dyaXRlKCkuDQo+IA0KPiBJbiB0aGlzIHNjZW5h
cmlvIHRoZSBmaXJtd2FyZSBkb3dubG9hZCB0YWtlcyBhdCBsZWFzdCAyMDAwIHNlY29uZHMuDQo+
IEJlY2F1c2UgdGhpcyBpcyBkb25lIGZyb20gdGhlIFVTQiBwcm9iZSBmdW5jdGlvbiwgdGhlIGxv
bmcgZGVsYXkgbWFrZXMNCj4gb3RoZXIgdGhpbmdzIGluIHRoZSBzeXN0ZW0gaGFuZy4NCj4gDQo+
IFJlZHVjZSB0aGUgdGltZW91dCB0byA1MDAgbXMuIFRoaXMgaXMgdGhlIHZhbHVlIHVzZWQgYnkg
dGhlIG9mZmljaWFsIFVTQg0KPiB3aWZpIGRyaXZlcnMgZnJvbSBSZWFsdGVrLg0KDQpBIHF1ZXN0
aW9uIGFib3V0IHRpbWVvdXQgdGltZS4gSXMgdGhpcyBlbm91Z2ggZm9yIFVTQiAyIG9yIG9sZGVy
Pw0KDQo+IA0KPiBPZiBjb3Vyc2UgdGhpcyBvbmx5IG1ha2VzIHRoaW5ncyBoYW5nIGZvciB+MzAg
c2Vjb25kcyBpbnN0ZWFkIG9mIH4zMA0KPiBtaW51dGVzLiBJdCBkb2Vzbid0IGZpeCB0aGUgZmly
bXdhcmUgZG93bmxvYWQuDQo+IA0KPiBUZXN0ZWQgd2l0aCBSVEw4ODIyQ1UsIFJUTDg4MTJCVSwg
UlRMODgxMUNVLCBSVEw4ODE0QVUsIFJUTDg4MTFBVSwNCj4gUlRMODgxMkFVLCBSVEw4ODIxQVUs
IFJUTDg3MjNEVS4NCj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IEZpeGVzOiBh
ODJkZmQzM2QxMjMgKCJ3aWZpOiBydHc4ODogQWRkIGNvbW1vbiBVU0IgY2hpcCBzdXBwb3J0IikN
Cj4gTGluazogaHR0cHM6Ly9naXRodWIuY29tL2x3ZmluZ2VyL3J0dzg4L2lzc3Vlcy8zNDQNCj4g
U2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+
DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

