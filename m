Return-Path: <linux-wireless+bounces-5506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E61EA890F11
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 01:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230AC1C20A1B
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 00:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67776A35;
	Fri, 29 Mar 2024 00:17:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B184A34
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 00:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671465; cv=none; b=bn6kckh2Gv5BSZ6r+CQsTRe1royyXdg/nsUIEaDHWh5ulVJeEtu6gCXAnN4dI8ruXElVWd88c6/4iO28euVI3iTRa4Dmzgg1pMQwegjaX9LO3/ODeo3UoDleTY9k/SAvhvLpg9i4zvEavpSUkRVa5+tcg/Bq7kA47nXVV0a70YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671465; c=relaxed/simple;
	bh=qsJBs4DVI20kc8zXYHDNMNrzsZUo9NaRWCChfiFSDl4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=orwg5k7ngm5EVPRKtmNSoUOT820L99Gr3nVNHI6vgw5VSuWAveQLL2ONi78XKzqIGXOSh6W2Q8NylzcPcsmpz4MdZo6B2ZK83qhkFJjgfCPa+qifXfXrNkBFaMfSea6QO24AXZeaPv20OSnk6vupop/yPcDmz9XPdtmWiPzWpfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42T0HdEA23078189, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42T0HdEA23078189
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 08:17:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 08:17:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 08:17:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Fri, 29 Mar 2024 08:17:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?5pa95bCP5LiwKOWMu+eUqOWItuWTgeS6p+S4mumbhuWboi3ljLvnlKjliLY=?=
 =?utf-8?B?5ZOB6ZuG5Zui5pys6YOoKQ==?= <shixiaofeng@weigaogroup.com>
CC: linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: Is RTL8822CE with Kernel 6.1 for imx6
Thread-Topic: Is RTL8822CE with Kernel 6.1 for imx6
Thread-Index: AQHae6GreAtxLBDbLkylo+A0KBQKpbFDXUwggAmbqQCAAOpUAA==
Date: Fri, 29 Mar 2024 00:17:39 +0000
Message-ID: <9bf07ffb8f1b487d910b445e0cf1fda6@realtek.com>
References: <a0aa71e3ca0e42f09abf658401070208@realtek.com>
 <AHYA5ACwHqi71yYpWUIbQ4qs.3.1711649408218.Hmail.shixiaofeng@weigaogroup.com>
In-Reply-To: <AHYA5ACwHqi71yYpWUIbQ4qs.3.1711649408218.Hmail.shixiaofeng@weigaogroup.com>
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

DQoodXNlIHBsYWluIHRleHQgYW5kIG5vIHRvcCBwb3N0aW5nIGZvciB3aXJlbGVzcyBtYWlsaW5n
IGxpc3QpDQoNCj4gwqBXaXRoIGtlcm5lbCA1LjQsIGl0IHdvcmtzIGZpbmUsIGJ1dCB3aXRoIGtl
cm5lbCA2LjEsIGl0IGRvZXNuJ3Qgd29yay4NCg0KSWYgeW91IHN1c3BlY3QgcnR3ODggb2Yga2Vy
bmVsIDYuMSBnZXRzIHdyb25nLCBwaWNrIGl0IGJhY2sgdG8ga2VybmVsIDUuNA0KdG8gc2VlIGlm
IGl0IHdvcmtzLiBPciBvcHBvc2l0ZWx5IHB1dCBvbGQgZHJpdmVyIHRvIG5ldyBrZXJuZWwuIA0K
DQoNCg==

