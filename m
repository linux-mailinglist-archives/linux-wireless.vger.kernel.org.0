Return-Path: <linux-wireless+bounces-6910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D710A8B2E81
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 03:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7836D1F23839
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 01:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E2A17F6;
	Fri, 26 Apr 2024 01:59:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E83917CD
	for <linux-wireless@vger.kernel.org>; Fri, 26 Apr 2024 01:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714096771; cv=none; b=RyIL/h5exXOT2WO4LXcniBpZ1eR3G1NLn5EZCBMlnfhwnDftU5JKBx6GS1LUsh8PXrrMMv89zeQkgl2NPr6vMMzlb7t0LIqGmOmXmZcsTT2Fpm0vr5Z29veNCZDgkQfoieSd2W/lAtObxa//2+wgeEsoW/qgnf2O/x+iGWSeqmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714096771; c=relaxed/simple;
	bh=629d361E17P3yxogIe1ulg60YpMuX4h4jx2JQelnYz0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GryxAwECHYSth422O/PMni9dJsGKh9X1bmeF5B1oHIG8WwUcpINFDGTGUFe8UFI66O3rNkqjVO3tqq53P0UliQARAMRlRrFkOoWx+zVyebC1uTj/pOQ9fv9TBdBLK93cmo6ldEsh1S1SSwE7RyUukVt87aCcopmSlXGEVVbUHqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43Q1x08z94158038, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43Q1x08z94158038
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 09:59:00 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 09:59:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 09:58:59 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 26 Apr 2024 09:58:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v7 5/6] wifi: rtlwifi: Clean up rtl8192d-common a bit
Thread-Topic: [PATCH v7 5/6] wifi: rtlwifi: Clean up rtl8192d-common a bit
Thread-Index: AQHalzxyy+Yr88dtfkmIjRP6RR/tN7F5y8AQ
Date: Fri, 26 Apr 2024 01:58:59 +0000
Message-ID: <89595f7d899f48dbb3a6832fca085935@realtek.com>
References: <72231f87-60fd-4d87-8cf4-ee2967f22dd2@gmail.com>
 <f6acfa78-2f4e-47f1-95d4-65aa77510113@gmail.com>
In-Reply-To: <f6acfa78-2f4e-47f1-95d4-65aa77510113@gmail.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
SW1wcm92ZSByZWFkYWJpbGl0eToNCj4gICogYWRkIGVtcHR5IGxpbmVzDQo+ICAqIHVzZSBhYnNf
ZGlmZiBpbiBydGw5MmRfZG1fdHhwb3dlcl90cmFja2luZ19jYWxsYmFja190aGVybWFsbWV0ZXIN
Cj4gICogcm9sbCB1cCByZXBlYXRlZCBzdGF0ZW1lbnRzIGludG8gYSBmb3IgbG9vcCBpbg0KPiAg
ICBydGw5MmRfZG1fdHhwb3dlcl90cmFja2luZ19jYWxsYmFja190aGVybWFsbWV0ZXINCj4gICog
c2hvcnRlbiBsaW5lcyBieSByZXBsYWNpbmcgbWFueSBpbnN0YW5jZXMgb2YgInJ0bHByaXYtPmRt
IiB3aXRoICJkbSINCj4gICAgcG9pbnRlciBpbiBydGw5MmRfZG1fdHhwb3dlcl90cmFja2luZ19j
YWxsYmFja190aGVybWFsbWV0ZXINCj4gICogc29ydCBzb21lIGRlY2xhcmF0aW9ucyBieSBsZW5n
dGgNCj4gICogcmVmYWN0b3IgX3J0bDkyZF9nZXRfdHhwb3dlcl93cml0ZXZhbF9ieV9yZWd1bGF0
b3J5IGEgbGl0dGxlDQo+ICAqIHJlZmFjdG9yIF9ydGw5MmRlX3JlYWRwb3dlcnZhbHVlX2Zyb21w
cm9tIGEgbGl0dGxlDQo+IA0KPiBEZWxldGUgdW51c2VkIHN0cnVjdHMgdGFnX2R5bmFtaWNfaW5p
dF9nYWluX29wZXJhdGlvbl90eXBlX2RlZmluaXRpb24NCj4gYW5kIHN3YXQuDQo+IA0KPiBTaW1w
bGlmeSBydGw5MmRfZmlsbF9oMmNfY21kIGEgbGl0dGxlIGFuZCBkZWxldGUgYSBwb2ludGxlc3Mg
d3JhcHBlcg0KPiBmdW5jdGlvbi4NCj4gDQo+IFRlc3RlZCB3aXRoIGEgc2luZ2xlIE1BQyBzaW5n
bGUgUEhZIFVTQiBkb25nbGUgZnJvbSBBbGlleHByZXNzIGxhYmVsbGVkDQo+ICJDQyZDIFdMLTYy
MTAtVjMiLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNl
cmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVr
LmNvbT4NCg0KVGhhbmtzIGZvciB0aGUgY29zbWV0aWNzIG9mIHRoaXMgcGF0Y2guIEl0IGxvb2tz
IG11Y2ggYmV0dGVyLiA6KQ0KDQoNCg==

