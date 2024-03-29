Return-Path: <linux-wireless+bounces-5508-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A9E890FAC
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 01:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75A9FB256DD
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 00:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186C72594;
	Fri, 29 Mar 2024 00:35:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E274D136A
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 00:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711672519; cv=none; b=DOju/Mz3yo/jzg/qluOcy8itoFhWv/I3XIyiOCSBt/gctNqHPlgs1uAh43660hnU5Qntf+EBDSd6loN455U4ImuJoo7FQOX7oYW3G9g80egnZCi+TPivULjBbfINpyvgg+ZSwN30zwXi6TWMlqNDS06bJVZtP0D0S8ztVYQa2kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711672519; c=relaxed/simple;
	bh=74liIhXVtMq+JdEyxNGsLodqvm3HU+LGcRNXDYfDXZQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GoSyynt7XqwGeZ5G2/tjnGuylhsaqmaXXwigh48HPDj9FvqhqFhEL9BDSGFz5m7dRs72etiVpguzKCDKzwW3bemblWlvdYraFW8v+QNCVpnRyuLQgskNNNIYHKhA6gekJqwAsDt/jiiwcQUhDAHSCV80P3Uwt7ztziAQa1E53IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42T0YgWS23090638, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42T0YgWS23090638
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 08:34:42 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 08:34:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 08:34:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Fri, 29 Mar 2024 08:34:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "kvalo@kernel.org"
	<kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "s.l-h@gmx.de"
	<s.l-h@gmx.de>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: RE: [PATCH v3 11/12] wifi: rtlwifi: Add rtl8192du/sw.{c,h}
Thread-Topic: [PATCH v3 11/12] wifi: rtlwifi: Add rtl8192du/sw.{c,h}
Thread-Index: AQHaev7lVhGGoQ4nQ0GxbEPAiHfc3rFCwUMAgAhizQCAANTTI///vigAgAAwEwCAAMUwAIABPbAA
Date: Fri, 29 Mar 2024 00:34:42 +0000
Message-ID: <1f8ebed6a04a4fbebf33b0a3edc2f50b@realtek.com>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
 <2eb79c8c-cf2c-4696-b958-e8d961628e17@gmail.com>
 <f86a40493745a53ff73083f87b3e8fae215eac77.camel@realtek.com>
 <66565618-3638-47e5-afe5-3530214da0c9@gmail.com> <87ttkrzf1m.fsf@kernel.org>
 <5696990a-4450-4d92-bbda-1d9ca3a9a619@gmail.com>
 <4672072ef782ae1200886a190c740e0f3ccec2c8.camel@realtek.com>
 <7873dee1-46a8-48a7-9059-bc300ac98c23@gmail.com>
In-Reply-To: <7873dee1-46a8-48a7-9059-bc300ac98c23@gmail.com>
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

DQo+IEkgZ290IGFub3RoZXIgaWRlYTogaWYgd2UgaGF2ZSBhIGd1YXJhbnRlZSB0aGF0IHRoZSB0
d28gVVNCDQo+IGludGVyZmFjZXMgYXJlIHByb2JlZCBvbmUgYXQgYSB0aW1lLCB0aGVuIHdlIGNh
biBtb3ZlIHRoZSBnbG9iYWwNCj4gdGhpbmdzIGludG8gc3RydWN0IHJ0bF9wcml2LiBUaGUgZmly
c3QgcHJvYmUgY2FsbCB3aWxsIGFsbG9jYXRlDQo+IHRoZSBhcnJheXMgYW5kIGluaXRpYWxpc2Ug
dGhlIG11dGV4ZXMuIFRoZSBzZWNvbmQgcHJvYmUgY2FsbA0KPiB3aWxsIG9idGFpbiB0aG9zZSBm
cm9tIHRoZSBmaXJzdCBzdHJ1Y3QgcnRsX3ByaXY6DQo+IA0KPiBpbnQgcnRsX3VzYl9wcm9iZShz
dHJ1Y3QgdXNiX2ludGVyZmFjZSAqaW50ZiwgLi4uKSB7DQo+ICAgICAgICAgdWRldiA9IGludGVy
ZmFjZV90b191c2JkZXYoaW50Zik7DQo+ICAgICAgICAgc3RydWN0IGllZWU4MDIxMV9odyAqZmly
c3RfaHcgPSB1c2JfZ2V0X2ludGZkYXRhKHVkZXYtPmFjdGNvbmZpZy0+aW50ZXJmYWNlWzBdKTsN
Cj4gICAgICAgICBzdHJ1Y3QgcnRsX3ByaXYgKmZpcnN0X3J0bHByaXYgPSBydGxfcHJpdihmaXJz
dF9odyk7DQo+IA0KDQpDb3VsZCBpdCBoYXZlIHJhY2luZyB3aGVuIG9idGFpbmluZyBtdXRleGVz
IGZyb20gc2Vjb25kIHByb2JlPyANClNob3VsZCB3ZSBuZWVkIGEgbG9jayB0byBlbnN1cmUgdGhl
IHNlcXVlbmNlPyANCg0KV2hlbiBkcml2ZXIgaXMgZ29pbmcgdG8gZG93biwgaG93IGNhbiBtdXRl
eGVzIGdldCBmcmVlIHNhZmVseT8NCg0KSXQgc2VlbXMgbGlrZSB3ZSBzdGlsbCBuZWVkIGFub3Ro
ZXIgZ2xvYmFsIGxvY2sgdG8gZW5zdXJlIHRoYXQuIA0KDQoNCg==

