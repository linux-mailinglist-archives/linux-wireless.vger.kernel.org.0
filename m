Return-Path: <linux-wireless+bounces-22650-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 414F7AAB940
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 08:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F621C0421D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 06:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2C720D50B;
	Tue,  6 May 2025 04:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="hdZhjbOM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C2318E3E
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 02:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746497505; cv=none; b=j7YerJHDodOBSNQAxrwpXlFIaHcTlZDeECilg+STkIPBQfEavhb5C6vBpTwZ8LXdmwyPujFdXO0lSFtSL73A5CRveY+DHQCVyURSRa3MwWybjh/xKCIQ8nAT5vgyNigxKmJyTmoHwovev/a9EH8Gnz5h/Jw93CpHMHXb0rRJUr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746497505; c=relaxed/simple;
	bh=zcXcuEws+HPigsMuDY3x79gGk/R/Ez0C9m3ySvYGEbo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qWb3T+xnxcHNna7+RZ8aVJ2qSZeF/ARwuc595sO/x1w3A3kxdlz3qflYjatbt3iVBr0pzReIoymkjjLF2Bw6F0anlGQcwG5jvQvXr4iJHLkA1ZVyM7rE7rnmmk+BzOqE+Ml+5eJcOEQY4W9MBIJRPPAm4KDCFtRaTfBVreA4m5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=hdZhjbOM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5462BcHsA1563753, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746497498; bh=zcXcuEws+HPigsMuDY3x79gGk/R/Ez0C9m3ySvYGEbo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=hdZhjbOM050lDiVCOHVbeXomkA4ZDZzwCoKmYi7MRF2RItEsxYaLNY7B9MoF2Mcyv
	 Cgm8TQnNudrvXyWOwEm1+7sUlvV2izJ7v7LQtwiV5oQFTmrElHnnGCZmFD0HH0zaEr
	 HX5EDtaHt/G0yvh5a74gycJXLIP2IHF2OZ27jPlDOrt3auiRN7lov4iO5d3qcgY1gL
	 KrlctSPmccA2jsiQDR8um4RQgWluck2MAFoLDNgh6Hqaz9kZCdC8EAh5mhfhSztxxx
	 3acTal7m6D9DeAxP/HkDobaxu0J50U7pCiqE69bvoPTkleNy6r96ha1RDree3lfFZu
	 JoTuF7Gw7NIrg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5462BcHsA1563753
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 10:11:38 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 May 2025 10:11:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 May 2025 10:11:38 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 6 May 2025 10:11:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Samuel Reyes <zohrlaffz@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: RTL8922AE driver issues
Thread-Topic: RTL8922AE driver issues
Thread-Index: AQHbvXDofJ7veYm0B0SRgsW1576rS7PDt/FQgAAI4oCAARqb4A==
Date: Tue, 6 May 2025 02:11:38 +0000
Message-ID: <ae5013a930574e68b96544df82f93157@realtek.com>
References: <CAD+XiyEJo0m8L6PbmBD=NPPa0E_wX3kk4ezn1qZ0d8JGXsS1qQ@mail.gmail.com>
 <0cf9bd4b99864f428175e34a2f2e014b@realtek.com>
 <CAD+XiyFkogCyQTk8Xhu8htGa892zFkY707+8WVCOdejb3FLNpg@mail.gmail.com>
In-Reply-To: <CAD+XiyFkogCyQTk8Xhu8htGa892zFkY707+8WVCOdejb3FLNpg@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

U2FtdWVsIFJleWVzIDx6b2hybGFmZnpAZ21haWwuY29tPiB3cm90ZToNCj4gQmlnIHVwZGF0ZSwg
SSB1cGRhdGVkIG15IG1vdGhlcmJvYXJkIHRvIHRoZSBuZXdlc3QgQklPUyAodkY0KSBhbmQgaXQN
Cj4gaGFzIGhlbHBlZCBkcmFtYXRpY2FsbHkgd2l0aCB0aGUgYW1vdW50IG9mIGVycm9ycyBpbiBk
bWVzZy4gQnV0IHRoZQ0KPiBpc3N1ZSB3aXRoIHRoZSBjb25uZWN0aW9uIGRyb3BwaW5nIGFmdGVy
IHNvbWUgdGltZSByZW1haW5zLiBJIGFkZGVkDQo+IGFtZF9pb21tdT1vZmYgdG8gbXkga2VybmVs
IHBhcmFtZXRlcnMgYW5kIHJhbiBzdWRvIGl3IHdsYW4wIHNldA0KPiBwb3dlcl9zYXZlIG9mZi4g
SSBkaWQgTk9UIGFwcGx5IHRoZSBrZXJuZWwgcGF0Y2ggeW91IGluY2x1ZGVkIHlldC4gSQ0KPiBy
YW4gZG1lc2cgd2hlbiBteSBjb25uZWN0aW9uIGRyb3BwZWQgYW5kIHNhdyBhIGJ1bmNoIG9mICdm
YWlsZWQgdG8NCj4gdXBkYXRlIFhYIFJYQkQgaW5mbzogLTExJyBlcnJvcnMgYWdhaW4uDQoNCkkg
ZG9uJ3QgaGF2ZSBjbGVhciBpZGVhIG5vdy4gUGxlYXNlIHRyeSBteSBwYXRjaCBmaXJzdC4gDQpJ
IHdpbGwgY2hlY2sgaW50ZXJuYWxseSBhbmQgd2lsbCBuZWVkIHlvdXIgaGVscCB0byBjb2xsZWN0
IG1vcmUgZGF0YS4NCg0KPiANCj4gSSBtYW5hZ2VkIHRvIGNhcHR1cmUgdGhlIGNvbm5lY3Rpb24g
ZHJvcCBpbiBhIHJlY29yZGluZyBzbyB5b3UgY2FuIHNlZQ0KPiB3aGF0IGl0IGxvb2tzIGxpa2Ug
b24gbXkgZW5kLiBNeSBjb25uZWN0aW9uIHdpbGwgcmVtYWluICdicm9rZW4nDQo+IGluZGVmaW5p
dGVseSB1bnRpbCBJIHRvZ2dsZSBhaXJwbGFuZSBtb2RlLg0KPiANCj4gVmlkZW86IGh0dHBzOi8v
eW91dHUuYmUvQmJWbFRVOEs5SGcNCj4gDQoNCkNhbiB5b3Ugb3BlbiBhIHRlcm1pbmFsIHRvIHNo
b3cga2VybmVsIGxvZyBuZXh0IHRpbWU/IEkgd291bGQgbGlrZSB0bw0Ka25vdyBkaXNjb25uZWN0
aW9uIGhhcHBlbnMgYWxvbmcgJ2ZhaWxlZCB0byB1cGRhdGUgWFggUlhCRCBpbmZvOiAtMTEnLiAN
Cg0KQnkgdGhlIHdheSwgcGxlYXNlIG5vdCB0b3AtcG9zdGluZyBpbiB3aXJlbGVzcyBtYWlsaW5n
Lg0KDQo=

