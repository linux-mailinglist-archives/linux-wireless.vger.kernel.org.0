Return-Path: <linux-wireless+bounces-26051-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD12B156B5
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jul 2025 02:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3EB547188
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jul 2025 00:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF81D170A2B;
	Wed, 30 Jul 2025 00:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="OUlgE3IZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B1114D70E;
	Wed, 30 Jul 2025 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753836306; cv=none; b=jU2J7D31ElYEYpfLlb4xxBk6CWqI05Xn/pCbcuuP3Ytfex5Aw2ZcRpf7eNSKEmJFZS2ALtuqzuE8URn6T/lIz1f7Vmh3KVVOSGBCAB8WsHbxijfx0r/VEN3ArYrAKUxV/k6I/QwD33wKiTgw96J7K6V+WX901PhjRGzlGZF1C9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753836306; c=relaxed/simple;
	bh=0XfiLjiIhL6BI+4MuznCe+eUwqiJarGpY/RGX10q77E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SMl4Ss0BI/1aKS+AKuAh6SerkxH+t3bytuAmEEqzq42WQt4bmLwZLBXq2jeClGp+n5bLpDwYboxte0Wikv8ekFdm/zJCszyvkIJ6+hOIwwHSy1z1EsUKLkflqqGs84RuadPBW/0IYKfxKtqANO3Wl+doyNV6SiwUcShTf6MdLS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=OUlgE3IZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56U0ilSlB2734924, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1753836287; bh=0XfiLjiIhL6BI+4MuznCe+eUwqiJarGpY/RGX10q77E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=OUlgE3IZVuCMu/8XB727y/yHtC+RG1H02Gdw2ZsOh3VXq2ATcKrMNIe0yCvC61bC1
	 8xzJc0OfXAw/Qd6aJKINVXAjyEkf2tnKR/ZxsrtiQS5jazqUJQwSrdC9Rib/+YUhKy
	 9XUImbmBItnC6qde7Fa4ZRBdY/GuyIjr/VJPLQwiWtjncgw2+rR3bOE8x3eLlaTTCA
	 DeqC8oXlERJHsSvhCvhw4CywZMkNcxLhWtYFZ3dgZyuuwQa6YjXKTAKuvgkLKxwXsE
	 SPauDtw9Fi7tzCtU44c6G3VTtQWCDL6SLaUGw3cl2TpTa0hRvu5/GIDCTeuqYEZRU1
	 lRclM6j67bvdw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56U0ilSlB2734924
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 08:44:47 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Jul 2025 08:44:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 30 Jul 2025 08:44:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Wed, 30 Jul 2025 08:44:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sean Anderson
	<sean.anderson@linux.dev>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: Print only once for unsupported c2h classes
Thread-Topic: [PATCH] wifi: rtw89: Print only once for unsupported c2h classes
Thread-Index: AQHcALaJzXGJOyfKPkG20PFKd07euLRI+tuAgADXwyA=
Date: Wed, 30 Jul 2025 00:44:46 +0000
Message-ID: <36a81df65326472b93c6524b7badb434@realtek.com>
References: <20250729182743.114733-1-sean.anderson@linux.dev>
 <d2d62793-046c-4b55-93ed-1d1f43cff7f2@gmail.com>
In-Reply-To: <d2d62793-046c-4b55-93ed-1d1f43cff7f2@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAy
OS8wNy8yMDI1IDIxOjI3LCBTZWFuIEFuZGVyc29uIHdyb3RlOg0KPiA+IFRoZXJlIGFyZSBtb3Jl
IHVuc3VwcG9ydGVkIGZ1bmN0aW9ucyB0aGFuIGp1c3QgTE9XUlRfUlRZLiBJbXByb3ZlIG9uDQo+
ID4gY29tbWl0IDNiNjY1MTliMDIzYiAoIndpZmk6IHJ0dzg5OiBwaHk6IGFkZCBkdW1teSBjMmgg
aGFuZGxlciB0byBhdm9pZA0KPiA+IHdhcm5pbmcgbWVzc2FnZSIpIGJ5IHByaW50aW5nIGEgbWVz
c2FnZSBqdXN0IG9uY2Ugd2hlbiB3ZSBmaXJzdA0KPiA+IGVuY291bnRlciBhbiB1bnN1cHBvcnRl
ZCBjbGFzcy4gVGhpcyBwcmV2ZW50cyBtZXNzYWdlcyBsaWtlDQo+ID4NCj4gPiBydHc4OV84OTIy
YWUgMDAwMDo4MTowMC4wOiBQSFkgYzJoIGNsYXNzIDIgbm90IHN1cHBvcnQNCj4gPg0KPiA+IGZy
b20gZmlsbGluZyB1cCBkbWVzZy4NCj4gPg0KPiANCj4gSSBhbHNvIGdldCAiTUFDIGMyaCBjbGFz
cyAxIGZ1bmMgMyBub3Qgc3VwcG9ydCIgYW5kICJNQUMgYzJoIGNsYXNzDQo+IDAgZnVuYyA2IG5v
dCBzdXBwb3J0IiB3aXRoIFJUTDg4MzJDVS4NCg0KVGhlc2UgdHdvIEMySCBldmVudHMgd2VyZSBk
ZWZpbmVkIGFzOiANCg0KLy8gQ0xBU1MgMSAtIEZXX09GTEQNCiNkZWZpbmUgRldDTURfQzJIX0ZV
TkNfQkVBQ09OX1JFU0VORCAweDMNCg0KLy8gQ0xBU1MgMCAtIEZXX0lORk8NCiNkZWZpbmUgRldD
TURfQzJIX0ZVTkNfQkNOX1VQRF9ET05FIDB4MDYNCg0KVGhlIGltcGxlbWVudGF0aW9uIG9mIGhh
bmRsZXJzIGluIHZlbmRvciBkcml2ZXIgbG9va3MgbGlrZSBkb2VzIG5vdGhpbmcNCm5lZWRlZCB0
byBiZSByZXdyaXR0ZW4uIEp1c3QgYWRkIGEgZHVtbXkgdG8gcmVwcmVzZW50IHRoYXQgd2UgaGF2
ZSByZXZpZXdlZA0KdGhlIEMySCBldmVudHMuDQoNCg0K

