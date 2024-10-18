Return-Path: <linux-wireless+bounces-14199-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576FF9A3552
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 08:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196BB283786
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 06:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E5A2BAEF;
	Fri, 18 Oct 2024 06:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="LaJJ8PUt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B3717E918
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 06:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729232780; cv=none; b=ndWbl5ttQjFjTrYUpOPVdee6PlGctlsPZPObHPXMijiSkkN/geQQawI6ueZx0VBMGHRTfPiqp/EhYa6TtvSqR8+Y0fuW59vQfulC3zaCvQoFJvWnbcc9nM634gbXmAv8eoGvY37utpQSiYYG7P3LLb9wzDwcYREUYlk7MGUl+Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729232780; c=relaxed/simple;
	bh=NeDgfWbdhldQ3thdep1+JfNRN8cubatjQ2q0o1ti7fk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W4+gAwj6NVGvFnhENTM4w5uZn4Aj2Tfsz7TxeZtl2XOStuEDM7Y//aLVE6+BAfoZ4lSME1Fy0B8Jdbv5VjFuhttscWuXdiBjCaofl5YZFgptRid99GxCgrzkBtzXNxgXCzgB3gP8oNa/BPTxwwqmfIy0KtE4Q+Y8AThmyN2XLrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=LaJJ8PUt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49I6QDNv81616973, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729232773; bh=NeDgfWbdhldQ3thdep1+JfNRN8cubatjQ2q0o1ti7fk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=LaJJ8PUtdtgeB7qircfJC3rPlVVJ6cjZCdPycK5k/BcQN9BPQG35eU4dTJf8+blP0
	 xVu/0H2zALVAsj2PMz4JB03GXcSLTbeEV3UaGwmiIb3UBID3qmtT3VSnMcXoZr3og1
	 GGDQxYj8MFAMYI8tcSaI9sbmaRWURJiYAJpwTQzDIaT/QEBX30DzCuwkG8xqeqQ0wV
	 87YePtQakpyZSrBnf1i9DEs5+smjzVlTG2qOrS/dU6C95CAG7IHfAO0T88o35NUQcc
	 Qk3Id6lb5PcgXArW/Yop9YlGODCoU4jXLIC4KDtAVAP2rXcEMDjDSScemmU9EWax0c
	 upLZ76sx6OdVQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49I6QDNv81616973
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 14:26:13 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 14:26:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 18 Oct 2024 14:26:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 18 Oct 2024 14:26:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 07/22] wifi: rtw88: Enable data rate fallback for older chips
Thread-Topic: [PATCH v2 07/22] wifi: rtw88: Enable data rate fallback for
 older chips
Thread-Index: AQHbHB8X7+Mo5dfyyk+9jf7FBZie97KME+rg
Date: Fri, 18 Oct 2024 06:26:13 +0000
Message-ID: <db016f99a85241798d28bf60edb0e61b@realtek.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
 <21dbccaf-82e2-48aa-9b11-dc217ca76309@gmail.com>
In-Reply-To: <21dbccaf-82e2-48aa-9b11-dc217ca76309@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
UlRMODgxMUFVIGZhaWxzIHRvIHBlcmZvcm0gdGhlIDQtd2F5IGhhbmRzaGFrZSB3aGVuIHRoZSBB
UCBpcyB0b28gZmFyDQo+IGJlY2F1c2UgaXQgdHJhbnNtaXRzIHRoZSBFQVBPTCBmcmFtZXMgYXQg
TUNTOSBhbmQgd2hlbiB0aGF0IGRvZXNuJ3QNCj4gd29yayBpdCByZXRyaWVzIDQ4IHRpbWVzIHdp
dGggdGhlIHNhbWUgcmF0ZSwgdG8gbm8gYXZhaWwuDQoNCkl0IGxvb2tzIHdlaXJkIHRoYXQgaXQg
ZG9lc24ndCB0cnkgbG93ZXIgcmF0ZS4NCg0KPiANCj4gUmV0cnlpbmcgNDggdGltZXMgd2l0aCB0
aGUgc2FtZSByYXRlIHNlZW1zIHBvaW50bGVzcy4gU2V0IHRoZQ0KPiBhcHByb3ByaWF0ZSBmaWVs
ZCBpbiB0aGUgVFggZGVzY3JpcHRvciB0byBhbGxvdyBpdCB0byB1c2UgbG93ZXIgcmF0ZXMNCj4g
d2hlbiByZXRyeWluZy4NCg0KVGhpcyBtZWFucyBzZXR0aW5nIDB4MWYgYXMgbGltaXQgaW4gVFgg
ZGVzY3JpcHRvciwgYW5kIHRoZW4gaXQgd2lsbA0KdHJ5IGxvd2VyIHJhdGVzPw0KDQoNCg==

