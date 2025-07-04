Return-Path: <linux-wireless+bounces-24813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7D9AF874B
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 07:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0545602A0
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 05:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1D2205E02;
	Fri,  4 Jul 2025 05:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Muwps9TT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4F61FF1C9
	for <linux-wireless@vger.kernel.org>; Fri,  4 Jul 2025 05:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751607129; cv=none; b=kd7OlWjp6WFxx2R8HahdPr9y+QGkgBnsrpNrr48EYdnMTTsaUqnDNSXB2VaBv8kmSgL/hKSfKJn3MuPhrRbof/hFfD4SKU2HfKe0lXyDDko5JOlcn3FGZc5StDW7RVBhL6R5f5rOiut0LgoN8tJ6MOd2Li/TgHzSmptmBUCIv+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751607129; c=relaxed/simple;
	bh=BVbbREn2AaWFqulhaUH6Zn37DbwK5DkNwCWs7IqZ8qg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mzoHfTFIoLeG/QQ0PEgTdxb15XTPJlLkdZj4UInk8mBxC4sizxLnoCG5zwFEcj5YkCzm4/2gYHzAcTJ4oe9v2QCpVwPL6NxkBMCoja+az5nBgIAjrU9AQW5wWo9fvCIlNWval5W/wZ8q3t1g07D/3iAsGaDoceqllDmmX5IB5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Muwps9TT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5645W24K03799291, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1751607122; bh=BVbbREn2AaWFqulhaUH6Zn37DbwK5DkNwCWs7IqZ8qg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Muwps9TTOjckUB7QBcnE6MRRCvNx4KGyujRopaDDzA2Ye4DxE3i4tMuTIL5q4UPWY
	 OQ4l398I8LBEiBSClnHvNQfYEdpd9UVsIx0E3rOC7e/wIgiGO9KvBQSFch9Ujyka1T
	 gkDilF2xgc5oBqymQ3z0/iEwOTyHcn3BtgLd3UOpXTSS8jq4rsIybdCFUY4zYCBkYA
	 hx216+tRCrbm9t+muy1LXXANEsheP59a1Rxfs3PMQf9w9O04E0UdzfNGa4IWLdJ6LI
	 bgUKUCBUVQ1DkqDrz7+GOTaUmTV7467xgGFYwTd63qWD5guG8wPWAKZ9ss0LqrLqMr
	 3Dj7FzxUC//Hw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5645W24K03799291
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Jul 2025 13:32:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 4 Jul 2025 13:32:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 4 Jul 2025 13:32:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Fri, 4 Jul 2025 13:32:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 5/6] wifi: rtw89: Add rtw8852bu.c
Thread-Topic: [PATCH rtw-next 5/6] wifi: rtw89: Add rtw8852bu.c
Thread-Index: AQHb6qHpa3VeTkhNf0uwDiFZVrjTR7QhdLNQ
Date: Fri, 4 Jul 2025 05:32:26 +0000
Message-ID: <38eb95e70be74dac93374cbc6dabd70f@realtek.com>
References: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
 <8297e328-446d-4620-8f49-eefaaeab5bf2@gmail.com>
In-Reply-To: <8297e328-446d-4620-8f49-eefaaeab5bf2@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGlz
IGlzIHRoZSBlbnRyeSBwb2ludCBmb3IgdGhlIG5ldyBydHc4OV84ODUyYnUgbW9kdWxlLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5j
b20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0K

