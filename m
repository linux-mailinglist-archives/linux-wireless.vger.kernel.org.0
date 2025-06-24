Return-Path: <linux-wireless+bounces-24399-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 154D3AE5C11
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 07:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39AD1BC00D8
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 05:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FE8227E8F;
	Tue, 24 Jun 2025 05:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FODaoirL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397B020EB
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 05:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750744340; cv=none; b=UHS5LhfCv3YKtfquFOQCTXOrOKXJ1ZC7OlLEmKNht5uIhUUv9AnAjNjmX+iOXiJi56KEc+dCXXJq87Zr3kf9n06tv4IsYzY27TaElsHO3qlNtDYdTIRYimP9SjnIFfSDNcYAzSspscXVWtfXZRsrAvMOVpIHRfZMxYxyHRwyXIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750744340; c=relaxed/simple;
	bh=P4NEvWnOW2bwAZmgcydknSfd3//nyyhCasIdV2gZmGM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t7sJhCjm9e/aQxCNvGU0plUWZ42T3tL8Iuh9Ux2d4m1xWzadZyBxdH2+516TL+Sg4BA7xE1eMWL66/SebN4pj9ZihUfl9SPImJHKAJG4JCEQVguuLZIRWV87QCsXWwEYrRo/FzECEmzmCoeSK14s8zm8/Ay5SPG1iOObs9V7ePA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FODaoirL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55O5qFt953104316, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750744335; bh=P4NEvWnOW2bwAZmgcydknSfd3//nyyhCasIdV2gZmGM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=FODaoirL/urdq2MJyrTfUV31S58LCjIf/dOZJxLQroRJfn2vzOKDqV6fg3vZR+KTz
	 E2KEurSQ23/vdZMB+ICHFGlNJfFA5JJiZb7Q8qB2nNqjZzUaVxAQ1I0gb/LO/O73ao
	 KvQGFvFIkzqj53jzQUiMhaqvqQvwhn6oJS2gf776AnKEysUYG8r2lWVi4kq/ck7xqD
	 ggmn2F0Pq/j/2mAW1k6Dc/bPuN9eFoPQXpdEKnKgHJznRa+1N8w0Pa30JS/9wSTHXM
	 APg+Bbj0kaB1A4EE8rtlglIHyWxXKiqAIRyDx8g0TwYkHshqrz2MInSna83ZBUDAlC
	 ZAbBuICMO4aNw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55O5qFt953104316
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 13:52:15 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Jun 2025 13:52:29 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 24 Jun 2025 13:52:28 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Tue, 24 Jun 2025 13:52:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v3 10/14] wifi: rtw89: Fix rtw89_mac_power_switch() for USB
Thread-Topic: [PATCH rtw-next v3 10/14] wifi: rtw89: Fix
 rtw89_mac_power_switch() for USB
Thread-Index: AQHb4hXfaOS2U5CVtEyauHxVmgda97QR1BFQ
Date: Tue, 24 Jun 2025 05:52:28 +0000
Message-ID: <be1d93105f824d71a32e8b0327967189@realtek.com>
References: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
 <3799b797-7d9a-4e8d-b9d5-73db3d3eccf8@gmail.com>
In-Reply-To: <3799b797-7d9a-4e8d-b9d5-73db3d3eccf8@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBDbGVh
ciBzb21lIGJpdHMgaW4gc29tZSByZWdpc3RlcnMgaW4gb3JkZXIgdG8gYWxsb3cgUlRMODg1MUJV
IHRvIHBvd2VyDQo+IG9uLiBUaGlzIGlzIGRvbmUgYm90aCB3aGVuIHBvd2VyaW5nIG9uIGFuZCB3
aGVuIHBvd2VyaW5nIG9mZiBiZWNhdXNlDQo+IHRoYXQncyB3aGF0IHRoZSB2ZW5kb3IgZHJpdmVy
IGRvZXMuDQo+IA0KPiBBbHNvIHRlc3RlZCB3aXRoIFJUTDg4MzJCVSBhbmQgUlRMODgzMkNVLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFp
bC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0K

