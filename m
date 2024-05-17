Return-Path: <linux-wireless+bounces-7752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5649F8C7F2F
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 02:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8687D1C215E2
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 00:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E6E4A3E;
	Fri, 17 May 2024 00:29:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5014A07
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715905745; cv=none; b=o7yl47Ev8vGcc4drGdEQva7qXWEgbflP01nzqH6BJTVD07yVeidawbgMjJxgAEEK93LsKZLYt9y1pEY8RXPPUZlVGVGmXf7MfvvK8gtXcylEGEI2spDzAANo/ygpooDJ0XqbL9bAk3P7kUxV2+P4xZ2QLnn6ze0X++mmOycz2dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715905745; c=relaxed/simple;
	bh=y3APD8TTlv2afSoSTFCpNRf1S5Mh6aOCe724RWigv8M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rC0iBICPYT9orDcs81wDGs15fPOu3fuORKH5jhnLPmpiJ2Tfmi7cOg6kMkhcr4ieSTgzxxl2wfH6z4WcotpT/nlcz5UWpHXdfreOAXpGqmzpOY4oLzRTOnjt97oht/UlDiYrvDdHX6vM7nFdO/6U/5uaJKgXQTfM0PE2ojh5M6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44H0SwRiA1755239, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44H0SwRiA1755239
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 08:28:58 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 17 May 2024 08:28:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 08:28:58 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 17 May 2024 08:28:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kurt Grutzmacher <grutz@jingojango.net>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: No packets in monitor mode with rtw89_8852ce
Thread-Topic: No packets in monitor mode with rtw89_8852ce
Thread-Index: AQHap6yrIao/b7yDAEuOFQV0lEFL1LGakn6Q
Date: Fri, 17 May 2024 00:28:58 +0000
Message-ID: <c8fd2e5a096748d0aec9adcc6b294fdc@realtek.com>
References: <CAMDnkSkWQqQN-cimuJ--XFEJbdNPJK_z7hocskSaBQbnH+tW=g@mail.gmail.com>
In-Reply-To: <CAMDnkSkWQqQN-cimuJ--XFEJbdNPJK_z7hocskSaBQbnH+tW=g@mail.gmail.com>
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

S3VydCBHcnV0em1hY2hlciA8Z3J1dHpAamluZ29qYW5nby5uZXQ+IHdyb3RlOiANCj4gVXNpbmcg
YSBSZWFsdGVrIDg4NTJjZSBtb2R1bGUgaW4gbW9uaXRvciBtb2RlIG9uIFVidW50dSAyMi4wNCBM
VFMgSSBhbQ0KPiBhYmxlIHRvIGNhcHR1cmUgZnJhbWVzIG9uIDIuNCBHSHogY2hhbm5lbHMgYnV0
IG5vdCBhbnkgb3RoZXINCj4gZnJlcXVlbmNpZXMuIExvdyBwb3dlciBtb2RlIGlzIGRpc2FibGVk
Lg0KPiANCj4gWzk4ODY5LjQ3MTAwMV0gcnR3ODlfODg1MmNlIDAwMDA6MDI6MDAuMDogbG9hZGVk
IGZpcm13YXJlIHJ0dzg5L3J0dzg4NTJjX2Z3LmJpbg0KPiBbOTg4NjkuNDgwMTIxXSBydHc4OV84
ODUyY2UgMDAwMDowMjowMC4wOiBGaXJtd2FyZSB2ZXJzaW9uIDAuMjcuNTYuMTQsDQo+IGNtZCB2
ZXJzaW9uIDAsIHR5cGUgMQ0KPiBbOTg4NjkuNDgwMTQyXSBydHc4OV84ODUyY2UgMDAwMDowMjow
MC4wOiBGaXJtd2FyZSB2ZXJzaW9uIDAuMjcuNTYuMTQsDQo+IGNtZCB2ZXJzaW9uIDAsIHR5cGUg
Mw0KPiBbOTg4NjkuNzU3MDQxXSBydHc4OV84ODUyY2UgMDAwMDowMjowMC4wOiBjaGlwIHJmZV90
eXBlIGlzIDENCj4gDQo+IHVidW50dUB1YnVudHU6fiQgc3VkbyBpdyByZWFsdGVrd2lmaTAgc2V0
IGZyZXEgMjQxMg0KPiB1YnVudHVAdWJ1bnR1On4kIHN1ZG8gdGNwZHVtcCAtaSByZWFsdGVrd2lm
aTANCg0KTXkgODg1MmNlIGlzIHdsYW4xLCBhbmQgdGhlbiBiZWxvdyBpbnN0cnVjdGlvbnMgY2Fu
IHNob3cgdXAgc29tZSBwYWNrZXRzOiANCg0Kc3VkbyBpdyBkZXYgd2xhbjEgaW50ZXJmYWNlIGFk
ZCBtb24wIHR5cGUgbW9uaXRvcg0Kc3VkbyBpZmNvbmZpZyBtb24wIHVwDQpzdWRvIHRjcGR1bXAg
LWkgbW9uMA0KDQoNCg==

