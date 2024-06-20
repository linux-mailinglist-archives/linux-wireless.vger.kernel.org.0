Return-Path: <linux-wireless+bounces-9283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE21910071
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 11:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08422284941
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 09:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC68217109F;
	Thu, 20 Jun 2024 09:33:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF481802E;
	Thu, 20 Jun 2024 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718876033; cv=none; b=H9jFtCUm+dOu4naMozxajyTRrCsfWUTDQ7Okom9tqeRma9CoKm3Rb4y3myboE0U7n8jKGmOlE2TcoKJp96b81LBSsl7P8wXrobzC/wz1uHYNbtBJbw7nxWNoS7vC02GcLv8ebFcGTHMdXYehGp+vUcfhSCGc9aKQq601kNgdcpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718876033; c=relaxed/simple;
	bh=sxoBp8344+h3toLqhD2tkt93nxAaMGVqGLXZJlV88us=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FGPBQl+fAj1CBaXnDOcu5AEahBwOQcIRJoDyGLHeZ3BQ3RzM4mg9UIN/YPQNeG6vyKSjd6rL2EfOinMzNTGxk419F297WhOIuY64y3LGdEuWrC838LGzgnxKVIK0EXI+thfzaiAB0/4nxliM91m8+6vH95diwrYvYVxCc9zvIOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45K9Xf6W22754179, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45K9Xf6W22754179
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 17:33:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 17:33:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 20 Jun 2024 17:33:41 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 20 Jun 2024 17:33:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Mathew George <mathewegeorge@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Bernie Huang
	<phhuang@realtek.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: RE: [REGRESSION] Freeze on resume from S3 (bisected)
Thread-Topic: [REGRESSION] Freeze on resume from S3 (bisected)
Thread-Index: AQHawgusbA+C/SyMRES67Y/3y6K7kbHOmQDAgAALtgCAAakyAP//jZeAgACItrA=
Date: Thu, 20 Jun 2024 09:33:41 +0000
Message-ID: <342b6b95d97a4bf09afee15c09481efc@realtek.com>
References: <87tthpwkqf.fsf@gmail.com>
 <2ce41d4129234ba9a91d5b4dcd8a40ee@realtek.com> <87sex93s63.fsf@gmail.com>
 <6970398610c546b1b62e599902c67572@realtek.com>
 <E3FF7BC1-725B-40E2-AAF0-CA41A44B9DF9@gmail.com>
In-Reply-To: <E3FF7BC1-725B-40E2-AAF0-CA41A44B9DF9@gmail.com>
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

TWF0aGV3IEdlb3JnZSA8bWF0aGV3ZWdlb3JnZUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+IFBsZWFz
ZSBzaGFyZSBBcmNoIExpbnV4IGltYWdlIHlvdSBhcmUgdXNpbmcuDQo+IA0KPiBOb3Qgc3VyZSB3
aGF0IHlvdSBtZWFuIGJ5ICdpbWFnZScuIA0KDQpJIGZlZWwgdGhpcyBwcm9ibGVtIG1heSBiZSBl
YXNpZXIgdG8gcmVwcm9kdWNlIG9uIEFyY2ggTGludXgsIHNvIEkgd291bGQgbGlrZQ0KdG8ga25v
dyBBcmNoIExpbnV4IGlzbyBmaWxlIHlvdSBpbnN0YWxsZWQuIA0KDQo+IEFzIHlvdSBjYW4gc2Vl
IGluIHRoZSBjcmFzaCBsb2cgYXR0YWNoZWQgdG8gbXkNCj4gcHJldmlvdXMgbWFpbCwgSSBidWls
dCB0aGUgbGF0ZXN0IG1haW5saW5lIGtlcm5lbCAoNDQ1ZTYwMzAzODgzIGF0IHRoZSB0aW1lKSB3
aXRoIHlvdXINCj4gcGF0Y2ggYXBwbGllZC4gSSB1c2VkIFt0aGlzIFBLR0JVSUxEXShodHRwczov
L2F1ci5hcmNobGludXgub3JnL3BhY2thZ2VzL2xpbnV4LWdpdCkNCj4gdG8gYnVpbGQgaXQ7IHRo
ZSBmaWxlIGBjb25maWdgIGNvbnRhaW5zIHRoZSBrZXJuZWwgY29uZmlndXJhdGlvbiAoSSBkaWQg
bm90IGFwcGx5IGFueSBvdGhlcg0KPiBvcHRpb25zKSwgYW5kIHRoZXJlIGFyZSBubyBwYXRjaGVz
IGFwcGxpZWQgZXhjZXB0IHlvdXJzLg0KDQpJIHdpbGwgZG8gaXQgYXMgeW91ciBzaWRlLiANCg0K
PiANCj4gPiBDb3VsZCB5b3UgcGxlYXNlIGhlbHAgdG8gY29sbGVjdCAyIG9yIG1vcmUgY3Jhc2gg
bG9nPw0KPiA+IFNvIEkgY2FuIGNoZWNrIGlmIHRoZXJlIGFyZQ0KPiA+IG1vcmUgdGhhbiBvbmUg
Y3Jhc2ggY2FzZXMuDQo+IA0KPiBXaGVuIEkgYW0gYmFjayBhdCBteSBzeXN0ZW0sIEkgd2lsbCBy
ZXByb2R1Y2UgdGhlIGlzc3VlIGEgZmV3IG1vcmUgdGltZXMgd2l0aA0KPiB0aGlzIGtlcm5lbCwg
YW5kIGF0dGFjaCB0aGUgbG9ncy4gSW4gdGhlIG1lYW50aW1lLCB5b3UgY291bGQgaGF2ZSBhIGxv
b2sgYXQgdGhlIGxvZ3MNCj4gbGlua2VkIGluIG15IGZpcnN0IG1haWwuIFRoZXJlIGFyZSBsb2dz
IGZvciBtb3N0IG9mIHRoZSBiYWQgY29tbWl0cyBlbmNvdW50ZXJlZCBpbiB0aGUNCj4gYmlzZWN0
aW9uLg0KDQpJIGhhdmUgc2VlbiB0aGF0LCBidXQgbm8gY2xlYXIgaWRlYSBmb3Igbm93LCBzbyBJ
IHdpbGwgaW5zdGFsbCBBcmNoIExpbnV4IGFzIHlvdXJzDQppbiBteSBzaWRlLg0KDQoNCg0K

