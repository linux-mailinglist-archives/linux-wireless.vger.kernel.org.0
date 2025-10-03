Return-Path: <linux-wireless+bounces-27796-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56101BB5DD1
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Oct 2025 05:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1174B42885E
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Oct 2025 03:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA22DE555;
	Fri,  3 Oct 2025 03:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="cPfF3HJm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A011862
	for <linux-wireless@vger.kernel.org>; Fri,  3 Oct 2025 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759462377; cv=none; b=f4Ukacnt8SGsWjPyHgecqk60Fu48bmE3uNQza75HAlk+e/cA3eFXPFcIsrEdjgMN1mRA6Uy5G+R68pF8qw8tvTqpsPXgg3o78bODqO7RAGCnqd+yKv0s33cxuZfFy7XLeQhZJreL80hjArd980t2t98hAbspcPzjb5Ri24PSifQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759462377; c=relaxed/simple;
	bh=b/MxCx4MyRMddsFVL10N82QidSC6P39IuvJvS7JC6EY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XxrfayvUC8/6is/y/dyeZkE+1m5VIiSB531xIOGuG1pf8ptqxNodRYt8i0EO6LaQaxjd2puaARLuhMb/AOsz9W7+Mg5d/ZUa6M4l/pXdMcow6qGEVquJsCoeOGYTwXSDA8PnFHFF+GFtyniIzmt4vLQSHIdlIBrfThKiBodFNyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=cPfF3HJm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5933Sfm661479728, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1759462122; bh=b/MxCx4MyRMddsFVL10N82QidSC6P39IuvJvS7JC6EY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=cPfF3HJmU1nm2tIG/c8P25TH/ngq3byWNG1rZjWBj22I/PQRwxl/SMPz9eEFWhUov
	 O6dBd58UQcKNq3eXOph4flG0gzuyJ2R0d5GI5f2qyLwovUZXsF7Wd5b7gofcZwEgI4
	 geGdNUh8/AKx3SZDvYH48kb3yhbTVQMpZP5usMaYzSjW1k+Qhah8zMxFSAZl1IVuBE
	 a4eA5L5Flg5K51ekRQOXgVhMdEBjlODvwSuI3MkuEmJUsaVqiUqchdD876awBtqWrh
	 w90FwQmA++s0HxBvjvL4K60ol9LmYj9qPXxgg6+z1LbLgyXn8zC9tlGm6ynxzmvVKE
	 HNqsFmZBPlv5w==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5933Sfm661479728
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Oct 2025 11:28:41 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 3 Oct 2025 11:28:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 3 Oct 2025 11:28:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Fri, 3 Oct 2025 11:28:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Nicolas Escande <nico.escande@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
CC: "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
        "Lorenzo
 Bianconi" <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: RE: [DESIGN RFC] Critical Update handling in the kernel
Thread-Topic: [DESIGN RFC] Critical Update handling in the kernel
Thread-Index: AQHb9tctaakFDhkEZkqxOSgZJa1WNbQ9uciAgANE8KCAQdy2AIAnJ0OAgAY2QWA=
Date: Fri, 3 Oct 2025 03:28:41 +0000
Message-ID: <5f5e23e38544400895ed888ea824cdea@realtek.com>
References: <20250717045540.27208-1-aditya.kumar.singh@oss.qualcomm.com>
 <1a77ca6a35ad03f839b7c997de3977b521d88edc.camel@sipsolutions.net>
 <fce447412112421887a1a81f5ada850e@realtek.com>
 <e79d3239-d536-45c9-b081-09ea7ba5bb00@oss.qualcomm.com>
 <DD5A1KBRHCWZ.RXDUFTTTZU4J@gmail.com>
In-Reply-To: <DD5A1KBRHCWZ.RXDUFTTTZU4J@gmail.com>
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

