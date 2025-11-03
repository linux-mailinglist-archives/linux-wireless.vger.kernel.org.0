Return-Path: <linux-wireless+bounces-28473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6483C29B54
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 01:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650843AA2AA
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 00:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B2F8479;
	Mon,  3 Nov 2025 00:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="IhLirxyT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D7717D2
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 00:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130878; cv=none; b=fpyI9MG6TGnvwkE/yqDmeTJ7F1hUyS12Jh1OezDhRlRDREmu9xgSX+8Kv8+GQcbRk+SH56GZRB6X4aqrRLIWeOiiA1NCN58DQXv786NAIZ6MAys0XB7LF/CK6SCTnSMLN2sTwWPckZn+1SjLXniLKQ2u1rmOMWF/S5G1bTlYE5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130878; c=relaxed/simple;
	bh=n7WlcHVJLwfvqip/EZcaywryg0zGWsfOqXt40/mKIt0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EN+8LblpgjQpghINauHsie+hBH3qldyedx6M6/mSWD5+ChXwf1l8ut95bDrNaIEQRIVfhxWxIx50IYKFEFHzGM1uE9y7EoXhQfCPXT3bCmgYe87mwNkHkTb/QGyvieqVaegSpbgr+bWUSJl9uUsLR68bxzitQf+GSlDkmyqXWyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IhLirxyT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A30lmM83493216, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762130868; bh=n7WlcHVJLwfvqip/EZcaywryg0zGWsfOqXt40/mKIt0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=IhLirxyTevbZe4K7uYUbWxJ1pI2RJBpDkEsNYREqM13l1mExoOXc5EB477+zZDmFU
	 iuX/iuMj0TyEfe0tMquGKgXX/IULzmLgu6W4QOvT7+OYic3AV2hMPpwXhsvzdIqmn2
	 WcT8Ph+ULolLxzY+2dbRBjbJy+5ptgyi7i2L4sWWiyO8J2C/NmNIGmhdwUrpxAGvhp
	 S5yxpL3kkthbNAjnEh7kkF4j7CoosdicsSDP5iql5HEx7SH+1P7UXFd+8FzpAA8ZcW
	 foZCU43WuUpknCSX8fth5B2gRYizkvY7JVQ0EeKzCwwMXQ+OSF+nSdOtONEhwyaDBy
	 slVLSoudqh7EQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A30lmM83493216
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Nov 2025 08:47:48 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 3 Nov 2025 08:47:49 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Mon, 3 Nov 2025 08:47:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v4 01/12] wifi: rtw89: 8832cu: turn off TX partial mode
Thread-Topic: [PATCH rtw-next v4 01/12] wifi: rtw89: 8832cu: turn off TX
 partial mode
Thread-Index: AQHcS2SF5mp311mcy06Z6bnhzjubW7TgHtSQ
Date: Mon, 3 Nov 2025 00:47:48 +0000
Message-ID: <ae01e924471e442c897b3087bdf0dff7@realtek.com>
References: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
 <3904dd9f-2178-41e5-95c2-7a9f6268e935@gmail.com>
