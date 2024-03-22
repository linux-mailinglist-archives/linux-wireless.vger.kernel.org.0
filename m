Return-Path: <linux-wireless+bounces-5127-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D9488649F
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 02:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81171F22EB4
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 01:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D37B65C;
	Fri, 22 Mar 2024 01:26:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3E92905
	for <linux-wireless@vger.kernel.org>; Fri, 22 Mar 2024 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711070773; cv=none; b=GCGcQgpoOnvkvE9mkF7xDaI+fqQL3X5HpOeUF34Npu+oqGsOcTO4osGpR0ICYZnTRAJ4JvjxDKKC0ZBQFK8UgOO8pljdsgKhmg4fASPRPO+bjrvknI7wJaYvwvDZ+UKaxQVqY3r44rL4h9EgcheLpsgqSguL1AwUCXt8Jv4V1xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711070773; c=relaxed/simple;
	bh=9aidg7GKYCoGw44cgWiPauiaglkau7lw0Ynk0K0ASKw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GiHMCWjr+Llr6HG7T7LMwbn+SDYvp6FPJQSAgnXszq8LNuwzzy02GdCqy78rHD85NcyipZ+1xATsZ9S3coIjhYgGMNWaIbu+mAjZwp4I2jQK84HslXE4qUpmL34w+c7dMXP9l6Xu60pfNnwA4lJc5uqgjFZpf/w0+INIttVha9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42M1Pd7tA1339408, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42M1Pd7tA1339408
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 09:25:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 09:25:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 09:25:38 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Fri, 22 Mar 2024 09:25:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
CC: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "s.l-h@gmx.de"
	<s.l-h@gmx.de>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: Re: [PATCH v3 01/12] wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
Thread-Topic: [PATCH v3 01/12] wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
Thread-Index: AQHaev2BAGYPBmfsRECC7UwfxaP+7bFCc06A
Date: Fri, 22 Mar 2024 01:25:38 +0000
Message-ID: <df597ba4a72da6522f23a790b4effa8cefc03ac3.camel@realtek.com>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
	 <bc6da9fe-f6e1-4b00-b776-72c9d845ed4d@gmail.com>
In-Reply-To: <bc6da9fe-f6e1-4b00-b776-72c9d845ed4d@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7A52FAB07AD5242A9BE800DA2590BC2@realtek.com>
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

T24gV2VkLCAyMDI0LTAzLTIwIGF0IDIxOjMzICswMjAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KPiANCj4gRGlmZmVyZW50IGNoYW5uZWxzIGhhdmUgZGlmZmVyZW50IFRYIHBvd2VyIHNldHRp
bmdzLiBydGw4MTkyZGUgaXMgdXNpbmcNCj4gdGhlIFRYIHBvd2VyIHNldHRpbmcgZnJvbSB0aGUg
d3JvbmcgY2hhbm5lbCBpbiB0aGUgNSBHSHogYmFuZCBiZWNhdXNlDQo+IF9ydGw5MmNfcGh5X2dl
dF9yaWdodGNobmxwbGFjZSBleHBlY3RzIGFuIGFycmF5IHdoaWNoIGluY2x1ZGVzIGFsbCB0aGUN
Cj4gY2hhbm5lbCBudW1iZXJzLCBidXQgaXQncyB1c2luZyBhbiBhcnJheSB3aGljaCBpbmNsdWRl
cyBvbmx5IHRoZSA1IEdIeg0KPiBjaGFubmVsIG51bWJlcnMuDQo+IA0KPiBVc2UgdGhlIGFycmF5
IGNoYW5uZWxfYWxsIChkZWZpbmVkIGluIHJ0bDgxOTJkZS9waHkuYykgaW5zdGVhZCBvZg0KPiB0
aGUgaW5jb3JyZWN0IGNoYW5uZWw1ZyAoZGVmaW5lZCBpbiBjb3JlLmMpLg0KPiANCj4gVGVzdGVk
IG9ubHkgd2l0aCBydGw4MTkyZHUsIHdoaWNoIHdpbGwgdXNlIHRoZSBzYW1lIFRYIHBvd2VyIGNv
ZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUy
QGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29t
Pg0KDQo=