Tmljb2xhcyBFc2NhbmRlIDxuaWNvLmVzY2FuZGVAZ21haWwuY29tPiB3cm90ZToNCj4gT24gVGh1
IFNlcCA0LCAyMDI1IGF0IDQ6MjQgUE0gQ0VTVCwgSmVmZiBKb2huc29uIHdyb3RlOg0KPiA+IE9u
IDcvMjQvMjAyNSAxOjQ4IEFNLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4+IEpvaGFubmVzIEJl
cmcgPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+IHdyb3RlOg0KPiA+Pj4+IEJlZm9yZSB3ZSBt
b3ZlIGZvcndhcmQgd2l0aCBpbXBsZW1lbnRhdGlvbiwgd2UnZCBsaWtlIHRvIGNvbmZpcm0gd2hl
dGhlcg0KPiA+Pj4+IHRoZSBwcm9wb3NlZCBkZXNpZ24gbG9va3Mgc291bmQuIEFyZSB0aGVyZSBh
bnkgY29uY2VybnMgb3IgcG90ZW50aWFsIGlzc3Vlcw0KPiA+Pj4+IHdlIHNob3VsZCBiZSBhd2Fy
ZSBvZj8NCj4gPj4+Pg0KPiA+Pj4+IE91dCBvZiBjdXJpb3NpdHksIHdlJ3JlIGFsc28gaW50ZXJl
c3RlZCBpbiB1bmRlcnN0YW5kaW5nIGhvdyBvdGhlciB2ZW5kb3JzDQo+ID4+Pj4gYXJlIGN1cnJl
bnRseSBoYW5kbGluZyB0aGlzIGZlYXR1cmUgaW4gdGhlaXIgZG93bnN0cmVhbSBkcml2ZXJzLiBJ
cyBpdA0KPiA+Pj4+IHR5cGljYWxseSBvZmZsb2FkZWQgdG8gZmlybXdhcmUsIG9yIGlzIHRoZSBs
b2dpYyBpbXBsZW1lbnRlZCBpbiB0aGUga2VybmVsPw0KPiA+Pj4+IEp1c3Qgd2FudCB0byBjb25m
aXJtIHdoZXRoZXIgYWxsIHRoaXMgd2lsbCBiZSB1c2VkIG9ubHkgYnkgbWFjODAyMTFfaHdzaW0N
Cj4gPj4+PiBvciB3aWxsIHRoZXJlIGJlIGFueSBhY3R1YWwgdXNlcnM/DQo+ID4+Pg0KPiA+Pj4g
SSB0aGluayBQaW5nLUtlIHByZXZpb3VzbHkgaW5kaWNhdGVkIHRoYXQgdGhleSB3ZXJlIHBsYW5u
aW5nIHRvIGRvDQo+ID4+PiB0aGluZ3MgaG9zdCBzaWRlPyBJJ20gbm90IHN1cGVyIGZhbWlsaWFy
IHdpdGggdGhlIHRpbWluZyBjb25zdHJhaW50cw0KPiA+Pj4gdGhvdWdoLCBzbyBJJ20gbm90IHN1
cmUgd2hhdCB0aGF0IG1pZ2h0IGltcGx5Lg0KPiA+Pg0KPiA+PiBZZXMsIFJlYWx0ZWsgdmVuZG9y
IGRyaXZlciBoYW5kbGVzIHRoZSBmZWF0dXJlIGluIGhvc3QgZHJpdmVyLiBIYXZpbmcgbm90DQo+
ID4+IHRlc3RlZCBDU0EgYW5kIE1MIHByb2NlZHVyZSBtZW50aW9uZWQgaW4gdGhpcyBkaXNjdXNz
aW9uIHRocmVhZCwgd2UNCj4gPj4gYXJlIGFsc28gbm90IHN1cmUgaG93IHRpbWluZyBjb25zdHJh
aW50IHRvIGV2YWx1YXRlIGlmIHdlIGhhdmUgdG8gaW1wbGVtZW50DQo+ID4+IHRoZSBmZWF0dXJl
IGluIGZpcm13YXJlLg0KPiA+DQo+ID4gUGluZy1LZSAoYW5kIEpvaGFubmVzKSwNCj4gPiBIYXZl
IHlvdSBoYWQgYSBjaGFuY2UgdG8gcmV2aWV3IEFkaXR5YSdzIEF1Z3VzdCAyMSBmb2xsb3ctdXA/
DQo+ID4NCj4gPiBXZSdkIGxpa2UgdG8gbW92ZSBmb3J3YXJkIHdpdGggb3VyIGZpcm13YXJlLWJh
c2VkIGFwcHJvYWNoIChzaW5jZSB0aGF0IGxvZ2ljDQo+ID4gaXMgYWxyZWFkeSBzaGlwcGluZyBp
biBvdXIgT3BlbldydC1iYXNlZCBzeXN0ZW1zKS4gUGVyaGFwcyBSZWFsdGVrIGNhbiBwcm9wb3Nl
DQo+ID4gYWx0ZXJuYXRpdmUgaG9zdC1iYXNlZCBsb2dpYywgYW5kIHRoZXJlIGNhbiBiZSBhIGZs
YWcgdG8gc2VsZWN0IGVpdGhlcg0KPiA+IGhvc3QtYmFzZWQgb3IgZmlybXdhcmUtYmFzZWQgQ3Jp
dGljYWwgVXBkYXRlIGhhbmRsaW5nPw0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IC9qZWZmDQo+IA0K
PiBIZXkgZ3V5cywgYW55IG5ld3Mgb24gdGhpcyBvbmUgPyBTZWVpbmcgdGhlIGllZWU4MDIuMTEg
Ym4gcHJlbGltaW5hcnkgd29yayBkb25lDQo+IGJ5IEpvaGFubmVzLCByZW1pbmRlZCBtZSB0aGF0
IHRoZXJlIGFyZSBzdGlsbCBzb21lIHVzZWZ1bGwgcGFydHMgb2YgODAyLjExIGJlDQo+IHRoYXQg
YXJlIG5vdCBjb21wbGV0ZWx5IGZpbmlzaGVkIHlldCAuLi4NCj4gDQo+IFRoYW5rcywNCg0KU29y
cnkgZm9yIHRoZSBsYXRlLiBJIGNoZWNrZWQgd2l0aCBSZWFsdGVrIHZlbmRvciBkcml2ZXIsIGEg
Y2ZnODAyMTEtYmFzZWQNCmRyaXZlciwgd2hpY2ggcHJlcGFyZXMgQ1NBIElFIGFjcm9zcyBsaW5r
cyBieSBkcml2ZXIsIGFuZCBzZW5kIGZpcm13YXJlIA0KYmVhY29uIGNvbnRlbnQgd2l0aCBvZmZz
ZXQgb2YgY291bnRkb3duIG9mIENTQSBJRS4gVGhlbiBmaXJtd2FyZSB3aWxsIGNvdW50ZG93bg0K
YW5kIGluZm9ybSBkcml2ZXIgd2hlbiBjb3VudGRvd24gYmVjb21lcyB6ZXJvLiANCg0KVGhpcyBp
bmZvIGlzIHN0aWxsIG5vdCB2ZXJ5IHVzZWZ1bCB0byBkZWNpZGUgd2hlcmUgaXQgc2hvdWxkIGJl
IGltcGxlbWVudGVkIHRob3VnaC4NCg0KDQo=

