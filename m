Return-Path: <linux-wireless+bounces-4037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14428686C4
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 03:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D9A1C2398D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 02:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB51EF4F1;
	Tue, 27 Feb 2024 02:19:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799311BF2A;
	Tue, 27 Feb 2024 02:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000389; cv=none; b=pSio2nx/TlTmqDIOjAMHzK5Tx4Mw2TwXVN2aYLReZ+7PUmdSXqm/MPrWSXsGH2xG1HhBxJYi+uTcS1P5GqDjL6sUQqGvzZ/SJfw1bT05u8VCABWtKBn9yR4MkvBsXMy/KsFdsOsz8fC0j0hUWi9kQ/Vi0DYjSqUi54Q7P4E8GKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000389; c=relaxed/simple;
	bh=WrJ/geYJ4m0Fzg4TIvqbTQqOY+uUZ6o7tRja06uCpvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BhyvBmmNQso8yxqTp5m4CvVqokLitUNyKSLa+NSvyMfklwfE1REGKOD0IyFi+Te4xmuiQHCMdEwZtbsri1nO2bsdP9Bvn5SM05LlN3kd6w70s+t0P1ciej/vWiq8QtXYKL7LWPV3Q9D4uPCpXjx3PNsjtL7LYDnb7z8KyWT3Rs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41R2JCbaC4098321, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41R2JCbaC4098321
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 10:19:12 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Tue, 27 Feb 2024 10:19:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 10:19:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Tue, 27 Feb 2024 10:19:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Larry Finger <Larry.Finger@gmail.com>, Kalle Valo <kvalo@kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Nick
 Morrow" <morrownr@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] wifi:rtw88: Add missing VID/PIDs
Thread-Topic: [PATCH] wifi:rtw88: Add missing VID/PIDs
Thread-Index: AQHaaR5OsMKDuxb7V0eSIsmyoISXYbEdcx8A
Date: Tue, 27 Feb 2024 02:19:10 +0000
Message-ID: <f62dde90650e42aaa43ab6a324be957d@realtek.com>
References: <4ume77rb9r8f.TVC1GJ8j2OsxjTtczJ7LwQ2@1EHFQ.trk.elasticemail.com>
In-Reply-To: <4ume77rb9r8f.TVC1GJ8j2OsxjTtczJ7LwQ2@1EHFQ.trk.elasticemail.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFycnkgRmluZ2VyIDxM
YXJyeS5GaW5nZXJAZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAyNywgMjAy
NCA5OjQxIEFNDQo+IFRvOiBLYWxsZSBWYWxvIDxrdmFsb0BrZXJuZWwub3JnPg0KPiBDYzogSm9o
YW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD47IGxpbnV4LXdpcmVsZXNzQHZn
ZXIua2VybmVsLm9yZzsgTmljayBNb3Jyb3cNCj4gPG1vcnJvd25yQGdtYWlsLmNvbT47IExhcnJ5
IEZpbmdlciA8TGFycnkuRmluZ2VyQGx3ZmluZ2VyLm5ldD47IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogW1BBVENIXSB3aWZpOnJ0dzg4OiBBZGQgbWlzc2luZyBWSUQvUElEcw0K
DQpNaXNzaW5nIGEgc3BhY2UgYmV0d2VlbiAid2lmaToiIGFuZCAicnR3ODg6IiwgYW5kIHN1Z2dl
c3QgdG8gbWVudGlvbiA4ODExQ1UNCmFuZCA4ODIxQ1UgaW4gc3ViamVjdC4gT3RoZXJzIGxvb2sg
Z29vZCB0byBtZS4gDQoNCj4gDQo+IEZyb206IE5pY2sgTW9ycm93IDxtb3Jyb3duckBnbWFpbC5j
b20+DQo+IA0KPiBQdXJwb3NlOiBBZGQgVklEL1BJRHMgdGhhdCBhcmUga25vd24gdG8gYmUgbWlz
c2luZyBmb3IgdGhpcyBkcml2ZXIuDQo+IC0gcmVtb3ZlZCAgLyogODgxMUNVICovIGFuZCAvKiA4
ODIxQ1UgKi8gYXMgdGhleSBhcmUgcmVkdW5kYW50DQo+IHNpbmNlIHRoZSBmaWxlIGlzIHNwZWNp
ZmljIHRvIHRob3NlIGNoaXBzLg0KPiAtIHJlbW92ZWQgLyogVE9UT0xJTksgQTY1MFVBIHYzICov
IGFzIHRoZSBtYW51ZmFjdHVyZXIuIEl0IGhhcyBhIFJFQUxURUsNCj4gVklEIHNvIGl0IG1heSBu
b3QgYmUgc3BlY2lmaWMgdG8gdGhpcyBhZGFwdGVyLg0KPiANCj4gU291cmNlIGlzDQo+IGh0dHBz
Oi8vMUVIRlEudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xpY2s/ZD1JODJIMFlSX1df
aDE3NUxiM05rYjBEOGk2SXF2dWhFU2UwV0xuWTZQN0lWd1IxVUt2Qg0KPiAwU1B4ZDFPbHAzUE5K
RW03aDFHZnQ4bEtGaVhxWWYxakVqbmlVbkJIVGRDaTBZcGkyWTl1Z3k4OGVHSHFiNU1COVUwTTda
YkJCYU93b2FHMGVIcGQ3M2R4VWZSY2ljZ1MzVEZCdncNCj4gMDY2c2RvSWgxSnhkckFET19ybzYw
DQo+IFZlcmlmaWVkIGFuZCB0ZXN0ZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBOaWNrIE1vcnJv
dyA8bW9ycm93bnJAZ21haWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBMYXJyeSBGaW5nZXIgPExh
cnJ5LkZpbmdlckBsd2Zpbmdlci5uZXQ+DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQoN
CkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

