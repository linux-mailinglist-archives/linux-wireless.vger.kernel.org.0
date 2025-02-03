Return-Path: <linux-wireless+bounces-18290-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8080BA254EF
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 09:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71EDD7A346D
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 08:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83851FCF68;
	Mon,  3 Feb 2025 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="aECNP9Yr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5A92066FD
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572734; cv=none; b=LwObDnsW3VBCWRj/s/2N1cquroivOqCZWaiRsT5d1JK+LFwUfodZDweeMMRGVrOBuHPpLcEs77BfraAlt+UPXcJsVhjBOSCKdcAJD/XFIdHn3e0xY6eAl+Jm4vXecS7Q16eKlf7i43C4vCDUyWLGgLMobEVflL0EgSJKAbiYawM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572734; c=relaxed/simple;
	bh=QAZDIbTkeobVhjIZ99acn5Bun6ryhKeL6G9kglFjY3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DBUnzn2MpF4xS7+zARe9px8EYTbcsoLdM8tNR65umUj1XXJWZDcgUDlHV0r0Z2iYBrB6JMPA3GkB+vas4Ah/TRZh7YhEJyqkxYYzKgZOWQXefJDxUDT7HycYcfNIRYwbkS6QGoeaU5fqGuQoSOi3Jgm7VshYxM55GGlOUAk4vbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=aECNP9Yr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5138ph3U31420645, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738572703; bh=QAZDIbTkeobVhjIZ99acn5Bun6ryhKeL6G9kglFjY3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=aECNP9YrpbO4Y93q/L7lapWDT5lKAgbDAi+xpdU8zAmAWAJKeIu5HIgG6REe7Ql7c
	 0nrrCSYQFxL1lEg+zRBOdefDFQ0BnmPd4GftSJpEgcXYsgBj/ZSF7kuEbipIfsB+cC
	 L1Z1NRC1LwEL2TCo0a6hWXlEgyfA4Bpx3FucaYzYBzwKvtaGqXJPBCE/fOMHxlMeJx
	 68nfJCzQte5cuJuuuc7SIziYGyKUaciN67FADetZmqMWsXamac0XccG0sEbSfWnWTg
	 VpVPkVM4FN/45C3Qp25UQwib7aO32kaQOtSz5uZWquf5pIPgtkd49mFxrN0e4+//ij
	 DDf1g9S1J/2gw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5138ph3U31420645
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 16:51:43 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Feb 2025 16:51:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 3 Feb 2025 16:51:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Mon, 3 Feb 2025 16:51:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        Ezra Buehler
	<ezra@easyb.ch>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Johannes Berg
	<johannes.berg@intel.com>,
        Reto Schneider
	<reto.schneider@husqvarnagroup.com>,
        Ezra Buehler
	<ezra.buehler@husqvarnagroup.com>
Subject: RE: [PATCH v2] wifi: rtl8xxxu: Enable AP mode for RTL8192CU (RTL8188CUS)
Thread-Topic: [PATCH v2] wifi: rtl8xxxu: Enable AP mode for RTL8192CU
 (RTL8188CUS)
Thread-Index: AQHbbJ1xE9KyBjPFvEiofeS+5WzYALM0aoyAgABYNYCAAIwjMA==
Date: Mon, 3 Feb 2025 08:51:43 +0000
Message-ID: <93fe56295aba4bf0bc1af603bd992f47@realtek.com>
References: <20250122071512.10165-1-ezra@easyb.ch>
 <393aa422-3ac8-40e7-aa2f-62956a844005@RTEXMBS04.realtek.com.tw>
 <19b8059a-c5f6-4467-8b42-31e70b9fe1f3@linutronix.de>
In-Reply-To: <19b8059a-c5f6-4467-8b42-31e70b9fe1f3@linutronix.de>
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