In-Reply-To: <3904dd9f-2178-41e5-95c2-7a9f6268e935@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBGcm9t
OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gDQo+IFRoZSBUWCBwYXJ0aWFs
IG1vZGUgaW4gVVNCIGRldmljZXMgd2lsbCBjYXVzZSB0aW1lb3V0IHRvIHdhaXQgZm9yIHBheWxv
YWQsDQo+IGNhdXNpbmcgU0VSIDB4OTk5IGFuZCBkaXNjb25uZWN0aW9uLiBUdXJuIG9mZiB0aGlz
IG1vZGUgYWNjb3JkaW5nIHRvDQo+IGRlc2lnbiBzdWdnZXN0aW9uLg0KPiANCj4gcnR3ODlfODg1
MmN1IDItNDoxLjA6IEZXIHN0YXR1cyA9IDB4ZWUwMDExMDgNCj4gcnR3ODlfODg1MmN1IDItNDox
LjA6IEZXIEJBREFERFIgPSAweDE4NjA1ZmM4DQo+IHJ0dzg5Xzg4NTJjdSAyLTQ6MS4wOiBGVyBF
UEMvUkEgPSAweDANCj4gcnR3ODlfODg1MmN1IDItNDoxLjA6IEZXIE1JU0MgPSAweDEwMTAwMDAN
Cj4gcnR3ODlfODg1MmN1IDItNDoxLjA6IFJfQVhfSEFMVF9DMkggPSAweDk5OQ0KPiBydHc4OV84
ODUyY3UgMi00OjEuMDogUl9BWF9TRVJfREJHX0lORk8gPSAweDcxMDIwMDEwDQo+IHJ0dzg5Xzg4
NTJjdSAyLTQ6MS4wOiBbRVJSXWZ3IFBDID0gMHgyMDEzZjU1ZQ0KPiBydHc4OV84ODUyY3UgMi00
OjEuMDogW0VSUl1mdyBQQyA9IDB4MjAxM2Y1NWENCj4gcnR3ODlfODg1MmN1IDItNDoxLjA6IFtF
UlJdZncgUEMgPSAweDIwMTNmNTVhDQo+IHJ0dzg5Xzg4NTJjdSAyLTQ6MS4wOiBbRVJSXWZ3IFBD
ID0gMHgyMDEzZjU1ZQ0KPiBydHc4OV84ODUyY3UgMi00OjEuMDogW0VSUl1mdyBQQyA9IDB4MjAx
M2Y1NWUNCj4gcnR3ODlfODg1MmN1IDItNDoxLjA6IFtFUlJdZncgUEMgPSAweDIwMTNmNTVlDQo+
IHJ0dzg5Xzg4NTJjdSAyLTQ6MS4wOiBbRVJSXWZ3IFBDID0gMHgyMDEzZjU1YQ0KPiBydHc4OV84
ODUyY3UgMi00OjEuMDogW0VSUl1mdyBQQyA9IDB4MjAxM2Y1NWUNCj4gcnR3ODlfODg1MmN1IDIt
NDoxLjA6IFtFUlJdZncgUEMgPSAweDIwMTNmNTVhDQo+IHJ0dzg5Xzg4NTJjdSAyLTQ6MS4wOiBb
RVJSXWZ3IFBDID0gMHgyMDEzZjU1ZQ0KPiBydHc4OV84ODUyY3UgMi00OjEuMDogW0VSUl1mdyBQ
QyA9IDB4MjAxM2Y1NTQNCj4gcnR3ODlfODg1MmN1IDItNDoxLjA6IFtFUlJdZncgUEMgPSAweDIw
MTNmNTU2DQo+IHJ0dzg5Xzg4NTJjdSAyLTQ6MS4wOiBbRVJSXWZ3IFBDID0gMHgyMDEzZjU1YQ0K
PiBydHc4OV84ODUyY3UgMi00OjEuMDogW0VSUl1mdyBQQyA9IDB4MjAxM2Y1NWENCj4gcnR3ODlf
ODg1MmN1IDItNDoxLjA6IFtFUlJdZncgUEMgPSAweDIwMTNmNTVlDQo+IHJ0dzg5Xzg4NTJjdSAy
LTQ6MS4wOiAtLS0+DQo+IGVycj0weDk5OQ0KPiBydHc4OV84ODUyY3UgMi00OjEuMDogUl9BWF9T
RVJfREJHX0lORk8gPTB4NzEwMjAwMTANCj4gcnR3ODlfODg1MmN1IDItNDoxLjA6IFJfQVhfU0VS
X0RCR19JTkZPID0weDcxMDIwMDEwDQo+IHJ0dzg5Xzg4NTJjdSAyLTQ6MS4wOiBEQkcgQ291bnRl
ciAxIChSX0FYX0RSVl9GV19IU0tfNCk9MHgwMDAwMDAwMA0KPiBydHc4OV84ODUyY3UgMi00OjEu
MDogREJHIENvdW50ZXIgMiAoUl9BWF9EUlZfRldfSFNLXzUpPTB4MDAwMDAwMDANCj4gcnR3ODlf
ODg1MmN1IDItNDoxLjA6IFJfQVhfRE1BQ19FUlJfSVNSPTB4MDAwMDAwMDANCj4gcnR3ODlfODg1
MmN1IDItNDoxLjA6IFJfQVhfRE1BQ19FUlJfSU1SPTB4MDAwMDAwMDANCj4gcnR3ODlfODg1MmN1
IDItNDoxLjA6IFJfQVhfQ01BQ19FUlJfSVNSIFswXT0weDAwMDAwMDAwDQo+IHJ0dzg5Xzg4NTJj
dSAyLTQ6MS4wOiBSX0FYX0NNQUNfRlVOQ19FTiBbMF09MHhmMDAwODAzZg0KPiBydHc4OV84ODUy
Y3UgMi00OjEuMDogUl9BWF9DS19FTiBbMF09MHhmZmZmZmZmZg0KPiBydHc4OV84ODUyY3UgMi00
OjEuMDogUl9BWF9DTUFDX0VSUl9JTVIgWzBdPTB4MDAwMDAwMDANCj4gcnR3ODlfODg1MmN1IDIt
NDoxLjA6IFtDTUFDXSA6IENNQUMxIG5vdCBlbmFibGVkDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQ
aW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KVGhvdWdoIHRoaXMgcGF0Y2ggaXMg
ZnJvbSBtZSwgYnV0IEkgdGhpbmsgeW91IGRpZCBzb21lIGNvc21ldGljIGFuZCBhZ3JlZQ0KdGhp
cyBwYXRjaCwgc28gSSdkIGFkZA0KDQpTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxy
dGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KSXMgaXQgb2theSB0byB5b3U/DQoNCg==

