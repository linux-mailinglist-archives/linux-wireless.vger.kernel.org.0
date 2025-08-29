Return-Path: <linux-wireless+bounces-26848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C5DB3B299
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 07:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E281C20299
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 05:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3021F5434;
	Fri, 29 Aug 2025 05:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="iGDPvR1K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB701401B
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 05:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445939; cv=none; b=JnPYBsIS+INetB1mP5HxY9Q0FAYws/xzW9V5nQPq8xwGIAtSC6uHw64b9xVRlOpx0cUvg8C0z4jenMC9EiYaTS+xpkuqwos8maBTuCvtQWFpOsxmOcY6ZHyZmQe1GqyeAqask677kWGAW4JFx13y6taj/KFNPRytbU50HChpvko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445939; c=relaxed/simple;
	bh=HtUfnbeUHnzkSNvD8K8uw3vu4VZSzVa2CL3omBXE22o=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FKPJg5YLVZBhTmW6hl8f5nis6Zbs+rEhIffJF8AdTrI0YZghzBSPIoL759nt8Ia88FKL8KnyHqrPGp6K2gfql+fxUlPpXleR62X6JNcjZs5pmjccJ/82VDMYtK0cyPVRR6ZcK5Ddb7vgGzqC8/XQiptL3VJlozAsC/h9rBkpgM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=iGDPvR1K; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57T5cmsfF3071559, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756445928; bh=HtUfnbeUHnzkSNvD8K8uw3vu4VZSzVa2CL3omBXE22o=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=iGDPvR1Kj74kJQYCOXPAo5/rSmhKArVuRRh1dmocuZPnMF+psGvaDqou122P+G3Eo
	 gjroDY/LDeoiQRAL+lql0jSnkjZ3cLecEA0wOApD99xr1vtJD92Or6TAR26mcSvNPT
	 mI+ZO+XGIQIfEbFWbSINlk31507vlVPCpBZjg7FTF/5zaBolvPk7g5LaqMQHfvThOj
	 1f2TIeEQQ+JQotJuP4a/42Wghj+J4R+pgjM5C6HhjQD4YYiBIIZMV5w0MyVfw0HnvC
	 90G7NoNFZ9uDpiwfjlHvs3uCzLpL8g9C+AT+AF/TCn3zekP+d0XNhOeK71s0xXePy7
	 vLd86kyIzxoYQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57T5cmsfF3071559
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 13:38:48 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 29 Aug 2025 13:38:48 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 29 Aug 2025 13:38:48 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Fri, 29 Aug 2025 13:38:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: oldherl <oldherl@archlinuxcn.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: Possible Regression of RTL8852BE on linux-firmware-realtek
Thread-Topic: Possible Regression of RTL8852BE on linux-firmware-realtek
Thread-Index: AQHcGKFX8JNSoDTnmkyK6CXXtzDeBLR5HJmA
Date: Fri, 29 Aug 2025 05:38:48 +0000
Message-ID: <c85ca611f0d74d2eb8bc400ebaaadb9b@realtek.com>
References: <2082485.tdWV9SEqCh@alphecca>
In-Reply-To: <2082485.tdWV9SEqCh@alphecca>
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

