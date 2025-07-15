Return-Path: <linux-wireless+bounces-25419-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C30B04CCC
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 02:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641CC3AEF2C
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 00:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5838D4400;
	Tue, 15 Jul 2025 00:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="rigIUXI9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069AE13AA2D
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 00:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752539313; cv=none; b=YAn9KUZ73Sxxg3POjiEeSYxDLqnVmwoniJi4PLAq3QvkK6UOWSzkth2tZ6vtGxC5RurU3Oo0QXkUAytpGj4+kAFOWRL/sq6Rqhrx0GvGQ17gBz3IfnK3TW3uZztHsZzHAEyHG8z5AWwoEk6KEYsi2gdc88bdJQHqLs3iFDxWQbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752539313; c=relaxed/simple;
	bh=TRRwZu/sw6hL36UuBXm9ZZbOmCtlV6RkO4Ju1AH6zdg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gzKzExdzjtAqhrT2EVl7zK82CfSMNvHsDn6huoaLlf5zYZj66HuQcasldDZ8+6A3/0ZVqQM1jakcvqOQsJtsn9oXxmXS3hpRLUHSQzW/RRejYcXrFDuhim2Lk0xix7msaILGt42IxFYORKWq5gWFcs7B0SxAZSNAKIUB1N/hYFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rigIUXI9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56F0SJlH43320660, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752539299; bh=TRRwZu/sw6hL36UuBXm9ZZbOmCtlV6RkO4Ju1AH6zdg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=rigIUXI9dSRaL0E/pyXV4A9X1dy0cmkxuDvyJ1V8lkuJe/oKtVQn8cJ59baAjXGjJ
	 htGWa5lrOQf3wgZhbPk4XlGpRTBk7VVyn4mRSJfjeMA2ubXoFi/x/GoLd4RvngiqGJ
	 21wNqmWQRdf4nfkfloU8eN3LPe0AIet/caCS3/xcxFAp/SYSUP1Tn5I50AoPk1nmOD
	 R7ngfgAxLpVgvb/ClLF+oI5cSxjLJmR665HWdbHvUA8cQ4v5N96xg7XTZC6d8QKHu3
	 i8A3ftZTm1HTJ4RwuBkidhjr+fGO4XWZ3SyDqGyH+qTI2sT56gnh1Cb2jKvfoLwovl
	 xSuUK6qhn7fLw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56F0SJlH43320660
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 08:28:19 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 08:28:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 15 Jul 2025 08:28:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Tue, 15 Jul 2025 08:28:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 1/2] wifi: rtw89: Increase polling delay in rtw89_fw_read_c2h_reg() for USB
Thread-Topic: [PATCH rtw-next 1/2] wifi: rtw89: Increase polling delay in
 rtw89_fw_read_c2h_reg() for USB
Thread-Index: AQHb8mIExRh8regsMUWLQVkqazNfxLQw3ZoQgADNTICAAK5tcA==
Date: Tue, 15 Jul 2025 00:28:19 +0000
Message-ID: <541d90fbd7114d9b8c5247ee50d68507@realtek.com>
References: <73f8bdbf-ff7f-4741-a6ea-b1d9026833c3@gmail.com>
 <9ce9b78535d74f08927ce2ac9c7731e9@realtek.com>
 <b24bb8a2-d635-4312-b451-065b8d8e950c@gmail.com>
In-Reply-To: <b24bb8a2-d635-4312-b451-065b8d8e950c@gmail.com>
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
NC8wNy8yMDI1IDA1OjQ5LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBUaGlzIHJlYWRfcG9sbF90
aW1lb3V0X2F0b21pYygpIHdpdGggYSBkZWxheSBvZiAxIMK1cyBhbmQgYSB0aW1lb3V0IG9mDQo+
ID4+IDEwMDAwMDAgwrVzIGNhbiB0YWtlIH4yNTAgc2Vjb25kcyBpbiB0aGUgd29yc3QgY2FzZSBi
ZWNhdXNlIHNlbmRpbmcgYQ0KPiA+PiBVU0IgY29udHJvbCBtZXNzYWdlIHRha2VzIH4yNTAgwrVz
Lg0KPiA+DQo+ID4gSSB3YXMgbm90IGF3YXJlIG9mIHRoZSBjaGFuZ2Ugb2YgWzFdLiBUaGUgYmVo
YXZpb3Igb2YgYXRvbWljIHZlcnNpb24gYmVjb21lcw0KPiA+IGRpZmZlcmVudCBmcm9tIG5vbi1h
dG9taWMgdmVyc2lvbi4NCj4gPg0KPiA+IEZvciB0aGlzIHBhdGNoLCBJIGZlZWwgd2UgY2FuIGtl
ZXAgZGVsYXlfdXMgdG8gMSBhbmQgdHJlYXQgdGltZW91dF91cyBhcw0KPiA+ICdjb3VudCcsIHdo
aWNoIFVTQiBkZXZpY2VzIGRvIHNtYWxsZXIgcmV0cmllcy4gVGhlIHNtYWxsZXIgZGVsYXlfdXMg
Y2FuDQo+ID4gcmVkdWNlIHRvdGFsIHBvbGxpbmcgdGltZSwgZXNwZWNpYWxseSBmb3IgUENJRSBk
ZXZpY2VzIChzZWUgbXkgY29tbWVudHMgYmVsb3cpDQo+ID4NCj4gPiBUaG91Z2ggSSBkb24ndCBt
ZWFzdXJlIHRvdGFsIHBvbGxpbmcgdGltZSBvZiBwYXRjaCAyLzIsIEkgZmVlbCB3ZSBjYW4gYXBw
bHkNCj4gPiBzaW1pbGFyIGlkZWEuDQo+ID4NCj4gDQo+IFllcywgYSBzbWFsbGVyIHRpbWVvdXQg
YWxzbyB3b3Jrcy4gSSB0ZXN0ZWQgNDAwMCBmb3IgdGhpcyBwYXRjaCBhbmQgMzIwMA0KPiBmb3Ig
cGF0Y2ggMi4gDQoNCkZvcmdvdCB0byBzYXksIGZvciBQQ0lFIGRldmljZXMgcGxlYXNlIGtlZXAg
dGhlIHRpbWVvdXQgYXMgd2FzLg0KDQo+ICg0MDAwICogMjUwID0gMTAwMDAwMCBhbmQgMzIwMCAq
IDEyNSA9IDQwMDAwMC4gSSBkb24ndCBrbm93DQo+IHdoeSBydHc4OV9yZWFkOCgpIGluIHRoZSBz
ZWNvbmQgcGF0Y2ggdGFrZXMgb25seSAxMjUgwrVzLikNCg0KDQo=

