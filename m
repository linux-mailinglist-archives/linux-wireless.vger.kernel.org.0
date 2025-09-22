Return-Path: <linux-wireless+bounces-27559-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC35B8F0C7
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 07:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D536616FC8D
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 05:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC3C1E521D;
	Mon, 22 Sep 2025 05:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="hs56J8KM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4380234BA47;
	Mon, 22 Sep 2025 05:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758520258; cv=none; b=MJYV8Qfec3v5pECr6wTo/+fxRxI2X9FLl3yJ9NMWxitqR+qQhWSsAyPgqTzSUURJl2YsNqfylhKd1HgNeFU+RGI0zk6BHCrfiGh6OEO/KZHnueUdEC+cl74VVz/L8xbA4rxc0YSnaHp1Av0gGuMcNobBz3qnDNyeYkrmAWJnQZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758520258; c=relaxed/simple;
	bh=h9WmkhGE2XndTUlFIPDGYWd1Wy/a4PZG1WZX/qmCO+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dlu4NjttHwoRIuc1LuBoxZR+s8KCAlXkcapupJrtUN/g2XsdvPZPu4uWoNHOnbeO2+0rW2j9h+M3HKtVK5VGZGpkOrt8vHaZUhRz+d2NnJbb+QtxXvWGrWRkaITWaiKVtbrF++cLIFjdTRUv7kz92QwUg5V0I9TVYV6ctLfv0IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=hs56J8KM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58M5ooK433924084, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758520250; bh=h9WmkhGE2XndTUlFIPDGYWd1Wy/a4PZG1WZX/qmCO+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=hs56J8KMlEehOuHZeUV/AqDaUqL5Nx0mUrM7U9frpsPCo9kZZmxXJGJY12gLqRkGS
	 fEHjc1a08MaEu/UKzuFHLX6hZld7T+iVFIvRjz8obPIarDUB9Go0tcCL14put3DgmF
	 Vv3PvyHNuF5ZCJSjPdNTjRwPTVLDml+UrWcYHzBHIJfDJRow0478MecJo7kpT+XGsf
	 /ozE04oqImGr6BU4vUkiDnZGI7uP3dauJ/u99sqjud0kEs/R15acYQA9PTBgmwfht+
	 mQwXVjrKSMfKiBc7NcJcNcKWecwl2uFWbrEHXHDbMk7sQ3hRAubS4l454/snc9uPcZ
	 jGRVt5O/hCR+Q==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58M5ooK433924084
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 13:50:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 22 Sep 2025 13:50:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Mon, 22 Sep 2025 13:50:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Yu-Chun Lin <eleanor15x@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?big5?B?Q1lfSHVhbmdbtsDgsq7LXQ==?= <cy.huang@realtek.com>,
        =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>,
        "jserv@ccns.ncku.edu.tw" <jserv@ccns.ncku.edu.tw>,
        "visitorckw@gmail.com"
	<visitorckw@gmail.com>
Subject: RE: [PATCH rtw-next] wifi: rtw89: Replace hardcoded strings with helper functions
Thread-Topic: [PATCH rtw-next] wifi: rtw89: Replace hardcoded strings with
 helper functions
Thread-Index: AQHcKw6iw9xkJS2rJEiZoIdnDXLQ2rSesj7w
Date: Mon, 22 Sep 2025 05:50:50 +0000
Message-ID: <715313b943d84cfeb3a337dc20be5f6a@realtek.com>
References: <20250921154410.1202074-1-eleanor15x@gmail.com>
In-Reply-To: <20250921154410.1202074-1-eleanor15x@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

WXUtQ2h1biBMaW4gPGVsZWFub3IxNXhAZ21haWwuY29tPiB3cm90ZToNCj4gUmVwbGFjZSBoYXJk
Y29kZWQgc3RyaW5ncyB3aXRoICdzdHJfb25fb2ZmKCknLCAnc3RyX2VuYWJsZV9kaXNhYmxlKCkn
LA0KPiBhbmQgJ3N0cl9yZWFkX3dyaXRlKCknLg0KPiANCj4gVGhlIGNoYW5nZSBpbXByb3ZlcyBy
ZWFkYWJpbGl0eSBhbmQgZW5hYmxlcyBwb3RlbnRpYWwgc3RyaW5nIGRlZHVwbGljYXRpb24NCj4g
YnkgdGhlIGxpbmtlciwgd2hpY2ggbWF5IHNsaWdodGx5IHJlZHVjZSBiaW5hcnkgc2l6ZS4NCg0K
SGF2ZSB5b3UgbWVhc3VyZWQgdGhlIGNoYW5nZSBvZiBiaW5hcnkgc2l6ZT8gTWF5YmUgeW91IGNh
biBzaGFyZSB0aGUgcmVzdWx0DQpoZXJlLg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZdS1DaHVu
IExpbiA8ZWxlYW5vcjE1eEBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OS9ydHc4ODUxYl9yZmsuYyB8IDEwICsrKysrKy0tLS0NCj4gIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcnR3ODg1MmFfcmZrLmMgfCAxMCArKysrKyst
LS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3J0dzg4NTJiX3Jmay5j
IHwgIDggKysrKystLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcnR3
ODg1MmNfcmZrLmMgfCAxMSArKysrKystLS0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydHc4OS91c2IuYyAgICAgICAgICB8ICAzICsrLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OS93b3cuYyAgICAgICAgICB8ICA1ICsrKystDQo+ICA2IGZpbGVzIGNo
YW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcnR3ODg1MWJfcmZrLmMNCj4g
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3J0dzg4NTFiX3Jmay5jDQo+IGlu
ZGV4IDg0YzQ2ZDJmNGQ4NS4uMDAwNzUzMDYxZTM4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3J0dzg4NTFiX3Jmay5jDQo+ICsrKyBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcnR3ODg1MWJfcmZrLmMNCj4gQEAgLTIsNiArMiw4
IEBADQo+ICAvKiBDb3B5cmlnaHQoYykgMjAyMi0yMDIzICBSZWFsdGVrIENvcnBvcmF0aW9uDQo+
ICAgKi8NCj4gDQo+ICsjaW5jbHVkZSA8bGludXgvc3RyaW5nX2Nob2ljZXMuaD4NCj4gKw0KDQpE
cml2ZXIgaGFzIGluY2x1ZGVkIHRoaXMgaW1wbGljaXRseSwgc28gZG9uJ3QgbmVlZCB0byBpbmNs
dWRlIGl0IGFjcm9zcw0Kd2hvbGUgcGF0Y2guDQoNCk90aGVyd2lzZSBsb29rcyBnb29kIHRvIG1l
Lg0KDQo=