b2xkaGVybCA8b2xkaGVybEBhcmNobGludXhjbi5vcmc+IHdyb3RlOg0KPiBJIGFtIHVzaW5nIHJl
YWx0ZWsgUlRMODg1MkJFIG9uIGEgbGFwdG9wLg0KPiBBZnRlciBhIHJlY2VudCB1cGRhdGUgb2Yg
dGhlIGZpcm13YXJlLCB0aGUgd2lmaSBkaXNjb25uZWN0cyBvZnRlbi4NCj4gDQo+IEkgYW0gdXNp
bmcgQXJjaCBMaW51eCBhbmQgY29uZmlybSB0aGF0IHRoZSBnb29kIHZlcnNpb24gb2YgZmlybXdh
cmUNCj4gYmVmb3JlIHVwZGF0ZSB3YXMgbGludXgtZmlybXdhcmUtcmVhbHRlayAyMDI1MDcwOC0x
Lg0KPiBydHc4OV84ODUyYmUgMDAwMDowMTowMC4wOiBMb2FkZWQgRlc6IHJ0dzg5L3J0dzg4NTJi
X2Z3LTEuYmluLCBzaGEyNTY6DQo+IDgxYzE0NjQwNmRjZTQ3Y2ZkZjcxOWY4OGQwZmRiMTNiNzVj
ZmI2NTEyMjY2NTA3MjIyODBhYjgxZjdlMzMxZjINCj4gDQo+IFRoZSBiYWQgdmVyc2lvbiBhZnRl
ciB1cGRhdGUgaXMgbGludXgtZmlybXdhcmUtcmVhbHRlayAyMDI1MDgwOC0xDQo+IHJ0dzg5Xzg4
NTJiZSAwMDAwOjAxOjAwLjA6IExvYWRlZCBGVzogcnR3ODkvcnR3ODg1MmJfZnctMS5iaW4sIHNo
YTI1NjoNCj4gOTUwNzZkNmQxMjg2OTViMjk4MzBlOGEwZTVlZmJkMGFmNjBhNTU5MGFkMzdiYmQ4
NTkxYTAyODE5NTJhNjFkZQ0KPiANCj4gVGhlIGNvbW1pdCBvZiB0aGUgZmlybXdhcmUgdXBkYXRl
IGlzDQo+IGh0dHBzOi8vZ2l0bGFiLmNvbS9rZXJuZWwtZmlybXdhcmUvbGludXgtZmlybXdhcmUv
LS9jb21taXQvDQo+IGViMDNjOGNlNTk1ZDc1ZjJhMmY4MWNiZTg3Njk4YzI1MzlmNjQzNzcNCj4g
DQo+IEkgd2FzIHVzaW5nIHRoZSBsaW51eCA2LjE2LjEuYXJjaDEtMSBrZXJuZWwgZm9yIGJvdGgg
YXR0ZW1wdHMuDQoNCkRpZCB5b3UgdXNlIEJsdWV0b290aCB0b28/IFBsZWFzZSB0cnkgNi4xNy1y
YyB0byBzZWUgaWYgaXQgY2FuIGltcHJvdmUuDQoNCj4gDQo+IFBvc3NpYmxlIHJlbGF0ZWQgbG9n
IG91dDoNCj4gWyAzNDU1Ljg3NzQ2OV0gcnR3ODlfODg1MmJlIDAwMDA6MDE6MDAuMDogdGltZWQg
b3V0IHRvIGZsdXNoIHBjaSB0eGNoOiAwDQo+IFsgMzQ1Ni4wODEwMTBdIHJ0dzg5Xzg4NTJiZSAw
MDAwOjAxOjAwLjA6IHRpbWVkIG91dCB0byBmbHVzaCBxdWV1ZXMNCj4gWyAzNDU2LjE0NzI1Ml0g
cnR3ODlfODg1MmJlIDAwMDA6MDE6MDAuMDogdGltZWQgb3V0IHRvIGZsdXNoIHBjaSB0eGNoOiAw
DQo+IFsgMzQ1Ni4zNTIxMDZdIHJ0dzg5Xzg4NTJiZSAwMDAwOjAxOjAwLjA6IHRpbWVkIG91dCB0
byBmbHVzaCBxdWV1ZXMNCj4gWyAzNDU2LjM3MTM0MF0gcnR3ODlfODg1MmJlIDAwMDA6MDE6MDAu
MDogdGltZWQgb3V0IHRvIGZsdXNoIHBjaSB0eGNoOiAwDQo+IFsgMzQ1Ni41NzY2NjFdIHJ0dzg5
Xzg4NTJiZSAwMDAwOjAxOjAwLjA6IHRpbWVkIG91dCB0byBmbHVzaCBxdWV1ZXMNCj4gWyAzNDU2
LjU4OTY5OF0gcnR3ODlfODg1MmJlIDAwMDA6MDE6MDAuMDogdGltZWQgb3V0IHRvIGZsdXNoIHBj
aSB0eGNoOiAwDQo+IA0KPiBJIGFtIGFsc28gcG9zdGluZyB0aGUgYnVnIHRvIEFyY2ggTGludXgg
YnVnIHRyYWNrZXI6DQo+IGh0dHBzOi8vZ2l0bGFiLmFyY2hsaW51eC5vcmcvYXJjaGxpbnV4L3Bh
Y2thZ2luZy9wYWNrYWdlcy9saW51eC1maXJtd2FyZS8tLw0KPiBpc3N1ZXMvMjYNCg0KDQo=

