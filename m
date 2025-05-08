Return-Path: <linux-wireless+bounces-22724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA09AAF05E
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 02:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56F29C77C4
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 00:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B715914F9D6;
	Thu,  8 May 2025 00:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="dco8tV+t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D664A2D;
	Thu,  8 May 2025 00:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746665983; cv=none; b=FQ9r1UdKtBOfF+Yv15YnDGF38CVk90Or7hQxiB1SQZPNUHJb4JbDRxqQV1D6i8eVYE9CIAOhPicnKAY6frtBoqDvBjORXUW9gL/jxpCb0BwKOGN5zJRSBg8kNb7mmYZV/6rKuHD+vkGfyYCZc0ZYop+tTmJY4v6AjJf49DO4YqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746665983; c=relaxed/simple;
	bh=5LGyU5TjYoz8v3b0xHtqy7faVAVLrVNhwrO0JlEFzqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AmDHKLWRXCdLbecorUfWoAeAgBb4S84arFAnQrtRF8ElI/maTrmEGzK+BAjvg0xmodYNWV/qEA73gqvtmEwDavKAJzuzNXRA01/lWomFs2/pXY4qLapWL3yTRCPoY1jf9claTc/M0oqLGSZHa09ebkEs7xvOJD7jzOXGd3nwWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=dco8tV+t; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5480xSyqD1276883, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746665969; bh=5LGyU5TjYoz8v3b0xHtqy7faVAVLrVNhwrO0JlEFzqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dco8tV+tdadb04IchYNT7ZtY+dtd5DOuyS8deL0WqCoV5rfQs+EdQxQysfhu3kxQN
	 c3SuZveGy8vT1sXeLk3b1nQ/lFrbnxC2Epnbj1mNd3spHlXKCevSXj4bLA7b14a2tO
	 +Uz4Hr5csbU68crFyUYBVuLF34zX/CRSec+7Gh7bEuBl3JwZpG9kWRfWHDrKIPl88o
	 LWmaQxMDYTWIpmYMcd+dzUnL4mCwJUmbld0TD+fYQTGojaTJsndqceb/rmKayq/4kc
	 LZcuQC4DjaVfxuGncW5DT9Gzahx56g5TDs2FklWlgO/yJdn09GTr1sQql5gaBbT3eb
	 Of7/nsIlzw+9A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5480xSyqD1276883
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 May 2025 08:59:29 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 May 2025 08:59:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 May 2025 08:59:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 8 May 2025 08:59:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <boddah8794@gmail.com>
CC: Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Bug report] rtw89: 8852b: IO_PAGE_FAULTs with beacon filter feature enabled
Thread-Topic: [Bug report] rtw89: 8852b: IO_PAGE_FAULTs with beacon filter
 feature enabled
Thread-Index: AQHbrfBpW2AH+n1rZEuyFH6rIsW1k7Olc7dQgAAnAYCAAXKcUIAf2VeAgAEkbIA=
Date: Thu, 8 May 2025 00:59:28 +0000
Message-ID: <419811cccd774d38b5a9c0bbcdf5dfbe@realtek.com>
References: <uidltsdsuujrczrtzgerhh5cw2tztxktfen6yvztnc7gttzgvk@jccomj7f4gul>
 <148ed65c53be4ef29246d372dd0fef8e@realtek.com>
 <z54thedngt3wnhr5bfer3yg7id2c4uqgw2jjvyausv6p66ys4k@guqol77fpugz>
 <dcf695a6621f43e38a20eb860194191a@realtek.com>
 <7injzacfmvhrugcovyxkn4elnaxnzg27c26zmcqzrwhottyk7e@ap5ellaozcg4>
In-Reply-To: <7injzacfmvhrugcovyxkn4elnaxnzg27c26zmcqzrwhottyk7e@ap5ellaozcg4>
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

