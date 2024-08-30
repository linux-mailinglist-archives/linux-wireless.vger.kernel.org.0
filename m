Return-Path: <linux-wireless+bounces-12252-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D66965A93
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 10:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CAB31C21183
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 08:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F5716726E;
	Fri, 30 Aug 2024 08:41:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5601531C9
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007267; cv=none; b=P8NUTMuZe+7s6VMa3dM2YUPU/PdBbIYLQfM8EWJf7XtvVrTKsPs0wduTqoIOWQ6mqt5yR5Cq3xidn/+1Ey9qGCFTP9R7b5OQKXILava3HOie6oUL3XmfiTEZDpYvbX/+7mGCS1ST+vVYW1I4jYCqikGGBDcQop7Z8q3cFfR0E40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007267; c=relaxed/simple;
	bh=HTOPegl0EeIquq29FJ7vT80LYTabFugNAxkzP+x/yLY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=gdLGA/qVl4DljnGm9cjj+7gnMbygTSDAqv5YNsMalliFkWe50rGehTGTiNzMpuzDA4/0ZcWUCBwfkdVXqEd+yHOloDjqnMD55rylOXqmH2Ke5J3ANjGzEJV78kxtBbLmc9pJXiQGIM9aL5hvMOjDM/1pVswKuyutxhuL/HsXrmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-41-mtZATFM0MOGVZZXXHVDNWw-1; Fri, 30 Aug 2024 09:41:02 +0100
X-MC-Unique: mtZATFM0MOGVZZXXHVDNWw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 30 Aug
 2024 09:40:18 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 30 Aug 2024 09:40:18 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jakub Kicinski' <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>
CC: Hongbo Li <lihongbo22@huawei.com>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "allison.henderson@oracle.com"
	<allison.henderson@oracle.com>, "dsahern@kernel.org" <dsahern@kernel.org>,
	"pshelar@ovn.org" <pshelar@ovn.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>, "dccp@vger.kernel.org" <dccp@vger.kernel.org>,
	"dev@openvswitch.org" <dev@openvswitch.org>, "linux-afs@lists.infradead.org"
	<linux-afs@lists.infradead.org>
Subject: RE: [PATCH net-next 0/8] Use max/min to simplify the code
Thread-Topic: [PATCH net-next 0/8] Use max/min to simplify the code
Thread-Index: AQHa+Ine9Uj88qKbsUSQ6aPvxEhV6bI/frIw
Date: Fri, 30 Aug 2024 08:40:18 +0000
Message-ID: <bfb315c60376419ea2ea90df7e7ae2dc@AcuMS.aculab.com>
References: <20240824074033.2134514-1-lihongbo22@huawei.com>
	<20240826144404.03fce39c@kernel.org>
	<4a92bb68-7fe7-4bf2-885f-e07b06ea82aa@huawei.com>	<878qwifub5.fsf@kernel.org>
 <20240827070347.4bf3a284@kernel.org>
In-Reply-To: <20240827070347.4bf3a284@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogSmFrdWIgS2ljaW5za2kNCj4gU2VudDogMjcgQXVndXN0IDIwMjQgMTU6MDQNCj4gDQo+
IE9uIFR1ZSwgMjcgQXVnIDIwMjQgMDc6NDU6MDIgKzAzMDAgS2FsbGUgVmFsbyB3cm90ZToNCj4g
PiA+IERvIHlvdSBtZWFuIHNvbWUgcGF0Y2hlcyB3aWxsIGdvIHRvIG90aGVyIGJyYW5jaGVzIChz
dWNoIGFzIG1hYzgwMjExKT8NCj4gPg0KPiA+IEpha3ViIG1lYW5zIHRoYXQgeW91ciBwYXRjaHNl
dCBoYWQgY29tcGlsYXRpb24gZXJyb3JzLCBzZWUgdGhlIHJlZCBvbg0KPiA+IHBhdGNod29yazoN
Cj4gPg0KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9uZXRkZXZicGYv
bGlzdC8/c2VyaWVzPTg4MjkwMSZzdGF0ZT0qJm9yZGVyPWRhdGUNCj4gDQo+IEZXSVcgSSBwcmVm
ZXIgbm90IHRvIHBvaW50IG5vb2JzIHRvIHRoZSBwYXRjaHdvcmsgY2hlY2tzLCBsZXN0IHRoZXkN
Cj4gdGhpbmsgaXQncyBhIHB1YmxpYyBDSSBhbmQgdGhleSBjYW4gZmxpbmcgYnJva2VuIGNvZGUg
YXQgdGhlIGxpc3QgOigNCj4gQnV0IHllcywgaW4gY2FzZSAiY29kZSBkb2Vzbid0IGJ1aWxkIiBu
ZWVkcyBhIGZ1cnRoZXIgZXhwbGFuYXRpb246DQo+IA0KPiBuZXQvY29yZS9wa3RnZW4uYzogSW4g
ZnVuY3Rpb24g4oCYcGt0Z2VuX2ZpbmFsaXplX3NrYuKAmToNCj4gLi8uLi9pbmNsdWRlL2xpbnV4
L2NvbXBpbGVyX3R5cGVzLmg6NTEwOjQ1OiBlcnJvcjogY2FsbCB0byDigJhfX2NvbXBpbGV0aW1l
X2Fzc2VydF85MjjigJkgZGVjbGFyZWQgd2l0aA0KPiBhdHRyaWJ1dGUgZXJyb3I6IG1pbihkYXRh
bGVuL2ZyYWdzLCAoKDFVTCkgPDwgMTIpKSBzaWduZWRuZXNzIGVycm9yDQouLi4NCj4gLi4vbmV0
L2NvcmUvcGt0Z2VuLmM6Mjc5NjoyODogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmG1p
buKAmQ0KPiAgMjc5NiB8ICAgICAgICAgICAgICAgICBmcmFnX2xlbiA9IG1pbihkYXRhbGVuL2Zy
YWdzLCBQQUdFX1NJWkUpOw0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+
fg0KDQpJIGNhbid0IGhlbHAgZmVlbGluZyB0aGF0IGEgc2lnbmVkIGRpdmlkZSBpc24ndCBpbnRl
bmRlZCBoZXJlLg0KV2hpY2ggcmF0aGVyIGltcGxpZXMgdGhhdCBib3RoIGRhdGFsZW4gYW5kIGZy
YWdzIGFyZSBzaWduZWQgdHlwZXMuDQpXaGVyZWFzIG5laXRoZXIgY2FuIGJlIHNlbnNpYmx5IG5l
Z2F0aXZlLg0KUGVyaGFwcyB0aGF0IGlzIHRoZSByZWFsIGJ1Zz8NCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==


