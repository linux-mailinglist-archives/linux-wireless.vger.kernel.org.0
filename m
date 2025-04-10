Return-Path: <linux-wireless+bounces-21371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76251A838C5
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 07:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191A117CD95
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 05:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA5F201278;
	Thu, 10 Apr 2025 05:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="kmwJe76v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903F220126A;
	Thu, 10 Apr 2025 05:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744264771; cv=none; b=oVomR4dcMJ0mi/4zPRDJwgYZqDg80QnIyL/j5Z3VBwI2DrDn+wx2Rz5PQPzAkletxDuFZ32jgEJVQummWe3PayuJvRRv9srunGYM4QRcmpK1Gw0gQNMvkPhIfqiO0Xg9maihyzCH1OyvOBbzrAggYseGt1jjyPeNFKJE7p9WAMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744264771; c=relaxed/simple;
	bh=fBAweAqVjz59iGfpmbWx6+zYHadAGxFNwXg3jgeoxGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AQWoE4IWAfXqF7fYfjJui6ArxeDqB3QxE9HgYdUPEbHrbuDwkQEKN+dpfEwebmE7nNnhp1ggpeWLTnfLwElSzgdxM0cM924lt3PioB1++fPrpnzZvEUQQTl0KJPqI4/HCRIYWtprMcxCxGHWljtfjibHcTP8GI6A4O2CB/KOaVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=kmwJe76v; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53A5xMRk92946392, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744264762; bh=fBAweAqVjz59iGfpmbWx6+zYHadAGxFNwXg3jgeoxGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=kmwJe76vP9gpXKIcAiFKqA0JSpY7i7zv+RUBkaUGA4BbRfHDl7OQfk4aJtfQA0JEU
	 BFjALVdZbFRhdIZbTTaDhg8wKKF4EumTZdHsBvOw/TRtv0l2be1boTjDfnyEWk+LBh
	 ZiwV5uLYqf/Yr2TR85MKEd+Idtz/2NzAe8an/ftrs8uJ/PViqR5PdYXLTaT5ZQsi9y
	 l8D6fjWs6DuK6aLUoZcnfDA6JoSMKJz2GlklHYgQnyVRUgCrm+/BwlbEupTUNkqkeG
	 SSGQer6RNyFxMMXa3T/qaeK3YC37mHYXO1CL4bGfH0txYpnOPjL7LxYd+8YRa58Pe2
	 uHhbb7BUq2Muw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53A5xMRk92946392
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 13:59:22 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Apr 2025 13:59:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 10 Apr 2025 13:59:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 10 Apr 2025 13:59:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC: Zhen XIN <zhen.xin@nokia-sbell.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC -v2] wifi: rtw88: sdio: Tx status for management frames
Thread-Topic: [RFC -v2] wifi: rtw88: sdio: Tx status for management frames
Thread-Index: AQHbqQKFFV8iNo+vskOiprOnyfj2d7OcT5Uw//+SRICAAIcU4A==
Date: Thu, 10 Apr 2025 05:59:21 +0000
Message-ID: <f790c63eb68d45478662934410c99bf6@realtek.com>
References: <20250409034910.1637422-1-zhen.xin@nokia-sbell.com>
 <7f96b6ee57b44626996b70da969219b5@realtek.com>
 <CAFBinCBHqwhtSAqE8xCoxsgRgHZ1n-zGC6wXo+emAaX6BBkR1A@mail.gmail.com>
In-Reply-To: <CAFBinCBHqwhtSAqE8xCoxsgRgHZ1n-zGC6wXo+emAaX6BBkR1A@mail.gmail.com>
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

