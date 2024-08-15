Return-Path: <linux-wireless+bounces-11456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5600952959
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 08:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A371F22979
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 06:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6636D176AD7;
	Thu, 15 Aug 2024 06:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="dAv3XTTP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2B818D647
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703251; cv=none; b=GlUWarmXYV/gzRnUoq5zKonQVmiA5fAhKHSyRaQRmIWyb6WE0E3sLvjPJ2QF7EuM86wcA+iTeVcVW/MeWA3W3ywWfEeV4lSZFPtyi3RbS0ZU3Feib/IV6PbgaggjnvwmkIgYy/LUrp5mX3eRaVT06zM7ukcYNxG1EEGGrVsnSZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703251; c=relaxed/simple;
	bh=LdL/PYBnMp8g4b5VwQf4M+gw4hnMAf3yhzlstSN75Bg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fHGXNTGXliDnQRNGTliLgY558ndk7WeRLkcAox18f0c7aJDbOrjnNT1Zk8yvZv503mefs/OppLAdi3e0+IdIZMdNT2cpEEwh3pMXXM6LLLV8HB8GkfaveKboTACuDsUTea/ZOS64NbygneDOj/RQ6q3sFPcwtoJ+1WCStYuqmsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=dAv3XTTP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47F6ROw543698272, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723703244; bh=LdL/PYBnMp8g4b5VwQf4M+gw4hnMAf3yhzlstSN75Bg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dAv3XTTPQwznjNPP3wIxGqPXmapubRzGEOzlRdyn37d72KJ2glaV2wx8IagKTzhVd
	 O1KcasX0PEUsiSDvXFuGVcn+AAPY4x2auyAbFyOTSQ9Xyfkb20vIfTvSJIvFhGgITi
	 DCVOM940FVXKJdacDoG6HUpUeAO+GnAQpOo7ek82TAzTv0TlLEDwvmnEMp58C85wWv
	 ATaeN0A22uM7eVGhXuPL8kWhM4gIgBpODPDdLwN0XBbrm9PQcW4mXrXDE0DU6h1PB7
	 1cUramzToXpPzB8w1NUKxWuSOvIHlEb+z4Kx+FEHvZ1Q6Fs1StG1JTrm9QKbMrXkKp
	 SNQONSNiWdP8Q==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47F6ROw543698272
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 14:27:24 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 14:27:24 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Aug 2024 14:27:24 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0]) by
 RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0%5]) with mapi id
 15.01.2507.035; Thu, 15 Aug 2024 14:27:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 04/20] wifi: rtw88: Extend the init table parsing for RTL8812AU
Thread-Topic: [PATCH 04/20] wifi: rtw88: Extend the init table parsing for
 RTL8812AU
Thread-Index: AQHa7DDa9UCYA1LJ40meHyeD8zYPM7In3KQQ
Date: Thu, 15 Aug 2024 06:27:24 +0000
Message-ID: <932d3b7c722c4c1894e5d41707ac9f6a@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <91c776d8-2ace-4ffe-8a34-9e3c9c990f35@gmail.com>
In-Reply-To: <91c776d8-2ace-4ffe-8a34-9e3c9c990f35@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGUg
Y2hpcHMgc3VwcG9ydGVkIHNvIGZhciBvbmx5IHVzZSB0aGUgZmlyc3QgY29uZGl0aW9uLCBhbmQg
c28gdGhlDQo+IHBhcnNpbmcgY29kZSBpZ25vcmVzIHRoZSBzZWNvbmQgY29uZGl0aW9uLiBSVEw4
ODEyQVUncyBpbml0IHRhYmxlcyB1c2UNCj4gdGhlIHNlY29uZCBjb25kaXRpb24gYWxzby4gTWFr
ZSB0aGUgcGFyc2luZyBjb2RlIGNoZWNrIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVy
Ymx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWluLmggfCAxNSArKysrKysNCj4gIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcGh5LmMgIHwgNTcgKysrKysrKysrKysrKysrKysr
KystLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkNCj4gDQoNClsuLi5dDQoNCj4gQEAgLTEwNDIsNiArMTA0NSw3IEBAIHZvaWQgcnR3X3BoeV9z
ZXR1cF9waHlfY29uZChzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LCB1MzIgcGtnKQ0KPiAgICAgICAg
IHN0cnVjdCBydHdfaGFsICpoYWwgPSAmcnR3ZGV2LT5oYWw7DQo+ICAgICAgICAgc3RydWN0IHJ0
d19lZnVzZSAqZWZ1c2UgPSAmcnR3ZGV2LT5lZnVzZTsNCj4gICAgICAgICBzdHJ1Y3QgcnR3X3Bo
eV9jb25kIGNvbmQgPSB7MH07DQo+ICsgICAgICAgc3RydWN0IHJ0d19waHlfY29uZDIgY29uZDIg
PSB7MH07DQoNCic9IHt9Jw0KDQpJIGd1ZXNzIHlvdSBpbWl0YXRlIGFib3ZlIGRlY2xhcmF0aW9u
LiBQbGVhc2UgY2hhbmdlIGJvdGggdG8gJz0ge30nLg0KDQo+IA0KPiAgICAgICAgIGNvbmQuY3V0
ID0gaGFsLT5jdXRfdmVyc2lvbiA/IGhhbC0+Y3V0X3ZlcnNpb24gOiAxNTsNCj4gICAgICAgICBj
b25kLnBrZyA9IHBrZyA/IHBrZyA6IDE1Ow0KDQpbLi4uXQ0KDQo+IEBAIC0xMDkxLDYgKzExMzQs
NyBAQCB2b2lkIHJ0d19wYXJzZV90YmxfcGh5X2NvbmQoc3RydWN0IHJ0d19kZXYgKnJ0d2Rldiwg
Y29uc3Qgc3RydWN0IHJ0d190YWJsZSAqdGJsKQ0KPiAgICAgICAgIGNvbnN0IHVuaW9uIHBoeV90
YWJsZV90aWxlICpwID0gdGJsLT5kYXRhOw0KPiAgICAgICAgIGNvbnN0IHVuaW9uIHBoeV90YWJs
ZV90aWxlICplbmQgPSBwICsgdGJsLT5zaXplIC8gMjsNCj4gICAgICAgICBzdHJ1Y3QgcnR3X3Bo
eV9jb25kIHBvc19jb25kID0gezB9Ow0KPiArICAgICAgIHN0cnVjdCBydHdfcGh5X2NvbmQyIHBv
c19jb25kMiA9IHswfTsNCg0KZGl0dG8uICc9e30nDQoNCj4gICAgICAgICBib29sIGlzX21hdGNo
ZWQgPSB0cnVlLCBpc19za2lwcGVkID0gZmFsc2U7DQo+IA0KPiAgICAgICAgIEJVSUxEX0JVR19P
TihzaXplb2YodW5pb24gcGh5X3RhYmxlX3RpbGUpICE9IHNpemVvZihzdHJ1Y3QgcGh5X2NmZ19w
YWlyKSk7DQoNCg0K

