Return-Path: <linux-wireless+bounces-5078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB90881C20
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 06:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24609B21EB1
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 05:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9F22E85C;
	Thu, 21 Mar 2024 05:33:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A8C2E41C
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 05:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710999199; cv=none; b=cMKSSpYDqE7VcdAWxGNc7Lao6B7W1abxso0mwcVhmwl8ElpnFI3IW4TJdNJZTK8IK9Yq3YbsRueFV7nihS60lI8BuKUIa1ofs6C5qRT5SH9TLQb99XsTwhx18FZrNRTpFagfX6aCn7rwZEAncgF6vyGdRZGZWrq8dq2k8RRp4Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710999199; c=relaxed/simple;
	bh=I+ToyNB2wTVW+cf/lnBpViL40PvelZl2EZtaedYsw4o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A6t9OA1rPxeJPSu2jFNnY0kktqNH/DqZcszR6gfNAz4mkurd4iWjTHH3ZyfTS//fR5x/b+N9W6IFwWMFSHemgJ5O8bga4qmdVqn/KVWNJdjU4CV52fSOFFpPcFxmQI/d2/FWjEiKGPNRocqN6mR7D8y1+3eIotNP31xqZBp1z+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42L5X7Rt8885629, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42L5X7Rt8885629
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 13:33:07 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 13:33:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 13:33:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Thu, 21 Mar 2024 13:33:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "kvalo@kernel.org" <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Leo.Li"
	<leo.li@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: disable txptctrl IMR to avoid flase alarm
Thread-Topic: [PATCH] wifi: rtw89: disable txptctrl IMR to avoid flase alarm
Thread-Index: AQHaezuD0B/f5lkmzkaOqNn1/IzumbFBpkXY//9/XgA=
Date: Thu, 21 Mar 2024 05:33:07 +0000
Message-ID: <2eefd73994778c1fa1dc03acf04708d686ec3185.camel@realtek.com>
References: <20240321025603.20614-1-pkshih@realtek.com>
	 <878r2c2mob.fsf@kernel.org>
In-Reply-To: <878r2c2mob.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F5D63B27B306D4787EDC58B8A5043E4@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gVGh1LCAyMDI0LTAzLTIxIGF0IDA3OjEyICswMjAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiAN
Cj4gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyaXRlczoNCj4gDQo+ID4gRnJv
bTogQ2hpYS1ZdWFuIExpIDxsZW8ubGlAcmVhbHRlay5jb20+DQo+ID4gDQo+ID4gVGhlIGhhcmR3
YXJlIGNvbW1hbmQgcGFyc2VyIG9mIHR4cHRjdHJsIChUWCBwcm90b2NvbCBjb250cm9sKSBoYXMg
b3Zlcmx5DQo+ID4gc3RyaW5nZW50IHRpbWVvdXQgY29uZGl0aW9ucywgd2hpY2ggcmVzdWx0cyBp
biBmYWxzZSBhbGFybS4gU28gZGlzYWJsZSBpdC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBD
aGlhLVl1YW4gTGkgPGxlby5saUByZWFsdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaW5n
LUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gDQo+IEknbSBpbiB0aGUgVG8gZmllbGQs
IGRvIHlvdSBtYXliZSB3YW50IG1lIHRvIHRha2UgdGhpcyB0byB3aXJlbGVzcyB0cmVlPw0KPiAN
Cg0KTm8sIGl0IHNob3VsZCBnbyB2aWEgcnR3LmdpdC4gSSBqdXN0IHNlbmQgdGhpcyBwYXRjaCBh
cyB1c3VhbC4gDQpTaG91bGQgSSBjaGFuZ2UgdG8gd2lyZWxlc3MgbWFpbGluZyBsaXN0IGFzIFRv
IGZpZWxkIGFuZCBubyBuZWVkIHRvIGFkZCB5b3UNCmluIG5laXRoZXIgVG8gZmllbGQgbm9yIENj
IGZpZWxkIGluIHRoZSBmdXR1cmU/IA0KDQpQaW5nLUtlDQoNCg==