TWFydGluIEthaXN0cmEgPG1hcnRpbi5rYWlzdHJhQGxpbnV0cm9uaXguZGU+IHdyb3RlOg0KPiBB
bSAwMy4wMi4yNSB1bSAwMzo0MCBzY2hyaWViIFBpbmctS2UgU2hpaDoNCj4gPiBFenJhIEJ1ZWhs
ZXIgPGV6cmFAZWFzeWIuY2g+IHdyb3RlOg0KPiA+DQo+ID4+IEZyb206IEV6cmEgQnVlaGxlciA8
ZXpyYS5idWVobGVyQGh1c3F2YXJuYWdyb3VwLmNvbT4NCj4gPj4NCj4gPj4gVGhpcyBhbGxvd3Mg
dGhlIGRyaXZlciB0byBiZSB1c2VkIGluIHdpcmVsZXNzIGFjY2VzcyBwb2ludCBtb2RlIG9uIHRo
ZQ0KPiA+PiBBVDkxU0FNOUcyNS1iYXNlZCBHQVJERU5BIHNtYXJ0IEdhdGV3YXkuDQo+ID4+DQo+
ID4+IFVuZm9ydHVuYXRlbHksIHRoZSBkYXRhIHRocm91Z2hwdXQgaW4gQVAgbW9kZSBhcHBlYXJz
IHRvIGJlIGxvd2VyIHRoYW4NCj4gPj4gd2l0aCB0aGUgdmVuZG9yIGRyaXZlciAob3IgaW4gU1RB
IG1vZGUpLiBFc3BlY2lhbGx5IHdoZW4gc2VuZGluZywgdGhlDQo+ID4+IGRhdGEgcmF0ZSBpcyBz
aWduaWZpY2FudGx5IGxvd2VyLiBNeSBtZWFzdXJlbWVudHMgcGVyZm9ybWVkIHdpdGggaXBlcmYz
DQo+ID4+IGFuZCBhbiBFZGltYXggRVctNzgxMVVuIChWSUQ6IDczOTIsIFBJRDogNzgxMSkgc2hv
d2VkIGEgbWF4aW11bSBUWCByYXRlDQo+ID4+IG9mIGFib3V0IDQgTWJpdHMvc2VjIGNvbXBhcmVk
IHRvIHRoZSB+MjQgTWJpdHMvc2VjIG1lYXN1cmVkIHdpdGggdGhlDQo+ID4+IHJ0bDgxOTJjdSBk
cml2ZXIuDQo+ID4+DQo+ID4+IEFsdGhvdWdoIHRoZSBwZXJmb3JtYW5jZSBtaWdodCBiZSBnb29k
IGVub3VnaCBmb3Igb3VyIHVzZSBjYXNlLCB0aGlzIGlzDQo+ID4+IHNvbWV0aGluZyB0aGF0IHNo
b3VsZCBiZSBmdXJ0aGVyIGxvb2tlZCBpbnRvLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBF
enJhIEJ1ZWhsZXIgPGV6cmEuYnVlaGxlckBodXNxdmFybmFncm91cC5jb20+DQo+ID4NCj4gPiAx
IHBhdGNoKGVzKSBhcHBsaWVkIHRvIHJ0dy1uZXh0IGJyYW5jaCBvZiBydHcuZ2l0LCB0aGFua3Mu
DQo+IA0KPiBJcyB0aGVyZSBhIHJlYXNvbiBmb3Igbm90IHNldHRpbmcgbWFjaWQgaW4gcnRsOHh4
eHVfZmlsbF90eGRlc2NfdjEoKSBhbmQNCj4gcnRsOHh4eHVfdXBkYXRlX3JhdGVfbWFzaygpIGxp
a2UgaXQgd2FzIGRvbmUgZm9yIHRoZSBnZW4yIGNhc2U/DQoNCnJ0bDh4eHh1X2ZpbGxfdHhkZXNj
X3YzKCkgZG9lc24ndCBmaWxsIG1hY2lkIG5laXRoZXIuIFF1aWNrbHkgc2VhcmNoIGZvcg0KdGhl
IGNvZGUgZmlsbGluZyB0eCBkZXNjIFsxXS4gSSB0aGluayB3ZSBjYW4gaGF2ZSBhDQogICAjZGVm
aW5lIFRYREVTQzMyX01BQ0lEX01BU0sgR0VOTUFTSyg0LCAwKQ0KDQpUaGUgaDJjIGNvbW1hbmQg
Zm9ybWF0IG9mIHJ0bDh4eHh1X3VwZGF0ZV9yYXRlX21hc2soKSBzZWVtaW5nbHkgc2hvdWxkIGJl
DQplcXVhbCB0byBydGw4MTkyY19zZXRfcmFpZF9jbWQoKSBbMl0sIGJ1dCBub3QuDQoNCkNhbiBh
bnlvbmUgaGVscCB0byBzcGluIHBhdGNoZXMgYW5kIHRlc3QgaWYgaXQgd29ya3M/DQoNClsxXSBo
dHRwczovL2dpdGh1Yi5jb20vbHdmaW5nZXIvcnRsODE5MmN1L2Jsb2IvbWFzdGVyL2hhbC9ydGw4
MTkyY3VfeG1pdC5jI0wyNTcNClsyXSBodHRwczovL2dpdGh1Yi5jb20vbHdmaW5nZXIvcnRsODE5
MmN1L2Jsb2IvbWFzdGVyL2hhbC9ydGw4MTkyY19jbWQuYyNMMjAxDQoNCg0K

