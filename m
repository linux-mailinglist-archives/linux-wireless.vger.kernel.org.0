Return-Path: <linux-wireless+bounces-27522-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC983B89647
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 14:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9D33AA07C
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 12:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6A22F291B;
	Fri, 19 Sep 2025 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Ixeu0gPU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23D41B3923
	for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 12:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284033; cv=none; b=TGTAlsrdh1BOKWfK8io93FgFLEoQ1P4mIF2lPam7t1QXcn4BfhjUOAawd7/CWf8If3n1/+iBElPmEMFOI8LQ8GFOndK89aB5v9QhicR4g/xQcaGiybim3IDHLcmZnXrGRoHubJ9Iitchmja15SOSwsX+/Mw1zFiXlg1c80Vf7u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284033; c=relaxed/simple;
	bh=L4PsgpDmXYcweh1CuaHd0MwFx+LU60le7sSs5tU5CyE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SYdfxWZIv18uyBLCdnrBDu4O3BIde7atQttcXRht3fAOdqcIToyZG+0diaIJoMjR5kbvHvDYKX7UtMOjh76/Ao0RpJ9uWNy22oiEiU/JKYYzlftODOXR6WP5Ga+fIvBr2cQ1olVvgSLi0sQ/pkG9L9+VKJOmOh0iEmEjP60J+Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ixeu0gPU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58JCD66t83674526, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758283986; bh=L4PsgpDmXYcweh1CuaHd0MwFx+LU60le7sSs5tU5CyE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Ixeu0gPUugT0FzWKiAOF4/dmZd+xoeSDvsbyRg8A9S5EffkKljIaD3+AqB5iuEVex
	 JgWl/DzQRhNtBzhWToGD4ECjBNgDruZIyA35VCZlLeu9/qHIhZzx5vXTkl2oPAUWPt
	 PLTvTo3ZdS00K3wEzRB73RDuGiZFMNXvT7GX8GYmJLvo9ue0XpfjrGqF60uc1DEdYf
	 gBA5vO8jmvbi4bDTbHpxKte3SzFROavkm7XJP1Qvbi4Y49pOnkksBvOFA26jVxO7Wq
	 tdMVaG10RMaesBJ9EonBOtPMUvmRY/tN0OuaZXjWuFmnXci9yFfY3PH0F+30hI0HTd
	 VPqskIpGmhyfQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58JCD66t83674526
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 20:13:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 19 Sep 2025 20:13:06 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Sep 2025 20:12:53 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::982b:42ba:82a4:f1d]) by
 RTEXMBS03.realtek.com.tw ([fe80::982b:42ba:82a4:f1d%2]) with mapi id
 15.01.2507.035; Fri, 19 Sep 2025 20:12:53 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "raja.mani@oss.qualcomm.com" <raja.mani@oss.qualcomm.com>
Subject: RE: [PATCH v2 3/6] iw: util: support parsing link id
Thread-Topic: [PATCH v2 3/6] iw: util: support parsing link id
Thread-Index: AQHcKVDl4WRNdjsD90SR0Zre371Yp7SaVM3A
Date: Fri, 19 Sep 2025 12:12:53 +0000
Message-ID: <7c988e7cbffc4edb8d8e863e2f1c82cc@realtek.com>
References: <20250917055543.27499-1-kevin_yang@realtek.com>
	 <20250917055543.27499-4-kevin_yang@realtek.com>
 <f4e33ca572e77755c6db82a37c5372a99a8b7485.camel@sipsolutions.net>
In-Reply-To: <f4e33ca572e77755c6db82a37c5372a99a8b7485.camel@sipsolutions.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Sm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4gd3JvdGU6DQo+IE9uIFdl
ZCwgMjAyNS0wOS0xNyBhdCAxMzo1NSArMDgwMCwgWm9uZy1aaGUgWWFuZyB3cm90ZToNCj4gPiBG
b3IgTkw4MDIxMV9GTEFHX01MT19WQUxJRF9MSU5LX0lEIGNhc2VzLCBNTEQgbmVlZHMgdG8gYXNz
aWduIGxpbmsgaWQsDQo+ID4gYnV0IG5vbi1NTEQgZG9lc24ndC4gQWRkIHN1cHBvcnQgb2YgcGFy
c2luZyBsaW5rIGlkIHdoZXJlIHRoZSBwYXR0ZXJuDQo+ID4gaXMgYXMgYmVsb3cuDQo+ID4NCj4g
PiAgICAgICBbbGluay1pZCA8TElOSyBJRD5dDQo+ID4NCj4gPiBJZiBmb3VuZCwgcHV0IE5MODAy
MTFfQVRUUl9NTE9fTElOS19JRCBhbmQgcmVtb3ZlIHRoZSBhc3NpZ25tZW50IGZyb20NCj4gPiB0
aGUgYXJndiByYW5nZS4NCj4gPg0KPiA+ICsgICAgIG1lbW1vdmUoYXJndiArIHBvcywgYXJndiAr
IHBvcyArIDIsDQo+ID4gKyAgICAgICAgICAgICBzaXplb2YoKmFyZ3YpICogKCphcmdjIC0gcG9z
IC0gMikpOw0KPiANCj4gSG9uZXN0bHksIEkgZG9uJ3QgcmVhbGx5IGxpa2UgdGhpcywgaXQncyBh
IGJpdCB0b28gbWFnaWM/IFdoYXQgaWYgeW91IGhhdmUgc29tZXRoaW5nIGluIHRoZXJlIHRoYXQN
Cj4gaXMgbGlrZQ0KPiANCj4gIC4uLiBzc2lkIGxpbmstaWQgZm9vIGJhcg0KPiANCj4gYW5kIHRo
ZW4gaXQgKm1lYW50KiB0aGUgU1NJRCB0byBiZSAibGluay1pZCIsIGJ1dCB3aXRoIHRoaXMgaXQg
bm93IGFjdHVhbGx5IGZhaWxzIG9yIHNvPyBJIGRvbid0DQo+IHRoaW5rIGl0J3MgYSBnb29kIGlk
ZWEuDQoNCkkgbWlzc2VkIHRvIGNvbnNpZGVyIHRoaXMga2luZCBvZiBjYXNlcywgc29ycnkuDQoN
Cj4gDQo+IFNvIEkgdGhpbmsgaXQgc2hvdWxkIGp1c3QgYmUgcGFyc2luZyBpdCB3aGVyZSBpdCBp
cyBhdCB0aGUgYmVnaW5uaW5nLCBhbmQgdGhlbiBmb3IgdGhlIGxhc3QgcGF0Y2gNCj4ganVzdCBw
dXQgaXQgYXQgdGhlIGJlZ2lubmluZyBpbiB0aGUgaGVscCwgY2FsbCBwYXJzZV9saW5rX2lkKCkg
Zmlyc3QgbGlrZSB5b3UgZGlkIGFscmVhZHksIGFuZCB3ZQ0KPiBkb24ndCBnZXQgYW55IHN1Y2gg
cG90ZW50aWFsIG1peHVwcz8NCj4gDQoNClRoYW5rcy4gSSB0aGluayBpdCB3b3Jrcy4NCkkgd2ls
bCBzZW5kIHYzLCB3aGljaCB0dXJucyB0byBwYXJzZSBsaW5rLWlkIGZpZWxkIGF0IHRoZSBiZWdp
bm5pbmcgb2YgYXJndi4NCg0K

