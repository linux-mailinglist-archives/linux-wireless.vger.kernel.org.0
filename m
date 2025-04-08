Return-Path: <linux-wireless+bounces-21230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDC7A7F2A6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 04:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3B9168BFA
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 02:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737A715820C;
	Tue,  8 Apr 2025 02:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GaMV1oDp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E676C4A21
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 02:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744079322; cv=none; b=ZmOwvrH4F1UzobGCjRyisOdR3Oa/sjGe7Nj0H9OQjaS4i6cvloGhqvBcvvNh++pITPLSR742uDrXnSmPQwTdszzAEdODJ5oi47nmhBzlKd0D+DpvdgpEyLzYHQOHJ50Cg6ta7yXGGa7/4cJx+zHC1v4ejz+DhYPMaDt9qeILWL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744079322; c=relaxed/simple;
	bh=TPlLrX64PXQ0RPAIA1myqb5dEzSGjVeAnsdIEQ0pjbc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dYA8kTz/qR/TebePQp+UxcVrXLBkecjurl9cMMGmfU9Jxzg8jUPrMf3jspgOtog8zFccNndptAIeD2bzdS7y0e9ETYpuNEp5RA6iVBpqz8RS7pRwv8Y2QccsGaUmh8iRdb9R9v0FrFnJDmnnU61800tW9gbwk/enZAj2xZVEMk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GaMV1oDp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5382SWxG42710875, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744079312; bh=TPlLrX64PXQ0RPAIA1myqb5dEzSGjVeAnsdIEQ0pjbc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GaMV1oDpSJSEM6x1zb60qtlYauCc96JHP+ztddb3GCbN1DAep7cXiXsouFD32adlR
	 H0cxHHQhf55soPd9+xqfUvlh5TBh49rLTnL2s7xOp7cXrMdueK88PFwrvq0G9/AAPJ
	 cNo8Ax9UAtyqW7pgehl7D4DM8dzkjv+ncCC3yF9jyz2py5FovCqDlt1k6gCwbIuL1b
	 63F02WHHGVmA6NFyRvCUs5AowWfk4IhmWwqbP9u+VvfsDmAkp/jj4erEKUSHPxQ/L8
	 ozB/dj9yiVysYh6se0t/4gB1DZDPruM74eZHV93lJhofbWJZRfWSIARULsbQ2e/w5T
	 f+a9yyri3ZheQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5382SWxG42710875
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Apr 2025 10:28:32 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Apr 2025 10:28:32 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 8 Apr 2025 10:28:31 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::dd06:104c:e04d:a488]) by
 RTEXMBS03.realtek.com.tw ([fe80::dd06:104c:e04d:a488%2]) with mapi id
 15.01.2507.035; Tue, 8 Apr 2025 10:28:31 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: Johannes Berg <johannes.berg@intel.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: On 021d53a3d87e ("wifi: mac80211: fix NULL dereference at band check in starting tx ba session")
Thread-Topic: On 021d53a3d87e ("wifi: mac80211: fix NULL dereference at band
 check in starting tx ba session")
Thread-Index: AQHbpKWdSm2ClWF+wk6tPW+lEv6JRLOZCMzw
Date: Tue, 8 Apr 2025 02:28:31 +0000
Message-ID: <d5b6ba0e6d0e449883ecbc062d343a75@realtek.com>
References: <95a01ec8-4f2e-4cc0-a107-cb40257f100e@yandex.ru>
In-Reply-To: <95a01ec8-4f2e-4cc0-a107-cb40257f100e@yandex.ru>
Accept-Language: zh-TW, en-US
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

RG1pdHJ5IEFudGlwb3YgPGRtYW50aXBvdkB5YW5kZXgucnU+IHdyb3RlOg0KPiANCj4gTG9va2lu
ZyBhdCAwMjFkNTNhM2Q4N2UgKCJ3aWZpOiBtYWM4MDIxMTogZml4IE5VTEwgZGVyZWZlcmVuY2Ug
YXQgYmFuZCBjaGVjayBpbiBzdGFydGluZyB0eA0KPiBiYSBzZXNzaW9uIiksIGNhbiB0aGUgZm9s
bG93aW5nIGJlIHVzZWZ1bCBmb3Igb2xkZXIgKGUuZy4gNS4xMCkga2VybmVscyB3aXRob3V0IGFu
eSBNTE8NCj4gc3VwcG9ydD8NCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvbWFjODAyMTEvYWdnLXR4
LmMgYi9uZXQvbWFjODAyMTEvYWdnLXR4LmMgaW5kZXgNCj4gNGI0YWIxOTYxMDY4Li4xYTg5YmEy
YWVjYWEgMTAwNjQ0DQo+IC0tLSBhL25ldC9tYWM4MDIxMS9hZ2ctdHguYw0KPiArKysgYi9uZXQv
bWFjODAyMTEvYWdnLXR4LmMNCj4gQEAgLTU5NSw3ICs1OTUsOCBAQCBpbnQgaWVlZTgwMjExX3N0
YXJ0X3R4X2JhX3Nlc3Npb24oc3RydWN0IGllZWU4MDIxMV9zdGEgKnB1YnN0YSwgdTE2DQo+IHRp
ZCwNCj4gICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiANCj4gICAgICAgICBpZiAo
IXB1YnN0YS0+aHRfY2FwLmh0X3N1cHBvcnRlZCAmJg0KPiAtICAgICAgICAgICBzdGEtPnNkYXRh
LT52aWYuYnNzX2NvbmYuY2hhbmRlZi5jaGFuLT5iYW5kICE9IE5MODAyMTFfQkFORF82R0haKQ0K
PiArICAgICAgICAgICAhcHVic3RhLT52aHRfY2FwLnZodF9zdXBwb3J0ZWQgJiYNCj4gKyAgICAg
ICAgICAgIXB1YnN0YS0+aGVfY2FwLmhhc19oZSkNCj4gICAgICAgICAgICAgICAgIHJldHVybiAt
RUlOVkFMOw0KPiANCj4gICAgICAgICBpZiAoV0FSTl9PTl9PTkNFKCFsb2NhbC0+b3BzLT5hbXBk
dV9hY3Rpb24pKQ0KPiANCj4gRG1pdHJ5DQo+IA0KDQpXaXRob3V0IE1MTywgbm8gTlVMTCBkZXJl
ZmVyZW5jZSBoZXJlLCBhbmQgdGhlIG9yaWdpbmFsIGxvZ2ljIGlzIHdvcmthYmxlICh0aG91Z2gg
bm90IHZlcnkgaW50dWl0aXZlKS4NClNvLCB0byBtZSwgaXQgZG9lc24ndCBzZWVtIG11Y2ggbmVj
ZXNzYXJ5IGZvciBvbGRlciBrZXJuZWxzLg0K

