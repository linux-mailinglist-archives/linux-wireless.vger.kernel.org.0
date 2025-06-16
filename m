Return-Path: <linux-wireless+bounces-24114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B705ADA618
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 03:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76AAF1890480
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 01:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A586288500;
	Mon, 16 Jun 2025 01:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Fdjo1VOh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FBC2882D1
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 01:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750038182; cv=none; b=uJ6Bw+9pXc5mXpDhy/fDivS6+Dx1vIm3C7d0SAHPr/c/BOIX2bvHcKSVqOBlIIiojclt3FKuefCF+AwV6j7GgmuFAwE4EYUoy/CrlCD9yWE8Z3v6r9XihbIB5xZ+mFw1dJN+etYZLK86LXo+odTR7o80F8Zc4x+n7WLLVKRSgx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750038182; c=relaxed/simple;
	bh=LE3ZEvFM9Ek79anfQFWMYoRvsNelkUbb18uveYpkH3I=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aU5j+vkezvMX6sOFFdKnieNv0u+w+U6JfgN55Phc/C9nxbHLlJh/+RPBPc5bHN67UoV6PFTzLSLzzxXMZ/PAUf3u+TkuErilwhfredIiADWbeLt4ugXhHK7jAl0FSN6FGZU280A1dOxBUzWR5Hx2V0Xx5KtKkK8tXGTaCR+eLnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Fdjo1VOh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G1guNW33836405, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750038176; bh=LE3ZEvFM9Ek79anfQFWMYoRvsNelkUbb18uveYpkH3I=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Fdjo1VOhPSGVq9htvy+WR6+ou5aAY7S2sOywqgP1DB/RBjw5xJmUICMb70ZVuldZz
	 ep3my2DFp6wiMR3TtDJCwG2hsag7GCXuGEehhYqSXqMXg5Ck8wYmCnJ6VRcUGHxvn5
	 jHk/LgPijHcUQY7ZmuZfwNa06WO3eGGe+rlN5UIQnIMImYXwPzzyNUPGjGxmjtgy3a
	 LobHCwOywlhQb7YC5W0JenJ4R71pkPElDq/+RQaZDQR0QTpKywpSireyxgHphSsFdb
	 UVDyIO1cUZttNKlBKCKTxDvDTzRWGK+5HBiywDqtUEfq35wFOUJg03twsM8aAe5FGT
	 pQyVvF2Dn4iTg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G1guNW33836405
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 09:42:56 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 09:42:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 16 Jun 2025 09:42:38 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 16 Jun 2025 09:42:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 06/14] wifi: rtw89: Disable deep power saving for USB/SDIO
Thread-Topic: [PATCH rtw-next v2 06/14] wifi: rtw89: Disable deep power saving
 for USB/SDIO
Thread-Index: AQHb2XSmCYCPd4qIlUOQewYxXHn4+bQFCnog
Date: Mon, 16 Jun 2025 01:42:37 +0000
Message-ID: <f098d82e620849f791fba9bc56198f5f@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
 <1e25d8b6-fb5c-4733-81ec-b9ae9bbd8f92@gmail.com>