TWFydGluIEJsdW1lbnN0aW5nbCA8bWFydGluLmJsdW1lbnN0aW5nbEBnb29nbGVtYWlsLmNvbT4g
d3JvdGU6DQo+IEhpIFBpbmctS2UsDQo+IA0KPiBPbiBUaHUsIEFwciAxMCwgMjAyNSBhdCA2OjMw
4oCvQU0gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiBbLi4uXQ0K
PiA+ID4gQEAgLTcxOCwxMCArNzE4LDcgQEAgc3RhdGljIHU4IHJ0d19zZGlvX2dldF90eF9xc2Vs
KHN0cnVjdCBydHdfZGV2ICpydHdkZXYsIHN0cnVjdCBza19idWZmICpza2IsDQo+ID4gPiAgICAg
ICAgIGNhc2UgUlRXX1RYX1FVRVVFX0gyQzoNCj4gPiA+ICAgICAgICAgICAgICAgICByZXR1cm4g
VFhfREVTQ19RU0VMX0gyQzsNCj4gPiA+ICAgICAgICAgY2FzZSBSVFdfVFhfUVVFVUVfTUdNVDoN
Cj4gPiA+IC0gICAgICAgICAgICAgICBpZiAocnR3X2NoaXBfd2NwdV8xMW4ocnR3ZGV2KSkNCj4g
PiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBUWF9ERVNDX1FTRUxfSElHSDsNCj4g
PiA+IC0gICAgICAgICAgICAgICBlbHNlDQo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICBy
ZXR1cm4gVFhfREVTQ19RU0VMX01HTVQ7DQo+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIFRY
X0RFU0NfUVNFTF9NR01UOw0KPiA+DQo+ID4gRG8geW91IHJlbWVtYmVyIHdoeSB5b3UgZGlkIHRo
ZSBzcGVjaWFsIGRlYWwgd2l0aCAxMW4gY2hpcHM/DQo+ID4gQW5kIHRoaXMgUkZDIGxvb2tzIGdv
b2QgdG8gbWUuIChleGNlcHQgdG8gY29tbWl0IG1lc3NhZ2UsIGJ1dCB0aGlzIGlzIFJGQykNCj4g
SSBkb24ndCByZW1lbWJlciAtIGFuZCBKZXJuZWogc2FpZCB0aGUgc2FtZSB0aGluZy4NCj4gSG93
ZXZlciwgc2luY2Ugd2UgZ290IHRoZSBmaXJzdCA4MDIuMTFuIGhhcmR3YXJlIGZvciB0ZXN0aW5n
IGxvbmcNCj4gYWZ0ZXIgdGhpcyBwYXJ0IHdhcyB3cml0dGVuIG15IHN1Z2dlc3Rpb24gaXM6IGxl
dCdzIHJvbGwgdGhpcyBpbnRvIGENCj4gcHJvcGVyIHBhdGNoLCBDYyBGaW9uYSBLbHV0ZSA8Zmlv
bmEua2x1dGVAZ214LmRlPiAoYXV0aG9yIG9mIFJUTDg3MjNDUw0KPiBzdXBwb3J0KSBvbiB0aGUg
cmVzdWx0aW5nIHBhdGNoKGVzKSBhbmQgdGhlbiBhcHBseSB0aGUgcGF0Y2hlcw0KPiAoYXNzdW1p
bmcgbm9ib2R5IG9ic2VydmVzIGFueSBwcm9ibGVtcykuDQo+IA0KPiBUbyBtYWtlIHRoaXMgYSBu
b24tUkZDIHBhdGNoIHRoZSBmb2xsb3dpbmcgc3RlcHMgYXJlIG5lZWRlZCAoaW4gbXkgb3Bpbmlv
bik6DQo+IC0gc3BsaXQgdGhlIGNoYW5nZSBpbnRvIHR3byBwYXRjaGVzIChvbmUgd2hpY2ggdW5j
b25kaXRpb25hbGx5IGNhbGxzDQo+IHJ0d19zZGlvX2luZGljYXRlX3R4X3N0YXR1cygpKQ0KPiAt
IGFub3RoZXIgb25lIGZvciB0aGUgVFhfREVTQ19RU0VMX01HTVQgbWFwcGluZw0KPiAtIGVhY2gg
b2YgdGhlIHBhdGNoZXMgc2hvdWxkIGluY2x1ZGUgdGhlaXIgb3duIGRlc2NyaXB0aW9uDQo+IC0g
SSBjaGVja2VkIHRoZSBoaXN0b3J5IGFuZCBpdCBzZWVtcyB0aGF0IGJvdGggcHJvYmxlbXMgd2Vy
ZQ0KPiBpbnRyb2R1Y2VkIHdpdGggdGhlIG9yaWdpbmFsIGNvbW1pdCwgbWVhbmluZyBib3RoIHBh
dGNoZXMgc2hvdWxkIGdldA0KPiB0aGUgZm9sbG93aW5nIGxpbmUgKGFib3ZlIHRoZSBTaWduZWQt
b2ZmLWJ5KTogRml4ZXM6IDY1MzcxYTNmMTRlNw0KPiAoIndpZmk6IHJ0dzg4OiBzZGlvOiBBZGQg
SENJIGltcGxlbWVudGF0aW9uIGZvciBTRElPIGJhc2VkIGNoaXBzZXRzIikNCj4gLSAocGx1cyBh
bnl0aGluZyBQaW5nLUtlIGhhcyB0byBhZGQgOi0pICkNCg0KVGhhdCdzIHN1cGVyIGNsZWFyLiBO
byBvdGhlciBvcGluaW9uIGZyb20gbWUuICA6LSkNCg0K

