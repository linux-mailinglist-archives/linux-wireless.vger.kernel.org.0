Return-Path: <linux-wireless+bounces-8387-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1BF8D7979
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 03:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56174B20B88
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 01:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FC110E6;
	Mon,  3 Jun 2024 01:07:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD2F631
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 01:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717376822; cv=none; b=Jke0TKZIGVZeLCxY84c0XPx90n1kyToezQ2Jd3q//w9nNZ8UWZGykdOmz93Dl58IBZO8/sQrrqeN5yCKI0zEtuNKE6pGXeil70MW9w7E/I0AY01kL+EXMEUQ0j/fq1dply9QqJ/3ERRu9kPFk1Rw8hlunB2jyChEh9A3Catl6EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717376822; c=relaxed/simple;
	bh=Y5qj08pLJQyCL/0P0Sp+wxoBjxUchtHMwyDXWpua3GM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I2HikXMeHArjUlqwQXGpPFK6t/NegH3S/ifHvMQRknpLWwotC+BSaKeY9vMwAUs0IL5kCIwTqK3auuCRxP/AdqXrp10wy7wNIE2YPn2oPtzywIb86DEd6M6BAdX2TYaNOoonVnEZdcbNM44xqW0TG7/qqtnFSgsmzx3BXWsbyiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45316v3zA2099295, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45316v3zA2099295
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Jun 2024 09:06:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 09:06:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 3 Jun 2024 09:06:56 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 3 Jun 2024 09:06:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: devin <maildevinplease@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: Realtek RTL8822CE PCIe Frequent Disconnection Issues on Linux
Thread-Topic: Realtek RTL8822CE PCIe Frequent Disconnection Issues on Linux
Thread-Index: AQHatG9h3oJF6pMaqU+NEkQZRdCiCbG1N6PQ
Date: Mon, 3 Jun 2024 01:06:56 +0000
Message-ID: <c0709b4c6a2d4be6895eb74994acf8d6@realtek.com>
References: <CAMY0kPLv-W=cXOzT6MAwu7vWr7GcOLWA0aiygbsuUkOAtMeJzg@mail.gmail.com>
In-Reply-To: <CAMY0kPLv-W=cXOzT6MAwu7vWr7GcOLWA0aiygbsuUkOAtMeJzg@mail.gmail.com>
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

ZGV2aW4gPG1haWxkZXZpbnBsZWFzZUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gWyAgNDU2Ljcz
NzQ4MV0gd2xwMnMwOiBDb25uZWN0aW9uIHRvIEFQIDEwOmRhOjQzOjk2OmNkOjFkIGxvc3QNCj4g
WyAgNDU4LjEwMjIwNF0gd2xwMnMwOiA4MCBNSHogbm90IHN1cHBvcnRlZCwgZGlzYWJsaW5nIFZI
VA0KPiBbICA0NTguMzA0NjkzXSB3bHAyczA6IGF1dGhlbnRpY2F0ZSB3aXRoIDEwOmRhOjQzOjk2
OmNkOjFkIChsb2NhbA0KPiBhZGRyZXNzPWM4Ojk0OjAyOjA1OmM0OmE5KQ0KPiBbICA0NTguMzY3
ODUxXSB3bHAyczA6IHNlbmQgYXV0aCB0byAxMDpkYTo0Mzo5NjpjZDoxZCAodHJ5IDEvMykNCj4g
WyAgNDU4LjM3NTI5M10gd2xwMnMwOiBhdXRoZW50aWNhdGVkDQo+IFsgIDQ1OC4zNzU2NjZdIHds
cDJzMDogYXNzb2NpYXRlIHdpdGggMTA6ZGE6NDM6OTY6Y2Q6MWQgKHRyeSAxLzMpDQo+IFsgIDQ1
OC4zODE2MzNdIHdscDJzMDogUlggQXNzb2NSZXNwIGZyb20gMTA6ZGE6NDM6OTY6Y2Q6MWQNCj4g
KGNhcGFiPTB4MTQxMSBzdGF0dXM9MCBhaWQ9MTIpDQo+IFsgIDQ1OC4zODIwMThdIHdscDJzMDog
YXNzb2NpYXRlZA0KPiBbICA0NTguNDU4NDg4XSB3bHAyczA6IExpbWl0aW5nIFRYIHBvd2VyIHRv
IDMwICgzMCAtIDApIGRCbSBhcw0KPiBhZHZlcnRpc2VkIGJ5IDEwOmRhOjQzOjk2OmNkOjFkDQoN
ClNpbmNlIHlvdXIgY29ubmVjdGlvbnMgZ2V0IGxvc3QgYWZ0ZXIgYWJvdXQgMjAgc2Vjb25kcywg
aXQncyB3b3J0aCB0byBnaXZlDQphIHRyeSB0byBkaXNhYmxlIHBvd2VyIHNhdmUgYnkNCg0KICAg
c3VkbyBpdyB3bGFuMSBzZXQgcG93ZXIgc2F2ZSBvZmYNCg0KDQo+IFsgIDQ3NS42MTk5MjNdIHds
cDJzMDogQ29ubmVjdGlvbiB0byBBUCAxMDpkYTo0Mzo5NjpjZDoxZCBsb3N0DQo+IFsgIDQ3Ny4w
MjAyMzhdIHdscDJzMDogODAgTUh6IG5vdCBzdXBwb3J0ZWQsIGRpc2FibGluZyBWSFQNCj4gWyAg
NDc3LjIyMTcyM10gd2xwMnMwOiBhdXRoZW50aWNhdGUgd2l0aCAxMDpkYTo0Mzo5NjpjZDoxZCAo
bG9jYWwNCj4gYWRkcmVzcz1jODo5NDowMjowNTpjNDphOSkNCj4gWyAgNDc3LjI4NDk3Nl0gd2xw
MnMwOiBzZW5kIGF1dGggdG8gMTA6ZGE6NDM6OTY6Y2Q6MWQgKHRyeSAxLzMpDQo+IFsgIDQ3Ny4y
OTIzNjZdIHdscDJzMDogYXV0aGVudGljYXRlZA0KPiBbICA0NzcuMjkyODcxXSB3bHAyczA6IGFz
c29jaWF0ZSB3aXRoIDEwOmRhOjQzOjk2OmNkOjFkICh0cnkgMS8zKQ0KPiBbICA0NzcuMjk5Mjgx
XSB3bHAyczA6IFJYIEFzc29jUmVzcCBmcm9tIDEwOmRhOjQzOjk2OmNkOjFkDQo+IChjYXBhYj0w
eDE0MTEgc3RhdHVzPTAgYWlkPTEyKQ0KPiBbICA0NzcuMjk5NjY1XSB3bHAyczA6IGFzc29jaWF0
ZWQNCj4gWyAgNDc3LjMwMjU2N10gd2xwMnMwOiBMaW1pdGluZyBUWCBwb3dlciB0byAzMCAoMzAg
LSAwKSBkQm0gYXMNCj4gYWR2ZXJ0aXNlZCBieSAxMDpkYTo0Mzo5NjpjZDoxZA0KDQoNCg==

