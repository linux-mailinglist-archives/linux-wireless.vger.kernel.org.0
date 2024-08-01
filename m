Return-Path: <linux-wireless+bounces-10803-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9666D944160
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 04:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F07FB29148
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 02:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B7C148311;
	Thu,  1 Aug 2024 02:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="FMPXw8O/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF7314600C
	for <linux-wireless@vger.kernel.org>; Thu,  1 Aug 2024 02:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722478093; cv=none; b=cWyhxHNZnP4b+0aoGwNQGuFDJZ68JQLyx6EWEufEHwniruaVn8knEClVt29oThrU34SPJ+UbJGyvy9voIHd6sdoa+jKyBJqrPEriIqMlnDm6tn3RLFX2OF8CSj8EtX4mkubEclKXCBuCdEKxuiQ1KmxKV2Dp5sRxFXD8PUTuyKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722478093; c=relaxed/simple;
	bh=HF+WgWFda+PKo5z6WxnJFmMB7F2ywP05Rp7X9lmF9/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S1B7JjZz1IWmbnqpRzwjZYtXDwNMmxHFVfpGK1AID8P75e4gvmoxtFODs/xf+jgJifA7Q1LgA910WeSbNjwxGwIwGeyRey9sREeShZzfYyf3DMVzEAURjg1j2NtCj9m2kEU+/yVxu2efgRtICIC3kQ9kS4uKFeNNwdY0bqIfUzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=FMPXw8O/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 471284nK43090632, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722478084; bh=HF+WgWFda+PKo5z6WxnJFmMB7F2ywP05Rp7X9lmF9/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=FMPXw8O/2lfZIA7RJCGd0aRNg0WzzUDR36bAOmsI96QFLGDX+sLm2Z58aeCrwHNnh
	 NolGnYDu6bUzfujGX9Pa0KVrNZpyCOWD9UfOdexSMkawhy1v+W0Z8tmGvz6fI3Uh/o
	 zcqFeLH2i75Ppvx70pe5VMkuwTo3kCfFcRktXr6JzasjhJyt8KhzyES54R23v2U0vv
	 5H1KMws90bVi+L8XSfq1IQFjd2FWmNW5XR22m4P597/qH1nfTT3t8Okd0zNufV6HV4
	 XfBC2a3ILwiJp4mZCd2PcOchow9MmayvJYytZoUaqi8JY1QCjmN8S5XpXLymk4Re5K
	 Z8/DO/mVqN7sA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 471284nK43090632
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 10:08:04 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 10:08:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Aug 2024 10:08:04 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 1 Aug 2024 10:08:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH 4/4] wifi: rtw88: Enable USB RX aggregation for 8822c/8822b/8821c
Thread-Topic: [PATCH 4/4] wifi: rtw88: Enable USB RX aggregation for
 8822c/8822b/8821c
Thread-Index: AQHa4SaYNUpCVu7qYkCj5dGtFlHeg7IOvtDwgAHO/wCAAR6hkA==
Date: Thu, 1 Aug 2024 02:08:04 +0000
Message-ID: <93593428a9bf42b7817a4fb33b539a2c@realtek.com>
References: <c03390ce-34c2-42dd-9bd6-b231bb1f2fae@gmail.com>
 <323190ee-5b88-4d37-bad0-b721cdfead1a@gmail.com>
 <a4e147a24d5d4165a336432d89773025@realtek.com>
 <9e1c7288-775f-4f10-a6d4-c93b635a3c1b@gmail.com>
In-Reply-To: <9e1c7288-775f-4f10-a6d4-c93b635a3c1b@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBJIHN1
cHBvc2UgdGhleSBjYW4gYmUgbW92ZWQgdG8gdGhlIHNhbWUgcGxhY2UsIGxpa2UgdGhlIGJ1cnN0
DQo+IHN0dWZmLiBNYXliZSBzdHJ1Y3QgcnR3X2hjaV9vcHMgc2hvdWxkIGhhdmUgYSBuZXcgbWVt
YmVyIGNhbGxlZA0KPiByeF9hZ2dyZWdhdGlvbiwgaW4gY2FzZSBzb21lb25lIGRlY2lkZXMgdG8g
bWFrZSB0aGUgU0RJTyBkcml2ZXINCj4gdXNlIGR5bmFtaWMgUlggYWdncmVnYXRpb24gYXMgd2Vs
bD8NCg0KTm90IHN1cmUuIFdlIGNhbiBqdXN0IGxlYXZlIE5VTEwgb3IgZHVtbXkgZnVuY3Rpb24g
Zm9yIFNESU8gdGVtcG9yYXJpbHkuIA0KDQo=

