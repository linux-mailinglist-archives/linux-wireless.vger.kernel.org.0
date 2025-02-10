Return-Path: <linux-wireless+bounces-18680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5FBA2E21A
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 02:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA133A5AA0
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 01:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DF3F4F1;
	Mon, 10 Feb 2025 01:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="DVIbb5Ke"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA2A934
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739152220; cv=none; b=Nlza5FlAUdLB9XJCcT32pX11wYdz5Ym7Gov9zzGJURhWcHmZ0LVChBM7xL3YvaPYiqVFLBwApqyj2y2Q0S6x1O5VuGt6BbJidUUFM/Ne3cWEysqbmHzS5HDnUvKzwLCkKPJBuHEcGak+IyJ1ejxLTzO7ytMQGZ3icp4WVz7vg1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739152220; c=relaxed/simple;
	bh=8CijdNNZm6tCZ+Ts8Dkixqyknts92cblq6kzIWt0SZY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=myiLTfR1hm2+A9+4o8tvM55+et+H4oBswy8j5fgAoj6QezvAmU2BDkZGrWbAl7BsLV4pa4siKU9RoxxWVFAo/P0Gz4bpvRXBBvMmfqkco6ASLxa5QGzEQYSZduOxWsumnMDIn+i5bYNZRySk+0CSDcZOASqPr09GkEuXBM4UvyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=DVIbb5Ke; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51A1oEHW11426325, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739152214; bh=8CijdNNZm6tCZ+Ts8Dkixqyknts92cblq6kzIWt0SZY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=DVIbb5Keopi2ZftIS7TadVLUhANT+Zw1nuL1ZxS35YNYyx8PotcXjYLwERKhaO6f6
	 oKvQBKNsC8EAt+WPzDGByTupHkrTmx4NshTKscZ50f3d04QmDtMrSpw3sWiiCKDRlW
	 BL+Qwni/H4X42vEy/0/h5NgNDJeuisPkrD27tDrrtuVojb+qyYFjSCP4I4jkKhRYeU
	 +qzC3LGK6e4/a/XN7gk4pfTH9Z5BeuX5m/btcyyDFn8kMYFe8uT+HWmew0H4Fq3QdE
	 KO07Ee1MJJufPZBiuQrwjO13Dr6UOIwpZBi9sayO74eT1P11j85nLcQhk+W4E+zarE
	 DeyJ3XXo7UXRg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51A1oEHW11426325
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 09:50:14 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Feb 2025 09:50:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 10 Feb 2025 09:50:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Mon, 10 Feb 2025 09:50:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 8/9] wifi: rtw88: Extend TX power stuff for 3-4 spatial streams
Thread-Topic: [PATCH v2 8/9] wifi: rtw88: Extend TX power stuff for 3-4
 spatial streams
Thread-Index: AQHbdzR0fZFlw+CekUqYdq7BuvR0mLM/zazg
Date: Mon, 10 Feb 2025 01:50:13 +0000
Message-ID: <244c5716d3f74d3187abde94214883cf@realtek.com>
References: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
 <d0c0e126-0794-4c4e-9203-ea39a707b673@gmail.com>
In-Reply-To: <d0c0e126-0794-4c4e-9203-ea39a707b673@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBbHRo
b3VnaCB0aGUgUlRMODgxNEFVIG9ubHkgaGFzIDMgc3BhdGlhbCBzdHJlYW1zLCBtYXliZSBzb21l
IG90aGVyIGNoaXANCj4gaGFzIDQuDQo+IA0KPiBDb3JyZWN0IHRoZSBUWCBwb3dlciBpbmRleCBh
bmQgVFggcG93ZXIgbGltaXQgY2FsY3VsYXRpb25zIGZvciAzU1MgYW5kDQo+IDRTUyBIVC9WSFQg
cmF0ZXMuDQo+IA0KPiBXaXRoIHRoaXMgdGhlIFJUTDg4MTRBVSBjYW4gc2V0IHRoZSBUWCBwb3dl
ciBjb3JyZWN0bHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4
ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJl
YWx0ZWsuY29tPg0KDQo=

