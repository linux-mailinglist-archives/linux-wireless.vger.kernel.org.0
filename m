Return-Path: <linux-wireless+bounces-4223-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBCE86BF93
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 04:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665111C21F79
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 03:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75771364D9;
	Thu, 29 Feb 2024 03:50:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D49C25765
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 03:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709178604; cv=none; b=JqKcUMo9+adXf2H4ZRgCzXW1XXiTRhu0qAPhaeNCh/nRd33ZDR9LrN9lUS02D/nAvU3lmLljGfR9P9Hs4WRAJXb78oCbF9ELge6AmhwtdbwPF+pFmdSWRRMN72Q2VK44UxgmTycJtnMSIpuRejiWcBifWiCmH1haqVXfp4ygFKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709178604; c=relaxed/simple;
	bh=CPLMLjy9fcPMBYS/tp3JNiIGzebJv6ET+H0xUEIIqFw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pTw8KktNLfAZMMhsrONGc7wrp2NzeREWgxa2kjkqLqC5SQu/p+ZAvSM+Nae/KQKbMM2kZTe4mjG/fthTbZWzlPibJy1d7z+wTDZPOQ7L07bxKCrsddMEXCSzeUXOFtp18aler8rIPhK0AqGIiSxwsTu9V4+RrCn6SIaVgFwJrf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41T3nuGS31109741, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41T3nuGS31109741
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 11:49:56 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 29 Feb 2024 11:49:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 11:49:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Thu, 29 Feb 2024 11:49:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 3/4] wifi: rtw88: 8821c: Fix beacon loss and disconnect
Thread-Topic: [PATCH 3/4] wifi: rtw88: 8821c: Fix beacon loss and disconnect
Thread-Index: AQHaaXd+X61LV90lUki0GiYoKqT5fbEgsPMg
Date: Thu, 29 Feb 2024 03:49:56 +0000
Message-ID: <35931378a9d5428e86c475923c437e54@realtek.com>
References: <909d9f75-44cd-4710-9d3f-56691fd58090@gmail.com>
 <e2d717f7-2e5b-47ff-a99f-f692e9c07003@gmail.com>
