Return-Path: <linux-wireless+bounces-5525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BABA89136B
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 06:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056D82889E1
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 05:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5A53D551;
	Fri, 29 Mar 2024 05:53:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FC837714
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 05:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711691625; cv=none; b=hjRyRO7igqUoDrRens5OgrebtMSZZaYTI3sgpKahvqzfq8DBl8coVQKoIS5B8VFuh5A3P0SrxPefUKnNfke7zkpF4zB/mjLeoHQ4U2mjyu8QQ+kKuXchbe285J1V9L9DM+od+fDDt9d8fOKkFzAm/m3bEWVtsTmQRkCsX/27n+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711691625; c=relaxed/simple;
	bh=l+SvkHA/szmqTsW9obSYFYFFgycbp1yYIfn1mpKR4SA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NZazuY1kAwUTPt0Jy/tCoenvcZTQXxIs8r50OK0lkt8A1mSs/fLvU3G39HgElAUpQj4WwUXsjhkXSnHQ9+XyBzLm3JHbhmGviRmFXDSxr3huAIxVezXcNzyP7SuLBxLLkJSlYaBQtZN1i+ikFNfi+2jVkiYCj6GSEvwVkfsZOso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42T5reBmB3458865, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42T5reBmB3458865
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 13:53:40 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 13:53:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 13:53:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Fri, 29 Mar 2024 13:53:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?5pa95bCP5LiwKOWMu+eUqOWItuWTgeS6p+S4mumbhuWboi3ljLvnlKjliLY=?=
 =?utf-8?B?5ZOB6ZuG5Zui5pys6YOoKQ==?= <shixiaofeng@weigaogroup.com>
CC: linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: Is RTL8822CE with Kernel 6.1 for imx6
Thread-Topic: Is RTL8822CE with Kernel 6.1 for imx6
Thread-Index: AQHae6GreAtxLBDbLkylo+A0KBQKpbFDXUwggAmbqQCAAAOXgIAA6T/Q///WAYCAAIZrcIAAAR+g
Date: Fri, 29 Mar 2024 05:53:40 +0000
Message-ID: <78962cc266b94d2e97d4a5d5764c143d@realtek.com>
References: <28a3b031b06f46c5b10e100392a33286@realtek.com>
 <ABMAEQA-Hji8SdfUpl4fK4pZ.3.1711691249214.Hmail.shixiaofeng@weigaogroup.com>
 <62bd231147994d91bd55b57327990762@realtek.com>
In-Reply-To: <62bd231147994d91bd55b57327990762@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

DQoNCj4gPiBTbywgaSB3b3VsZCBsaWtlIHRvIGNoZWNrIHRvIHlvdSwgaXMgdGhlcmUgYW55IHN1
Y2Nlc3NmdWwgY2FzZSB0aGF0IGEgODgyMkNFIFdJRkkgbW9kdWxlIHdvcmtzIHdlbGwgd2l0aA0K
PiBLZXJuZWwgNi4xPw0KPiANCj4gSSBzdWdnZXN0IHlvdSBpbnN0YWxsIFVidW50dSBvciBvdGhl
ciBkaXN0cm8gb24geW91ciB4ODYgUEMsIGFuZCB1cGRhdGUNCj4gKHVwZ3JhZGUgb3IgZG93bmdy
YWRlKSB0aGUga2VybmVsIHRvIDYuMS4gSGF2ZSB5b3UgdHJpZWQgdGhhdD8NCg0KQnkgdGhlIHdh
eSwgcGxlYXNlIHVzZSBwbGFpbiB0ZXh0IG1vZGUgYW5kIG5vIHRvcCBwb3N0aW5nLCB3aGljaCBp
cyBjb252ZW50aW9uIA0Kb2YgdGhpcyBtYWlsaW5nIGxpc3QuIA0KDQoNCg==

