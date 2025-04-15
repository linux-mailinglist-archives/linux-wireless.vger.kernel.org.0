Return-Path: <linux-wireless+bounces-21523-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7D0A89253
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 04:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB43F189C402
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 02:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B5571747;
	Tue, 15 Apr 2025 02:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="eOQaNF/A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD7E214A7A
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 02:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685689; cv=none; b=o6S7BXFsCmqGgQE1bUosx561MTY0Hi+IID3IaAt0vliA9sxWVeRpz2fkF4NwLXx3Uc7Oh8eobgGyXIA6EThu7LgkqRC3NKUSwWO2V6eScfWLuhKPTNUfi0EeadPBBQVkyeX6FS/6Z3bdE/UJ675aqSwkUwOzMI5E84VFY4fg9N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685689; c=relaxed/simple;
	bh=OG7k6E4tEYVDcstB3fQIJAYvAFNVDw+pP3BVQBVaAE8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O/lDVSOZiYPqxPgcELdkVVnlzpr71LsL2aV4ED6/Afl+RFmOTv/FKkNAnO8PJr9dsc0odn9WMLWFsAakr10VgkHaUfiocLDvFQRz2lqWIQjvZy8ITCtkC4jaXplAe4ZJzi6YuIDhFA/1fOI3QnGaht62ObVZEKXI3C4LEw5atGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=eOQaNF/A; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53F2sSWM1477963, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744685668; bh=OG7k6E4tEYVDcstB3fQIJAYvAFNVDw+pP3BVQBVaAE8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=eOQaNF/A+N90Lek7XgCjGjSCsuhM4AK+Re0iPMgJJz5oND0+i/DYrwEGKgm0ixplv
	 vtJliJ8Bbnx/HCwfyvTWRZOHqUeyCbm2VPLnNyDkMmdl3LPMxgLLK0tWeW865MVoS3
	 Zk8gPLpK+eqLH0cl74ybp8LXcwf5v2mGMwq07PbqTOba9o8ZhiGDNvkg9iQO30c00Z
	 Qg+JViZNa+UOjinTEhf6MDTvJS6M/039T4Wng+OAzqXR4sDLDEXclkkRbQjU4UTgqx
	 zdZR89S3CS+hMl5zDnlhkV/dx2lCphsK2Fo6Sumy2DZo5BVKTsTUDR2gwQsaqPPVCg
	 ILHnrzocE6dWw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53F2sSWM1477963
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 10:54:28 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Apr 2025 10:54:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 15 Apr 2025 10:54:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 15 Apr 2025 10:54:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: Using check_hw_ready() through rtw88
Thread-Topic: Using check_hw_ready() through rtw88
Thread-Index: AQHbrSYCBz3jLZ+PdkeRkB8xZ3UQQrOkCBNQ
Date: Tue, 15 Apr 2025 02:54:27 +0000
Message-ID: <679950c1c1d04ccb99a46656c48d8a14@realtek.com>
References: <0cf73d37-fe94-4d3c-8450-a62c047c5138@yandex.ru>
In-Reply-To: <0cf73d37-fe94-4d3c-8450-a62c047c5138@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

RG1pdHJ5IEFudGlwb3YgPGRtYW50aXBvdkB5YW5kZXgucnU+IHdyb3RlOg0KPiANCj4gSSd2ZSBu
b3RpY2VkIHRoYXQgcnR3ODgyMmNfZHBrX2NhbF9jb2VmMSgpIGlzIHRoZSBvbmx5IHBsYWNlIHdo
ZXJlDQo+IHRoZSB2YWx1ZSByZXR1cm5lZCBieSBjaGVja19od19yZWFkeSgpIGlzIHNpbGVudGx5
IGlnbm9yZWQ7IGlzIGl0DQo+IGFsd2F5cyBzYWZlIGZvciB0aGUgcmVzdCBvZiB0aGUgZHJpdmVy
Pw0KPiANCg0KVGhhdCBtZWFucyBSRiBjYWxpYnJhdGlvbiBnb2VzIGludG8gdW5leHBlY3RlZCBz
dGF0ZSwgc28gdGhlIHBlcmZvcm1hbmNlDQptaWdodCBiZSBub3QgdGhlIGJlc3QuIE1heWJlIHRo
cm93aW5nIGEgbWVzc2FnZSBpcyBlbm91Z2ggZm9yIHRoZSBjYXNlLg0KDQoNCg==

