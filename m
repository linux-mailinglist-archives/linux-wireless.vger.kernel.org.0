Return-Path: <linux-wireless+bounces-6357-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 896AC8A610F
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 04:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7911F21CE0
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 02:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957DAA35;
	Tue, 16 Apr 2024 02:31:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233A9A34
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 02:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713234704; cv=none; b=tfd000V06vgRoPnlaVa1Oae4itX5MnA28S5VQVd/Lq2e9kNo8RBtyYEJbewVwPCBx+dReQJgRLADqrkUm88khAyKOeY4edffXVGK6VBhRv0c7wgW2wGKQ+NhuHrW1BFPl/Y+i9bY2LswWZFky41VM/suf1kf7PB1FkyEkXfc9yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713234704; c=relaxed/simple;
	bh=Q2UuYGvdJkkp8CtuRON0NixyuQVh7SPapOyi+vU+G1I=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NEkVm6unmSvHiBhPw4kpMsILHURyU5RQctBQdbwpBSq8mynJjn+0DW3T3t92Do0VBa1EMSodkx70vR9ZPLMAHGLbuYkAQNbvG3EiZbFRo8DjyfTn5DhIVdB2Sjz16EQ0NW61f1XC+PnVzI9fOYYkP9Ew+hSr1K0fsly/F9pQRJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43G2VThJ41736597, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43G2VThJ41736597
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 10:31:29 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 10:31:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 10:31:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 16 Apr 2024 10:31:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Plamen Dimitrov <plamen.dimitrov@pevogam.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Problems with RTL8852BE PCIe 802.11ax Wireless Network Controller and Linux kernel 6.7.7-100.fc38.x86_64
Thread-Topic: Problems with RTL8852BE PCIe 802.11ax Wireless Network
 Controller and Linux kernel 6.7.7-100.fc38.x86_64
Thread-Index: AQHajxBK3TMYBDJJU02LKax8Cy6TM7FphqBQgAAfJYCAAAJakA==
Date: Tue, 16 Apr 2024 02:31:28 +0000
Message-ID: <efc3e8306e1b417cbb779109a4a5ff54@realtek.com>
References: <7833fd15-5875-40b8-a20b-a68fa92f814f@pevogam.com>
 <2e67ec1dfc8b420bab05dc025c7c59cf@realtek.com>
 <f8e3d8c6-11ef-4dff-8c4e-d10e8a4006aa@pevogam.com>
In-Reply-To: <f8e3d8c6-11ef-4dff-8c4e-d10e8a4006aa@pevogam.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

UGxhbWVuIERpbWl0cm92IDxwbGFtZW4uZGltaXRyb3ZAcGV2b2dhbS5jb20+IHdyb3RlOg0KDQo+
IA0KPiBJbmRlZWQsIEkgaGFkIHRyaWVkIHRoaXMgYmVmb3JlIGJ1dCBkaWQgbm90IGluY2x1ZGUg
aXQgaW4gbXkgcmVwb3J0LiBOb3cgSSBkZWNpZGVkIHRvIHJlZG8gZXZlcnl0aGluZw0KPiBqdXN0
IGluIGNhc2UgYW5kIHRoZSBXaUZpIHN0aWxsIGRpc2FwcGVhcnMgd2l0aGluIGEgZmV3IG1pbnV0
ZXMgd2l0aCBsb2dzIGxpa2UNCg0KRGlkIHlvdSBtZWFuIGl0IHdvcmtzIGluaXRpYWxseSBidXQg
V2lGaSBnb3QgbG9zdCBhZnRlciBhIHdoaWxlPw0KUGxlYXNlIGF0dGFjaCB5b3VyIGZ1bGwgbG9n
IGZyb20gYm9vdCAodmlhIHByaXZhdGUgbWFpbCBpZiB5b3UgaGF2ZSBjb25jZXJuKS4NCg0KQW5v
dGhlciB0cnkgaXMgdG8gZGlzYWJsZSBwb3dlciBzYXZlIGJ5ICdpdycgY29tbWFuZCByaWdodCBh
ZnRlciBib290aW5nLCBsaWtlDQogIHN1ZG8gaXcgd2xhbjAgc2V0IHBvd2VyX3NhdmUgb2ZmIA0K
DQoNCg==

