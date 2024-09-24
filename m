Return-Path: <linux-wireless+bounces-13096-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D614983B37
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 04:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36881F2226A
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 02:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E11D3D68;
	Tue, 24 Sep 2024 02:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="dWELgFwA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D1D18D;
	Tue, 24 Sep 2024 02:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727144998; cv=none; b=mP4TylSKCfBUShylePI5gydqiTjLgA5YjnsO0zbrhJGmYVx1x29iNgDxSufXPguOMt7EPgdtQAy38Vjom/zJklz4tvmMac82Oh7jmcFFjPu+6t1O1VhVKftyapyMTaDhz0rhyn9ya2fUDvWfxg/mmvQgDl4M9/KugPyIvCsTnD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727144998; c=relaxed/simple;
	bh=QRXBIaQoBdvKIIgUBGyLszNnmweWx2ShJLcMibTbGP4=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=F72DR3msB94Cs1+nmzEW3mj6IZNapnGpriyQZbt9IPlxfdgqtnOgP98TEDRwz8SLEHxx4p+gFU5RsNNj1FJITHj486y9NMyh3UIc4w2IWUhif4k/8qyVPsDl1Y5sdWezpGhbf4lJZjItepz/iV+c/yWERuXz0zQawKx5Gi/oJkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=dWELgFwA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48O2TnD522250472, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727144990; bh=QRXBIaQoBdvKIIgUBGyLszNnmweWx2ShJLcMibTbGP4=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=dWELgFwA0+/KjuGY98SvtYW932pon9hInHvN0TkxWNzf55jMVkRGo9Y3PIquq8t3G
	 wx4CnBQuq84fMK+/HK7fQhrdmLhUbLy6Iwa4ltkmLOwrT1L6FkQ4TRAkJYSloBk+4k
	 arGZFX5l+myrTLqyUAWZfI+5/u5Zq5jeOaY2PQvUcNP36pU8J5i/KZ979Uc/JnUW1A
	 9bASydGWT+NCCzFc4luSt+NeWWX7N+BDNDCTuzMunFu/4RKF9ZVQQajnfBLE1K5fnQ
	 6PKFul2SjkMIHi4LbTbQrXis0Ln2PcKOhPSxb1RSVkW+d0HJgGZ+5MLOM1qF3R9t1e
	 kKHQYAyJenkEA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48O2TnD522250472
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 10:29:49 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 10:29:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 24 Sep 2024 10:29:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Tue, 24 Sep 2024 10:29:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?TWFyY2VsIFdlacOfZW5iYWNo?= <mweissenbach@ignaz.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: RTL8852BE wifi no longer working after 6.11 upgrade
Thread-Topic: RTL8852BE wifi no longer working after 6.11 upgrade
Thread-Index: AQHbCMemb6H6HxFviUGmiPt2/8qxPLJdDI+A//+Vo4CAAJ3wIP//qTkAgAFYScCAB/0z0A==
Date: Tue, 24 Sep 2024 02:29:49 +0000
Message-ID: <3784ba9d7af34d41b439b7ee0d9e9f8f@realtek.com>
References: <63a3ef5acd70454e9f8db114204e2e2d@realtek.com>
 <20240918114718.Horde.TpiB1MVH0uadLCQXUbR5WtB@ignaz.org> 
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

