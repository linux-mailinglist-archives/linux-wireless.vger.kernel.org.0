Return-Path: <linux-wireless+bounces-24375-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA950AE5856
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 02:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06B377A2754
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 00:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B780329A2;
	Tue, 24 Jun 2025 00:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="EZRxG1sa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32AA2114;
	Tue, 24 Jun 2025 00:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750724054; cv=none; b=NWIY3MmTRHBZL+rsE8EwRP9x6t5JLU1+yRG+zcV/llHX97v1piyF3lfvzHSZIGG35FT7q1eldCYSa9ZXjk8SAOv99wZDUwDuTeUgpMJ49tAvTdZVUbtKJtNAjU6hjPSdsAzvOKKPPumS9wMHMlGQFHhy1vqbLL4nsv8ApISrEf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750724054; c=relaxed/simple;
	bh=kjhl/ZlXGHdFlX33+fCNQzvWOD46B42IZ6JdnNIm6K0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WtDS5sUdOEYxkENbxqR09x7LqV1tb5lM/a6scKWqCY6/9PA63rDwDDGLwtvFuq6PT7wVTCy8AMUKE+dAwAj7N8FVXQZXZOIbJzWPaxcBT/CuGSnhIsv1M0KE0KWGnpC1Oabs1n8ZjoKOYMGDzD0krsGUoW6dJ2lahL/YgvvTPJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=EZRxG1sa; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55O0E62N02234004, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750724046; bh=kjhl/ZlXGHdFlX33+fCNQzvWOD46B42IZ6JdnNIm6K0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=EZRxG1sa6DZgC3n37NcLkGINdXakq8JaR6RcYTkJSgHZ77lW50lGyT3+YNGwhStnK
	 zTkqFYKa4C6ZF8wloOymHYK5seYYsoCJPgzAF+MVHrqdYk5fUGr4YYyXkQ5BvhPZIn
	 AV76DXEEjz0AhPprMqkO5OUm9ZrfxYn0pdj43MEGBUzYX+bM30Z2kUHLkv+KCoR55w
	 3eHsH28BWOFGZsjqaK7eTPbpSSwxF0NljA+hTOU/r4QFpojteiP/QtKLROuN07IYYi
	 YxXN8TIHLFXYIQx8bSGKJshULtqqdpg4mL+vnqo/t3/iPWYA+Pno1ijTz3C+hVtqga
	 AqgL1Fkxs9xYQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55O0E62N02234004
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 08:14:06 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Jun 2025 08:14:19 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 24 Jun 2025 08:14:19 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Tue, 24 Jun 2025 08:14:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Bernie Huang
	<phhuang@realtek.com>,
        Fedor Pchelkin <boddah8794@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Bug report] rtw89: 8852b: IO_PAGE_FAULTs with beacon filter feature enabled
Thread-Topic: [Bug report] rtw89: 8852b: IO_PAGE_FAULTs with beacon filter
 feature enabled
Thread-Index: AQHbrfBpW2AH+n1rZEuyFH6rIsW1k7Olc7dQgAAnAYCAAXKcUIAf2VeAgAEkbICACRO4gIA/xfYAgAD40hA=
Date: Tue, 24 Jun 2025 00:14:19 +0000
Message-ID: <b06f906cbdee403f9aa9442a5d7cab29@realtek.com>
References: <uidltsdsuujrczrtzgerhh5cw2tztxktfen6yvztnc7gttzgvk@jccomj7f4gul>
 <148ed65c53be4ef29246d372dd0fef8e@realtek.com>
 <z54thedngt3wnhr5bfer3yg7id2c4uqgw2jjvyausv6p66ys4k@guqol77fpugz>
 <dcf695a6621f43e38a20eb860194191a@realtek.com>
 <7injzacfmvhrugcovyxkn4elnaxnzg27c26zmcqzrwhottyk7e@ap5ellaozcg4>
 <419811cccd774d38b5a9c0bbcdf5dfbe@realtek.com>
 <42783d9a032143bfb67ea969ee0b805d@realtek.com>
 <ed0b9b6f-f480-40ec-b4d5-453c78bd8a5c@gmail.com>
