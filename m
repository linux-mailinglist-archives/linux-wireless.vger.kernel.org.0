Return-Path: <linux-wireless+bounces-34150-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qESuClH1yWln3gUAu9opvQ
	(envelope-from <linux-wireless+bounces-34150-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:00:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B495F3551D1
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D1213008524
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 04:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B69537E2F3;
	Mon, 30 Mar 2026 03:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="OmLRRGqy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8184393DF7
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 03:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774843197; cv=none; b=XC626s5NAOqY6tFW+IPb3chUJbhWVA0mNN6UDdyR5Xdey8xn8EuNNCrbaHXQXDuRyQjeth9EYu2Vtlof8EgPTbSlWTqehvRxgpoemnyEeO+6mQvHn/kgoCfY+4/LBGZWr1uGTUjS24RWrlP0fOidXuATsB+z+vi5X99nUUw0vsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774843197; c=relaxed/simple;
	bh=fHkCWCF9pouoeyJ8MKH4ef1/tCAEaiJaSx5AqBrnhlc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BJDV2soD0cF017aTy3hHBcLfMC7siOsPT373ljQSXbm4MSleF2E+jz3zM2VPOzQ/trJJVz9EkHt7Jpr6Ih64UJmWIbXciw6GDMc5/3lu3R61uWo+jJOAPmNK6JmDpAPCyAtuvsHPqrN+RD4O8k1nw7rrPiLicIvWA8LrLq9QJAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=OmLRRGqy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U3xoN73301746, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774843190; bh=fHkCWCF9pouoeyJ8MKH4ef1/tCAEaiJaSx5AqBrnhlc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=OmLRRGqyWsynu+OXjkFpRYbfOkjw6bFzJE1cyZaHmIeqMSC1Aup5ellUe1Khvc/+Y
	 6QulcguuJ3HGPPqxX+60UF2jmfeJbaI2zzgbvBUkU4Vncr/yK47yCu9SH8i+3bESl/
	 PF2RzpXAq1NDVqUGZFNIJnoPgoYkkVdbnOzmEIXrsjKOae97ecuqCd1IY0KUoUplVO
	 lcNBXjTDvXc80WlS7ynlVgSzGr+oWjKduPSdWYa6eAaYWsisew+C1bHbdypr2rb7ZD
	 38DZFdzDERMIl+yyOXWVjGUx41rPM/QYGUfZwUdaR+ChmVGgutm8fAJRYc4DDZZAzy
	 kwTHucXKLe7gQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U3xoN73301746
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 11:59:50 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 11:59:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 11:59:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::46e9:fab9:b2cf:c99b%10]) with mapi id
 15.02.1748.010; Mon, 30 Mar 2026 11:59:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 08/12] wifi: rtw89: Let hfc_param_ini have
 separate settings for USB 2/3
Thread-Topic: [PATCH rtw-next 08/12] wifi: rtw89: Let hfc_param_ini have
 separate settings for USB 2/3
Thread-Index: AQHcvUMMkV42yWPWf0WPgepl4KWm2bXGeBqg
Date: Mon, 30 Mar 2026 03:59:50 +0000
Message-ID: <161ecdf2be3c4e9593156a85d26c595b@realtek.com>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
 <f6c8001f-caf1-4094-b1c7-c654f205613f@gmail.com>
In-Reply-To: <f6c8001f-caf1-4094-b1c7-c654f205613f@gmail.com>
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
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-34150-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B495F3551D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBSVEw4
OTEyQVUgbmVlZHMgZGlmZmVyZW50IHNldHRpbmdzIGZvciBVU0IgMiBhbmQgVVNCIDMuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNv
bT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCj4g
LS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2NvcmUuaCAgICAgIHwg
MiArLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYyAgICAgICB8
IDIgKy0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcnR3ODg1MWIuYyAg
fCAxICsNCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcnR3ODg1MmEuYyAg
fCAxICsNCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcnR3ODg1MmIuYyAg
fCAxICsNCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcnR3ODg1MmJ0LmMg
fCAyICstDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3J0dzg4NTJjLmMg
IHwgMSArDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3J0dzg5MjJhLmMg
IHwgMiArLQ0KDQpJIG1pZ2h0IG1pc3MgdGhpcyBjaGFuZ2UgYnkgcnR3ODkyMmQuYywgc2luY2Ug
d2UgYXJlIHN1Ym1pdHRpbmcgIGF0IHRoZQ0Kc2FtZSB0aW1lLiBCdXQgbm8gd29ycmllcywgaXQg
d2lsbCBiZSBhbGlnbmVkIHdoZW4gcGVvcGxlIGFyZSBhZGRpbmcNClJUTDg5MjJEVS4gIA0KDQoN
Cg==

