Return-Path: <linux-wireless+bounces-11468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC179529C6
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 09:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0FC71C20A73
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 07:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A1817A938;
	Thu, 15 Aug 2024 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="EJdUWtiV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C6517A5A6
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723706393; cv=none; b=eKQzsY7bw06DNAjSXte76M5xbqnAtU26mNKvvh2gEWeGgZPp30CMMNVR+Cw19d1bOgCYSyKev/BS0YyrujgQ2jsFh2InjnFp/dtJua1wCt/C5UQrZJrx3PBpShMLH5aQMUqvQUwRCJQP7iWY/xtLAJ0Ics24vr7kKYj8CrGQnEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723706393; c=relaxed/simple;
	bh=SdZB91kpJNyEvbbmEdLhhfjNS7fIBukE23JIgkYUbKA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RLHWyhJNf4G3hTAVxXZbrsuFmuCtqaw6iXDArkg7GSovCaDp/kO0lSw3vKWu6OCk01ZimB1hs3mZMtvl6b0ESSi/SMLS+YrUlH2ZKf57h0WRtNPKCTr6kcineD7jYVCLFRB9IA7yjoQb9Qf/4n7weAV5Fbuoweva97nhENkVbUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=EJdUWtiV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47F7Jl2V23733272, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723706387; bh=SdZB91kpJNyEvbbmEdLhhfjNS7fIBukE23JIgkYUbKA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=EJdUWtiVfgLAT6MtkVUiS/I46hGhcS/3NkbFkWwwMf6Q6kvoI53R3cwaRKXCdIMdS
	 Fu3Yk9LugZmQeOls/B4sVuLHAgMzoc3ZIZ4d1rTlU1h+F4S9kFcG9HhY4GNfIYgE8f
	 CV1g/bie2FgTuX9f7pMnTe1hK4mRmDzMLSVqU9yiMIHDoNtEbU8dwl8g+rlqKCWhwq
	 olevc+FAGzCxOZE97VIt6EpeOEBMbKvjhgdcTzEqOLeTaTS4rnR4jCGuXPwrZSFPj8
	 oik97AUJLMb8l6zFynUg1a2CD9bSWDs0oVZyypRoAMG9+1baRKXDx7YxLK3Y8cnjnQ
	 viW1Oeaad/EQg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47F7Jl2V23733272
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 15:19:47 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 15:19:48 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Aug 2024 15:19:48 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0]) by
 RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0%5]) with mapi id
 15.01.2507.035; Thu, 15 Aug 2024 15:19:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 13/20] wifi: rtw88: coex: Support chips without a scoreboard
Thread-Topic: [PATCH 13/20] wifi: rtw88: coex: Support chips without a
 scoreboard
Thread-Index: AQHa7DHwLjQXTvSMpEmH+xaoHCNvdLIn7ogw
Date: Thu, 15 Aug 2024 07:19:47 +0000
Message-ID: <a0f328d0fca44364bcf1fd27de227284@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <0c597b71-4359-4571-91f8-44910854a136@gmail.com>
In-Reply-To: <0c597b71-4359-4571-91f8-44910854a136@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBbGwg
dGhlIGNoaXBzIGN1cnJlbnRseSBzdXBwb3J0ZWQgaGF2ZSBhICJzY29yZWJvYXJkIjogdGhlIGNo
aXAga2VlcHMNCj4gdHJhY2sgb2YgY2VydGFpbiB0aGluZ3MgcmVsYXRlZCB0byBibHVldG9vdGgs
IGZvciBleGFtcGxlLCB3aGV0aGVyDQo+IGJsdWV0b290aCBpcyBhY3RpdmUuIFRoZSBpbmZvcm1h
dGlvbiBjYW4gYmUgcmVhZCBmcm9tIHJlZ2lzdGVyIDB4YWEuDQo+IA0KPiBSVEw4ODIxQVUgZG9l
c24ndCBoYXZlIHRoaXMuIEltcGxlbWVudCBibHVldG9vdGggYWN0aXZpdHkgZGV0ZWN0aW9uIGlu
DQo+IHJ0d19jb2V4X21vbml0b3JfYnRfZW5hYmxlKCkgYmFzZWQgb24gdGhlIGJsdWV0b290aCBU
WC9SWCBjb3VudGVycy4NCj4gDQo+IFRoaXMgaXMgbW9zdGx5IGltcG9ydGFudCBmb3IgUlRMODgx
MUFVLCB0aGUgdmVyc2lvbiBvZiBSVEw4ODIxQVUgd2l0aG91dA0KPiBibHVldG9vdGguIFdpdGhv
dXQgdGhpcyBjaGFuZ2UsIHRoZSBkcml2ZXIgdGhpbmtzIGJsdWV0b290aCBpcyBhY3RpdmUNCj4g
YW5kIHRoZSB3aWZpIHNwZWVkcyBhcmUgbG93Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVy
Ymx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtl
IFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

