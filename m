Return-Path: <linux-wireless+bounces-29367-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B3CC8CEEB
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 07:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CC6B4E29EA
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 06:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5215027FB32;
	Thu, 27 Nov 2025 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="LBqX2O0V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E9A1C84D7;
	Thu, 27 Nov 2025 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764225479; cv=none; b=W7A88keSWfDaZ4grmikg147nIoA+GGs5HLxi2XoOPwWRzGnTJDhYjo+tY2tyELAhfvn3FCWwXcuQW8jF54LPdbCxCXj/OibPgVtuSdyg2EF7DLo9h2Kd99EbCntcDJKZQAeoBK8aOzTyANQnWvIRm0Jt4IrzAsAwFJpEUIRRoHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764225479; c=relaxed/simple;
	bh=I05VPNqST7r1/tGeMsbN7lwPOpMV3/Tl1035VoFskG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iFJdcSpWxXExmWGRCZmSHIfVtXY/DZvUvPrFvemNnU5JP2b0a1uCY8TMnFUd8n9FTdGcf09C8uZVWHEoDZzkkWgn5O5rzgZMiDKuM+1XiI3uO9sMOWlcWdXaEXR0+jqt2jmPZ5fFMYukfPqrCcvTH9KWDV0phogownDcsJnChMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=LBqX2O0V; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AR6b94512366436, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1764225429; bh=I05VPNqST7r1/tGeMsbN7lwPOpMV3/Tl1035VoFskG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=LBqX2O0Vop30YiyhlEinDzchj13wIoOCuYcBvHSznb2M3iLDT9egUTTnl7pnBiC++
	 45+Ebsd++IluJzzhHyIRWS/HWvkgY+OMyXHisWEw4+O0I80HcVaPr13WJbt6oesIM0
	 misT1HCw9GeHctlJvHUXWfMH18ll1xyaiHiKqSWow/fgVp83v1l67+JGmHO2ZoJxkm
	 o5ca7oBKzFUcTLBmusWWOBrL69IiJ8A403frNKiRGF8wdD9IGusghScCmpXhHm3bzx
	 PD5qlh4+LVdAxQ/X/WBI8nlv8XrqG6zFraAxtt+zGR3TgwSsBvmHdI+4q6ILtdqpcH
	 KIlONXHG6Eqyg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AR6b94512366436
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Nov 2025 14:37:09 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 27 Nov 2025 14:37:09 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Thu, 27 Nov 2025 14:37:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: alex bestoso <alexbestoso@bestosotech.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Bug Report - Rtlwifi
Thread-Topic: Bug Report - Rtlwifi
Thread-Index: AQHcX2aCIrWXMHkLVU+2neUA3tknNrUGEIuQ
Date: Thu, 27 Nov 2025 06:37:09 +0000
Message-ID: <0b376fdcc68442f7b41268bb26cce73e@realtek.com>
References: <85517aee-6e2a-4524-a5e2-6b48d05facbe@bestosotech.com>
In-Reply-To: <85517aee-6e2a-4524-a5e2-6b48d05facbe@bestosotech.com>
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

YWxleCBiZXN0b3NvIDxhbGV4YmVzdG9zb0BiZXN0b3NvdGVjaC5jb20+IHdyb3RlOg0KPiBCdWcg
RGVzY3JpcHRpb24gOiANCj4gICAgIEluZGV4IG91dCBvZiByYW5nZS4gUHJvYmxlbSBoYXBwZW5z
IG9uIGl0J3Mgb3duIGFmdGVyIGJlaW5nIGNvbm5lY3RlZCB0byBhIG5ldHdvcmsgZm9yIGEgc2hv
cnQgd2hpbGUuDQo+IA0KPiBFcnJvciBtZXNzYWdlIDogDQo+ICAgICBVQlNBTjogYXJyYXktaW5k
ZXgtb3V0LW9mLWJvdW5kcyBpbiBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkv
cnRsODE5MmN1L3RyeC5jOjUxNDozMA0KPiAgICAgWyAgNDU0LjM1MTA0MV0gaW5kZXggMTAgaXMg
b3V0IG9mIHJhbmdlIGZvciB0eXBlICdydGxfdGlkX2RhdGEgWzldJw0KPiANCj4gS2VybmVsIFZl
cnNpb24gOiANCj4gICAgIDYuMTguMC1yYzYrDQo+IA0KPiBTdWdnZXN0ZWQgU29sdXRpb246IA0K
PiAgICAgY2hhbmdlIHRoZSBmaWxlIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lm
aS9ydGw4MTkyY3UvdHJ4LmMgZnJvbSANCj4gDQo+ICAgICA1MTMgICAgIHRpZCA9IGllZWU4MDIx
MV9nZXRfdGlkKGhkcik7DQo+ICAgICA1MTQgICAgIGFnZ19zdGF0ZSA9IHN0YV9lbnRyeS0+dGlk
c1t0aWRdLmFnZy5hZ2dfc3RhdGU7DQo+ICAgICA1MTUgICAgIGFtcGR1X2RlbnNpdHkgPSBzdGEt
PmRlZmxpbmsuaHRfY2FwLmFtcGR1X2RlbnNpdHk7DQo+IA0KPiAgICAgdG8NCj4gDQo+ICAgICA1
MTMgICAgIHRpZCA9IGllZWU4MDIxMV9nZXRfdGlkKGhkcik7DQo+ICAgICA1MTQgICAgIGlmKHRp
ZCA8IE1BWF9USURfQ09VTlQpDQo+ICAgICA1MTUgICAgICAgICBhZ2dfc3RhdGUgPSBzdGFfZW50
cnktPnRpZHNbdGlkXS5hZ2cuYWdnX3N0YXRlOw0KPiAgICAgNTE2ICAgICBhbXBkdV9kZW5zaXR5
ID0gc3RhLT5kZWZsaW5rLmh0X2NhcC5hbXBkdV9kZW5zaXR5Ow0KDQpUaGlzIGNoYW5nZSBpcyBm
aW5lIHRvIG1lLiBDYW4geW91IHNlbmQgYSBwYXRjaD8NCg0K

