Return-Path: <linux-wireless+bounces-30791-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4F8D1BD5B
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 01:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61B3C3028F6C
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 00:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE90223DFB;
	Wed, 14 Jan 2026 00:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="i74RFkwN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE451D5ABA;
	Wed, 14 Jan 2026 00:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768351380; cv=none; b=U1arWLhe8P/twhay1z9S4Ddwrpa1xW0VtM8k/65vjRYbNtqzWPmbj8bMEEjZ+deZvUr81GghQ1AFCZtXIjg4EdM2+6ixQV2KJaIw+tH1p+TQoiFoVOhswX7wpfL2SqTtA/LLxRUMdMPmxdPsaqMmWI7+zU7EVqCEsKJt3jDh/pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768351380; c=relaxed/simple;
	bh=D1lqkMadSFdtz1TZDznXy14oNpx/D2/eOpaP82LUKzQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q05ikdC0bkOjsrGQbDppCgXZGC+78gfbsoAt3wnZg31A6P5iJXaXQWu7UxT9wyaL+8NjVRnzACo/687uA4ScIAMPMLBXPXmR5ZX4w+Z6KNnkenpkMXPwpAH8E5iJpNBvsFVOnpgv7W8kTtiINpwAqaTPBnJsWbzVjytDHVE/ULI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=i74RFkwN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60E0gKwmD4056786, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768351340; bh=D1lqkMadSFdtz1TZDznXy14oNpx/D2/eOpaP82LUKzQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=i74RFkwNw8dUmjldIT0O8sWeFE9Y05u1dBSuZtgmzFR/Gr0bDzs7nRgqkmACnlSOt
	 JxQXs6AI7Ch0fvhF/vs/E/o0ed31FiRGk/LtTMyU7eNjeDPAhbHAvfJu0eZ3kOEFFs
	 5CzF1KeyXbvr8njOgwWQ9KuFCYDOVvFmEGmQd64Vg9qrW09Z9xARN4u6e9YZmTvU+D
	 CdIOiLOOUZMMmpzv08DcKAQg5DoRPtZ8ONmAAozX1h7Mio5OnNsHtXYonFLwmLMBNg
	 bS602kAEQNpBWNBAoZSBWrzs86x7T3HDbcMrlkQZVNtITXUVdJ3El4fVntm9e1rNsx
	 iajsmz0d8pPVQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60E0gKwmD4056786
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 08:42:20 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 08:42:21 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 08:42:21 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Wed, 14 Jan 2026 08:42:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Marco Crivellari <marco.crivellari@suse.com>,
        Johannes Berg
	<johannes@sipsolutions.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Tejun Heo
	<tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker
	<frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michal Hocko <mhocko@suse.com>
Subject: RE: [PATCH 0/3] replace system_unbound_wq, add WQ_PERCPU to
 alloc_workqueue
Thread-Topic: [PATCH 0/3] replace system_unbound_wq, add WQ_PERCPU to
 alloc_workqueue
Thread-Index: AQHchHflG2hBHIy4fU2PLZw20ZoPtLVP82HzgAAA13n//3sVAIABYqHA
Date: Wed, 14 Jan 2026 00:42:21 +0000
Message-ID: <32088fccfccb468db893b33022f21fba@realtek.com>
References: <20251113162032.394804-1-marco.crivellari@suse.com>
 <CAAofZF5yenY8Q92taaJW2-=kenDVuc6ABEtbVT5+yzM_pBVZsw@mail.gmail.com>
 <2f4c22558d20b42615adde772551c1bfb346da47.camel@sipsolutions.net>
 <CAAofZF4Ptjmo=7taHuw_rdya-kGhEZGqXbQn8yPCi1pgA24mkw@mail.gmail.com>
 <ed1279c6d79e13f9679ac33ea47201d5eea2d1c4.camel@sipsolutions.net>
 <CAAofZF7BkX4hy=Sp2Yjq=aGrYL4wPj_vuoMRxPKpnU2Gs2eQbA@mail.gmail.com>
