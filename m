Return-Path: <linux-wireless+bounces-8315-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ADA8D4D2E
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 15:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFB71F234AD
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 13:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3013D183A61;
	Thu, 30 May 2024 13:49:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAB53D68
	for <linux-wireless@vger.kernel.org>; Thu, 30 May 2024 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076994; cv=none; b=jd6z4yNX8qVmUb4D2TCAwSLjbHGULPbGeBT/6VfXqgmr3km98l75/fSunDh7gmXbszvA9Thw7ktft94WTLqRKB6hMx31n9u2khERdT8OLCJvdvMUtcag4he5ThQaT/9VjYWBc/n5m0clU/UVV/S5A1pvZj2/BBPChoYTvfFv0BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076994; c=relaxed/simple;
	bh=36qMTbEx4tuAY0Qj8HXlamEQAZ7jJlEQb/qwUlGcXaI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mo5qf6SGXwED/JCa5Nvyx+cCJ4wZoiXL5sUxQ+eg+YqJTCB66LVBhvp8ZXfoaHHdCSQDJmObdqPZg4yih7Ov7wCucbYlfITjHQMmKo5Zcl4kj7frwVMtCY7AZ16j1j2+Kdv1sHG1rNa+AvFGhcMlfOnDGIvxLqLh9F5/7QFNLvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44UDnWpsD777760, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44UDnWpsD777760
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 21:49:32 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 21:49:32 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 30 May 2024 21:49:32 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::b9ff:7c04:a2d:c266]) by
 RTEXMBS03.realtek.com.tw ([fe80::b9ff:7c04:a2d:c266%2]) with mapi id
 15.01.2507.035; Thu, 30 May 2024 21:49:32 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: mac80211: fix NULL dereference at band check in starting tx ba session
Thread-Topic: [PATCH] wifi: mac80211: fix NULL dereference at band check in
 starting tx ba session
Thread-Index: AQHarOpgkYVLW/TkN0STRQVqWrvRWLGttqwAgAIG0bA=
Date: Thu, 30 May 2024 13:49:31 +0000
Message-ID: <639f8c2b59eb42beb56b28e53307886a@realtek.com>
References: <20240523082200.15544-1-kevin_yang@realtek.com>
 <173a8af7e9b544c496f2aee2bb47fca99279873c.camel@sipsolutions.net>
In-Reply-To: <173a8af7e9b544c496f2aee2bb47fca99279873c.camel@sipsolutions.net>
Accept-Language: zh-TW, en-US
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

Sm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4gd3JvdGU6DQo+IA0KPiBP
biBUaHUsIDIwMjQtMDUtMjMgYXQgMTY6MjIgKzA4MDAsIGtldmluX3lhbmdAcmVhbHRlay5jb20g
d3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4gVGhpcyBjaGVja3MgdGhhdCB0aGUgKmZpcnN0KiBs
aW5rIHRoZSBTVEEgdXNlZCBpc24ndCA2IEdIeiwgYnV0IG1heWJlIGl0IHNob3VsZCBiZSAqYW55
KiBsaW5rPw0KPiANCj4gQnV0IHRoZW4gYWdhaW4sIHdlIGRvbid0IHJlYWxseSBuZWVkIHRoaXMg
Y2hlY2sgZm9yIGFuIE1MTyBTVEEgc2luY2UgaXQgd2lsbCBoYXZlIEhUIHN1cHBvcnRlZA0KPiB1
bmxlc3MgaXQgYXNzb2NpYXRlZCBvbiA2IEdIei4gTWF5YmUgd2Ugc2hvdWxkIGp1c3Qgbm90IGRv
IHRoZSBjaGVjayB0aGlzIHdheSwgYnV0IGNoZWNrIGlmIGl0DQo+IGhhcyBIVCBvciBWSFQgb3Ig
SEUgb3Igc29tZXRoaW5nIGxpa2UgdGhhdD8NCj4gDQoNCkkgdGhpbmsgdGhlcmUgYXJlIHR3byBw
b2ludHMgaGVyZS4NCg0KMS4gdGhlIHdheSB0byBhdm9pZCB0aGlzIE5VTEwgZGVyZWZlcmVuY2UN
CihDdXJyZW50IHBhdGNoIGp1c3QgZm9sbG93ZWQgb3JpZ2luYWwgbG9naWMgYW5kIG1hZGUgaXQg
cnVubmFibGUgb24gYm90aCBNTEQgYW5kIG5vbi1NTEQuKQ0KDQpBY2NvcmRpbmcgdG8gY29tbWVu
dHMsIEkgd2lsbCBjaGFuZ2UgdG8gY2hlY2sgaHRfc3VwcG9ydGVkL3ZodF9zdXBwb3J0ZWQvaGFz
X2hlL2hhc19laHQuDQpUaGVuLCBpdCBkb2Vzbid0IG5lZWQgdG8gcmVmZXJlbmNlIGNoYW5yZXEu
b3Blci5jaGFuIGhlcmUuIFNvLCB0aGVyZSB3b24ndCBiZSBOVUxMIGRlcmVmZXJlbmNlLg0KDQoy
LiB0aGUgY2hlY2sgbG9naWMgd2hlbiBNTEQNCihDdXJyZW50IHBhdGNoIGRpZG4ndCBjb25zaWRl
ciB0aGlzIHByb3Blcmx5LikNCg0KQWNjb3JkaW5nIHRvIHNwZWMuLCBCQSBhZ3JlZW1lbnQgZG9l
cyBvbmNlIHBlciBUSUQgYW5kIGFwcGx5IHRvIGFsbCBjb3JyZXNwb25kaW5nIGxpbmtzLg0KU28s
IEkgYW0gdGhpbmtpbmcgbWF5YmUgSSBjaGVjayB0aGUgY29uZGl0aW9ucyBvbiBhbGwgdmFsaWRf
bGlua3Mgd2hlbiBNTEQuDQpBbmQsIG9ubHkgY2hlY2sgZGVmbGluayB3aGVuIG5vbi1NTEQuDQpI
b3cgYWJvdXQgaXQ/DQoNCg==

