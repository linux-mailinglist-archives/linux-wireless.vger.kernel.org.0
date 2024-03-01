Return-Path: <linux-wireless+bounces-4278-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED5586D853
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 01:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F62CB2227E
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 00:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC344368;
	Fri,  1 Mar 2024 00:28:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96A0365
	for <linux-wireless@vger.kernel.org>; Fri,  1 Mar 2024 00:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252932; cv=none; b=bzlf2lTkDbiivB7E2lkkyMOZzrfW8Y0bKw5J4N9/AT61nI6PpYY179RKBvw6QHEX1CEJl9Zglpid2hl9UcJnNmjm4Y+Y/cKllLGelfQKB2r9jDJZ03C1ULpemlMQ3K4loDD2oBop8CfNgvsP/db3Pis+veACGrodzqXNpyLvoIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252932; c=relaxed/simple;
	bh=lE30y5k+BhXN+KywDOxnw9njBV+cnr9LxFni5rGPWFs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MMrGbp1DBnY65+PvO0fcZrK4filGuhdDS9glPtBZr/MxOF5i5Y4ENlMoEv+WafpqozzCpaRfoA/Ar2KG8YMvv7ul1LFbnX9zMjQWpGql19aE1fONC4jqaX0j1vVngeiFIxxU9z6yveMbdDXcrTGwcUCRTRd9Kw4nI1inWlIZats=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4210SgqN61648756, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4210SgqN61648756
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 08:28:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 1 Mar 2024 08:28:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 08:28:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Fri, 1 Mar 2024 08:28:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH v2 3/4] wifi: rtw88: 8821c: Fix beacon loss and disconnect
Thread-Topic: [PATCH v2 3/4] wifi: rtw88: 8821c: Fix beacon loss and
 disconnect
Thread-Index: AQHaa1+Q2030B+ZoiE6TtjnHMFYierEiCAGg
Date: Fri, 1 Mar 2024 00:28:42 +0000
Message-ID: <6a895139dd684401ae26aefa5a07cbf6@realtek.com>
References: <f12ed39d-28e8-4b8b-8d22-447bcf295afc@gmail.com>
 <276c31d8-b9a8-4e54-a3ac-09b74657aff7@gmail.com>
