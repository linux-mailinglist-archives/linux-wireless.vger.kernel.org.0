Return-Path: <linux-wireless+bounces-22889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 178A0AB4A38
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 05:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57631B40432
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 03:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7EC1C28E;
	Tue, 13 May 2025 03:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="c8rR7dy8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B19A10957
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 03:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747107797; cv=none; b=dsGTgl73eSjPPZnWzAjiDj5gAVwHOwCyZyLtX65I1MISQPiHVCUzpFwu/RbGVc/gTKf6bnuWgH8nX85k1iu2opqoW9YRL2k8kHxlzifi0sGajL14GoKFF15HuiYHbkLtSnpxvonmgEBWqiouuE1E1wdVaOFQ5xKHYiiJt9mXzuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747107797; c=relaxed/simple;
	bh=mePDPs+JOsuI1mX6rUPz9GRSBGwa3+5gQxwge8gtIeo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DygDviIoE2H/I6OlcZYHcCsIjnyKg1XSpOxSpljbfewXiu/RqoUTJbkFSKL/dOZ5l+AnVFjS2YP/apUbr39GZQdNWRuXaCjAWKp0QdghL58xtOsiOkMv4r5fEngfDFkZQeQOwMdZZYGtQ7YS0Z6mrhK1lt6p6H5K3NvilWxDBN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=c8rR7dy8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54D3hAkL53619928, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747107790; bh=mePDPs+JOsuI1mX6rUPz9GRSBGwa3+5gQxwge8gtIeo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=c8rR7dy8Ehr2IWi7JQzqS8Hz7YOL0JqyD/kPPH1Q5NsGNN9+zKIORL9U7UC0akw+6
	 2FEkUKfnMQav//5bt3ppnD7C639nUrDCSVRqw2hgzxj/tCPNjr7o/0bsFGnkGVFFYV
	 2CcA2IoCI7QIqYoX/IEwnGxW2S9H68Lb6mEkHrP4xLr0TkVXKjoiNNZGsHTyCgQojZ
	 ni5fqIequyadw95xN+i8gyJ1oSV8umR/u5WD/B1ChQaZPZ3qfqSKe8u2WfZxcFP03Z
	 aOs06eBvHLtUui/rKoBHlVQxh9FsP5S6eYq1OKQOldpDoa/DCinkiRPUabSk04w2qw
	 BAbrjZoxHqQjA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54D3hAkL53619928
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 11:43:10 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 May 2025 11:43:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 May 2025 11:43:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 13 May 2025 11:43:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v1 08/13] wifi: rtw89: Hide some errors when the device is unplugged
Thread-Topic: [PATCH rtw-next v1 08/13] wifi: rtw89: Hide some errors when the
 device is unplugged
Thread-Index: AQHbvTZ1FHSZK4x/l0KUNwLxduMxALPP9JTQ
Date: Tue, 13 May 2025 03:43:10 +0000
Message-ID: <61a8d41163d4402992e679becb7d18fa@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <6038bad5-4a4e-4f99-8292-e37a6d11961c@gmail.com>
In-Reply-To: <6038bad5-4a4e-4f99-8292-e37a6d11961c@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBIGZl
dyB1bm5lY2Vzc2FyeSBlcnJvciBtZXNzYWdlcyBhcmUgcHJpbnRlZCB3aGVuIHRoZSBkZXZpY2Ug
aXMNCj4gdW5wbHVnZ2VkLiAicmVhZCBzd3NpIGJ1c3kiIGluIHBhcnRpY3VsYXIgY2FuIGFwcGVh
ciB+MTAwMCB0aW1lcyB3aGVuDQo+IFJUTDg4NTFCVSBpcyB1bnBsdWdnZWQuDQo+IA0KPiBBZGQg
YSBuZXcgZmxhZyBSVFc4OV9GTEFHX1VOUExVR0dFRCBhbmQgcHJpbnQgc29tZSBlcnJvciBtZXNz
YWdlcyBvbmx5DQo+IHdoZW4gdGhpcyBmbGFnIGlzIG5vdCBzZXQuIFRoZSBuZXcgVVNCIGRyaXZl
ciB3aWxsIHNldCB0aGUgZmxhZyB3aGVuDQo+IHRoZSBkZXZpY2UgaXMgdW5wbHVnZ2VkLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5j
b20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KWy4u
Ll0NCg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9t
YWMuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMNCj4gaW5kZXgg
MWEwMzM1NWIzNDBmLi45OWYwMWZmZjkwZmUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OS9tYWMuYw0KPiBAQCAtODgsNyArODgsNyBAQCBpbnQgcnR3ODlfbWFjX3dy
aXRlX2x0ZShzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYsIGNvbnN0IHUzMiBvZmZzZXQsIHUzMiB2
YWwpDQo+IA0KPiAgICAgICAgIHJldCA9IHJlYWRfcG9sbF90aW1lb3V0KHJ0dzg5X3JlYWQ4LCBs
dGVfY3RybCwgKGx0ZV9jdHJsICYgQklUKDUpKSAhPSAwLA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDUwLCA1MDAwMCwgZmFsc2UsIHJ0d2RldiwgUl9BWF9MVEVfQ1RSTCArIDMp
Ow0KDQpGb3IgdGhpcyBjYXNlLCB0aW1lb3V0IHRpbWUgaXMgbGFyZ2UgZW5vdWdoIGZvciBVU0Iu
IEJ1dCBJJ20gc3VycHJpc2luZyB0aGF0DQp5b3UgZG9uJ3QgbmVlZCB0byBhZGp1c3QgdGltZW91
dCB0aW1lIG9mIHJlYWRfcG9sbF90aW1lb3V0KCkgZm9yIFVTQiBkZXZpY2VzLCANCnNpbmNlIFVT
QiBpcyBtdWNoIHNsb3dlciB0aGFuIFBDSUUuDQoNCklmIHNvbWV0aW1lIHlvdSBuZWVkLCBJIHN1
Z2dlc3QgdGhpcyBwYXR0ZXJuIChudW1iZXIgaXMgYXJ0aWZpY2lhbCk6IA0KDQp1NjQgcnR3ODlf
aGNpX3RpbWVvdXQocnR3ZGV2LCB0bykNCnsNCiAgICBpZiAoVVNCIDIpDQogICAgICAgIHJldHVy
biBtYXgodG8sIDIwMCk7IC8vIEkgYXNzdW1lIFVTQiAyIGlzIHNsb3dlciBhbmQgMjAwIGlzIGVu
b3VnaCBmb3IgdHdvIHRpbWVzIElPLg0KICAgIGVsc2UgaWYgKFVTQiAzKQ0KICAgICAgICByZXR1
cm4gbWF4KHRvLCAxMDApOyAvLyBJIGFzc3VtZSBVU0IgMyBpcyBmYXN0ZXIgdGhhbiBVU0IgMg0K
DQogICAgcmV0dXJuIHRvOw0KfQ0KDQp1NjQgdG87DQoNCnRvID0gcnR3ODlfaGNpX3RpbWVvdXQo
cnR3ZGV2LCAzMCk7DQoNCi0gcmVhZF9wb2xsX3RpbWVvdXQoLi4uLCAxLCAzMCwgLi4uKTsNCisg
cmVhZF9wb2xsX3RpbWVvdXQoLi4uLCAxLCB0bywgLi4uKTsNCg0KDQo=

