Return-Path: <linux-wireless+bounces-22159-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FADEA9FE35
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 02:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3493B32FC
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 00:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4392D17C68;
	Tue, 29 Apr 2025 00:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="sevkdFOR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD98017588;
	Tue, 29 Apr 2025 00:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745886095; cv=none; b=jswP7nCSm9TGXOXpkB0Ams+yPD1lw+SpElhhRdcn4WGldXK134Ges9r1LNh7ZvE3TXFUE0M/3SnrAsx7mCkPZL7AyymzieUsBcrrLKWX0DpC8fGq3k2yql9YeY7Uc/AtrpCVMPtNsI2O1sblW/4crUmp9pxnLwD9uQKJpeHpA7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745886095; c=relaxed/simple;
	bh=vRcYgLolkOu4x0b3yFeVx0iL5VudqRp/C5dy3C2h72k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CwzvzSEGFWa+N0KPVn/e7Xhh7BdO1AocX433Fj45Otrhu/ksg+xTi6izfZcq2baLCNyI7STaaXCD/xvjzVMJGkI5q9NXdGEjFsf0huUS8+fhbLM5cyZVfeu+i/lZJbypSUNce44ydtUS5CeUfaBRfyz2c2csOINQqtUdXEvIkYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=sevkdFOR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53T0LPBw83391512, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745886085; bh=vRcYgLolkOu4x0b3yFeVx0iL5VudqRp/C5dy3C2h72k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=sevkdFOROkVIrjH4nn2ZTK2fJJiV/xF0VJ0IrFgYDyR8ux9ZJbVATAGLlWZ04AlfS
	 CU266g6wNt4TvmSg7DF4v/CcWjF9wxjSGrTddHj0JyRrA2EPhB+khnCtPVozEdSlrM
	 rxGWHunDMPXCmyDplKY1r8biYKnD1nHMUI3pySeJr/WguxQm4vs1o9952mTt5LLof7
	 j9t93GhRSBgr6rReaBkolHwqpipsrGmwpm+q4DY2RyfFEL3+EXTFIgx/r5WqV37tuq
	 /sNggpAll37d4fG5qd1EtClVxa+PkZj/g47GXIMWDUc0ny9H9ocjJDciAoRYAp0u/4
	 ExXEggKayC0Bg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53T0LPBw83391512
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 08:21:25 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Apr 2025 08:21:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 29 Apr 2025 08:21:22 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 29 Apr 2025 08:21:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?T25kxZllaiBKaXJtYW4=?= <megi@xff.cz>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open
 list:REALTEK WIRELESS DRIVER (rtw89)" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: Fix inadverent sharing of struct ieee80211_supported_band data
Thread-Topic: [PATCH] wifi: rtw89: Fix inadverent sharing of struct
 ieee80211_supported_band data
Thread-Index: AQHbtwrOUtNppvqbbk6+hgDxNYRyi7O4TFxAgADOeYCAAK+uYA==
Date: Tue, 29 Apr 2025 00:21:22 +0000
Message-ID: <85baab98b0e74936bdecac3a63552f1a@realtek.com>
References: <20250427002414.410791-1-megi@xff.cz>
 <d3c6e149a2794551ba4570bdd7f1b7e7@realtek.com>
 <yurmw275hyo3zwstdwfqyepan3mj3anqavnpv6hu2742h4ofgx@c56eohg3s6ue>
In-Reply-To: <yurmw275hyo3zwstdwfqyepan3mj3anqavnpv6hu2742h4ofgx@c56eohg3s6ue>
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

PiA+IFNpbmNlIHlvdSBoYXZlIGR1cGxpY2F0ZWQgYXJyYXlzIG9mIGNoYW5uZWxzIGFuZCBiaXRy
YXRlLCB3ZSBzaG91bGQgYWRkIGNvbnN0DQo+ID4gdG8gdGhlbSwgbGlrZToNCj4gPg0KPiA+ICAg
c3RhdGljIGNvbnN0IHN0cnVjdCBpZWVlODAyMTFfY2hhbm5lbCBydHc4OV9jaGFubmVsc197Mmdo
eiw1Z2h6LDZnaHp9W10NCj4gPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWVlZTgwMjExX3JhdGUg
cnR3ODlfYml0cmF0ZXNbXQ0KPiANCj4gVGhhdCB3aWxsIHByb2R1Y2U6DQo+IA0KPiAgIGluaXRp
YWxpemF0aW9uIGRpc2NhcmRzICdjb25zdCcgcXVhbGlmaWVyIGZyb20gcG9pbnRlciB0YXJnZXQg
dHlwZSBbLVdkaXNjYXJkZWQtcXVhbGlmaWVyc10NCj4gDQo+IHdhcm5pbmdzLCBiZWNhdXNlICBz
dHJ1Y3QgaWVlZTgwMjExX3N1cHBvcnRlZF9iYW5kIGRvZXNuJ3QgaGF2ZSB0aGVzZSBmaWVsZHMN
Cj4gYXMgY29uc3QuIFRoZSBkaXNjYXJkaW5nIG9mIGNvbnN0IHF1YWxpZmllcnMgaXMgYXBwYXJl
bnRseSBzYWZlIGluIHRoaXMgY2FzZSwNCj4gc28gSSBjYW4gZWl0aGVyIGNhc3QgdGhlIHBvaW50
ZXJzIHRvIG5vbi1jb25zdCB3aGVuIGFzc2lnbmVkIGhlcmU6DQo+IA0KPiAgMjcwIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgaWVlZTgwMjExX3N1cHBvcnRlZF9iYW5kIHJ0dzg5X3NiYW5kXzJnaHogPSB7
DQo+ICAyNzEgICAgICAgICAuYmFuZCAgICAgICAgICAgPSBOTDgwMjExX0JBTkRfMkdIWiwNCj4g
IDI3MiAgICAgICAgIC5jaGFubmVscyAgICAgICA9IHJ0dzg5X2NoYW5uZWxzXzJnaHosDQo+ICAy
NzMgICAgICAgICAubl9jaGFubmVscyAgICAgPSBBUlJBWV9TSVpFKHJ0dzg5X2NoYW5uZWxzXzJn
aHopLA0KPiAgMjc0ICAgICAgICAgLmJpdHJhdGVzICAgICAgID0gcnR3ODlfYml0cmF0ZXMsDQo+
ICAyNzUgICAgICAgICAubl9iaXRyYXRlcyAgICAgPSBBUlJBWV9TSVpFKHJ0dzg5X2JpdHJhdGVz
KSwNCj4gIDI3NiAgICAgICAgIC5odF9jYXAgICAgICAgICA9IHswfSwNCj4gIDI3NyAgICAgICAg
IC52aHRfY2FwICAgICAgICA9IHswfSwNCj4gIDI3OCB9Ow0KPiANCg0KQWguIEkgd2FzIG5vdCBh
d2FyZSBvZiB0aGlzIHBvaW50LiBQbGVhc2Uga2VlcCBpdCBhcyB3YXMuIA0KDQo=