In-Reply-To: <276c31d8-b9a8-4e54-a3ac-09b74657aff7@gmail.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMSwgMjAy
NCA2OjM1IEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFBp
bmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPjsgU2FzY2hhIEhhdWVyIDxzaGFAcGVuZ3V0
cm9uaXguZGU+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAzLzRdIHdpZmk6IHJ0dzg4OiA4ODIxYzog
Rml4IGJlYWNvbiBsb3NzIGFuZCBkaXNjb25uZWN0DQo+IA0KPiBUZW5kYSBVOSBWMi4wLCB3aGlj
aCBjb250YWlucyBSVEw4ODExQ1UsIGlzIHByYWN0aWNhbGx5IHVudXNhYmxlIGJlY2F1c2UNCj4g
b2YgZnJlcXVlbnQgZGlzY29ubmVjdGlvbnM6DQo+IA0KPiBGZWIgMjMgMTQ6NDY6NDUgaWRlYXBh
ZDIgd3BhX3N1cHBsaWNhbnRbNDI3XTogd2xwM3MwZjN1MjogQ1RSTC1FVkVOVC1CRUFDT04tTE9T
Uw0KPiBGZWIgMjMgMTQ6NDY6NDYgaWRlYXBhZDIgd3BhX3N1cHBsaWNhbnRbNDI3XTogd2xwM3Mw
ZjN1MjogQ1RSTC1FVkVOVC1ESVNDT05ORUNURUQNCj4gICAgICAgICBic3NpZD05MDo1NTpkZTpf
XzpfXzpfXyByZWFzb249NCBsb2NhbGx5X2dlbmVyYXRlZD0xDQo+IA0KPiBGZWIgMjMgMTQ6NDY6
NTIgaWRlYXBhZDIgd3BhX3N1cHBsaWNhbnRbNDI3XTogd2xwM3MwZjN1MjogQ1RSTC1FVkVOVC1D
T05ORUNURUQNCj4gICAgICAgICAtIENvbm5lY3Rpb24gdG8gOTA6NTU6ZGU6X186X186X18gY29t
cGxldGVkIFtpZD0wIGlkX3N0cj1dDQo+IEZlYiAyMyAxNDo0Njo1NCBpZGVhcGFkMiB3cGFfc3Vw
cGxpY2FudFs0MjddOiB3bHAzczBmM3UyOiBDVFJMLUVWRU5ULUJFQUNPTi1MT1NTDQo+IEZlYiAy
MyAxNDo0Njo1NSBpZGVhcGFkMiB3cGFfc3VwcGxpY2FudFs0MjddOiB3bHAzczBmM3UyOiBDVFJM
LUVWRU5ULURJU0NPTk5FQ1RFRA0KPiAgICAgICAgIGJzc2lkPTkwOjU1OmRlOl9fOl9fOl9fIHJl
YXNvbj00IGxvY2FsbHlfZ2VuZXJhdGVkPTENCj4gDQo+IEZlYiAyMyAxNDo0NzowMSBpZGVhcGFk
MiB3cGFfc3VwcGxpY2FudFs0MjddOiB3bHAzczBmM3UyOiBDVFJMLUVWRU5ULUNPTk5FQ1RFRA0K
PiAgICAgICAgIC0gQ29ubmVjdGlvbiB0byA5MDo1NTpkZTpfXzpfXzpfXyBjb21wbGV0ZWQgW2lk
PTAgaWRfc3RyPV0NCj4gRmViIDIzIDE0OjQ3OjA0IGlkZWFwYWQyIHdwYV9zdXBwbGljYW50WzQy
N106IHdscDNzMGYzdTI6IENUUkwtRVZFTlQtQkVBQ09OLUxPU1MNCj4gRmViIDIzIDE0OjQ3OjA1
IGlkZWFwYWQyIHdwYV9zdXBwbGljYW50WzQyN106IHdscDNzMGYzdTI6IENUUkwtRVZFTlQtRElT
Q09OTkVDVEVEDQo+ICAgICAgICAgYnNzaWQ9OTA6NTU6ZGU6X186X186X18gcmVhc29uPTQgbG9j
YWxseV9nZW5lcmF0ZWQ9MQ0KPiANCj4gVGhpcyBpcyBjYXVzZWQgYnkgYSBtaXN0YWtlIGluIHRo
ZSBjaGlwIGluaXRpYWxpc2F0aW9uLiBUaGlzIHZlcnNpb24gb2YNCj4gdGhlIGNoaXAgcmVxdWly
ZXMgbG9hZGluZyBhbiBleHRyYSBBR0MgdGFibGUgcmlnaHQgYWZ0ZXIgdGhlIG1haW4gb25lLA0K
PiBidXQgdGhlIGV4dHJhIHRhYmxlIGlzIGJlaW5nIGxvYWRlZCBhdCB0aGUgd3JvbmcgdGltZSwg
aW4NCj4gcnR3X2NoaXBfYm9hcmRfaW5mb19zZXR1cCgpLg0KPiANCj4gTW92ZSB0aGUgZXh0cmEg
QUdDIHRhYmxlIGxvYWRpbmcgdG8gdGhlIHJpZ2h0IHBsYWNlLCBpbg0KPiBydHdfcGh5X2xvYWRf
dGFibGVzKCkuDQo+IA0KPiBUaGUgcnR3X2NoaXBfYm9hcmRfaW5mb19zZXR1cCgpIGNhbiBvbmx5
IGRvICJzb2Z0d2FyZSIgdGhpbmdzLCBhbmQNCj4gcnR3X3BoeV9sb2FkX3RhYmxlcygpIGNhbiBy
ZWFsbHkgZG8gSU8uDQo+IA0KPiBGaXhlczogNWQ2NjUxZmU4NTgzICgicnR3ODg6IDg4MjFjOiBz
dXBwb3J0IFJGRSB0eXBlMiB3aWZpIE5JQyIpDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUg
U21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGlo
IDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg0KDQo=

