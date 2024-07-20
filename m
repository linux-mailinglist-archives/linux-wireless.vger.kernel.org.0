Return-Path: <linux-wireless+bounces-10405-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23387937EB0
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2024 04:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841352823D1
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2024 02:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9218E63A5;
	Sat, 20 Jul 2024 02:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Vv69bb8o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972643D6D;
	Sat, 20 Jul 2024 02:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721441154; cv=none; b=GhCX9uisec8Ei3EbvgolAzNwE9GS4sNec6cgaujSng8ieOVQ1fE/+BJA8xtXJoC/sHmaCM3X/psLLrhzXGir2b9YbVrdXbnrtfrUGp7anoTF3JX3c7l2vG28voXN0UIkDagalrm7voZKkpCOBQnfkVEvToI0fLFS6U5xX8ad1b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721441154; c=relaxed/simple;
	bh=U8p5GAQpFGpq70MtuAxhIlGIzD8sr9DTdQhN4ZGSKc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HvjOIS0jPy77T+3c1Zcf6+WZOvfi0qwhOLk9WUNam2/I8lP1rUFCXHgG39lFemC71cRGX01RinOr/l3qdNRIteBSzbFfRW+vyXS4VKaUMfsZ3vKqiSwEnZsGZMdWSJ1ak5wtxoYVtnjdO7gZqxdjuDVms+rBc6fAq2NubWThi6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Vv69bb8o; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46K25cSR21142998, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721441138; bh=U8p5GAQpFGpq70MtuAxhIlGIzD8sr9DTdQhN4ZGSKc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-ID:Content-Transfer-Encoding:MIME-Version;
	b=Vv69bb8oXiwONG904r1/1x6jOzoxO1LOhr+9g3DxUeyn7MH2Ctk8ANmVPqUz0b0qQ
	 G8wi2z7vMV9ElptexiL+f50gpGVQ9vZj6vZBCFZMdaxwg4/hQ4uWbJMvxWkuPfFOng
	 OWqY0HQR9sYKpPwIgm58ezSzU9Xknl+wAnKKbk2gicOXlB8PzXT8pWXqkpNUFgV04E
	 6LrdSJKtJ7iqYD4/iamE/SzkrksRa6w5BAKR/w5cvK/Dv+wfDZ04kWq//pWLguWPLx
	 wY0qKgfnHZzdWfiGkzAJGoO+R74dYxLdJI622L/SM9PN++YJvoXnp85036YzQ8/9ZF
	 lyaqu3+39pUrw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46K25cSR21142998
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 10:05:38 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 20 Jul 2024 10:05:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 20 Jul 2024 10:05:37 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Sat, 20 Jul 2024 10:05:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>
CC: "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH v2 6/6] wifi: rtw89: 8852bt: add 8852BE-VT to Makefile and Kconfig
Thread-Topic: [PATCH v2 6/6] wifi: rtw89: 8852bt: add 8852BE-VT to Makefile
 and Kconfig
Thread-Index: AQHa2aRz+5UDUgym/kyl6kQSq1NO57H+OL6AgAAgWgA=
Date: Sat, 20 Jul 2024 02:05:37 +0000
Message-ID: <e53f0d0a67442642be823081ca6cab49ff122cc4.camel@realtek.com>
References: <20240719062414.21953-7-pkshih@realtek.com>
	 <202407200741.dMG9uvHU-lkp@intel.com>
In-Reply-To: <202407200741.dMG9uvHU-lkp@intel.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <6218ED1609605C4DB87E4A09F7E9D699@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gU2F0LCAyMDI0LTA3LTIwIGF0IDA4OjA5ICswODAwLCBrZXJuZWwgdGVzdCByb2JvdCB3cm90
ZToNCj4gDQo+ID4gPiBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3J0dzg4NTJi
dF9yZmsuYzoxODI3OjQ2OiB3YXJuaW5nOiBvcGVyYXRvciAnPzonIGhhcyBsb3dlcg0KPiA+ID4g
cHJlY2VkZW5jZSB0aGFuICcmJzsgJyYnIHdpbGwgYmUgZXZhbHVhdGVkIGZpcnN0IFstV2JpdHdp
c2UtY29uZGl0aW9uYWwtcGFyZW50aGVzZXNdDQo+ICAgICAxODI3IHwgICAgICAgICAgICAgICAg
ICAgICBraWR4LCBkcGstPmlzX2Rwa19lbmFibGUgJiBvZmZfcmV2ZXJzZSA/ICJlbmFibGUiIDog
ImRpc2FibGUiKTsNCj4gICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIH5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+IF4NCj4gICAgZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OS9ydHc4ODUyYnRfcmZrLmM6MTgyNzo0Njogbm90ZTogcGxhY2UgcGFyZW50
aGVzZXMgYXJvdW5kIHRoZQ0KPiAnJicgZXhwcmVzc2lvbiB0byBzaWxlbmNlIHRoaXMgd2Fybmlu
Zw0KPiAgICAgMTgyNyB8ICAgICAgICAgICAgICAgICAgICAga2lkeCwgZHBrLT5pc19kcGtfZW5h
YmxlICYgb2ZmX3JldmVyc2UgPyAiZW5hYmxlIiA6ICJkaXNhYmxlIik7DQo+ICAgICAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBeDQo+ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAoICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICkNCj4gICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OS9ydHc4ODUyYnRfcmZrLmM6MTgyNzo0Njogbm90ZTogcGxhY2UgcGFyZW50aGVzZXMgYXJv
dW5kIHRoZQ0KPiAnPzonIGV4cHJlc3Npb24gdG8gZXZhbHVhdGUgaXQgZmlyc3QNCj4gICAgIDE4
MjcgfCAgICAgICAgICAgICAgICAgICAgIGtpZHgsIGRway0+aXNfZHBrX2VuYWJsZSAmIG9mZl9y
ZXZlcnNlID8gImVuYWJsZSIgOiAiZGlzYWJsZSIpOw0KPiAgICAgICAgICB8ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiAgICAg
ICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICkNCj4gICAgMSB3YXJuaW5nIGdlbmVyYXRl
ZC4NCg0KSW4gdjMsIEkgd2lsbCBjb3JyZWN0IHRoaXMgYnkgJ3N0cl9lbmFibGVfZGlzYWJsZShk
cGstPmlzX2Rwa19lbmFibGUgJiBvZmZfcmV2ZXJzZSknDQp3aXRoIGEgbmV3IHBhdGNoLg0KDQoN
Cg==

