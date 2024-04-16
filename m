Return-Path: <linux-wireless+bounces-6369-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057D38A63C2
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 08:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36DC81C20A24
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 06:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EB3EEAB;
	Tue, 16 Apr 2024 06:31:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB0635280
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249099; cv=none; b=t46JUX4Bdw2RRRAhRI4SkcLIk7X31Bs3YKsnsuiDQDCObUxZQIdJlcVFx7gshFGGsBw8cqBu57Wtf+Cm7SPHPwwdibAOm2ay45wa+5T/ICEXoSui++PRxuhcSlQfi74MoVniIlbnpZdl5p0yiTx1KMlyTmdqia1FGoYkiXbMYLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249099; c=relaxed/simple;
	bh=X1S4JvszNBA/V11HCjnSWYu1c03/8j4j7/Y/NBXEgaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ibN8MkeGiQOkYM93AyeQcxDVIqRCbCmJOS5FQ/IhTQiKlaluDdC7wyV9KFQ64JNiH1+xWJlPbUYvt27Gnl49OeyPovLMUVkmAPRzPINHZsJePhA+kwfoA1W708ccKPZ1aWhNCxxQN3TgDQzr3xy6YNrcYPhyLeGnTnpnk+0oi74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43G6VVppC1919772, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43G6VVppC1919772
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 14:31:31 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 14:31:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 14:31:31 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 16 Apr 2024 14:31:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v2] wifi: rtl8xxxu: Fix the TX power of RTL8192CU, RTL8723AU
Thread-Topic: [PATCH v2] wifi: rtl8xxxu: Fix the TX power of RTL8192CU,
 RTL8723AU
Thread-Index: AQHaj3fEQwqjtaY86kStlNWOaDdCJLFqZzHA
Date: Tue, 16 Apr 2024 06:31:30 +0000
Message-ID: <c2e6f267654a495984a9b853105ec168@realtek.com>
References: <6ae5945b-644e-45e4-a78f-4c7d9c987910@gmail.com>
In-Reply-To: <6ae5945b-644e-45e4-a78f-4c7d9c987910@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
RG9uJ3Qgc3VidHJhY3QgMSBmcm9tIHRoZSBwb3dlciBpbmRleC4gVGhpcyB3YXMgYWRkZWQgaW4g
Y29tbWl0DQo+IDJmYzBiOGU1YTE3ZCAoInJ0bDh4eHh1OiBBZGQgVFggcG93ZXIgYmFzZSB2YWx1
ZXMgZm9yIGdlbjEgcGFydHMiKQ0KPiBmb3IgdW5rbm93biByZWFzb25zLiBUaGUgdmVuZG9yIGRy
aXZlcnMgZG9uJ3QgZG8gdGhpcy4NCj4gDQo+IEFsc28gY29ycmVjdCB0aGUgY2FsY3VsYXRpb25z
IG9mIHZhbHVlcyB3cml0dGVuIHRvDQo+IFJFR19PRkRNMF9Ye0MsRH1fVFhfSVFfSU1CQUxBTkNF
LiBBY2NvcmRpbmcgdG8gdGhlIHZlbmRvciBkcml2ZXIsDQo+IHRoZXNlIGFyZSB1c2VkIGZvciBU
WCBwb3dlciB0cmFpbmluZy4NCj4gDQo+IFdpdGggdGhlc2UgY2hhbmdlcyBydGw4eHh4dSBzZXRz
IHRoZSBUWCBwb3dlciBvZiBSVEw4MTkyQ1UgdGhlIHNhbWUNCj4gYXMgdGhlIHZlbmRvciBkcml2
ZXIuDQo+IA0KPiBOb25lIG9mIHRoaXMgYXBwZWFycyB0byBoYXZlIGFueSBlZmZlY3Qgb24gbXkg
UlRMODE5MkNVIGRldmljZS4NCg0KSUlSQyBUWCBwb3dlciBpcyBpbiB1bml0IG9mIDAuNSBkQm0s
IHNvIHRoYXQgd291bGQgbm90IGJlIHNpZ25pZmljYW50IHRvDQp0aHJvdWdocHV0LiANCg0KPiAN
Cj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1
ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkkgY2hlY2tlZCBsb2dpYyBvZiBj
aGFuZ2VzIGlzIHRoZSBzYW1lIGFzIHZlbmRvciBkcml2ZXIgbm93LiANCg0KUmV2aWV3ZWQtYnk6
IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCg==

