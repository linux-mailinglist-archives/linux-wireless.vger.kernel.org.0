Return-Path: <linux-wireless+bounces-5073-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22957881B73
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 04:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB201F221DA
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 03:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9676C7462;
	Thu, 21 Mar 2024 03:23:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA431C05
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 03:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710991424; cv=none; b=jJYz7Xt/jF0sxld5eD3ik6KC7VGPewmaFhgPhnJMCEnHE8DtTWlTqdYUDUhEttq69Y9Maq6peJopaNK4NnJy6Yi3ZmZRQ9QGMIUfmBCV23sxgLuyjWJTeoY6XKdjdBNazQHR/PJMG0v5TT6CQssuvj+bc8y8h3AP3wovYRBdDIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710991424; c=relaxed/simple;
	bh=1vSap6uGVRfSB6Lw6lHI3Lesxil1p/+rEUBjM49DO8A=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=p+xrJcrEYWGff4e83LepdcDPFboB6V+KyfrVxVNt8fOAfbVCaLDdA5ti6NQ7KceGVnar6Y17swQ2XQ/EMiia+8ch50LqGPLJlvVG4OAVrcLIszd19Um4XPoI3hidu4VtNVLtjPr7IwRZUHC7RT7BE/x0NYMReA6VBZBx0EIcgQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42L3NMUw8854128, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42L3NMUw8854128
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 11:23:22 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 11:23:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 11:23:22 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Thu, 21 Mar 2024 11:23:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Timlee
	<timlee@realtek.com>,
        "fiona.klute@gmx.de" <fiona.klute@gmx.de>
Subject: pull request: rtw: update/add firmware of Realtek WiFi 8703B, 8852C and 8922A
Thread-Topic: pull request: rtw: update/add firmware of Realtek WiFi 8703B,
 8852C and 8922A
Thread-Index: AQHaez8gfXswwKPojk2NYPBw/+RTQg==
Date: Thu, 21 Mar 2024 03:23:22 +0000
Message-ID: <063c9937acb36ccf352056d212a9a2733abb9dd5.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <276027C930F13F42896FC5AA023AC95F@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGksDQoNCkFkZC91cGRhdGUgdGhyZWUgZmlybXdhcmUgaW5jbHVkaW5nIA0KDQogLSBhZGQgaW5p
dGlhbCBmaXJtd2FyZSB2MTEuMC4wIGZvciA4NzAzDQogLSB1cGRhdGUgODg1MkMgdG8gdjAuMjcu
NTYuMTQNCiAtIGFkZCBpbml0aWFsIGZpcm13YXJlIHYwLjM1LjE4LjAgZm9yIDg5MjJBDQoNClRo
YW5rIHlvdQ0KUGluZy1LZQ0KDQotLS0NClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21t
aXQgMjJlZTFkOGNhNjY2M2NhN2MyODQ3NzU4MTk5M2Q2ZWQ1Y2M1NDMyMzoNCg0KICBNZXJnZSBi
cmFuY2ggJ3JvYm90L3ByLTAtMTcxMDg2MTE2NCcgaW50byAnbWFpbicgKDIwMjQtMDMtMTkgMTk6
MDc6MTQgKzAwMDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0K
DQogIGh0dHBzOi8vZ2l0aHViLmNvbS9wa3NoaWgvbGludXgtZmlybXdhcmUuZ2l0IEhFQUQNCg0K
Zm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDA4MjU5ZTdmMTdmNTUzZDVmOTg1YTUzMGY4
MjVhYzhhZDZmNDg0NTA6DQoNCiAgcnR3ODk6IDg4NTJjOiB1cGRhdGUgZncgdG8gdjAuMjcuNTYu
MTQgKDIwMjQtMDMtMjEgMTE6MDI6MzIgKzA4MDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkNoaW4tWWVuIExlZSAo
MSk6DQogICAgICBydHc4OTogODg1MmM6IHVwZGF0ZSBmdyB0byB2MC4yNy41Ni4xNA0KDQpGaW9u
YSBLbHV0ZSAoMSk6DQogICAgICBydHc4ODogQWRkIFJUTDg3MDNCIGZpcm13YXJlIHYxMS4wLjAN
Cg0KUGluZy1LZSBTaGloICgxKToNCiAgICAgIHJ0dzg5OiA4OTIyYTogYWRkIGZpcm13YXJlIHYw
LjM1LjE4LjANCg0KIFdIRU5DRSAgICAgICAgICAgICAgICAgICAgfCAgMTIgKysrKysrKysrLS0t
DQogcnR3ODgvUkVBRE1FICAgICAgICAgICAgICB8ICAgMyArKysNCiBydHc4OC9ydHc4NzAzYl9m
dy5iaW4gICAgIHwgQmluIDAgLT4gMjAyOTAgYnl0ZXMNCiBydHc4OC9ydHc4NzAzYl93b3dfZncu
YmluIHwgQmluIDAgLT4gMjMwNzQgYnl0ZXMNCiBydHc4OS9ydHc4ODUyY19mdy5iaW4gICAgIHwg
QmluIDE1MzI3MzYgLT4gMTUzMjY1NiBieXRlcw0KIHJ0dzg5L3J0dzg5MjJhX2Z3LmJpbiAgICAg
fCBCaW4gMCAtPiAxNTM3NjkwIGJ5dGVzDQogNiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBydHc4OC9ydHc4NzAzYl9m
dy5iaW4NCiBjcmVhdGUgbW9kZSAxMDA2NDQgcnR3ODgvcnR3ODcwM2Jfd293X2Z3LmJpbg0KIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBydHc4OS9ydHc4OTIyYV9mdy5iaW4NCg0K

