Return-Path: <linux-wireless+bounces-15999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6F49E88B3
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 01:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AE1280EDD
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 00:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6381446B8;
	Mon,  9 Dec 2024 00:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="MZoMsfeY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38E85234;
	Mon,  9 Dec 2024 00:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733704010; cv=none; b=K7WRz+SvQniwx9mKna8ZTQ9ZldI73bpltM9t6h0CgTljTSg/QEY8HGKEzCg75B3e4qRjGZs/zXlG+7KoffcDwXTpaXGhDJWwM1LChb91jORdabHPzf+IKmgHx12+FeVg7d81x9KbMBJgIPnNSN3KKul0lFiAu06ZtDt5dhTCHB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733704010; c=relaxed/simple;
	bh=Xy8TrOhAejEC7lIReBFuEnDvP0P9w1gRCS6WWCa7QeI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z356lZFmypsu361leOBSb9DhGzVf0dkOcGRcVJm2+1+N1NcVBWpJW9xsGMdseCnFYBbTENdj2tr0X9gBkaUlnfNGEhkCcPO+AU2aUGoVI6Xv0GP8gJlCGOBit3Y7AtksN3SpBK4wSlgADVaEoJ7sqh2aY3fviNQokSi8NXJ0jK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=MZoMsfeY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4B90QQHW03911839, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733703986; bh=Xy8TrOhAejEC7lIReBFuEnDvP0P9w1gRCS6WWCa7QeI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=MZoMsfeYP8Fq5Za2ExEXNoQhB6P6Zml23IZE4F6Li9bBssI1bwFc8QM8tLTcE2c8P
	 mpaBJkm7O+ZZpGC99LVGercquGeviPp+ZIcwLnvuWVZJi/I5WHLsUSbDQw1yUYYxee
	 3qdrBenjhA+6/lkrHbEQUT7ae2A4htcMtpS0eWuwfHpmkDdoJHFg+Ksmtl4cMrTf2p
	 tptHTu4kjczXWc5TjXSyCGvNpzRjlaItutI2827UkSMIKuBhA6pVmzruCyGKrD+q9A
	 humnoVDrU4NWQ/b2s3rACVPDorRLyhm9gyBCcNV3n9VBWTonOAr5DMuH7RhRv7trl8
	 izkQauC/k+8lQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4B90QQHW03911839
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 08:26:26 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 08:26:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 9 Dec 2024 08:26:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Mon, 9 Dec 2024 08:26:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Hans de Goede <hdegoede@redhat.com>,
        Jes Sorensen
	<Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Peter Robinson
	<pbrobinson@gmail.com>
Subject: RE: [PATCH] wifi: rtl8xxxu: add more missing rtl8192cu USB IDs
Thread-Topic: [PATCH] wifi: rtl8xxxu: add more missing rtl8192cu USB IDs
Thread-Index: AQHbMR7R6Gvee4SdJkqElRUs0WKrm7K72VoAgCAvYgCAATWcgA==
Date: Mon, 9 Dec 2024 00:26:26 +0000
Message-ID: <8e0a643ecdc2469f936c607dbd555b4c@realtek.com>
References: <20241107140833.274986-1-hdegoede@redhat.com>
 <6cf370a2-4777-4f25-95ab-43f5c7add127@RTEXMBS04.realtek.com.tw>
 <094431c4-1f82-43e0-b3f0-e9c127198e98@redhat.com>
In-Reply-To: <094431c4-1f82-43e0-b3f0-e9c127198e98@redhat.com>
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

SGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IEhpLA0KPiANCj4g
T24gMTgtTm92LTI0IDM6MjMgQU0sIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPiBIYW5zIGRlIEdv
ZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPiB3cm90ZToNCj4gPg0KPiA+PiBUaGUgcnRsOHh4eHUg
aGFzIGFsbCB0aGUgcnRsODE5MmN1IFVTQiBJRHMgZnJvbSBydGx3aWZpL3J0bDgxOTJjdS9zdy5j
DQo+ID4+IGV4Y2VwdCBmb3IgdGhlIGZvbGxvd2luZyAxMCwgYWRkIHRoZXNlIHRvIHRoZSB1bnRl
c3RlZCBzZWN0aW9uIHNvIHRoZXkNCj4gPj4gY2FuIGJlIHVzZWQgd2l0aCB0aGUgcnRsOHh4eHUg
YXMgdGhlIHJ0bDgxOTJjdSBhcmUgd2VsbCBzdXBwb3J0ZWQuDQo+ID4+DQo+ID4+IFRoaXMgZml4
ZXMgdGhlc2Ugd2lmaSBtb2R1bGVzIG5vdCB3b3JraW5nIG9uIGRpc3RyaWJ1dGlvbnMgd2hpY2gg
aGF2ZQ0KPiA+PiBkaXNhYmxlZCBDT05GSUdfUlRMODE5MkNVIHJlcGxhY2luZyBpdCB3aXRoIENP
TkZJR19SVEw4WFhYVV9VTlRFU1RFRCwNCj4gPj4gbGlrZSBGZWRvcmEuDQo+ID4+DQo+ID4+IENs
b3NlczogaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0yMzIxNTQw
DQo+ID4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4+IENjOiBQZXRlciBSb2JpbnNv
biA8cGJyb2JpbnNvbkBnbWFpbC5jb20+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEhhbnMgZGUgR29l
ZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+DQo+ID4+IFJldmlld2VkLWJ5OiBQZXRlciBSb2JpbnNv
biA8cGJyb2JpbnNvbkBnbWFpbC5jb20+DQo+ID4NCj4gPiAxIHBhdGNoKGVzKSBhcHBsaWVkIHRv
IHJ0dy1uZXh0IGJyYW5jaCBvZiBydHcuZ2l0LCB0aGFua3MuDQo+ID4NCj4gPiAzMWJlMzE3NWJk
N2Igd2lmaTogcnRsOHh4eHU6IGFkZCBtb3JlIG1pc3NpbmcgcnRsODE5MmN1IFVTQiBJRHMNCj4g
DQo+IFRoYW5rIHlvdSBmb3IgbWVyZ2luZyB0aGlzLCBzaW5jZSB0aGlzIGlzIGEgYnVnZml4IHBh
dGNoLCBzZWUgZS5nLiA6DQo+IA0KPiBodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19i
dWcuY2dpP2lkPTIzMjE1NDANCj4gDQo+IEkgd2FzIGV4cGVjdGluZyB0aGlzIHBhdGNoIHRvIHNo
b3cgdXAgaW4gNi4xMy1yYzEgYnV0IGl0IGRvZXMNCj4gbm90IGFwcGVhciB0byBiZSB0aGVyZS4N
Cj4gDQo+IENhbiB5b3UgcGxlYXNlIGluY2x1ZGUgdGhpcyBpbiBhIGZpeGVzLXB1bGwtcmVxdWVz
dCB0byB0aGUgbmV0d29yaw0KPiBtYWludGFpbmVyIHNvIHRoYXQgZ2V0cyBhZGRlZCB0byBhIDYu
MTMtcmMjIHJlbGVhc2Ugc29vbiBhbmQgdGhlbg0KPiBjYW4gYmUgYmFja3BvcnRlZCB0byB2YXJp
b3VzIHN0YWJsZSBrZXJuZWxzID8NCj4gDQoNClRoaXMgcGF0Y2ggc3RheXMgaW4gcnR3LmdpdCBh
bmQgNi4xNCB3aWxsIGhhdmUgaXQsIGFuZCB0aGVuIGRyYWluIHRvIHN0YWJsZQ0KdHJlZXMuIEZv
ciB0aGUgcmVkaGF0IHVzZXJzLCBjb3VsZCB5b3UgYXNrIHRoZSBkaXN0cm8gbWFpbnRhaW5lciB0
byB0YWtlIHRoaXMNCnBhdGNoIGFoZWFkPyANCg0KUGluZy1LZQ0KDQo=