In-Reply-To: <CAAofZF7BkX4hy=Sp2Yjq=aGrYL4wPj_vuoMRxPKpnU2Gs2eQbA@mail.gmail.com>
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

TWFyY28gQ3JpdmVsbGFyaSA8bWFyY28uY3JpdmVsbGFyaUBzdXNlLmNvbT4gd3JvdGU6DQo+IE9u
IFR1ZSwgSmFuIDEzLCAyMDI2IGF0IDEyOjE54oCvUE0gSm9oYW5uZXMgQmVyZw0KPiA8am9oYW5u
ZXNAc2lwc29sdXRpb25zLm5ldD4gd3JvdGU6DQo+ID4gT0sgY29vbCwgbm8gd29ycmllcy4gRldJ
VyBJIG1pZ2h0IGhhdmUgZXZlbiBtb3JlIGluIHdpcmVsZXNzLW5leHQ6DQo+ID4gaHR0cHM6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvd2lyZWxlc3Mvd2lyZWxlc3Mt
bmV4dC5naXQvDQo+ID4NCj4gPiBJZiB5b3Ugd2FudCB0byBzZWUgd2hhdCdzIHBlbmRpbmcsIHdl
IGhhdmUgaXQgaW4gcGF0Y2h3b3JrIGZvciB3aXJlbGVzczoNCj4gPiBodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtd2lyZWxlc3MvbGlzdC8NCj4gPg0KPiA+IFRoZSBh
dGg2a2wgb25lIHNlZW1zIHRvIGJlIHBlbmRpbmcgc3RpbGwgb24gSmVmZjoNCj4gPg0KPiBodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtd2lyZWxlc3MvcGF0Y2gvMjAy
NTExMTMxNjIwMzIuMzk0ODA0LTItbWFyY28uY3JpdmVsbGFyaUBzdXMNCj4gZS5jb20vDQo+IA0K
PiBBaGEsIG5pY2UsIG1hbnkgdGhhbmtzIQ0KPiANCg0KVGhlIHJ0dzg4IG9uZSBbMV0gaXMgc3Rp
bGwgcXVldWVkIG9uIG15IGhhbmQsIGJlY2F1c2UgaXQgd2FzIHdyb25nbHkgYXBwbGllZCBbMl0N
CmNhdXNpbmcgcmVncmVzc2lvbiBhbmQgcmV2ZXJ0ZWQgYnkgWzNdLiBIb3dldmVyLCBJIGhhdmUg
bm90IHJlYmFzZWQgcnR3LW5leHQNCnRyZWUgb24gdG9wIG9mIHdpcmVsZXNzIHRyZWUsIHNvIEkg
Y2FuJ3QgYXBwbHkgWzFdLiBEbyB5b3UgdGhpbmsgdGhpcyBpcyB1cmdlbnQ/DQpJZiBzbywgSSdk
IHNlbmQgYSBwdWxsIHJlcXVlc3QgdG8gd2lyZWxlc3MtbmV4dCByaWdodCBub3cgc2luY2UgaXQg
aXMgNi4xOS1yYzUuDQpJIGRvbid0IHdhbnQgZnJlcXVlbnQgcHVsbC1yZXF1ZXN0IHRoYXQgbWFp
bnRhaW5lcnMgaGF2ZSBleHRyYSBsb2FkLiANCg0KWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5l
bC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9wYXRjaC8yMDI1MTExMzE2MDYwNS4zODE3Nzct
My1tYXJjby5jcml2ZWxsYXJpQHN1c2UuY29tLw0KWzJdIDljMTk0ZmU0NjI1ZCAoIndpZmk6IHJ0
dzg4OiBhZGQgV1FfVU5CT1VORCB0byBhbGxvY193b3JrcXVldWUgdXNlcnMiKQ0KWzNdIDBmZjVl
ODFlMTUxOCAoIlJldmVydCAid2lmaTogcnR3ODg6IGFkZCBXUV9VTkJPVU5EIHRvIGFsbG9jX3dv
cmtxdWV1ZSB1c2VycyIiKQ0KDQoNCg==

