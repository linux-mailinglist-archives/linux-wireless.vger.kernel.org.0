Return-Path: <linux-wireless+bounces-19533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED5FA47932
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 10:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F04031670D5
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 09:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03A6C2FB;
	Thu, 27 Feb 2025 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="v6NRGyGp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D6B2222D4
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740648681; cv=none; b=c3BytZjtYvX4As3X20XRmfcUnYOuxNucw+2vErepn7s1B+XMiOtecchE/3M/nGGhCauULd06Rrilpnb1Ndt7ZcFeoufR5cjj8OaNdQU+gJEUAySpQevNtV8+P3KpMqGgrAAwDjaOYcCDXYltHPUyKPbHzC6Dh8CpjCRGHvjGXc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740648681; c=relaxed/simple;
	bh=oFYqInCAhyEw8iMWyo4uPtRXKOSYxUsHS0Js4VIZT4U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VmXuaiwWFjO47ATNI71iui+2XXRV7+snUnOdpCSqmeJL2IcOPrkQwi11FlTtd43TUGzvWkUW3fqAKYgEebtb4PjfOtKxulUtwv4UBO1MbTIGKToffpgFVo55BciuEogcccBL0JacLqdDCtAD0UlSOB5bDost48Zno0EjDGHMgrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=v6NRGyGp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51R9UR2901578942, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740648627; bh=oFYqInCAhyEw8iMWyo4uPtRXKOSYxUsHS0Js4VIZT4U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=v6NRGyGpUzlGcnUy9wF0VrI5B3keJgbEYQbXrJeEJw0606Kwp6pyJMtSdh5n/KGfp
	 ljb5O82kRBxujs7yZT7SQ2TS0r1VHR80kJau2vY5qOdfAjlLSvOIGH9g7UQEpZtf6A
	 aBWq0/I89Rap2z+5ZFSNuY5oms+rVLUmK7Ghk6KsTjKY0oWgN2GIaucYnKj4vyf8/7
	 onIuXKUBusCdA6PEEwbeX1JN98BJ40Dh5EaTx3r2z7zDdnLg/03DvwVi0gji0FoIJk
	 f0qStPxU7KnIcBduvaN//Dp5qy5rf9aGMWouNok50vwBdwZPy8lMGqMbMCOyWZi4J1
	 jsZJalBXGsNqw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51R9UR2901578942
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 17:30:27 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Feb 2025 17:30:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 27 Feb 2025 17:30:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Thu, 27 Feb 2025 17:30:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>,
        "ath12k@lists.infradead.org"
	<ath12k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Jeff
 Johnson" <jeff.johnson@oss.qualcomm.com>
Subject: RE: [PATCH v3 0/5] wifi: mac80211/ath12k: add support to fill link statistics of multi-link station
Thread-Topic: [PATCH v3 0/5] wifi: mac80211/ath12k: add support to fill link
 statistics of multi-link station
Thread-Index: AQHbiNRWxqr3IXhrSUK4baRfUgVXCrNaTpeAgACTN7A=
Date: Thu, 27 Feb 2025 09:30:27 +0000
Message-ID: <df26e3aeb3724d969f444eab65d8c872@realtek.com>
References: <20250227045824.91480-1-quic_sarishar@quicinc.com>
 <bac3fdc3bd39e45150e5b7d60be01b5d732a04bf.camel@sipsolutions.net>
In-Reply-To: <bac3fdc3bd39e45150e5b7d60be01b5d732a04bf.camel@sipsolutions.net>
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

SGkgSm9oYW5uZXMsDQoNCkpvaGFubmVzIEJlcmcgPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+
IHdyb3RlOg0KPiBPbiBUaHUsIDIwMjUtMDItMjcgYXQgMTA6MjggKzA1MzAsIFNhcmlrYSBTaGFy
bWEgd3JvdGU6DQo+ID4gQ3VycmVudGx5LCBzdGF0aW9uIHN0YXRpc3RpY3MgYXJlIGZpbGxlZCBh
dCBkZWZsaW5rIGZvciBib3RoIG5vbi1NTCBhbmQNCj4gPiBtdWx0aS1saW5rKE1MKSBzdGF0aW9u
Lg0KPiA+DQo+ID4gSGVuY2UsIGFkZCBzdXBwb3J0IHRvIGZpbGwgc3RhdGlvbiBzdGF0aXN0aWNz
IGZvciB0aGUgY29ycmVzcG9uZGluZw0KPiA+IGxpbmsgb2Ygc3RhdGlvbi4NCj4gPg0KPiA+IERl
cGVuZHMtT246IFtSRkMsdjMsMDAvMTJdIHdpZmk6IGNmZzgwMjExL21hYzgwMjExOiBhZGQgc3Vw
cG9ydCB0bw0KPiA+ICAgICAgICAgICAgIGhhbmRsZSBwZXIgbGluayBzdGF0aXN0aWNzIG9mIG11
bHRpLWxpbmsgc3RhdGlvbg0KPiA+IExpbms6DQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9jb3Zlci8yMDI1MDIxMzE3MTYzMi4xNjQ2NTM4LTEt
cXVpY19zYXJpc2hhckBxdWljaQ0KPiBuYy5jb20vDQo+IA0KPiBUaGF0IGNhbid0IHdvcmsgZm9y
IHRoZSBhdXRvbWF0aW9uLi4uDQoNCkkgaGF2ZSBlbmNvdW50ZXJlZCBzdHJ1Y3R1cmFsIChub3Qg
ZnVuY3Rpb25hbCkgZGVwZW5kZW5jeSBwcm9ibGVtIHRvby4gDQpDb3VsZCB5b3Ugc2hhcmUgaG93
IEkgY2FuIHRlbGwgTklQQSB0aGUgZGVwZW5kZW5jeSBiZXR3ZWVuIHR3byBwYXRjaHNldD8NCg0K
UGluZy1LZQ0KDQo=

