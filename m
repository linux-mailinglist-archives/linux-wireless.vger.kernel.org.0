Return-Path: <linux-wireless+bounces-13030-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF40597CFE1
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 04:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4221C2137A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 02:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B116179BD;
	Fri, 20 Sep 2024 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="vl2EMMO4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED617578
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 02:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726798959; cv=none; b=IWlMdsKnLWA18YPzMpe41CbrUM6qLqtB/hz9Wxb4OI+ihQhD43QcOmI9rr/yMQXj3hpllONogJSB0ArglrEekAMS2TAjYKmBQOqLetmypEGWgtK6IzRnosKywLMVddaq7bigzvo1eZvLU4yYpwIwlCPNYo3UVbociFwwyOxs1AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726798959; c=relaxed/simple;
	bh=Cj43QmJ1rFAC1IMiKcSmHo6N2oiPhf49dFMqzu62f0Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BhK2QnoLTAnaB2g9oDvrC4mnBsHyMsXRUaCMLjB2sb4/rR3DeTo7waH7LARooxmc1esTK0wHmqlql2nFnQWTfBKcJ8mrVDmn0/DPfPXMmR3znf1nOkyLzEMDHTKWA1fMAaUqTxrTLkxhQN9/gSIMCbGUGCG7ZCMu7osASguVtDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=vl2EMMO4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48K2MYUQ0426823, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726798954; bh=Cj43QmJ1rFAC1IMiKcSmHo6N2oiPhf49dFMqzu62f0Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=vl2EMMO4+Gk7pjFEYWhQ/93BZyLPHVCDgnL+zBgoGlkIW6wK+ANgAxhLQjKMFfRS1
	 aixat4SGQuLvFYVSIjTgGqyKrIdf5uSKWSGSBaqoU/T9sjVdnSTq52xx2EOzc93X/D
	 qKjdmoybfKtsZWUis+gH2Nvq0i3IVodoLc4DTLPn6dyWSnTrzwC0VqCq0Wv/KD2NQ4
	 De72VS2KoIsKxTkIEAsdp+15nWKZV1uO0bJNeWNrOoc4z1glmdDvZFrLuNCe6ePxSp
	 wJK4JDtpGXYTxJmo2ciF6oOtSzuR3Nqt86gTNQWzkYLu3edsUNkd5Pij6joQRUmNrZ
	 n+zruYk6TVExg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48K2MYUQ0426823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 10:22:34 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 10:22:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 20 Sep 2024 10:22:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 20 Sep 2024 10:22:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/2] wifi: rtw88: Constify some arrays and structs
Thread-Topic: [PATCH 1/2] wifi: rtw88: Constify some arrays and structs
Thread-Index: AQHbCVR+AFJ70tcp3EytYwVbczOsW7Jf9RcA
Date: Fri, 20 Sep 2024 02:22:33 +0000
Message-ID: <8eadcbcbc8e84cd982785e53aea6805e@realtek.com>
References: <dae7994f-3491-40de-b537-ebf68df084bb@gmail.com>
In-Reply-To: <dae7994f-3491-40de-b537-ebf68df084bb@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGVz
ZSBhcmUgbmV2ZXIgbW9kaWZpZWQsIHNvIG1ha2UgdGhlbSBjb25zdDoNCj4gDQo+IGNhcmRfZW5h
YmxlX2Zsb3dfODcwM2INCj4gY2FyZF9kaXNhYmxlX2Zsb3dfODcwM2INCj4gcnR3ODcwM2Jfb3Bz
DQo+IA0KPiBydHc4NzIzZF9vcHMNCj4gY2FyZF9lbmFibGVfZmxvd184NzIzZA0KPiBjYXJkX2Rp
c2FibGVfZmxvd184NzIzZA0KPiANCj4gdHJhbnNfY2FyZGRpc190b19jYXJkZW11Xzg4MjFjDQo+
IHRyYW5zX2NhcmRlbXVfdG9fYWN0Xzg4MjFjDQo+IHRyYW5zX2FjdF90b19jYXJkZW11Xzg4MjFj
DQo+IHRyYW5zX2NhcmRlbXVfdG9fY2FyZGRpc184ODIxYw0KPiBjYXJkX2VuYWJsZV9mbG93Xzg4
MjFjDQo+IGNhcmRfZGlzYWJsZV9mbG93Xzg4MjFjDQo+IHJ0dzg4MjFjX2RpZw0KPiBwYWdlX3Rh
YmxlXzg4MjFjDQo+IHJxcG5fdGFibGVfODgyMWMNCj4gcHJpb3FfYWRkcnNfODgyMWMNCj4gcnR3
ODgyMWNfb3BzDQo+IA0KPiBjYXJkX2VuYWJsZV9mbG93Xzg4MjJiDQo+IGNhcmRfZGlzYWJsZV9m
bG93Xzg4MjJiDQo+IHByaW9xX2FkZHJzXzg4MjJiDQo+IHJ0dzg4MjJiX29wcw0KPiBydHc4ODIy
Yl9lZGNjYV90aA0KPiANCj4gY2FyZF9lbmFibGVfZmxvd184ODIyYw0KPiBjYXJkX2Rpc2FibGVf
Zmxvd184ODIyYw0KPiBwcmlvcV9hZGRyc184ODIyYw0KPiBydHc4ODIyY19vcHMNCj4gcnR3ODgy
MmNfZWRjY2FfdGgNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4
MjFjZXJmZTJAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVh
bHRlay5jb20+DQoNCg0KDQo=

