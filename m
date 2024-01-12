Return-Path: <linux-wireless+bounces-1760-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C0C82B89E
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 01:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5131C23846
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 00:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9AA10F1;
	Fri, 12 Jan 2024 00:34:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD80210EE
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 00:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40C0YKzT41998563, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40C0YKzT41998563
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 08:34:20 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 12 Jan 2024 08:34:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 12 Jan 2024 08:34:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Fri, 12 Jan 2024 08:34:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>
Subject: RE: [PATCH v3] wifi: rtlwifi: rtl_usb: Use sync register writes
Thread-Topic: [PATCH v3] wifi: rtlwifi: rtl_usb: Use sync register writes
Thread-Index: AQHaRJ5lsOXMlNJnFUOprr+PGThGSrDVVNPw
Date: Fri, 12 Jan 2024 00:34:19 +0000
Message-ID: <03923811e2e242418080c8f6e58358be@realtek.com>
References: <fb71bae6-8b19-4b6e-b4a6-0d260f2139e1@gmail.com>
In-Reply-To: <fb71bae6-8b19-4b6e-b4a6-0d260f2139e1@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDEx
LCAyMDI0IDEwOjU3IFBNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPjsgTGFycnkgRmluZ2VyIDxMYXJy
eS5GaW5nZXJAbHdmaW5nZXIubmV0Pg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjNdIHdpZmk6IHJ0bHdp
Zmk6IHJ0bF91c2I6IFVzZSBzeW5jIHJlZ2lzdGVyIHdyaXRlcw0KPiANCj4gQ3VycmVudGx5IHJ0
bF91c2IgcGVyZm9ybXMgcmVnaXN0ZXIgd3JpdGVzIHVzaW5nIHRoZSBhc3luYw0KPiB1c2Jfc3Vi
bWl0X3VyYigpIGZ1bmN0aW9uLiBUaGlzIGFwcGVhcnMgdG8gd29yayBmaW5lIGZvciB0aGUgUlRM
ODE5MkNVLA0KPiBidXQgdGhlIFJUTDgxOTJEVSAoc29vbiB0byBiZSBzdXBwb3J0ZWQgYnkgcnRs
d2lmaSkgaGFzIGEgcHJvYmxlbToNCj4gaXQgdHJhbnNtaXRzIGV2ZXJ5dGhpbmcgYXQgdGhlIDFN
IHJhdGUgaW4gdGhlIDIuNCBHSHogYmFuZC4gKFRoZSA1IEdIeg0KPiBiYW5kIGlzIHN0aWxsIHVu
dGVzdGVkLikNCj4gDQo+IFdpdGggdGhpcyBwYXRjaCwgcnRsX3VzYiBwZXJmb3JtcyB0aGUgcmVn
aXN0ZXIgd3JpdGVzIHVzaW5nIHRoZQ0KPiBzeW5jaHJvbm91cyB1c2JfY29udHJvbF9tc2coKSBm
dW5jdGlvbiwgYW5kIHRoZSBSVEw4MTkyRFUgd29ya3MNCj4gbm9ybWFsbHkuIFRoZSBSVEw4MTky
Q1Ugc3RpbGwgd29ya3MuDQo+IA0KPiBUaGUgdmVuZG9yIGRyaXZlcnMgdXNlIHRoZSBhc3luYyB3
cml0ZXMgaW4gb25seSBvbmUgZnVuY3Rpb24sDQo+IHJ0bDgxOTJkdV90cmlnZ2VyX2dwaW9fMCAv
IHJ0bDgxOTJjdV90cmlnZ2VyX2dwaW9fMCwgd2hpY2ggcHJvYmFibHkNCj4gZG9lc24ndCBldmVu
IHJ1biBpbiByZWFsIGxpZmUuIFRoZXkgdXNlIHN5bmMgd3JpdGVzIGV2ZXJ5d2hlcmUgZWxzZS4N
Cj4gDQo+IEFsc28sIHJlbW92ZSAic3luYyIgYW5kICJhc3luYyIgZnJvbSB0aGUgbmFtZXMgb2Yg
dGhlIG1lbWJlcnMgb2YNCj4gc3RydWN0IHJ0bF9pbyB0byBhdm9pZCBjb25mdXNpb246DQo+IA0K
PiB3cml0ZXs4LDE2LDMyfV9hc3luYyAtPiB3cml0ZXs4LDE2LDMyfQ0KPiAgcmVhZHs4LDE2LDMy
fV9zeW5jICAtPiAgcmVhZHs4LDE2LDMyfQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1
ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNo
aWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

