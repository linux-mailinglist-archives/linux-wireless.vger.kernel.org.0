Return-Path: <linux-wireless+bounces-12993-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A78697C252
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 02:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E551F22879
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 00:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE1C4A1B;
	Thu, 19 Sep 2024 00:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="G57YO9pq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC1F4A1D
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 00:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726705152; cv=none; b=g1tqcXsycuD6j4N6SmAtShGNrF45oqY3MY8CEYnXQjlfdBe1kBgV94v1EoruNFjR/0E3l9zObrT1PBaW5ARLcqMx17b89GOS25Xp3yOjrsbbP9v5KgGFjZp0bpONcPwsV93tP6hMYVaAS3kEl4lFn/lLIgLnQd427u24Dz4Gd2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726705152; c=relaxed/simple;
	bh=AQi2Ggqld+lpgU/mKVxHfxsWW6Rai3onQ3XXuVVDmLU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qxDjqprS5p8ZLARq4xjr3l8LayNPSosvKxIefeTGonaOUMwwnRn1wCdExuNheg0LWiu92MUnSx7nA4sRnwVR3lFUrJJ3eisPec0QXN6/2/c2IUbIyxNLBZWuPJ7XtG1rw1atE9e/jwkLeO+PMEOQ0l89cMrYOFfxvDT410ZWM0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=G57YO9pq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48J0J2xxC2905128, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726705142; bh=AQi2Ggqld+lpgU/mKVxHfxsWW6Rai3onQ3XXuVVDmLU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=G57YO9pqB42wYlDAJrOf5CbVxUlLTBO+WsqYFzInaHK6Dx/5GgpL6m+sjd0hPQYXP
	 YsAgI0ntKcSX3pYbVCEohrIL+X16vA0wm5fzcaXOfSvU6Gde/uNXZtx/kk1FruWv8b
	 eHeaHYpnD+rdmSiKC0cHKkyG+13fumBEwzZpx1q+nF3OaxS3SCzll38z59hGcFcVIA
	 2K07xwhzzJBMXEV6bbYx0XRdvjdRC0M8mTIde9XVDqraDgSeIq4WWWFY1KklwRG3oB
	 I8jostNNAhQ6lpgTmOCLwo0tpdDM4LB+CgCcRNEXuhHKin240UznfZ1NQsGb0Kwfoe
	 h9/Q5h17acQYA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48J0J2xxC2905128
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Sep 2024 08:19:02 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 08:19:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 19 Sep 2024 08:19:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 19 Sep 2024 08:19:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?Q2VtIMOcTkFM?= <cemunal@linuxmail.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: RE: RE: PCIe Bus Error from rtw_8821ce
Thread-Topic: RE: RE: PCIe Bus Error from rtw_8821ce
Thread-Index: AQHbCNiaV91dngQR6EiAODPVjiVajbJcwL+g///croCAAIoz8P//xIgAgAFUqsA=
Date: Thu, 19 Sep 2024 00:19:02 +0000
Message-ID: <ee1680e0f3e1460d8228ebecfd8e95b9@realtek.com>
References: <trinity-7a84c76b-e8b0-4da8-8f8c-07ad3485a23d-1726560422197@3c-app-mailcom-lxa11>
 <6d0fc72b21794f73a6017b467a102500@realtek.com>
 <trinity-154f2ef3-0df7-4802-88fc-d2ddcfb70a52-1726643761105@3c-app-mailcom-lxa04>
 <71107862cf8e451ca19c1dac72a51b4a@realtek.com>
 <trinity-dd463594-7071-49e4-8e07-e6c885c189e3-1726660668932@3c-app-mailcom-lxa11>
In-Reply-To: <trinity-dd463594-7071-49e4-8e07-e6c885c189e3-1726660668932@3c-app-mailcom-lxa11>
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

Q2VtIMOcTkFMIDxjZW11bmFsQGxpbnV4bWFpbC5vcmc+IHdyb3RlOg0KPiANCj4gWWVzLCBjaGVj
a2VkIGFuZCB0aGVpciB2YWx1ZXMgYXJlIHNldCBhcyAiWSIgYW5kIHRoZXJlIGlzIG5vIG9wdGlv
bnMgYWJvdXQgUENJIHBvd2VyIHNhdmUgaW4gdGhlIEJJT1MuDQo+IA0KDQpBZGRpdGlvbmFsbHkg
dHJ5IHRvIHR1cm4gb2ZmIFdpRmkgcG93ZXIgc2F2ZSBieSAnaXcgd2xhbjAgc2V0IHBvd2VyX3Nh
dmUgb2ZmJy4NCg0KVGhpcyBpcyB0aGUgbGFzdCB0cnkgSSBoYXZlLiANCg0KDQo=

