Return-Path: <linux-wireless+bounces-5524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D87889136A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 06:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E20B4B22DAF
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 05:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801693A267;
	Fri, 29 Mar 2024 05:52:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94C83D0D2
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 05:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711691537; cv=none; b=AQ42pfWWaZalugAMUSKh9x6K+qJoVgJ5XAH/JTBbiEoqhhlg6jPZ6IO9etVZbxmeqdsZaW9zLGs7tqb5Y2qd23T89T2NSGXu/E6Y15LAaADzQiK0HAscgop6FpNfCPUA9Yh2etRuzNlxH4mQIl3CVEi1WuX3PxhIbWBqXh86JfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711691537; c=relaxed/simple;
	bh=gvjgcjXqhQyj+/AH2oPLjiydGFY2BY1y8tUgGJhmlTE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X937VIYSexm2ZYuiBnvSr1x/EIfBscXqeMATSd6ak1UqahAeoY4kzDFlwt9lGz414chsuo9Do22hQ1s0jlpOfo+Mb1XGMue3CSpI6qcoLGzh6uwingvFf9mXXhVKDXCQT8RgelUwiMsS8wgnh6IIUIeMBI6tvDlTc4z0UX6QzJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42T5qBm653456752, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42T5qBm653456752
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 13:52:12 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 13:52:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 13:52:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Fri, 29 Mar 2024 13:52:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?5pa95bCP5LiwKOWMu+eUqOWItuWTgeS6p+S4mumbhuWboi3ljLvnlKjliLY=?=
 =?utf-8?B?5ZOB6ZuG5Zui5pys6YOoKQ==?= <shixiaofeng@weigaogroup.com>
CC: linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: Is RTL8822CE with Kernel 6.1 for imx6
Thread-Topic: Is RTL8822CE with Kernel 6.1 for imx6
Thread-Index: AQHae6GreAtxLBDbLkylo+A0KBQKpbFDXUwggAmbqQCAAAOXgIAA6T/Q///WAYCAAIZrcA==
Date: Fri, 29 Mar 2024 05:52:11 +0000
Message-ID: <62bd231147994d91bd55b57327990762@realtek.com>
References: <28a3b031b06f46c5b10e100392a33286@realtek.com>
 <ABMAEQA-Hji8SdfUpl4fK4pZ.3.1711691249214.Hmail.shixiaofeng@weigaogroup.com>
In-Reply-To: <ABMAEQA-Hji8SdfUpl4fK4pZ.3.1711691249214.Hmail.shixiaofeng@weigaogroup.com>
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

DQo+IFNvLCBpIHdvdWxkIGxpa2UgdG8gY2hlY2sgdG8geW91LCBpcyB0aGVyZSBhbnkgc3VjY2Vz
c2Z1bCBjYXNlIHRoYXQgYSA4ODIyQ0UgV0lGSSBtb2R1bGUgd29ya3Mgd2VsbCB3aXRoIEtlcm5l
bCA2LjE/DQoNCkkgc3VnZ2VzdCB5b3UgaW5zdGFsbCBVYnVudHUgb3Igb3RoZXIgZGlzdHJvIG9u
IHlvdXIgeDg2IFBDLCBhbmQgdXBkYXRlIA0KKHVwZ3JhZGUgb3IgZG93bmdyYWRlKSB0aGUga2Vy
bmVsIHRvIDYuMS4gSGF2ZSB5b3UgdHJpZWQgdGhhdD8NCg0KDQo=