UGluZy1LZSBTaGloIHdyb3RlOg0KPiBNYXJjZWwgV2Vpw59lbmJhY2ggPG13ZWlzc2VuYmFjaEBp
Z25hei5vcmc+IHdyb3RlOg0KPiA+IEZpcnN0IG9mIGFsbCwgdGhhbmsgeW91IHNvIG11Y2ggZm9y
IHlvdXIgdGltZSBhbmQgd29yayENCj4gPg0KPiA+IEkgaG9wZSBpIGRvbid0IGNhdXNlIGFueSBj
b25mdXNpb24gYW5kIHRoaXMgcXVlc3Rpb24gbWF5IGJlIGJhc2VkIG9uIG15IGxhY2sgb2YgIHVu
ZGVyc3RhbmRpbmcgdGhlIHBhdGNoLA0KPiA+IGkgYWxtb3N0IGRvbid0IGRhcmUgdG8gYXNrLCBi
dXQgZG9lcyB0aGlzIHF1aXJrIG9ubHkgZ2V0cyBpbnRvIGFmZmVjdCwgd2hlbiBzb21lb25lIHVz
ZXMgdGhlIHNhbWUgbWFpbmJvYXJkDQo+ID4gaSB1c2U/IElzIHRoaXMgYW4gcmF0aGVyIHJhcmUg
Y2FzZSB0aGF0IHByb2JhYmx5IHdvbid0IGVmZmVjdCBvdGhlciBwZW9wbGU/DQo+ID4NCj4gPiBJ
IGNhbid0IGp1ZGdlIHRoYXQgc28gcGxlYXNlIGRvbid0IGdldCBtZSB3cm9uZywgYnV0IGkgZmVl
bCBhIGJpdCB1bmVhc3kgYWJvdXQgdGhpcy4gSSBhc3N1bWUgdGhhdCBtb3N0DQo+ID4gZmlzdCB0
aW1lIExpbnV4IHVzZXJzIHRoYXQgaGF2ZSBzaW1pbGFyIChidXQgbm90IHRoZSBzYW1lKSBwbGF0
Zm9ybSwgd2hlcmUgdGhpcyBxdWlyayB3aWxsIG5vdCBnZXQgYXBwbGllZA0KPiA+IGFuZCB0aGV5
IGVuZCB1cCB3aXRoIG5vbi13b3JraW5nIHdpZmksIGp1c3Qgbm90aWNlIHRoYXQgd2lmaSBkb2Vz
bid0IHdvcmsgYW5kIGdpdmUgdXAgb24gTGludXggYW5kIHJlbWVtYmVyDQo+ID4gaXQgYXMgIk15
IFdpZmkgZXZlbiBkaWRuJ3Qgd29yayB0aGVyZSIuDQo+ID4NCj4gPiBBcyBhIGxvbmcgdGltZSBH
ZW50b28gdXNlciwgaSBoYXZlIHRoZSBjYXBhYmlsaXR5IHRvIGJ1aWxkIG15IG93biBrZXJuZWwg
YW5kIHByb3ZpZGUgZmVlZGJhY2sgdGhhdCBjYW4NCj4gaGVscA0KPiA+IGZpeCB0aGlzIGlzc3Vl
LCBidXQgaSBhc3N1bWUgbW9zdCB1c2VycyBkb24ndC4gSSB3b3VsZCBhc3N1bWUgYW4gVWJ1bnR1
IHVzZXJzIHdpbGwganVzdCByZW1vdmUgdGhlIFVidW50dQ0KPiA+IHBhcnRpdGlvbiBhbmQgY2Fs
bHMgaXQgYSBkYXkgY29udGludWluZyB1c2luZyBXaW5kb3dzLiBJIGFtIGEgYml0IHdvcnJpZWQg
YW5kIHdvbmRlciwgaWYgdGhlcmUgbWF5YmUgYQ0KPiB3YXkNCj4gPiB0byBmaXggdGhhdCwgdGhh
dCBpcyBpbmRlcGVuZGVudCBvbiBteSBzcGVjaWZpYyBoYXJkd2FyZS9tYWluYm9hcmQuDQo+ID4N
Cj4gPiBPZiBjb3Vyc2UsIGZlZWwgZnJlZSB0byBjb3JyZWN0IG1lIGlmIGkgYW0gZ2V0dGluZyBz
b21ldGhpbmcgd3JvbmcgaGVyZSwgaW0gbmVpdGhlciBhbiBLZXJuZWwgbm9yIEMgZXhwZXJ0DQo+
ID4gYW5kIHRoYW5rIHlvdSBmb3IgeW91ciB0aW1lIGFnYWluLg0KPiA+DQo+IA0KPiBZb3UgYXJl
IHJpZ2h0LiBJIHdhcyBub3QgYXdhcmUgb2YgdGhhdC4gSSB3aWxsIGRpc2N1c3MgcGVvcGxlIGlu
dGVybmFsbHkgYW5kIHJlY29uc2lkZXIgdGhlIHNvbHV0aW9uLg0KDQpXaXRoIGludGVybmFsIGRp
c2N1c3Npb24sIHRoZSBlYXJseSBjaGlwcyBpbmNsdWRpbmcgUlRMODg1MkJFIGhhdmUgaW50ZXJv
cGVyYWJpbGl0eQ0KcHJvYmxlbSB3aXRoIHNvbWUgcGxhdGZvcm1zLCBzbyB3ZSBkZWNpZGUgdG8g
cm9sbGJhY2sgdG8gMzItYml0IERNQSBmb3IgdGhlc2UgY2hpcHMsDQphbmQgb25seSBlbmFibGUg
MzYtYml0IERNQSBmb3IgdGVzdGVkIHBsYXRmb3Jtcy4gDQoNClBsZWFzZSBoZWxwIHRvIHRlc3Qg
aWYgWzFdIHdvcmtzIHRvIHlvdS4gDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC13aXJlbGVzcy8yMDI0MDkyNDAyMTYzMy4xOTg2MS0xLXBrc2hpaEByZWFsdGVrLmNvbS9ULyN1
DQoNCg==

