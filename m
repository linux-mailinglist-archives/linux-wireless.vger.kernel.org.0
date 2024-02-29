Return-Path: <linux-wireless+bounces-4225-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEFA86BFA8
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 04:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6C31F2239C
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 03:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB4639AEF;
	Thu, 29 Feb 2024 03:53:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0789D39ADF
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 03:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709178806; cv=none; b=HxWvyF4LaM4i9D0fAZKDhNkjln9rsh3w0tUrUNJnPucRpuCoarsoh2SbJl6UoH3vFQrzLWOdXccZWTi/keCgRYVOFqjtE/n9EayoIcOcG8kP1DHwhl7flzFOD7T18EGy/J+2md/wDuXoOF0CBHk1QTPFutJWGr/tm1d+Uh7s6Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709178806; c=relaxed/simple;
	bh=pD67QRGtdpcHpJZ/h4HvuybyzCL+ZrnBPAkbxyPN5kM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m+1mqBzsJBHJLP0WkDLYPOs2THYg8Sk4ua9fKCp5SIZIEO/l9ubgaLxPfTumyRFm3eWZW0un2BmtoaH/jw/+e6+CshK0gICReGArqaPwNrDDvi0G/tgnzO62coa/nZU+CvjKEwS4ZcPM1dXkqAOh0dvYh+bHKFivgNZ/Kt4qODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41T3rKmaD1110074, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41T3rKmaD1110074
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 11:53:20 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 29 Feb 2024 11:53:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 11:53:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Thu, 29 Feb 2024 11:53:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 4/4] wifi: rtw88: 8821c: Fix false alarm count
Thread-Topic: [PATCH 4/4] wifi: rtw88: 8821c: Fix false alarm count
Thread-Index: AQHaaXdsz0WVrUQFRkyEQ2XeMOU9uLEgsqgg
Date: Thu, 29 Feb 2024 03:53:20 +0000
Message-ID: <2eb16c4010174954a51f77bacfb53976@realtek.com>
References: <909d9f75-44cd-4710-9d3f-56691fd58090@gmail.com>
 <38e3d94e-0cab-4a43-be10-c15ff5387919@gmail.com>
In-Reply-To: <38e3d94e-0cab-4a43-be10-c15ff5387919@gmail.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDI3
LCAyMDI0IDg6MjEgUE0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBD
YzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCA0
LzRdIHdpZmk6IHJ0dzg4OiA4ODIxYzogRml4IGZhbHNlIGFsYXJtIGNvdW50DQo+IA0KPiBNYWtl
IGRtX2luZm8tPnRvdGFsX2ZhX2NudCB0aGUgc3VtIG9mIGNja19mYV9jbnQgYW5kIG9mZG1fZmFf
Y250LA0KPiBub3QganVzdCBvZmRtX2ZhX2NudC4NCj4gDQo+IEZpeGVzOiA5NjAzNjEyMzhiODYg
KCJydHc4ODogODgyMWM6IGFkZCBmYWxzZSBhbGFybSBzdGF0aXN0aWNzIikNCj4gU2lnbmVkLW9m
Zi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFja2Vk
LWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

