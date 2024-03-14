Return-Path: <linux-wireless+bounces-4719-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C2287B5D2
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 01:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CE8285E07
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 00:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F1739B;
	Thu, 14 Mar 2024 00:35:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7104182
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 00:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710376524; cv=none; b=I95YthOLsxeXtCn0v7tBfYU5E3Gk1ZIHyW/Kt39y+cRG/RR6coI+QH6cWqSDWSYH9apUsrkGU1V4ottNpTzo1dTcRw9vhinhrNb4S745ebqiU8BaMZ1XaImihKj1UF6cQYSaBv9jCZhPd1rhbMiIne0iECJ8Pok5edc+3Iy0Ilg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710376524; c=relaxed/simple;
	bh=jsYIZyiMx2rFcgkv/zkVSBoxqn6sg4CZexRVkSVp2d4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cdo5DPN0Lf9VrUpB34QrFUMc37eADs2SYn0AzNdsEKoSeXqqZgbMxYvIOEM413yHdb89rNlqn542d2pLo3rmKzJYYycNedjR0SojG7ImCcuXSTjlg2CuQnyRuPNJK6F/4GyCsewjEoUJdOGsZHsXXDTwPU3e2rZRCuoG69UMnVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42E0Yq5W21049709, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42E0Yq5W21049709
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 08:34:52 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 08:34:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 08:34:52 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Thu, 14 Mar 2024 08:34:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
CC: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "s.l-h@gmx.de"
	<s.l-h@gmx.de>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: Re: [PATCH 3/3] wifi: rtlwifi: Add new rtl8192du driver
Thread-Topic: [PATCH 3/3] wifi: rtlwifi: Add new rtl8192du driver
Thread-Index: AQHadMv3uItg2xAbwU+uyVoTsONiULE0pIMAgAEcKYCAAB41AA==
Date: Thu, 14 Mar 2024 00:34:52 +0000
Message-ID: <f39d07ae90b42ba4661525ac5b06d8e1deb0dd50.camel@realtek.com>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
	 <303a7402-43f0-4f98-9aa1-b4eb660eead0@gmail.com>
	 <9e5485592f792339593d0b03b86794e5e010337a.camel@realtek.com>
	 <1cfe8151-0989-4853-961d-e14daf293744@gmail.com>
In-Reply-To: <1cfe8151-0989-4853-961d-e14daf293744@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <139682214343584F90EC89E7642CED29@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI0LTAzLTE0IGF0IDAwOjQ1ICswMjAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KPiANCj4gT24gMTMvMDMvMjAyNCAwNzo0OSwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IA0K
PiA+IFBsZWFzZSBydW4gY2hlY2twYXRjaC5wbCB0aGF0IHJlcG9ydHM6DQo+ID4gICAidG90YWw6
IDAgZXJyb3JzLCAxMSB3YXJuaW5ncywgMjcgY2hlY2tzLCA4MDQ1IGxpbmVzIGNoZWNrZWQiDQo+
ID4gDQo+ID4gKFNvcnJ5LCBJIHdyb25nbHkgcG9zdGVkIGFib3ZlIHJlc3VsdCBvbiBwYXRjaCAy
LzMpPg0KPiANCj4gSSBkaWQgcnVuIGNoZWNrcGF0Y2gsIHRoZXNlIGFyZSB0aGUgdGhpbmdzIEkg
ZGVjaWRlZCB0byBpZ25vcmUuIDopDQo+IA0KDQpKdXN0IHJlbWluZCB5b3UgY2FuIGNoZWNrIHRo
b3NlIHdhcm5pbmdzIGJlY2F1c2UgSSdtIHdhaXRpbmcgZm9yIHlvdXIgdjIgdGhhdA0Kc3BsaXRz
IHRoaXMgYmlnIHBhdGNoLCBhbmQgeWVzIHdlIGNhbiBpZ25vcmUgc29tZSBvZiB0aGVtLiANCg0K
DQoNCg==

