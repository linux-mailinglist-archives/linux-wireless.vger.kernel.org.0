Return-Path: <linux-wireless+bounces-7160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9A08BBAA1
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 13:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8BE1F21382
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 11:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730BB171CC;
	Sat,  4 May 2024 11:16:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2104689
	for <linux-wireless@vger.kernel.org>; Sat,  4 May 2024 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714821414; cv=none; b=UIwvOwbJTmQ9pDb9dWiTowwjyfIliok9IQXECs6sB1c1V+BQMhq4Y83g2T8gWyRp8vpzQPw3xoAIWEXpWCOzpQR2YNlwfGNkxN6v/ySpSG8zFsiZYpS+N+Q5tQ9mcH/0PVOKLgmpDTMVLf5T03hggsAX08WxLU91rajTySJwt6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714821414; c=relaxed/simple;
	bh=KQPBwJJGR9SSDUhy3pED0/NQQ1eaLsqyXTaUqmRCPnA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ch/qBrETfY3owsXQk8fhXsQ6+YkierouOfrxpruT42gC+DfoHpOQ0J5sqjJh3zJ5tCmub8/qGrbb5Sy07wD2G5PoMMSmQ40QniZx2r3Cmu3FbCQMLLQ9yRA5QriV4ngqbjAqN3wd5Z+J//zit3w4DKubooxmTLoXThZQ3qFEyEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 444BGbRV2196857, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 444BGbRV2196857
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 4 May 2024 19:16:37 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 4 May 2024 19:16:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 4 May 2024 19:16:37 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Sat, 4 May 2024 19:16:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "kvalo@kernel.org" <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: pull-request: rtw-next-2024-05-04
Thread-Topic: pull-request: rtw-next-2024-05-04
Thread-Index: AQHanbtZT6OtPHricEuEHKld+5GqvLGGIpqAgABE2wA=
Date: Sat, 4 May 2024 11:16:37 +0000
Message-ID: <03e00a7f47c86323f34748853ba38859b4d52695.camel@realtek.com>
References: <333d56f0-ef24-4946-958d-e804cf9c733b@RTEXMBS04.realtek.com.tw>
	 <171480660387.2072516.10612946227059882367.kvalo@kernel.org>
In-Reply-To: <171480660387.2072516.10612946227059882367.kvalo@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FD014AEBCD3524A81168E74B5B54884@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gU2F0LCAyMDI0LTA1LTA0IGF0IDA3OjEwICswMDAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiAN
Cj4gZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkL2h3X2NvbW1v
bi5jOjk4NjoyOg0KPiAuL2luY2x1ZGUvbGludXgvYml0ZmllbGQuaDoxODk6MTU6IHdhcm5pbmc6
ICdyYXRlX21hc2snIGlzIHVzZWQgdW5pbml0aWFsaXplZCBbLVd1bmluaXRpYWxpemVkXQ0KPiAN
Cg0KSSBoYXZlIHVwZGF0ZWQgZ2NjIHRvIDEzLjIuMSAobG9jYWwgYnVpbGQpLCBidXQgc3RpbGwg
Y2FuJ3Qgc2VlIHRoaXMgd2FybmluZy4NClRoZW4sIEkgZm9yY2UgdG8gYWRkIC1XdW5pbml0aWFs
aXplZCBhbmQgZGVsZXRlIC1Xbm8tbWF5YmUtdW5pbml0aWFsaXplZA0KbG9jYWxseSwgYW5kIEkg
Y2FuIHNlZSB0aGlzIHdhcm5pbmcgKGJ1dCAtV21heWJlLXVuaW5pdGlhbGl6ZWQgaW5zdGVhZCku
DQoNCkkgZGlkIHN1c3BlY3Qgd2lyZWxlc3MtbmV4dCB0cmVlIGRvZXMgbW9yZSBjb21waWxlciBv
cHRpb25zLCBzbyBJIGFsc28NCnRyaWVkIHRvIG1lcmdlIHRoZSB0cmVlLCBidXQgc3RpbGwgdGhl
IHNhbWUuDQoNClRvIHByZXZlbnQgYmxvY2tpbmcgcHVsbC1yZXF1ZXN0LCBJIHdvdWxkIG1ha2Ug
cGF0Y2ggYW5kIHNlbmQgcHVsbC1yZXF1ZXN0DQpieSB5b3VyIGZpbmRpbmcuIEkgd2lsbCBjb250
aW51ZSB0byBkaWcgdGhlIGNhdXNlIGFmdGVyd2FyZC4gDQoNClBpbmctS2UgDQoNCg0KDQo=

