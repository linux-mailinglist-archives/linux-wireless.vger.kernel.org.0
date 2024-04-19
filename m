Return-Path: <linux-wireless+bounces-6548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7DC8AA706
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 04:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729A82826E6
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 02:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD3010E3;
	Fri, 19 Apr 2024 02:44:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D86EC2
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 02:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713494673; cv=none; b=FXAP5bmswQ3wSPby2mNYMYBIRAnckK5FpJ9KnX/52kvw7g18HGE/3/+QAOeRKJEC5giGaqeP+al+45f/dMq2o7N21MJ617K6zk9z9BEV2H6GVm5MpPlpnTlmCHY7UoNsmlZIkROKfrBfcl0auyfgpyj1yUNGr3izDCc23qkyfdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713494673; c=relaxed/simple;
	bh=uUPsKjR/kb86xxnOxDQyYyBr/UFtvo3nkPmTxkQTRwU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IdtpEhjLeMgDG37lZs+j6/4KWFtde7wpjvr49TspxQJEDLiwzC4jfysMiVvAdn0bPAX84NNjyH+DcFwLTZaPiCtq4tU0scngf46CEdwfKJyfYK5YGt8mESop5gm7FCRAHb4Tg/ocnbGuCsY/LxWZfy9GcKwyVYbKSJsh+RTgQGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43J2iQtG5933451, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43J2iQtG5933451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 10:44:26 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 10:44:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 10:44:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 19 Apr 2024 10:44:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 1/2] wifi: rtl8xxxu: Add separate MAC init table for RTL8192CU
Thread-Topic: [PATCH 1/2] wifi: rtl8xxxu: Add separate MAC init table for
 RTL8192CU
Thread-Index: AQHakdwkKoR9kNIsXkmGAsctQFpfOLFu4pFA
Date: Fri, 19 Apr 2024 02:44:25 +0000
Message-ID: <a9ede460e23e476b97da9f71c026b88c@realtek.com>
References: <a53ed8b9-27fc-4871-a20a-ad42c6d210d3@gmail.com>
In-Reply-To: <a53ed8b9-27fc-4871-a20a-ad42c6d210d3@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBVbnRp
bCBub3cgUlRMODE5MkNVIGZhbWlseSB3YXMgdXNpbmcgdGhlIE1BQyBpbml0IHRhYmxlIGZyb20g
UlRMODcyM0FVLA0KPiBidXQgdGhlc2UgdGFibGVzIGFyZSBub3QgaWRlbnRpY2FsIGluIHRoZSB0
d28gdmVuZG9yIGRyaXZlcnMuIEltcG9ydA0KPiB0aGUgY29ycmVjdCB0YWJsZSBmb3IgUlRMODE5
MkNVLg0KDQpJIGJlbGlldmUgeW91IGhhdmUgdGVzdGVkIG9uIHJlYWwgaGFyZHdhcmUuIENhbiB5
b3UgbGlzdCB0aGUgaGFyZHdhcmUgeW91DQp0ZXN0ZWQgaW4gY29tbWl0IG1lc3NhZ2U/IEkgY2Fu
IGFkZCB0aGVtIGR1cmluZyBjb21taXR0aW5nLCBvciBzZW5kaW5nIHYyDQppcyBhbHNvIGZpbmUu
DQoNCg0KPiANCj4gQWxzbyBtb3ZlIHRoZSBleGlzdGluZyBNQUMgaW5pdCB0YWJsZSB0byBydGw4
eHh4dV84NzIzYS5jLCB3aGljaCBpcw0KPiB0aGUgb25seSByZW1haW5pbmcgdXNlci4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29t
Pg0KDQpSZXZpZXdlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg0K

