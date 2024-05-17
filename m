Return-Path: <linux-wireless+bounces-7753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DB18C7F38
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 02:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB8E283595
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 00:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD75938B;
	Fri, 17 May 2024 00:32:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21AF389
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 00:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715905972; cv=none; b=X003VCbG+1CWZeAaLbD7QMFAYY0Xqff11zvITzkKM7CBCUNAIUFK5/UVFptN09BzdnkDdqNv867H2L8l2Pr7n2hJkezjN2SSVQ/P00O/5goYYRvsZh2Gb5FcYRCpvKUsJ4eX3rQDc/VGfWzqyBb+f6eP/AyuMLpKNK/q+vBj11E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715905972; c=relaxed/simple;
	bh=ZDqASoQSHQaX1zu31r2aOCS2/Ja++yYR5zpG04bLRE0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Di+NpLcgTCzwJmaxlNEYQYdbc72TSdiZrlfUnsG0pQbwijkthEOJJEcmXCVi5/BpPdfF6eMfvcfVBB5xdDskZ049hOfrAPxSzFFBJO0kyfWEXo1s4/CZUpXag1ptH+Z5/iKgRhYWoYe3QvYxx9huGU8127zOquZ1fUtfwaKMXTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44H0WemhE1758274, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44H0WemhE1758274
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 08:32:40 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 17 May 2024 08:32:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 08:32:41 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 17 May 2024 08:32:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Larry Finger <Larry.Finger@lwfinger.net>
CC: linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: Problem with 8922ae
Thread-Topic: Problem with 8922ae
Thread-Index: AQHapvySFjuIGFw1t0ytdSVFqyYk5rGZA7uA//+AvACAAInFUIAAZTAAgAEhFEA=
Date: Fri, 17 May 2024 00:32:40 +0000
Message-ID: <e53d3f3ccab94d9a85a4c8e08c8e7ab2@realtek.com>
References: <898f027b-bf08-4f6b-b0c7-623ca5c5f23c@lwfinger.net>
 <fec7536d76cd469e8fbc375219205d1b@realtek.com>
 <723e1eed-e706-4533-b33b-a880b9a46fd8@lwfinger.net>
 <a321afd48004484cb1a598fc4f54556c@realtek.com>
 <c97e2856-de5b-4bd2-987d-e40b15d748ae@lwfinger.net>
In-Reply-To: <c97e2856-de5b-4bd2-987d-e40b15d748ae@lwfinger.net>
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

TGFycnkgRmluZ2VyIDxsYXJyeS5maW5nZXJAZ21haWwuY29tPiB3cm90ZToNCj4gT24gNS8xNS8y
NCA4OjE2IFBNLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gUmVjZW50bHkgd2UgYWRkZWQgV29X
TEFOIGFuZCBCVC1jb2V4aXN0ZW5jZSBmb3IgODkyMkFFLiBJIHRoaW5rIHlvdSBkaWRuJ3QgdXNl
DQo+ID4gV29XTEFOIGZlYXR1cmVzLCBzbyBjYXVzZSBtaWdodCBiZSBCVC1jb2V4aXN0ZW5jZS4g
TWF5YmUgYW5vdGhlciB0cnkgaXMgdG8gdHVybg0KPiA+IG9mZiBCVCBpZiB5b3UgYXJlIHVzaW5n
Lg0KPiA+DQo+ID4gSSB3aWxsIHNldHVwIGEgUEMgdG8gc2VlIGlmIEkgY2FuIHJlcHJvZHVjZSB0
aGlzIHByb2JsZW0uDQo+ID4NCj4gDQo+IFBpbmctS2UsDQo+IA0KPiBJIGFtIG5vdCB1c2luZyBC
VC4gSSB1bmxvYWRlZCB0aGUgQlQgZHJpdmVycywgYW5kIHN0aWxsIGdvdCB0aGUgd2FybmluZy4N
Cj4gDQoNClRoYW5rcyBmb3IgdGhlIHRlc3QuIFBsZWFzZSBhdHRhY2ggd2FybmluZ3MgeW91IG1l
dCB0byBtZS4gSSB3aWxsIHBhc3MgdGhlbQ0KdG8gaW50ZXJuYWwgZXhwZXJ0cyB0byBhbmFseXpl
LiANCg0KSW4gbXkgc2V0dXAsIHdoaWNoIGNvbm5lY3RzIHRvIDJHSHogQVAgYW5kIHBsYXlzIHlv
dXR1YmUsIEkgc3RpbGwgY2FuJ3Qgc2VlDQp3YXJuaW5nIGZvciBhYm91dCAxIGRheS4gSSB3aWxs
IGtlZXAgdGVzdCBvdmVyIHdlZWtlbmQuDQoNClBpbmctS2UNCg0K

