Return-Path: <linux-wireless+bounces-13872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 680ED9997D5
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 02:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05EF728553D
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 00:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B957B7DA82;
	Fri, 11 Oct 2024 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="rHwX7GDf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F271C3D
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728605889; cv=none; b=cQbMaxeDwNpxMumnwfljk0mXGuaH982UZkM97mWgcivgnxMsmdUpzlM0/YG7/vS3xwZZlpeKAh68Vaiz7ZsUjlXAZQJPZb/gyo93QsExkUJTpDSGFkJ1WJu4vYKRG4Fo2FKD6WXqvLq1ALtJxfunPh1s33IxgX4YAStR0fbuyEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728605889; c=relaxed/simple;
	bh=fNv5iK91N4A3S8Q3+sDSacCDSs6ubkZylfcnhQiJaVU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GhrnkMdbhSNNPllOQojaG0OFJkkqlqq6+8Y/T+zAbK8/pDRCBMtVcDcMPGqbRurR6CCVwZs52t7wVQTkZz/Az2VBgiAhwF3l0MoiNT/URDxFVfaoBh89M31kEQxaHUY+HxQFlbm6jxntchpJH0i+IlMmwGakDiisAteLaz/kvWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=rHwX7GDf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49B0I1b443038816, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728605881; bh=fNv5iK91N4A3S8Q3+sDSacCDSs6ubkZylfcnhQiJaVU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=rHwX7GDffcCijZXAuWMHIxwXngwUPPXC0b2zgZ6ApOicIrFqgy1+hQJukWp9JvtMG
	 x6a+I/3QDMK04ZH0hpZ15qrhcFb9L0xZsuTc4cmH974VURRRTqagYRCekg9vvSSNHy
	 sftFKi1tuAsnvluhaa/vVAjQF9ZFK8kNvmiAzW9mHHu0RtS63DoJ5s0p1bHWmyAchd
	 qpirADU+FKUHfwtFNKlN12G5+t3aNgYkgVioCXa84Bdyo+fk6H4U5+Zkz/59p0xopN
	 2Bnzi63ratz+JUmj12J5UNmAh5Hjnr7JnsQaey6ynZ1bvz1F5xEZF94YcSxQ3pahyG
	 uH3zh2eMrroBQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49B0I1b443038816
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 08:18:01 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 08:18:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 11 Oct 2024 08:18:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 11 Oct 2024 08:18:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtlwifi: rtl8192du: Don't claim USB ID 0bda:8171
Thread-Topic: [PATCH] wifi: rtlwifi: rtl8192du: Don't claim USB ID 0bda:8171
Thread-Index: AQHbGynxRkG6/djiCEqH16RdBt6+gbKAr2Fg
Date: Fri, 11 Oct 2024 00:18:00 +0000
Message-ID: <225423541cc0446999eff1811e74ea9d@realtek.com>
References: <40245564-41fe-4a5e-881f-cd517255b20a@gmail.com>
In-Reply-To: <40245564-41fe-4a5e-881f-cd517255b20a@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGlz
IElEIGFwcGVhcnMgdG8gYmUgUlRMODE4OFNVLCBub3QgUlRMODE5MkRVLiBUaGlzIGlzIHRoZSB3
cm9uZyBkcml2ZXINCj4gZm9yIFJUTDgxODhTVS4gVGhlIHI4NzEydSBkcml2ZXIgZnJvbSBzdGFn
aW5nIGhhbmRsZXMgdGhpcyBJRC4NCj4gDQo+IEkgdGhpbmsgdGhpcyBJRCBjb21lcyBmcm9tIHRo
ZSBvcmlnaW5hbCBydGw4MTkyZHUgZHJpdmVyIGZyb20gUmVhbHRlay4NCj4gSSBkb24ndCBrbm93
IGlmIHRoZXkgYWRkZWQgaXQgYnkgbWlzdGFrZSwgb3IgaXQgd2FzIGFjdHVhbGx5IHVzZWQgZm9y
DQo+IHR3byBkaWZmZXJlbnQgY2hpcHMuDQo+IA0KPiBSVEw4MTg4U1Ugd2l0aCB0aGlzIElEIGV4
aXN0cyBpbiB0aGUgd2lsZC4gUlRMODE5MkRVIHdpdGggdGhpcyBJRA0KPiBwcm9iYWJseSBkb2Vz
bid0Lg0KDQpDb25maXJtZWQgd2l0aCBpbnRlcm5hbCBJRCB0YWJsZSwgMGJkYTo4MTcxIGlzIGJl
bG9uZyB0byA4MTg4U1UuDQoNCj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgdjYu
MTENCj4gTGluazogaHR0cHM6Ly9naXRodWIuY29tL2x3ZmluZ2VyL3J0bDgxOTJkdS9pc3N1ZXMv
MTA1DQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21h
aWwuY29tPg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoN
Cg==

