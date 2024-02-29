Return-Path: <linux-wireless+bounces-4255-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F122D86CBE5
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 15:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88F1280F54
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 14:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6569B47F79;
	Thu, 29 Feb 2024 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bY+XvT9Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A16B137757
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218030; cv=none; b=tggBE1E2vwl9I5bi8Wjxf8SR49Mk+6WpbywoT7+jWjRHodO+SlbYmbKb+4sZaz4Ozp0It7a6QkgU6QTcL4mHnjUrYFri/LbSJSAUs4+jhrqk3nKHAzkf5/NqJBYPfpSajbX+fF6UIydZL3lXkimLmDVEXFx2CKDI9sSxjX63HgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218030; c=relaxed/simple;
	bh=UEwgZO4zFDy1ZX3tBkNqyir0jdURKrAXmho4rFSTvbQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Or/wyFQIq+Fc8nAQxl6imamjr/gIFOTKlT701hvQfZXrUgzBYEiiSys9/dflmEMFulzVeMNuF3DAP8NDd8ThF/RybqigzTWwEW8Nxs3guNzJ0eUPQvI0M0Wka/X/trsJwEOmU7H4Oun2cuP5VwA087o8vS1UGiSXlpEi4UEra44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bY+XvT9Y; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41TEl49N059210;
	Thu, 29 Feb 2024 08:47:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709218024;
	bh=UEwgZO4zFDy1ZX3tBkNqyir0jdURKrAXmho4rFSTvbQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=bY+XvT9YMfe48UXZ9nqJmYdIKkvkhuwZqj+sMjoepzpVQxZuZvCipBCbdViQTDtn2
	 /g4oAP5tebXnOZb3hCZZnzJWBzlpqnQBOBMFTbj34SwX4OwoE4xiKbGpaYLqPikb5g
	 GWjSA5h2WCBfOBkU2MKlyxuyc/iQKZT4HDOgWkNI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41TEl4U5082640
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Feb 2024 08:47:04 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Feb 2024 08:47:04 -0600
Received: from DLEE102.ent.ti.com ([fe80::2cde:e57d:8075:c010]) by
 DLEE102.ent.ti.com ([fe80::2cde:e57d:8075:c010%17]) with mapi id
 15.01.2507.023; Thu, 29 Feb 2024 08:47:04 -0600
From: "Itzhak, Shlomi" <shlomii@ti.com>
To: Fabio Estevam <festevam@gmail.com>, "Mishol, Guy" <guym@ti.com>,
        "Menon,
 Nishanth" <nm@ti.com>
CC: linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: wl18xx: Error when using the latest firmware
Thread-Topic: wl18xx: Error when using the latest firmware
Thread-Index: AQHaawLp3FzDhcJ2Kk6kBVguw1clRbEhZZCw
Date: Thu, 29 Feb 2024 14:47:04 +0000
Message-ID: <5229778a589d461fa292cae5e73367f7@ti.com>
References: <CAOMZO5DqMjMj_-ohuNmKvWu+i1pN8LHXnG8fGYKrk=OH+mO2BA@mail.gmail.com>
In-Reply-To: <CAOMZO5DqMjMj_-ohuNmKvWu+i1pN8LHXnG8fGYKrk=OH+mO2BA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGksDQpZb3UgYXJlIHVzaW5nIGEgdmVyeSBvbGQgZHJpdmVyIGlmIGl0IHRocm93cyBhbiBlcnJv
ciBvZiBGVyA4LjkuKi4qLjU4Lg0KVGhlcmUgd2VyZSB0d28gbWFqb3IgZHJpdmVyIHVwZGF0ZXMg
c2luY2UgdGhlbiwgb25lIGZvciB0aGUgV1BBMyBzdXBwb3J0IGFuZCB0aGUgb3RoZXIgZm9yIGEg
bWFqb3IgaXNzdWUgd2UgaGFkIHdpdGggYSBQTiBkcmlmdC4NCkJvdHRvbSBsaW5lLCB0byB0YWtl
IHRoZSBsYXRlc3QgRlcsIHlvdSB3b3VsZCBhbHNvIG5lZWQgdG8gaW1wbGVtZW50IGFsbCB0aGUg
ZHJpdmVyIHBhdGNoZXMuDQpZb3UgY2FuIGZpbmQgdGhvc2UgdW5kZXIgaHR0cHM6Ly9naXQudGku
Y29tL2NnaXQvd2lsaW5rOC13bGFuL2J1aWxkLXV0aWxpdGVzL2xvZy8/aD1yOC45DQpSZWdhcmRz
LA0KU2hsb21pDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBGYWJpbyBFc3Rl
dmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+IA0KU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDI5LCAy
MDI0IDE6MzIgUE0NClRvOiBJdHpoYWssIFNobG9taSA8c2hsb21paUB0aS5jb20+OyBzYXVyYWJo
bmFyYW5nQHRpLmNvbTsgTWlzaG9sLCBHdXkgPGd1eW1AdGkuY29tPjsgTWVub24sIE5pc2hhbnRo
IDxubUB0aS5jb20+DQpDYzogbGludXgtd2lyZWxlc3MgPGxpbnV4LXdpcmVsZXNzQHZnZXIua2Vy
bmVsLm9yZz4NClN1YmplY3Q6IHdsMTh4eDogRXJyb3Igd2hlbiB1c2luZyB0aGUgbGF0ZXN0IGZp
cm13YXJlDQoNCkhpLA0KDQpJIGFtIHJ1bm5pbmcga2VybmVsIDYuNi4xOCBvbiBhbiBpbXg2ZGwg
Ym9hcmQgd2l0aCB0aGUgV0wxOFhYIFdpZmkgY2hpcC4NCg0KSSB0cmllZCB1c2luZyB0aGUgbW9z
dCByZWNlbnQgZmlybXdhcmUgKDguOS4xLjAuMikgZnJvbSB0aGUgbWFzdGVyIGJyYW5jaCBvZjoN
Cg0KaHR0cHM6Ly9naXQudGkuY29tL2NnaXQvd2lsaW5rOC13bGFuL3dsMTh4eF9mdy9sb2cvDQoN
CmJ1dCB0aGUgZm9sbG93aW5nIGVycm9yIGlzIHNlZW46DQoNCndsY29yZTogRVJST1IgWW91ciBX
aUZpIEZXIHZlcnNpb24gKDguOS4xLjAuMikgaXMgaW52YWxpZC4NClBsZWFzZSB1c2UgYXQgbGVh
c3QgRlcgOC45LiouKi41OC4NCg0KVGhlbiBJIHVzZWQgRlcgOC45LjAuMC45MCBhbmQgdGhpcyB2
ZXJzaW9uIGlzIGFjY2VwdGVkLg0KDQpTaG91bGQgZHJpdmVycy9uZXQvd2lyZWxlc3MvdGkvd2xj
b3JlL2Jvb3QuYyBiIGJlIGNoYW5nZWQgdG8gYWxsb3cgcnVubmluZyB0aGUgbGF0ZXN0IDguOS4x
LjAuMj8gV2hhdCBpcyB0aGUgcmVjb21tZW5kZWQgd2wxOHh4IGZpcm13YXJlIHZlcnNpb24gd2hl
biBydW5uaW5nIGEgbWFpbmxpbmUga2VybmVsPw0KDQpBbnkgc3VnZ2VzdGlvbnM/DQoNClRoYW5r
cywNCg0KRmFiaW8gRXN0ZXZhbQ0K

