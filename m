Return-Path: <linux-wireless+bounces-4662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C06C87A1FE
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 04:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3DCAB21DBA
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 03:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D686101E3;
	Wed, 13 Mar 2024 03:53:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F954C144
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 03:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710302006; cv=none; b=LatXld6amMckkOb9QrynB2wMjSnVK9G5QZoxS6Xyhxh40hj2cqriJiCFntP/28GfUiT7CzraBGNJtIVBPLFUl8x9aaOyOwyqe0CsuOlKxKFrIGW/PD/uQOcPz9zU4GfnCvd+uC790siU93Us4tLC/DBObaG4T94yn6GVRZGPuAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710302006; c=relaxed/simple;
	bh=DrC9jxyrX1pnqVW1lHJOY3OoOpUCTWaBGjHaeMrYSco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=II1KMl/KWKMLTxv1KeB+p+irIIIvcs5ydeQjEnqJ/E9Z+d3f6cnXWBMAeas66j6gDXzd+Ucj+ZNums8C1U167WB4O1+GzXvxfYygiCR5vin0gY6GEdFpsvwtHU+UopojWwQ1QkxM3Z9Vigzo8589YOI7PqnDuE8j83cCQ+y4oFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42D3r3rN5482625, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42D3r3rN5482625
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 11:53:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 11:53:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 11:53:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Wed, 13 Mar 2024 11:53:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
CC: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "s.l-h@gmx.de"
	<s.l-h@gmx.de>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: Re: [PATCH 1/3] wifi: rtlwifi: Move code from rtl8192de to rtl8192d-common
Thread-Topic: [PATCH 1/3] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
Thread-Index: AQHadMtD5PbM3LC0pEyBntnmuPy2drE0OGIAgABLjAA=
Date: Wed, 13 Mar 2024 03:53:02 +0000
Message-ID: <c23608da2932896f7beb8fc29247efa5b2e92be0.camel@realtek.com>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
	 <19743f05-5c95-41ad-bdb9-3694e5d2bb41@gmail.com>
In-Reply-To: <19743f05-5c95-41ad-bdb9-3694e5d2bb41@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <B59B50BA885D5546B25E1490FC8F0C60@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI0LTAzLTEzIGF0IDAxOjIxICswMjAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KDQo+IA0KDQo+IHJ0bDkyZF9kbV9jaGVja190eHBvd2VyX3RyYWNraW5nX3RoZXJtYWxfbWV0
ZXIoKSBpcyBhY3R1YWxseQ0KPiB1bnVzZWQgaW4gcnRsODE5MmRlLiBTaG91bGQgSSBqdXN0IGRl
bGV0ZSBpdD8NCj4gDQo+IEkgZG9uJ3QgcmVtZW1iZXIgd2h5IEkgbWFkZSBpdCBzdGF0aWMsIGJ1
dCB0aGF0IGludHJvZHVjZWQNCj4gYSB3YXJuaW5nLg0KDQoNCkkgZmVlbCB3ZSBjYW4gc2V0IHJ0
bHByaXYtPmRtLnR4cG93ZXJfdHJhY2tpbmcgPSBmYWxzZSwgYW5kIHRoZW4gdW5jb21tZW50DQov
KiBydGw5MmRfZG1fY2hlY2tfdHhwb3dlcl90cmFja2luZ190aGVybWFsX21ldGVyKGh3KTsgKi8N
Cg0KDQpNb3JlLCB0aGlzIGZ1bmN0aW9uIGFwcGVhcnMgdHdpY2U6IA0KDQokIGdpdCBncmVwIHJ0
bDkyZF9kbV9jaGVja190eHBvd2VyX3RyYWNraW5nX3RoZXJtYWxfbWV0ZXINCnJ0bDgxOTJkZS9k
bS5jOnN0YXRpYyB2b2lkIHJ0bDkyZF9kbV9jaGVja190eHBvd2VyX3RyYWNraW5nX3RoZXJtYWxf
bWV0ZXIoc3RydWN0IGllZWU4MDIxMV9odyAqaHcpDQpydGw4MTkyZGUvZG0uYzogICAgICAgICAv
KiBydGw5MmRfZG1fY2hlY2tfdHhwb3dlcl90cmFja2luZ190aGVybWFsX21ldGVyKGh3KTsgKi8N
CnJ0bDgxOTJkdS9kbS5jOnZvaWQgcnRsOTJkX2RtX2NoZWNrX3R4cG93ZXJfdHJhY2tpbmdfdGhl
cm1hbF9tZXRlcihzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodykNCnJ0bDgxOTJkdS9kbS5jOiAgICAg
ICAgIHJ0bDkyZF9kbV9jaGVja190eHBvd2VyX3RyYWNraW5nX3RoZXJtYWxfbWV0ZXIoaHcpOw0K
DQpJIHN1cHBvc2UgeW91IHNob3VsZCBtb3ZlIHJ0bDkyZF9kbV9jaGVja190eHBvd2VyX3RyYWNr
aW5nX3RoZXJtYWxfbWV0ZXIoKQ0KdG8gZG1fY29tbW9uLmMuIA0KDQpQaW5nLUtlIA0KDQo=

