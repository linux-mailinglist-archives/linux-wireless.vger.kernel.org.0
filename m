Return-Path: <linux-wireless+bounces-5814-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ABE896F96
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 14:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4996B1C243CD
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 12:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCDC1474BF;
	Wed,  3 Apr 2024 12:55:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81A6146A75
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148924; cv=none; b=eQOpSar1lOLHtVc3ptC35eOekLqzNSV8NJMBB7ODUxoi7b3NPBNooWvg3Zm5ObsuVZzGx/MIDdWs2ljfWkrJFfatnAlxaGfQyhTrT4bBdyFmzqnze3O/PP3HQmofrpHwgu8Dh06cJ/xIH4edTprkeO/cMfm6kIkz81EZNvn0PMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148924; c=relaxed/simple;
	bh=lkFPD9wO8NvCDkC/+n70/SZWpOEq0LtzWRfYD6iFbWc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EUh58ky1L9E+enMnMoBl0FeNVDr4FcEsBbepw2pD+9fEMVMT+uwkYi/zDDvbDbokKVZ6UFASM3QI2aymOfD9qrTW12+BKUszkLt99rSD+uNgDs6xBB1eIBHdUk2boLfgd08t0wQ1CpFVqqLeF+s8SbirmMWmIdkicn5rxg9/Czk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 433CtCIg9940473, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 433CtCIg9940473
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Apr 2024 20:55:12 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 20:55:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 20:55:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 3 Apr 2024 20:55:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "nbd@nbd.name" <nbd@nbd.name>
Subject: Re: [PATCH 10/13] wifi: mt76: mt7915: add mt7986, mt7916 and mt7981 pre-calibration
Thread-Topic: [PATCH 10/13] wifi: mt76: mt7915: add mt7986, mt7916 and mt7981
 pre-calibration
Thread-Index: AQHahbXGB1CWg4HZjEGprXZP2j2FZLFV+nOA
Date: Wed, 3 Apr 2024 12:55:13 +0000
Message-ID: <4cea6924dad8c564312cfa819e189121016dae85.camel@realtek.com>
References: <20240403103032.54823-1-nbd@nbd.name>
	 <20240403103032.54823-10-nbd@nbd.name>
In-Reply-To: <20240403103032.54823-10-nbd@nbd.name>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <40352E102895A9498BAFFB578010467D@realtek.com>
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

T24gV2VkLCAyMDI0LTA0LTAzIGF0IDEyOjMwICswMjAwLCBGZWxpeCBGaWV0a2F1IHdyb3RlOg0K
PiANCj4gRnJvbTogUGV0ZXIgQ2hpdSA8Y2h1aS1oYW8uY2hpdUBtZWRpYXRlay5jb20+DQo+IA0K
PiBBZGQgcHJlLWNhbGlicmF0aW9uIGZvciBtdDc5ODYgYW5kIG10NzkxNi4gSXQgaGFzIGRpZmZl
cmVudCBkYXRhIHNpemUNCj4gd2l0aCBtdDc5MTUuIEdyb3VwIGNhbCBuZWVkcyA1NGsgYW5kIDk0
ayBmb3IgMkcgKyA1RyBhbmQgMkcgKyA2RywNCj4gcmVzcGVjdGl2ZWx5LiBEUEQgY2FsIG5lZWRz
IDMwMGsuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBDaGl1IDxjaHVpLWhhby5jaGl1QG1l
ZGlhdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3RhbmxleVlQIFdhbmcgPFN0YW5sZXlZUC5X
YW5nQG1lZGlhdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRmVsaXggRmlldGthdSA8bmJkQG5i
ZC5uYW1lPg0KPiAtLS0NCg0KWy4uLl0NCg0KPiAtc3RhdGljIGludCBtdDc5MTVfZHBkX2ZyZXFf
aWR4KHUxNiBmcmVxLCB1OCBidykNCj4gK3N0YXRpYyBpbnQgbXQ3OTE1X2RwZF9mcmVxX2lkeChz
dHJ1Y3QgbXQ3OTE1X2RldiAqZGV2LCB1MTYgZnJlcSwgdTggYncpDQo+ICB7DQo+IC0gICAgICAg
c3RhdGljIGNvbnN0IHUxNiBmcmVxX2xpc3RbXSA9IHsNCj4gKyAgICAgICBjb25zdCB1MTYgZnJl
cV9saXN0X3YxW10gPSB7DQo+ICAgICAgICAgICAgICAgICA1MTgwLCA1MjAwLCA1MjIwLCA1MjQw
LA0KPiAgICAgICAgICAgICAgICAgNTI2MCwgNTI4MCwgNTMwMCwgNTMyMCwNCj4gICAgICAgICAg
ICAgICAgIDU1MDAsIDU1MjAsIDU1NDAsIDU1NjAsDQo+IA0KDQonc3RhdGljIGNvbnN0JyB3b3Vs
ZCBiZSBiZXR0ZXIgdGhhbiAnY29uc3QnLCBiZWNhdXNlICdzdGF0aWMgY29uc3QnIGlzIG9ubHkN
CmEgY29weSBvZiByb2RhdGEsIGJ1dCAnY29uc3QnIGlzIGEgY29weSBvZiByb2RhdGEgcGx1cyBh
IGxvY2FsIGNvcHkgaW4gc3RhY2suDQoNCg0KDQo=

