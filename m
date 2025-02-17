Return-Path: <linux-wireless+bounces-19065-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F70A37D58
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 09:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C021608AC
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 08:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D56815F306;
	Mon, 17 Feb 2025 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="D7gJqpNr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEF11519A3
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739781778; cv=none; b=BnmXVWM+PSTRBPvlAe8q2egGmD73QPGQBFbexsnwCzMwVTRqTz2VQPDoYy0W0mgchHRymGClk/DJ34oAxStG2xppvKxYqBDivusu7XYVghN9+5ElNAPTQp/DsTbY4WiAWGkeg/K6VDL7LQuo7MXegaW3Z0/G1ahd370064e2JR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739781778; c=relaxed/simple;
	bh=20I+LfMUT4WvbPbuFu/qFIyN8YQICY7KETDi19APdL8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lq0b5w6c9UqaWq18lrHi1yMBzDRBpukhYepYMb8jkEuJ7weZ4ILBqWou4t/BSYyfLSYnuh88il8xty2H63ATBk1Cx5isxBp8E7qsDvlne5fea8GVFRNhrGFy/plHUo9UFaAix3bv/k9bg9UD1MzyBs3QsadHa5iNznRqbXzpaTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=D7gJqpNr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51H8gocP72807484, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739781770; bh=20I+LfMUT4WvbPbuFu/qFIyN8YQICY7KETDi19APdL8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=D7gJqpNrQVHrsM2XKDgtxjGIRlHwHpOUczYL8FVzVcebQS5B5TwkhgWfjdzsoSTFr
	 C1z/fXhDPekDobi8sL+PA3dbs+8K7DSeuXmGjOLoTLiNNkg028uHq0C0XnopIoq6Xf
	 YZgqRv3KG+l6t+4pkld2Z2Zmz6CKTMqiNJyBmb/cEbyBbVg79zF8MB+FsTAMUdl7Ca
	 OCNDU9eS5IM7yYE3HGxk1ko9md7wmlcHnV578MZB/3Z5KwMVh1HldLXcFy9fcrJvGN
	 uCFSLFhHYSZc1EYU36JgXCYTt/HCWcGOaE64jh97gnZrQPT8rv13VxJJPvhbLNxqt9
	 azw0ZUQSD2YSg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51H8gocP72807484
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 16:42:50 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Feb 2025 16:42:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 17 Feb 2025 16:42:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Mon, 17 Feb 2025 16:42:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 1/8] wifi: rtw88: Fix rtw_mac_power_switch() for RTL8814AU
Thread-Topic: [PATCH v2 1/8] wifi: rtw88: Fix rtw_mac_power_switch() for
 RTL8814AU
Thread-Index: AQHbf/TUzVnDQrRvUUmqwMCff8C/drNLL9hg
Date: Mon, 17 Feb 2025 08:42:49 +0000
Message-ID: <c0cac4a479a14218a8c7c1cd5fccd087@realtek.com>
References: <12ab9180-45e9-40e5-98e0-6ef7b6c463d5@gmail.com>
 <749490ce-6663-4c82-bdf2-8df1e237fd74@gmail.com>
In-Reply-To: <749490ce-6663-4c82-bdf2-8df1e237fd74@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBydHdf
bWFjX3Bvd2VyX3N3aXRjaCgpIGNoZWNrcyBiaXQgOCBvZiBSRUdfU1lTX1NUQVRVUzEgdG8gc2Vl
IGlmIHRoZQ0KPiBjaGlwIGlzIHBvd2VyZWQgb24uIFRoaXMgYml0IGFwcGVhcnMgdG8gYmUgYWx3
YXlzIG9uIGluIHRoZSBSVEw4ODE0QVUsDQo+IHNvIGlnbm9yZSBpdC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpBY2tl
ZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg0K