In-Reply-To: <e2d717f7-2e5b-47ff-a99f-f692e9c07003@gmail.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDI3
LCAyMDI0IDg6MjAgUE0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBD
YzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAz
LzRdIHdpZmk6IHJ0dzg4OiA4ODIxYzogRml4IGJlYWNvbiBsb3NzIGFuZCBkaXNjb25uZWN0DQo+
IA0KPiBUZW5kYSBVOSBWMi4wLCB3aGljaCBjb250YWlucyBSVEw4ODExQ1UsIGlzIHByYWN0aWNh
bGx5IHVudXNhYmxlIGJlY2F1c2UNCj4gb2YgZnJlcXVlbnQgZGlzY29ubmVjdGlvbnM6DQo+IA0K
PiBGZWIgMjMgMTQ6NDY6NDUgaWRlYXBhZDIgd3BhX3N1cHBsaWNhbnRbNDI3XTogd2xwM3MwZjN1
MjogQ1RSTC1FVkVOVC1CRUFDT04tTE9TUw0KPiBGZWIgMjMgMTQ6NDY6NDYgaWRlYXBhZDIgd3Bh
X3N1cHBsaWNhbnRbNDI3XTogd2xwM3MwZjN1MjogQ1RSTC1FVkVOVC1ESVNDT05ORUNURUQNCj4g
ICAgICAgICBic3NpZD05MDo1NTpkZTpfXzpfXzpfXyByZWFzb249NCBsb2NhbGx5X2dlbmVyYXRl
ZD0xDQo+IA0KPiBGZWIgMjMgMTQ6NDY6NTIgaWRlYXBhZDIgd3BhX3N1cHBsaWNhbnRbNDI3XTog
d2xwM3MwZjN1MjogQ1RSTC1FVkVOVC1DT05ORUNURUQNCj4gICAgICAgICAtIENvbm5lY3Rpb24g
dG8gOTA6NTU6ZGU6X186X186X18gY29tcGxldGVkIFtpZD0wIGlkX3N0cj1dDQo+IEZlYiAyMyAx
NDo0Njo1NCBpZGVhcGFkMiB3cGFfc3VwcGxpY2FudFs0MjddOiB3bHAzczBmM3UyOiBDVFJMLUVW
RU5ULUJFQUNPTi1MT1NTDQo+IEZlYiAyMyAxNDo0Njo1NSBpZGVhcGFkMiB3cGFfc3VwcGxpY2Fu
dFs0MjddOiB3bHAzczBmM3UyOiBDVFJMLUVWRU5ULURJU0NPTk5FQ1RFRA0KPiAgICAgICAgIGJz
c2lkPTkwOjU1OmRlOl9fOl9fOl9fIHJlYXNvbj00IGxvY2FsbHlfZ2VuZXJhdGVkPTENCj4gDQo+
IEZlYiAyMyAxNDo0NzowMSBpZGVhcGFkMiB3cGFfc3VwcGxpY2FudFs0MjddOiB3bHAzczBmM3Uy
OiBDVFJMLUVWRU5ULUNPTk5FQ1RFRA0KPiAgICAgICAgIC0gQ29ubmVjdGlvbiB0byA5MDo1NTpk
ZTpfXzpfXzpfXyBjb21wbGV0ZWQgW2lkPTAgaWRfc3RyPV0NCj4gRmViIDIzIDE0OjQ3OjA0IGlk
ZWFwYWQyIHdwYV9zdXBwbGljYW50WzQyN106IHdscDNzMGYzdTI6IENUUkwtRVZFTlQtQkVBQ09O
LUxPU1MNCj4gRmViIDIzIDE0OjQ3OjA1IGlkZWFwYWQyIHdwYV9zdXBwbGljYW50WzQyN106IHds
cDNzMGYzdTI6IENUUkwtRVZFTlQtRElTQ09OTkVDVEVEDQo+ICAgICAgICAgYnNzaWQ9OTA6NTU6
ZGU6X186X186X18gcmVhc29uPTQgbG9jYWxseV9nZW5lcmF0ZWQ9MQ0KPiANCj4gVGhpcyBpcyBj
YXVzZWQgYnkgYSBtaXN0YWtlIGluIHRoZSBjaGlwIGluaXRpYWxpc2F0aW9uLiBUaGlzIHZlcnNp
b24gb2YNCj4gdGhlIGNoaXAgcmVxdWlyZXMgbG9hZGluZyBhbiBleHRyYSBBR0MgdGFibGUgcmln
aHQgYWZ0ZXIgdGhlIG1haW4gb25lLA0KPiBidXQgdGhlIGV4dHJhIHRhYmxlIGlzIGJlaW5nIGxv
YWRlZCBhdCB0aGUgd3JvbmcgdGltZS4NCg0KVGhhbmtzIGZvciB0aGUgZmluZGluZy4gVGhlIHJ0
d19jaGlwX2JvYXJkX2luZm9fc2V0dXAoKSBjYW4gb25seSBkbyAic29mdHdhcmUiDQp0aGluZ3Ms
IGFuZCBydHdfcGh5X2xvYWRfdGFibGVzKCkgY2FuIHJlYWxseSBkbyBJTy4gQWRkIHRoaXMgdG8g
Y29tbWl0IG1lc3NhZ2UNCmlmIHlvdSB0aGluayB0aGlzIGNhbiBiZSBjbGVhci4gDQoNCj4gDQo+
IE1vdmUgdGhlIGV4dHJhIEFHQyB0YWJsZSBsb2FkaW5nIHRvIHRoZSByaWdodCBwbGFjZS4NCj4g
DQo+IEZpeGVzOiA1ZDY2NTFmZTg1ODMgKCJydHc4ODogODgyMWM6IHN1cHBvcnQgUkZFIHR5cGUy
IHdpZmkgTklDIikNCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNl
cmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVr
LmNvbT4NCg0KDQo=

