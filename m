Return-Path: <linux-wireless+bounces-8033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65AA8CDEED
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 02:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F9C1F2166C
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 00:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959CA7FB;
	Fri, 24 May 2024 00:36:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAFD36D;
	Fri, 24 May 2024 00:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716511006; cv=none; b=DlLP8DMGsUWJULmUooDJCzwm0n48h0jso4xWU4joCPC4Cv5Yrar/9REYqD9b3AVHgnOlrfZnyb8uo0j9pfLh00iQ0X4y5nIY0dKA8gj7vRM55xvRLh6E7//aX/H/e+HbNUofDFh3OS9dw+gtYwIi9TBF7kgOoWL68HFe9FyzHbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716511006; c=relaxed/simple;
	bh=JdMmuZbKXPkOidcdB/87y1uuTORyZPwXg3doRxtxYgk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fVfsX48v2spjZwA0/s5eqx/R3ZV3wdpgCVd5Hx6CHUrNrWElmfvwlZp3YEwCbFkWrJGKvE0zdN8Ev2y2X/cUe8u0PCt7kNYadLYYtjCm+gowAgjcxsi5GNautc/JPS5fmzGQjPfcaFFhK/9JdLv469UJfKYtNZjNw7NwHiTlqqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44O0aXlfD1489359, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44O0aXlfD1489359
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 08:36:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 08:36:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 24 May 2024 08:36:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 24 May 2024 08:36:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Shichao Lai <shichaorai@gmail.com>, Kalle Valo <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: RE: INFO: trying to register non-static key in skb_dequeue
Thread-Topic: INFO: trying to register non-static key in skb_dequeue
Thread-Index: AQHarBxzMJWY0Vu27kehlktUAsNdF7GkIKiggAA0AwCAATc1MA==
Date: Fri, 24 May 2024 00:36:33 +0000
Message-ID: <b5a61acb12f0401f8077c677d53f8fa7@realtek.com>
References: <CAEk6kZuuezkH1dVRJf3EAVZK-83=OpTz62qCugkpTkswj8JF6w@mail.gmail.com>
 <54dbdd605bca48a68ae9a7423b4c994f@realtek.com>
 <CAEk6kZtsmKrvSEsPmH_5yYdqzZtAqubyh7qe7jaXBe6sz2nPrg@mail.gmail.com>
In-Reply-To: <CAEk6kZtsmKrvSEsPmH_5yYdqzZtAqubyh7qe7jaXBe6sz2nPrg@mail.gmail.com>
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

U2hpY2hhbyBMYWkgPHNoaWNoYW9yYWlAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IEl0IHNlZW1z
IHRvIHdvcmsgY29ycmVjdGx5ISBObyB3YXJubmluZyBvY2N1cnMuDQo+IElmIHlvdSBhcmUgdG8g
YWRkIGEgcGF0Y2gsIHBsZWFzZSBhZGQgdGhlIGZvbGxvd2luZyB0YWcgdG8gdGhlIGNvbW1pdDoN
Cj4gUmVwb3J0ZWQtYnk6IFNoaWNoYW8gTGFpIDxtYWlsdG86c2hpY2hhb3JhaUBnbWFpbC5jb20+
DQoNCkFkZGVkLCBhbHNvIGFkZGVkIFRlc3RlZC1ieSBbMV0uDQoNClsxXSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC13aXJlbGVzcy8yMDI0MDUyNDAwMzI0OC41OTUyLTEtcGtzaGloQHJl
YWx0ZWsuY29tL1QvI3UNCg0K