RmVkb3IgUGNoZWxraW4gPGJvZGRhaDg3OTRAZ21haWwuY29tPiB3cm90ZToNCj4gT24gVGh1LCAx
Ny4gQXByIDAxOjA1LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gRmVkb3IgUGNoZWxraW4gPGJv
ZGRhaDg3OTRAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBPbiBXZWQsIDE2LiBBcHIg
MDA6NDksIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPiA+ID4gQXMgYmlzZWN0aW9uLCBjYW4gSSBz
dW1tYXJpemUgYXMgYmVsb3cgdGFibGU/DQo+ID4gPiA+DQo+ID4gPiA+ICAgICBkNTZjMjYxZTUy
ICAgICAgICAgICBmaXJtd2FyZSAgICAgICAgICAgICBJT19QQUdFX0ZBVUxUDQo+ID4gPiA+ICAg
IChDUU0gc3VwcG9ydCkNCj4gPiA+ID4gICAtLS0tLS0tLS0tLS0tLS0gICAgICAtLS0tLS0tLS0t
LSAgICAgICAgICAtLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gPiAgICAgICBvICAgICAgICAgICAg
ICAgICAwLjI5LjI5LjcgICAgICAgICAgICAgICAgICB5ZXMNCj4gPiA+ID4gICAgICAgbyAgICAg
ICAgICAgICAgICAgMC4yOS4yOS41ICAgICAgICAgICAgICAgICAgbm8NCj4gPiA+ID4gICAgICAg
eCAgICAgICAgICAgICAgICAgMC4yOS4yOS43ICAgICAgICAgICAgICAgICAgbm8NCj4gPiA+ID4g
ICAgICAgeCAgICAgICAgICAgICAgICAgMC4yOS4yOS41ICAgICAgICAgICAgICAgICAgbm8NCj4g
PiA+ID4NCj4gPiA+ID4gSWYgdGhpcyB0YWJsZSBpcyBjb3JyZWN0LCB3ZSB3aWxsIGNoZWNrIHRo
ZSBiZWFjb24gZmlsdGVyIGZlYXR1cmUgaW4gZmlybXdhcmUuDQo+ID4gPiA+DQo+ID4gPg0KPiA+
ID4gWWVzLCBpdCBjb3JyZWN0bHkgZGVzY3JpYmVzIHRoZSBzaXR1YXRpb24uIE15IHN1c3BpY2lv
biBjdXJyZW50bHkgZmFsbHMgb24NCj4gPiA+IHRoZSBiZWFjb24gZmlsdGVyIGZlYXR1cmUgaW4g
ZmlybXdhcmUsIHRvby4NCj4gPg0KPiA+IENvdWxkIHlvdSBoZWxwIHRvIHRlc3Qgd2hlbiB3ZSBo
YXZlIHVwZGF0ZWQgZmlybXdhcmU/DQo+ID4NCj4gDQo+IEhpLA0KPiANCj4gV2VyZSB5b3UgYWJs
ZSB0byByZXByb2R1Y2Ugb3IgdHJhY2sgZG93biB0aGUgcHJvYmxlbT8NCg0KWWVzLCB3ZSBoYXZl
IHJlcHJvZHVjZWQgdGhpcyBwcm9ibGVtLCBhbmQgd2UgZm91bmQgc2VuZGluZyBmaXJtd2FyZSBj
b21tYW5kDQpkdXJpbmcgZGVlcCBQUyBtb2RlIHdpbGwgcmFpc2UgSU9fUEFHRV9GQVVMVC4gV2l0
aCBiZWxvdyBzZXR0aW5nIHRvIGRpc2FibGUNCmRlZXAgUFMgbW9kZSwgdGhlIHN5bXB0b20gY2Fu
IGRpc2FwcGVhci4NCg0KICAgcnR3ODlfY29yZS5rbyBkaXNhYmxlX3BzX21vZGU9eQ0KDQpOb3cg
d2UgYXJlIGFycmFuZ2luZyBDQVQtQyBlcXVpcG1lbnQgdG8gY2FwdHVyZSBzaWduYWxzIGluIFBD
SUUgYnVzIHRvIHNlZQ0Kd2hhdCBoYXBwZW5zIGF0IHRoYXQgbW9tZW50LiANCg0KT25lIHBvc3Np
YmxlIHNvbHV0aW9uICh3b3JrYXJvdW5kKSBpcyB0byBhdm9pZCBzZW5kaW5nIGZpcm13YXJlIGNv
bW1hbmRzDQpkdXJpbmcgZGVlcCBQUyBtb2RlLCBiZWZvcmUgd2UgZm91bmQgb3V0IHRoZSByb290
IGNhdXNlLiANCg0KDQo=

