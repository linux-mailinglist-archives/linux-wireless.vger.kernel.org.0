Return-Path: <linux-wireless+bounces-10167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB3992DDA6
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 03:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D195E1C21808
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 01:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0293201;
	Thu, 11 Jul 2024 01:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="AzOdFXgS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB89EDE;
	Thu, 11 Jul 2024 01:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720660090; cv=none; b=RWbfm60nSqfriN1zBFQ9uL32mLXlEHRLAuetGyFTk8trENdq1SNXrqNnIZ8ksvHlZWvxy4VtfR5soFESKKTBqCNpGrzcU6BYqBSenKYA8+AvX2sVDmaLdiszskJxbE7tsIxV96CbTcvwrz9md/wK9WA7DticcIABIJosUqeYnI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720660090; c=relaxed/simple;
	bh=GZ6TeTkURZEkICEupC4JglsSBRC3luXvLeZtmEQBQ+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bQakTV2sHnuxfxhbhPwWyvpQx2K0jTvuIHft3eEEsNt1wa80RafT9vMnuFamq2VcZaE36Hgl1A2itrFEFXcLs1Icjklux5ri0AFdfNHoLP9pTnnyuDdF/DtsHfDonW4r/36pU1l61eIhsv5o/xln1J/ecv1dQGkInrltxS+rOWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=AzOdFXgS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46B1803102704447, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720660080; bh=GZ6TeTkURZEkICEupC4JglsSBRC3luXvLeZtmEQBQ+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=AzOdFXgSQ9JrT6dxZdsCSbYqNE7vTsm0VnpamxKUIg4LODV8Bm3fLSBDeTAAASK9h
	 Lv5dh2JlFfjNVXD877pROXHJspR1MgnY0/3lc1jrhFBuYvQtXJRQAoX33Mqf652a9Z
	 YaOe+HgmILHdJix860KfDs/fAVXirG12RGN0bv246C5ibj2Pu3/Q6QnZ1SKP4qc+g6
	 MroKD0S87lzw1ydEWlfSJNc7uReyBmB+4VYmNvQIlFnLxAQZBv5WTpodP2I3ObUidh
	 7bWivBJPTxYfug4L7wWBrI6FBIF1SNbbPLNpDi6TxyYEg4LDyCg4QfF4f+Sq0NiN5l
	 oRofnagrjHUMw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46B1803102704447
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 09:08:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 09:08:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jul 2024 09:08:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 11 Jul 2024 09:08:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Colin Ian King <colin.i.king@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] wifi: rtw89: 8852bt: rfk: Fix spelling mistake "KIP_RESOTRE" -> "KIP_RESTORE"
Thread-Topic: [PATCH][next] wifi: rtw89: 8852bt: rfk: Fix spelling mistake
 "KIP_RESOTRE" -> "KIP_RESTORE"
Thread-Index: AQHa0ruFWRpvCWi/UkaLsQbm6z/XUrHwt/sw
Date: Thu, 11 Jul 2024 01:08:00 +0000
Message-ID: <f188660d4333447381cc708008d3e9a9@realtek.com>
References: <20240710112253.228171-1-colin.i.king@gmail.com>
In-Reply-To: <20240710112253.228171-1-colin.i.king@gmail.com>
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

Q29saW4gSWFuIEtpbmcgPGNvbGluLmkua2luZ0BnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGVyZSBp
cyBhIHNwZWxsaW5nIG1pc3Rha2UgaW4gYSBsaXRlcmFsIHN0cmluZy4gRml4IGl0Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmkua2luZ0BnbWFpbC5jb20+DQoN
CkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

