Return-Path: <linux-wireless+bounces-19675-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFF7A4B5DF
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 02:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941743A2DE3
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 01:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4833114A605;
	Mon,  3 Mar 2025 01:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="KSvum7yG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E79139CE3
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 01:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740966732; cv=none; b=DEpa73bTwLN1NSertGeIuZD8wl3D7Ioii1HqQskCbqgPd7ryUQf6RN21GEGNdKucohK5VAeKCDnnuKf7xNDcx4PED0nSObLbCZmSC3ntCqT8VYQ9CkZDDcnJgjIorewEwVSZbUn+muuFIpcW/WQfeyEuJdAnRAtnNg4B2IXECQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740966732; c=relaxed/simple;
	bh=FxHc9C719Xc3i1iwtU4IgZUAFv6P8rduzpsAS4q2RZ8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gh6KNUhzR9QyhCsm+j92iYIfVGasmnvorKRxM5F+HUNYB1Sg40Ux3m5SyiSacK+7WA08WB7usP75FJE5cshfZ+Q1tzEjydctzI2iTE0c9NUZ3csLPCF/eVw9ox1pFTfn8j5hD2/ZSQto0QogeFgbuOcmNHJ0NrslpFj2yQApkxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=KSvum7yG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5231q5Zk9377768, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740966725; bh=FxHc9C719Xc3i1iwtU4IgZUAFv6P8rduzpsAS4q2RZ8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=KSvum7yGBVFGckMh+QOUM7B/AcZgRcx7ZXL/22cTHO7jYYjz1LfJbNnjVdIFFp0dY
	 HOgsntDZAZtwlaOfs0xZ2gOs5gIZvDtJrQ8QQ/+NCYlgu3wRshnnVMQmBiZbcK5PDb
	 4EDI1HpnBV2G+kE/n1xfYomXUObjakrdiptdprLqead56SRwxeqwpORzbANeLFmDuR
	 2iDlWFGkoXBCfrX5eoVI5czk8nYS3Z6G/uJOmy4+RyZ5zypdl94UAxxR8InAJ238gZ
	 CbduKcGGrEqjx2EtQUrnGnKBAZQiDZpVPvEo67RxtYPfMpoSB1q6A1tOgMppp9LF40
	 PuBdi5KjXkqxQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5231q5Zk9377768
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 09:52:05 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Mar 2025 09:52:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 3 Mar 2025 09:52:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Mon, 3 Mar 2025 09:52:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 1/7] wifi: rtw88: Add some definitions for RTL8814AU
Thread-Topic: [PATCH rtw-next 1/7] wifi: rtw88: Add some definitions for
 RTL8814AU
Thread-Index: AQHbiK+/pxd1orxab06LR+fBi+ThK7NgrDRw
Date: Mon, 3 Mar 2025 01:52:05 +0000
Message-ID: <b6a5282950c44852bd91bab6094aeadb@realtek.com>
References: <8e9d900e-0721-425c-8466-bd57742c9f86@gmail.com>
 <2a18fa0f-0a80-4059-b69c-907e18d85893@gmail.com>
In-Reply-To: <2a18fa0f-0a80-4059-b69c-907e18d85893@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBZGQg
dmFyaW91cyByZWdpc3RlciBkZWZpbml0aW9ucyB3aGljaCB3aWxsIGJlIHVzZWQgYnkgdGhlIG5l
dyBkcml2ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIx
Y2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0
ZWsuY29tPg0KDQoNCg0K

