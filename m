Return-Path: <linux-wireless+bounces-3540-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C10F85322B
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 14:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEEC31F21B08
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 13:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C09356444;
	Tue, 13 Feb 2024 13:44:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA36E3A1D9
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831846; cv=none; b=GX3WPRkpeuMybHkqAe3AMQ90h07BWkucwNt/Mj4keRCAWScdfwvq3qsDTmXVOn0ipLkEvKxphnqVDbYbW5Lyd8JcLFtAdD89arYqCv+6RSfVwqWmmli+N2DxCpQNzJQZq9tpmZGLNnHzV5lKJ33UMZJDZ4efGFWhrjg54SEzqAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831846; c=relaxed/simple;
	bh=8Gc/X6aUttyvrEK7D+t4j25bGJP0Qq+NxHJEShSF8o8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MdxaD0Xvf+F0/YadK3h6QYMdXtl9ZM6hg3RkU8IH6CeSNNOsnrfNvU8qUZkajEtLuhQ1cmWTcUN8XEBhpVJ3E6ZzzZpVI/rR4ygfLFsnL+Q8YW1yYirdGy/rLPFj/K0+cR7yJMVS4BAjf9JRoUnBiqrpPXVnxH2gsYiCt3iXl1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41DDhkXT31738869, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41DDhkXT31738869
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 21:43:46 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Tue, 13 Feb 2024 21:43:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 21:43:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Tue, 13 Feb 2024 21:43:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "kvalo@kernel.org" <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>
Subject: Re: [PATCH] wifi: rtw89: fw: remove unnecessary rcu_read_unlock() for punctured
Thread-Topic: [PATCH] wifi: rtw89: fw: remove unnecessary rcu_read_unlock()
 for punctured
Thread-Index: AQHaXngKdGa2OX5o7UibcRlIUUMYS7EIOpt+//+HhQA=
Date: Tue, 13 Feb 2024 13:43:46 +0000
Message-ID: <f8b28bf1f735432489c1674d62fc68a8cf475ee8.camel@realtek.com>
References: <20240213122556.9593-1-pkshih@realtek.com>
	 <87ttmced8l.fsf@kernel.org>
In-Reply-To: <87ttmced8l.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC6D9660F3F60E41BB246C831AA351CB@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gVHVlLCAyMDI0LTAyLTEzIGF0IDE0OjU0ICswMjAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiAN
Cj4gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyaXRlczoNCj4gDQo+ID4gVGhl
IHJjdV9yZWFkX3VubG9jaygpIGlzIGFjY2lkZW50YWxseSBhZGRlZCwgYW5kIHNwYXJzZSB3YXJu
Og0KPiA+IA0KPiA+ICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5jOjI4
MDc6MTc6DQo+ID4gICAgIHdhcm5pbmc6IGNvbnRleHQgaW1iYWxhbmNlIGluICdydHc4OV9md19o
MmNfYXNzb2NfY21hY190YmxfZzcnIC0gdW5leHBlY3RlZCB1bmxvY2sNCj4gPiANCj4gPiBGaXhl
czogYjgyNzMwYmY1N2I1ICgid2lmaTogY2ZnODAyMTEvbWFjODAyMTE6IG1vdmUgcHVuY3R1cmlu
ZyBpbnRvIGNoYW5kZWYiKQ0KPiA+IENjOiBKb2hhbm5lcyBCZXJnIDxqb2hhbm5lcy5iZXJnQGlu
dGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVr
LmNvbT4NCj4gDQo+IENvbW1pdCBiODI3MzBiZjU3YjUgaXMgaW4gd2lyZWxlc3MtbmV4dCBzbyBJ
J2xsIHF1ZXVlIHRoaXMgcGF0Y2ggdG8NCj4gd2lyZWxlc3MtbmV4dCBhcyB3ZWxsLCByaWdodD8N
Cg0KSSB0aGluayB5ZXMuDQoNCj4gDQo+IFRoaXMgYWdhaW4gc2hvd3MgaG93IGltcG9ydGFudCBp
dCBpcyB0byBmaXggYWxsIHRoZSByZW1haW5naW5nIHNwYXJzZQ0KPiB3YXJuaW5ncyBpbiB3aXJl
bGVzcyBjb2RlIHNvIHRoYXQgd2UgZG9uJ3QgbWlzcyBpbXBvcnRhbnQgd2FybmluZ3MgbGlrZQ0K
PiB0aGlzLiBJZiB0aGVyZSBqdXN0IHdvdWxkIGJlIGEgd2F5IHRvIGdldCB0aGUgY2xlYW51cCBw
YXRjaCBzdWJtaXR0ZXJzDQo+IHRvIGZpeCB0aGUgc3BhcnNlIHdhcm5pbmdzLCBzaWdoLg0KPiAN
Cg0KSW4gc2hvcnQgdGVybSwgY2FuIHdlIHJlY29yZCB0aGUgY291bnQgb2Ygd2FybmluZ3MgYW5k
IGVuc3VyZSBpdA0KZG9lc24ndCBpbmNyZWFzZSB3aGlsZSBuZXcgY29tbWl0cyBhcmUgZ2V0dGlu
ZyBtZXJnZWQ/IA0KDQpQaW5nLUtlIA0KDQo=