In-Reply-To: <ed0b9b6f-f480-40ec-b4d5-453c78bd8a5c@gmail.com>
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
NC8wNS8yMDI1IDA2OjI5LCBCZXJuaWUgSHVhbmcgd3JvdGU6DQo+ID4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4N
Cj4gPiBTZW50OiBUaHVyc2RheSwgTWF5IDgsIDIwMjUgODo1OSBBTQ0KPiA+IFRvOiBGZWRvciBQ
Y2hlbGtpbiA8Ym9kZGFoODc5NEBnbWFpbC5jb20+DQo+ID4gQ2M6IEJlcm5pZSBIdWFuZyA8cGho
dWFuZ0ByZWFsdGVrLmNvbT47IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+IFN1YmplY3Q6IFJFOiBbQnVnIHJlcG9ydF0gcnR3
ODk6IDg4NTJiOiBJT19QQUdFX0ZBVUxUcyB3aXRoIGJlYWNvbiBmaWx0ZXIgZmVhdHVyZSBlbmFi
bGVkDQo+ID4NCj4gPiBGZWRvciBQY2hlbGtpbiA8Ym9kZGFoODc5NEBnbWFpbC5jb20+IHdyb3Rl
Og0KPiA+Pj4gT24gVGh1LCAxNy4gQXByIDAxOjA1LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4+
Pj4gRmVkb3IgUGNoZWxraW4gPGJvZGRhaDg3OTRAZ21haWwuY29tPiB3cm90ZToNCj4gPj4+Pj4N
Cj4gPj4+Pj4gT24gV2VkLCAxNi4gQXByIDAwOjQ5LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4+
Pj4+PiBBcyBiaXNlY3Rpb24sIGNhbiBJIHN1bW1hcml6ZSBhcyBiZWxvdyB0YWJsZT8NCj4gPj4+
Pj4+DQo+ID4+Pj4+PiAgICAgZDU2YzI2MWU1MiAgICAgICAgICAgZmlybXdhcmUgICAgICAgICAg
ICAgSU9fUEFHRV9GQVVMVA0KPiA+Pj4+Pj4gICAgKENRTSBzdXBwb3J0KQ0KPiA+Pj4+Pj4gICAt
LS0tLS0tLS0tLS0tLS0gICAgICAtLS0tLS0tLS0tLSAgICAgICAgICAtLS0tLS0tLS0tLS0tLS0t
LQ0KPiA+Pj4+Pj4gICAgICAgbyAgICAgICAgICAgICAgICAgMC4yOS4yOS43ICAgICAgICAgICAg
ICAgICAgeWVzDQo+ID4+Pj4+PiAgICAgICBvICAgICAgICAgICAgICAgICAwLjI5LjI5LjUgICAg
ICAgICAgICAgICAgICBubw0KPiA+Pj4+Pj4gICAgICAgeCAgICAgICAgICAgICAgICAgMC4yOS4y
OS43ICAgICAgICAgICAgICAgICAgbm8NCj4gPj4+Pj4+ICAgICAgIHggICAgICAgICAgICAgICAg
IDAuMjkuMjkuNSAgICAgICAgICAgICAgICAgIG5vDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gSWYgdGhp
cyB0YWJsZSBpcyBjb3JyZWN0LCB3ZSB3aWxsIGNoZWNrIHRoZSBiZWFjb24gZmlsdGVyIGZlYXR1
cmUgaW4gZmlybXdhcmUuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pg0KPiA+Pj4+PiBZZXMsIGl0IGNvcnJl
Y3RseSBkZXNjcmliZXMgdGhlIHNpdHVhdGlvbi4gTXkgc3VzcGljaW9uIGN1cnJlbnRseQ0KPiA+
Pj4+PiBmYWxscyBvbiB0aGUgYmVhY29uIGZpbHRlciBmZWF0dXJlIGluIGZpcm13YXJlLCB0b28u
DQo+ID4+Pj4NCj4gPj4+PiBDb3VsZCB5b3UgaGVscCB0byB0ZXN0IHdoZW4gd2UgaGF2ZSB1cGRh
dGVkIGZpcm13YXJlPw0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gSGksDQo+ID4+Pg0KPiA+Pj4gV2Vy
ZSB5b3UgYWJsZSB0byByZXByb2R1Y2Ugb3IgdHJhY2sgZG93biB0aGUgcHJvYmxlbT8NCj4gPg0K
PiA+PiBZZXMsIHdlIGhhdmUgcmVwcm9kdWNlZCB0aGlzIHByb2JsZW0sIGFuZCB3ZSBmb3VuZCBz
ZW5kaW5nIGZpcm13YXJlIGNvbW1hbmQgZHVyaW5nIGRlZXAgUFMgbW9kZSB3aWxsDQo+IHJhaXNl
IElPX1BBR0VfRkFVTFQuIFdpdGggYmVsb3cgc2V0dGluZyB0byBkaXNhYmxlIGRlZXAgUFMgPiBt
b2RlLCB0aGUgc3ltcHRvbSBjYW4gZGlzYXBwZWFyLg0KPiA+DQo+ID4+ICAgcnR3ODlfY29yZS5r
byBkaXNhYmxlX3BzX21vZGU9eQ0KPiA+DQo+ID4+IE5vdyB3ZSBhcmUgYXJyYW5naW5nIENBVC1D
IGVxdWlwbWVudCB0byBjYXB0dXJlIHNpZ25hbHMgaW4gUENJRSBidXMgdG8gc2VlIHdoYXQgaGFw
cGVucyBhdCB0aGF0IG1vbWVudC4NCj4gPg0KPiA+PiBPbmUgcG9zc2libGUgc29sdXRpb24gKHdv
cmthcm91bmQpIGlzIHRvIGF2b2lkIHNlbmRpbmcgZmlybXdhcmUgY29tbWFuZHMgZHVyaW5nIGRl
ZXAgUFMgbW9kZSwgYmVmb3JlDQo+IHdlIGZvdW5kIG91dCB0aGUgcm9vdCBjYXVzZS4NCj4gPg0K
PiA+IEhpIEZlZG9yLA0KPiA+DQo+ID4gQ291bGQgeW91IHBsZWFzZSBjaGVjayB3aGV0aGVyIHRo
ZSBhdHRhY2hlZCBmaXJtd2FyZSBmaXhlcyB0aGlzIGlzc3VlPw0KPiA+IFRoZSBmaXJtd2FyZSB2
ZXJzaW9uIHNob3VsZCBiZSAxLjI5LjI5LjkuDQo+IEJ5IHRoZSB3YXksIHdoYXQgZG9lcyB0aGUg
Zmlyc3QgbnVtYmVyIG1lYW4/IFRoZSBwcmV2aW91cyB2ZXJzaW9uIHdhcw0KPiAwLjI5LjI5Ljgu
IEkgd291bGQgZXhwZWN0IG9ubHkgdGhlIGxhc3QgbnVtYmVyIHRvIGNoYW5nZSBmb3IgdGhpcyBi
dWcgZml4Lg0KDQpUaGlzIGZpcm13YXJlIGlzIGZvciB0ZXN0aW5nIG9ubHkuIFRoZSBmb3JtYWwg
ZmlybXdhcmUgc2hvdWxkIGJlIDAuMjkuMjkueC4gDQoNCg==

