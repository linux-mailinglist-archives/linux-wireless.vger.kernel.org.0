Return-Path: <linux-wireless+bounces-30109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C91BCDE32D
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 02:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 304793006A64
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 01:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8781C862E;
	Fri, 26 Dec 2025 01:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="V5xKFREb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1D8155C97
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 01:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766712895; cv=none; b=mjtsTW4KgWS3JlF5oM+h3U1P12q11qResl3lNg0+p4Tqr3IcuwTz1h4ZT+kjKjdwnMNR44XUXkYzGP6XpmayU5DatcrYWmC8plAuXWeA/foCcIoxYS2RWAGHTDva49C7KPnC+POin9CniIpqMDRq1TsmCUxvjAIW42r3k2mFj74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766712895; c=relaxed/simple;
	bh=hcseJR18FlJ9sHfGkW8fel0i+HCGJ+Fr8j5bsVp7Dks=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=imEoAZaXHexnyScWLBe1qDaWomi12/fLbYCyelErfyB+H0poA2IqA+Wt9FeEgMdbHGwb0pfHhcqwS8DxSkl+kBJPpnGdTUrYViuYJo+HOEtwWEiOnfg9VhSyyJjfku+p1hiK9IKfzhCGgPf3zEj9o0pmHJAOe8pRBDqJjKKy0Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=V5xKFREb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ1YnuxE2653426, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766712889; bh=hcseJR18FlJ9sHfGkW8fel0i+HCGJ+Fr8j5bsVp7Dks=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=V5xKFREbagncVg3hXHR1QMB/bxFbDMWr2j/yWBwyC9p/DlSaDsbuXfu8HHZ/xREC0
	 qsMVnM1uVMl1fAFGfjd1lYCXCIOFDCw2wkOmsup3gE2TzpG7p6olbszuN8yARWBreU
	 2LzAdrM+q+DJEtBuWfQnchvu6HFP9f5o/8XLAfLvfHVCxLJjr5uw9xVPSxQNsjqu15
	 DFu3aIzdwVzhk6O/q4HEAlYNrjWUUpb53atYZUlFZcpUr2iPfwGn4w9MTb31yVg9pE
	 YE8KPnL8+vKOyR+sWRm+uekSNHAj5j3NogbuiC6iVR1Ee842XgztUigMyPwqS/iBt9
	 /2o+l7NzjKiMQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ1YnuxE2653426
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Dec 2025 09:34:49 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 09:34:49 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Fri, 26 Dec 2025 09:34:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw88: Increase the RX gain before
 scanning
Thread-Topic: [PATCH rtw-next] wifi: rtw88: Increase the RX gain before
 scanning
Thread-Index: AQHcdGKJJfjlHzX5XkmiZluwXG+txbUzJr8g
Date: Fri, 26 Dec 2025 01:34:49 +0000
Message-ID: <1daba5383bd046f2a4f02e9baadc652b@realtek.com>
References: <c2e72aff-190d-4f59-9914-2588de756385@gmail.com>
In-Reply-To: <c2e72aff-190d-4f59-9914-2588de756385@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBGcm9t
OiBNYXJ0aW4gSHLFr3phIDxtYXJ0aW4uaHJ1emExMjNAZ21haWwuY29tPg0KPiANCj4gVGhlIGRy
aXZlciByZWR1Y2VzIHRoZSBSWCBnYWluIHdoaWxlIGNvbm5lY3RlZCB0byBhIG5ldHdvcmsgbG9j
YXRlZA0KPiBjbG9zZSBieS4gSW4gdGhpcyBjb25kaXRpb24gc2NhbnMgcmV0dXJuIGZldyByZXN1
bHRzIGJlY2F1c2UgdGhlIG1vcmUNCj4gZGlzdGFudCBuZXR3b3JrcyBjYW4ndCBiZSBoZWFyZC4N
Cj4gDQo+IFRlbXBvcmFyaWx5IGluY3JlYXNlIHRoZSBSWCBnYWluIGJlZm9yZSBzY2FubmluZyBp
biBvcmRlciB0byBkZXRlY3QNCj4gYWxsIGF2YWlsYWJsZSBuZXR3b3Jrcy4gUmVzZXQgdGhlIFJY
IGdhaW4gYmFjayB0byB0aGUgbGFzdCByZWNvcmRlZA0KPiB2YWx1ZSBvbmNlIHRoZSBzY2FuIGZp
bmlzaGVzLg0KPiANCj4gTGluazogaHR0cHM6Ly9naXRodWIuY29tL2x3ZmluZ2VyL3J0dzg4L2lz
c3Vlcy8zMzcNCj4gU2lnbmVkLW9mZi1ieTogTWFydGluIEhyxa96YSA8bWFydGluLmhydXphMTIz
QGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNl
cmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVr
LmNvbT4NCg0K

