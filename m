Return-Path: <linux-wireless+bounces-27719-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E926BAAF21
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 04:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141403A777B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 02:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0718F1A9F8C;
	Tue, 30 Sep 2025 02:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="i2dIecwn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B208F3D6F;
	Tue, 30 Sep 2025 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759197807; cv=none; b=mWaUweSqkDY71szpmuGKNIUOWu3SQ/VODS7xXiBAWNdPcjnr5O32eoZHGGd8kBpnBa+404ZaJuQlEYgQhCpbe4iq0mrvl7tQmJqI51p0PfbI5ZBwcTlzHMmCpQgGVQUqq2LLHVer0uwld6/5C4XNLu/kPfZt3PvP0Kl+r5IAhnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759197807; c=relaxed/simple;
	bh=d92AQ9P4yG7koP5tgbZUh8eKfBnRAmJcjBiY7YtKajU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YlOYTQ0i27CljdkWNyjfvsDffY13IBxJr29J6kYvEN+kq1NFg++XoIrL4i+cnaBCcn8AcDRh/1WeSqjr1lpoVwXervjMgHeQYxWbZsLGbdWPX+dtn74ekUz+7BuW+Vo08txZ1+Vd2tPGPtUp3g1VnD2rdUnl6PRpdvBp2NIOBic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=i2dIecwn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58U23AF90243943, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1759197791; bh=d92AQ9P4yG7koP5tgbZUh8eKfBnRAmJcjBiY7YtKajU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=i2dIecwnLwEWsO0RZiobkF2pSKDD9UajZkMo1AsuHW6z6ly6OwDtHqvJh2zg/qnh0
	 xFuneVZZsHACtPiAA/a3gRi2vJozR0tY+hHdYytP8HVcwDpJAswjqqmWMOBkclwvMe
	 RGXQL/lbwHzD5GXUab2A8yKGU4gwZbNUc0QLaImiMSr0L3RfB7hCZW7p43kSwY9Cwg
	 KewYB3pnUn5wpFIDIb2uRUGohYiZQ6gckkjHvwbkV4fUVU5bbUkXohbHf8m9XJN59d
	 oEkFSOimMTNTKg7N+0qmKcsWFyysK7f4Ag3DrAuzHz3WRQW5zpZk70DJ243W3rUrB3
	 p90LgZcGJWDbA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58U23AF90243943
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 10:03:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 30 Sep 2025 10:03:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Tue, 30 Sep 2025 10:03:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Zong-Zhe Yang
	<kevin_yang@realtek.com>,
        Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw-next 2/6] wifi: rtw89: usb: fix leak in rtw89_usb_write_port()
Thread-Topic: [PATCH rtw-next 2/6] wifi: rtw89: usb: fix leak in
 rtw89_usb_write_port()
Thread-Index: AQHcKjJT5omW/NQns0OoAayiPu+sBrSiDXMggAdagwCAAaAzsA==
Date: Tue, 30 Sep 2025 02:03:10 +0000
Message-ID: <41bf70bc86a64692928f025aee2d3006@realtek.com>
References: <20250920132614.277719-1-pchelkin@ispras.ru>
 <20250920132614.277719-3-pchelkin@ispras.ru>
 <fbd7e4192bb8422980a2916489d4961d@realtek.com>
 <20250929120454-04af8f947a628885bf00db71-pchelkin@ispras>
In-Reply-To: <20250929120454-04af8f947a628885bf00db71-pchelkin@ispras>
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

RmVkb3IgUGNoZWxraW4gPHBjaGVsa2luQGlzcHJhcy5ydT4gd3JvdGU6DQo+ID4NCj4gPiBCeSB0
aGUgd2F5LCBkdXJpbmcgSSByZXZpZXcgdGhpcyBmdW5jdGlvbiwgdHhjYi0+dHhfYWNrX3F1ZXVl
IGlzIGENCj4gPiBzdHJ1Y3Qgc2tfYnVmZl9oZWFkLCBob3cgYWJvdXQganVzdCBzdHJ1Y3Qgc2tf
YnVmZiAqc2tiPw0KPiA+IChJIG1pZ2h0IGFzayBCaXR0ZXJibHVlIFNtaXRoIGFib3V0IHRoaXMp
Lg0KPiANCj4gdHhfYWNrX3F1ZXVlIGlzIGltcGxlbWVudGVkIGxpa2UgaW4gcnR3ODgsIGJ1dCB0
aGVyZSBpcyBubyBUWCBhZ2dyZWdhdGlvbg0KPiBpbiBydHc4OSB5ZXQgSSBndWVzcy4NCg0KR290
IGl0ICYgdGhhbmtzLiANCg0KDQo=

