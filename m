Return-Path: <linux-wireless+bounces-30905-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E0ED309C6
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 12:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B14E30734FC
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 11:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDF336655C;
	Fri, 16 Jan 2026 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="frIBqlZi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44528322B72;
	Fri, 16 Jan 2026 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768563700; cv=none; b=h63GzEickAcQVL6xUaEVBXZlRznM9/anP1AmDPAH69N7oft2zWHFJE5BO/tsR/VjLu8KUkCOKo3+jpTW0f7r6j4PolFQv2QyECNldtPMgtp7BsR0tw3Khdc98pUTT6p3ClTGH8phaKAq1VgAztVf7NQYfBXykFeljwtJddMvryM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768563700; c=relaxed/simple;
	bh=3MLMUwqS1xUYXjIK4uS5nf0DKDLqE966MTs+MDAWcaI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j33x9Uic+n47tiEXYIhb4uC1iVHR5wCaFOdoYy416T84TAH24H6GtpHMUePIWrk58S3qU7Sd41m65lzrAVEODe9GAv9c9U2HVoYTTohmq2cLG51a7c0zQiSboA2fnHwy/gCEWEZMBZmq+HVnttpSFEJMbrKcJWdMz9oebgpMfQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=frIBqlZi; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60GBfWd55980196, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768563692; bh=3MLMUwqS1xUYXjIK4uS5nf0DKDLqE966MTs+MDAWcaI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=frIBqlZiBdEtfDW0o+Ofb6HpEVhnhbA20pOfLNFuVQPK5Eup/Jv9iImHOkxuhJWiV
	 LFAg5I6a5HghkVxaXvH2QXuajakw0dNo09AzVQGOFezqr1rmiY8H1XlcP77xoRgvNu
	 RiD/nRz/HyG0xUS7z8SuTxE6EXhmQsiBnjUOGQnqSfDJcMMlhyLyxsjs5cvzdDdkCF
	 FdFve4sdkpqTrRR4u1A7ZtemOjWALZNCarEHEOGrjJDK39wj62dPU4Im95l98v6nas
	 CaIDlaxRbvId3mVK6fC/gcy6MsF4II3QMhf9umGLm+3ngXnVurREDHDh5zauoYeY9N
	 kRZQ1LvwACNgQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60GBfWd55980196
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 19:41:32 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 16 Jan 2026 19:41:31 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([fe80::8bac:ef80:dea8:91d5]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::8bac:ef80:dea8:91d5%9]) with mapi id
 15.02.1748.010; Fri, 16 Jan 2026 19:41:31 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Markus Elfring <Markus.Elfring@web.de>, Zilin Guan <zilin@seu.edu.cn>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Ping-Ke
 Shih" <pkshih@realtek.com>
CC: LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>,
        Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: RE: [PATCH] wifi: rtw89: debug: Fix memory leak in
 __print_txpwr_map()
Thread-Topic: [PATCH] wifi: rtw89: debug: Fix memory leak in
 __print_txpwr_map()
Thread-Index: AQHchr0WflTXzBa1CkaZ7RXjavv0q7VUHE+AgACLEkA=
Date: Fri, 16 Jan 2026 11:41:31 +0000
Message-ID: <acc90353107248b98215847e56bb374b@realtek.com>
References: <20260116074836.1199951-1-zilin@seu.edu.cn>
 <1d32418f-c315-4ce4-9b4c-6781bda72cfe@web.de>
In-Reply-To: <1d32418f-c315-4ce4-9b4c-6781bda72cfe@web.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

TWFya3VzIEVsZnJpbmcgPE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4gd3JvdGU6DQo+IA0KPiDigKYN
Cj4gPiBGaXggdGhpcyBieSBmcmVlaW5nIHRoZSB0ZW1wb3JhcnkgYnVmZmVyIGJ1ZnAgaW4gdGhl
IGVycm9yIHBhdGguDQo+IOKApg0KPiANCj4gSG93IGRvIHlvdSB0aGluayBhYm91dCB0byB1c2Ug
YW4gYXR0cmlidXRlIGxpa2Ug4oCcX19mcmVlKHZmcmVlKeKAnT8NCj4gaHR0cHM6Ly9lbGl4aXIu
Ym9vdGxpbi5jb20vbGludXgvdjYuMTktcmM1L3NvdXJjZS9kcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0dzg5L2RlYnVnLmMjDQo+IEw4MTUtTDg1OA0KPiANCg0KVXNpbmcgX19mcmVlKFhY
WCkgaXMgZmluZSB0byBtZS4NCkJ1dCwgSSBkb24ndCBzZWVtIHRvIHNlZSBERUZJTkVfRlJFRSh2
ZnJlZSwgLi4uKSB5ZXQuDQpTbyBwZXJoYXBzLCBuZWVkIHRvIHVzZSBfX2ZyZWUoa3ZmcmVlKS4N
Cg0K

