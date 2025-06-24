Return-Path: <linux-wireless+bounces-24401-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB4FAE5CB3
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 08:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD34A3BA822
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 06:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DB61A42C4;
	Tue, 24 Jun 2025 06:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="V7b3mc7Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABBA19AD48
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 06:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750745880; cv=none; b=hHsrEd+K//cleJbASc/9YaIpHow2rTrXOdAf3Sb9ZR4gukLtEXeyi8HMbGyhyK2TItv+yH4u8bdgGHg0T4EluG3BDXKJCbD9B3P3zy+JFP1tKTQwfv2d9OS6zIMtfGCacIGElSx3vTUNQJ3M560adhAraaN9X/SXnHKILjDDb9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750745880; c=relaxed/simple;
	bh=i/PDK79aaX78rII8skYzGL+g0JkzStqlYEwt+ttYXqE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xgdi+2kAKGxMAVuHZk0cLpsyHbBeAKlFlypY57Evsqbt9JP/K58wPZphD1aX1DTtLlPcVlZBHG4rhBZwTaZDtKCALoTISU8tefFFQdkyHujCAWACnpaPXKG4wLjxng9LMg1Y7NYwqtLrTK+3Kx3KH7bGjc5T8CyEO4ejEWRSrr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=V7b3mc7Y; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55O6Ht3fA3156409, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750745875; bh=i/PDK79aaX78rII8skYzGL+g0JkzStqlYEwt+ttYXqE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=V7b3mc7YJKOzSPd6YeSz3jZi9PyXN/ms+V62H2s2ptAKrRa9+ygtXI66Pe5+TZ6G8
	 oxDn0fywIi2HzytGA4Ku5Xu7Vx4jJoLSzWCta4ZTTUg26hqdF/q1JDPzywbSIovPMB
	 PHlZgeJsqu6I/Xk+/+qli9qzhiFyvAUXtDJ8aNqzonDgFNDTFzjMjoRVTcmDtWUaUk
	 r2MGYkIfuu8ujkqx+0fYsRqBPuc+DbGHHsPuEOm4apiSbaqV4S56HgE/QxHKXguixm
	 vPJHhJK29rZU6es0gHoX3unEriY7U/iV3hhhsUUPg2TB4czPjDKiRveaylyjoiTt+w
	 5tjLkICaIf6mg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55O6Ht3fA3156409
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 14:17:55 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Jun 2025 14:18:09 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 24 Jun 2025 14:18:08 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Tue, 24 Jun 2025 14:18:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v3 12/14] wifi: rtw89: Add usb.{c,h}
Thread-Topic: [PATCH rtw-next v3 12/14] wifi: rtw89: Add usb.{c,h}
Thread-Index: AQHb4hYyuc5Gik9HDkqPh8/oMZn2OLQR2kSA
Date: Tue, 24 Jun 2025 06:18:08 +0000
Message-ID: <f7b37013ef354a2b975e1df5b5d14f16@realtek.com>
References: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
 <4f456355-fdc5-4624-ab00-ed374f3b58a1@gmail.com>
In-Reply-To: <4f456355-fdc5-4624-ab00-ed374f3b58a1@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBZGQg
dmVyeSBiYXNpYyBVU0Igc3VwcG9ydC4gTm8gVFgvUlggYWdncmVnYXRpb24sIG5vIFRYIHF1ZXVl
cywgbm8NCj4gc3dpdGNoaW5nIHRvIFVTQiAzIG1vZGUuDQo+IA0KPiBSVEw4ODUxQlUgYW5kIFJU
TDg4MzJCVSB3b3JrLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRs
ODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCnYzIGlzIGZpbmUgdG8gbWUuIA0KDQpTaW5jZSB5b3Ug
YXJlIGdvaW5nIHRvIGFkZCBUWCBxdWV1ZXMgYnkgdjQsIEkgZG9uJ3QgYWRkIG15IEFja2VkLWJ5
Lg0KDQoNCg==