In-Reply-To: <1e25d8b6-fb5c-4733-81ec-b9ae9bbd8f92@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBEaXNh
YmxlIHJ0dzg5X21hY19zZW5kX3Jwd20oKSBmb3IgVVNCIGFuZCBTRElPIGJlY2F1c2UgaXQgaXMg
Y2FsbGVkIGluDQo+IGF0b21pYyBjb250ZXh0IGFuZCBhY2Nlc3NpbmcgaGFyZHdhcmUgcmVnaXN0
ZXJzIHJlc3VsdHMgaW4gInNjaGVkdWxpbmcNCj4gd2hpbGUgYXRvbWljIiBlcnJvcnMuDQo+IA0K
PiBEaXNhYmxlIHJ0dzg5X21hY19wb3dlcl9tb2RlX2NoYW5nZSgpIGJlY2F1c2UgaXQgcHJpbnRz
IGFuIGVycm9yIG1lc3NhZ2UNCj4gd2hlbiBydHc4OV9tYWNfc2VuZF9ycHdtKCkgaXMgZGlzYWJs
ZWQuDQo+IA0KPiBNb2RpZnkgcnR3ODlfcHNfcG93ZXJfbW9kZV9jaGFuZ2UoKSB0byBjYWxsDQo+
IHJ0dzg5X3BzX3Bvd2VyX21vZGVfY2hhbmdlX3dpdGhfaGNpKCkgb25seSBmb3IgUENJIGJlY2F1
c2UgdGhlIGxhdHRlcg0KPiBpcyBwcm9iYWJseSByZWxldmFudCBvbmx5IGZvciBQQ0kgYW5kIGFs
c28gYmVjYXVzZSBpdCBjYWxscw0KPiBuYXBpX3NjaGVkdWxlKCksIHdoaWNoIHJlc3VsdHMgaW4g
ZGVyZWZlcmVuY2luZyBhIG51bGwgcG9pbnRlciB3aXRoIFVTQi4NCj4gDQo+IEZvciBVU0IgYW5k
IFNESU8gcnR3ODlfcHNfcG93ZXJfbW9kZV9jaGFuZ2UoKSBwcm9iYWJseSBuZWVkcyB0byBjYWxs
DQo+IHJ0dzg5X21hY19wb3dlcl9tb2RlX2NoYW5nZSgpIGluc3RlYWQsIGluIGNhc2UgZGVlcCBw
b3dlciBzYXZpbmcgaXMgZXZlcg0KPiBlbmFibGVkIGZvciBVU0Igb3IgU0RJTy4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0K
PiAtLS0NCj4gdjI6DQo+ICAtIERpc2FibGUgZGVlcCBwb3dlciBzYXZpbmcgZm9yIFNESU8gYWxz
by4NCj4gIC0gRG9uJ3QgZGlzYWJsZSBydHc4OV9wc19wb3dlcl9tb2RlX2NoYW5nZSgpIGZvciBV
U0IvU0RJTy4NCj4gIC0gRGlzYWJsZSBydHc4OV9tYWNfcG93ZXJfbW9kZV9jaGFuZ2UoKSBmb3Ig
VVNCL1NESU8uDQo+ICAtIENhbGwgcnR3ODlfcHNfcG93ZXJfbW9kZV9jaGFuZ2Vfd2l0aF9oY2ko
KSBvbmx5IGZvciBQQ0kgYW5kIGNhbGwNCj4gICAgcnR3ODlfbWFjX3Bvd2VyX21vZGVfY2hhbmdl
KCkgZm9yIFVTQi9TRElPLg0KPiAgLSBVcGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdlLg0KPiAtLS0N
Cj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMgfCA2ICsrKysrKw0K
PiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9wcy5jICB8IDMgKystDQo+ICAy
IGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L21hYy5jDQo+IGluZGV4IDdmM2M4MTZkNDcw
NC4uMmNlYmRlOWU5MjI5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0dzg5L21hYy5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODkvbWFjLmMNCj4gQEAgLTEzMzYsNiArMTMzNiw5IEBAIHN0YXRpYyB2b2lkIHJ0dzg5X21hY19z
ZW5kX3Jwd20oc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LA0KPiAgew0KPiAgICAgICAgIHUxNiBy
ZXF1ZXN0Ow0KPiANCj4gKyAgICAgICBpZiAocnR3ZGV2LT5oY2kudHlwZSAhPSBSVFc4OV9IQ0lf
VFlQRV9QQ0lFKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPiArDQoNCkkgdGhpbmsgd2Ug
Y2FuIGp1c3QgcmV0dXJuIFJUVzg5X1BTX01PREVfTk9ORSBpbiBydHc4OV91cGRhdGVfcHNfbW9k
ZSgpDQpmb3IgaGNpLnR5cGUgIT0gUlRXODlfSENJX1RZUEVfUENJRS4NCg0KSWYgbm90LCBJIHdv
dWxkIGxpa2UgdG8gZGVmaW5lIGEgJ3J0d2Rldi0+aGNpLmNhbl9kZWVwX3BzJyBmb3IgdGhlIHB1
cnBvc2UNCnRvIGRpc2FibGUgZGVlcCBQUyB0ZW1wb3JhcmlseS4gU29tZXRpbWUgd2UgY2FuIHN1
cHBvcnQgaXQgYnkganVzdCByZW1vdmluZw0KdGhpcyBmbGFnIHNpbXBseS4gQnV0IG5vdCB2ZXJ5
IHByZWZlciB0aGlzIHdheSB0aG91Z2guIA0KDQo=

