Return-Path: <linux-wireless+bounces-26223-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8931B1E232
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 08:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA42163ED4
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 06:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DE22040AB;
	Fri,  8 Aug 2025 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="cjjA1ptJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384671E48A
	for <linux-wireless@vger.kernel.org>; Fri,  8 Aug 2025 06:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754634068; cv=none; b=iPi3gMfGb40nK3TqA5ufE7skOIzowNz55gMQLLJ1k8RKPvF8BIyBzIZQNvPEi3q/7g5LIQgWVY6YBWpzSRTPA5L13v8O203kAAmse1CNvTILsnr++exAuifxz+1/vCinz48GyIhF8y7jnf+2FS8ugaVw2GEk+ETwDslwwsx4ztA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754634068; c=relaxed/simple;
	bh=9B/yO783Qb+V89BFvMliRXW23mY/3M9Rypqsj3JQwME=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DTADg8R8pWnff3Fx0RqiPFQPu2j9JALrYc4mxrHd5WEX4zccLF20RGRQhqTaz/y2SJLi1e1K1n8FvO5od5GeZZie59EhsY51iKQerJNAa12DHMQRAOW9QAvLTEuP7ndQ7tbyqPXwz23BjXcrxn6Nx9agZKcK74DJh8QCxI4K6bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=cjjA1ptJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5786L2Rl82798705, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754634062; bh=9B/yO783Qb+V89BFvMliRXW23mY/3M9Rypqsj3JQwME=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=cjjA1ptJoAbsq4CLSM9IrR0KOWjIMySJA+ISb4eXymdhtDyH/gbo8VF0VVByPp2I8
	 fWyxhiDZnvAHcIK/8nN2PMxwPpC/TBgx7/DaHgH7Gfy2yob4uLPP3pwAjT1lyq4vXM
	 ZtiDUyM0C9Uak3ncyLqPXWpTTbbUiux6ODPA9/s1fQQlpEBqbnp/WEpJd8yJ10k4Qa
	 CdCyWO+VuMzQPJrGQkYRMkZhE4D9QbHiqsFqD1E2ERsQWt8QtfvbNFDSCUWuNJMQbG
	 bdAaIXGqdCiQmP/zJWD3C0aVcf6Yj1d/5ss59QqRjaA/S43I/TfqBpi+8NmhLafSed
	 NUALXpUs6BE7w==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5786L2Rl82798705
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 14:21:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Aug 2025 14:21:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc%10]) with mapi id
 15.02.1544.011; Fri, 8 Aug 2025 14:21:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: rtw89: RTL8832CU loses the connection
Thread-Topic: rtw89: RTL8832CU loses the connection
Thread-Index: AQHcAzk7XBTSI9LTvESl2o/pktzRxbRYURnw
Date: Fri, 8 Aug 2025 06:21:02 +0000
Message-ID: <ddeb37fb73b24e35b7f37494fa3c6bf0@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
 <2bc07f15-c551-467e-b9e6-2cc65b874e8a@gmail.com>
In-Reply-To: <2bc07f15-c551-467e-b9e6-2cc65b874e8a@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAw
MS8wOC8yMDI1IDIzOjQ5LCBCaXR0ZXJibHVlIFNtaXRoIHdyb3RlOg0KPiA+IEFkZCBzdXBwb3J0
IGZvciBSVEw4ODUyQ1UuIEl0IHdvcmtzIHdlbGwgYnV0IHNvbWV0aW1lcyBpdCBsb3NlcyB0aGUN
Cj4gPiBjb25uZWN0aW9uOg0KPiA+DQo+ID4gSnVsIDA0IDE2OjA1OjU2IGlkZWFwYWQyIGtlcm5l
bDogd2xwM3MwZjN1NDogQ29ubmVjdGlvbiB0byBBUCAuLi4gbG9zdA0KPiA+IEp1bCAxNCAxMzo0
NToyNiBpZGVhcGFkMiBrZXJuZWw6IHdscDNzMGYzdTQ6IENvbm5lY3Rpb24gdG8gQVAgLi4uIGxv
c3QNCj4gPiBKdWwgMTUgMTc6NTE6MjggaWRlYXBhZDIga2VybmVsOiB3bHAzczBmM3U0OiBDb25u
ZWN0aW9uIHRvIEFQIC4uLiBsb3N0DQo+ID4gSnVsIDE4IDE0OjQzOjMwIGlkZWFwYWQyIGtlcm5l
bDogd2xwM3MwZjN1NDogQ29ubmVjdGlvbiB0byBBUCAuLi4gbG9zdA0KPiA+IEp1bCAyNCAxNDo1
ODowNyBpZGVhcGFkMiBrZXJuZWw6IHdscDNzMGYzdTQ6IENvbm5lY3Rpb24gdG8gQVAgLi4uIGxv
c3QNCj4gPg0KPiA+IFdoZW4gdGhhdCBoYXBwZW5zIGl0IHJlY29ubmVjdHMgaW1tZWRpYXRlbHku
DQo+ID4NCj4gSXQncyBlYXN5IHRvIHJlcHJvZHVjZSB3aXRoICJpcGVyZjMgLWMgMTkyLjE2OC4w
LjEgLXQgMzAwMCIuIFVzdWFsbHkgaXQNCj4gdGFrZXMgMTAtMTIgbWludXRlcyB0cmFuc21pdHRp
bmcgYXQgfjEgR2Jwcy4NCj4gDQoNCkkgaGF2ZSBjb250YWN0ZWQgaW50ZXJuYWwgZXhwZXJ0IHRv
IHNlZSBpZiB0aGV5IGNhbiBoZWxwLg0KDQpUaGlzIGlzIGZpcnN0IHByb2JsZW0gdGhhdCBkaXNj
b25uZWN0ZWQgZnJvbSBBUCBoYXBwZW5zIDEwLTEyIG1pbnV0ZXMuIA0KU2luY2Ugc2Vjb25kIHBy
b2JsZW0gaGFwcGVucyBpbW1lZGlhdGVseSwgd2Ugd291bGQgbGlrZSB0byBjaGVjayB0aGUNCnNl
Y29uZCBvbmUgZmlyc3RseS4NCg0KPiANCj4gVGhpcyBydW5zIG9uY2UgcGVyIHNlY29uZC4gTm93
IEkgZ2V0IHRoaXMgaW5zdGVhZCBvZiB0aGUgY29ubmVjdGlvbiBsb3NzOg0KPiANCg0KV2UgYXJl
IHByZXBhcmluZyBhIGRlYnVnIHBhdGNoLiBJJ2xsIHNlbmQgeW91IG5leHQgd2Vlay4NCg0KDQo=

