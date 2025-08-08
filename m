Return-Path: <linux-wireless+bounces-26221-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C445FB1E1FD
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 08:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F5418C0D23
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 06:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BD221D00D;
	Fri,  8 Aug 2025 06:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="YVT5GH1r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D641F8908
	for <linux-wireless@vger.kernel.org>; Fri,  8 Aug 2025 06:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754633585; cv=none; b=b0v8Ji7TQ5L02oay0G0voA37oq+vsVTaklHCAqAlF5tkAk5CTpipUihWJW380QGadWpxnfdjjH6peNAGr5NV8ze6jPVp1wShEn9bV+SYC20cOx3CSNHnUdrZ4qSoDB6Yrs0X+xkH/M7HxkuskDNvrlUMRUep2fiAVoGFN45OpGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754633585; c=relaxed/simple;
	bh=QV1dI7BnsSx40zU0QcUovo7odve4DRWsuVQ5J2sWvcw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j/TjfTJ/vMbV6Ky6+YOzAd+t8e4lWjYz0xaCFMWFQEaoyYiFdoEDTcAcrkao6Qpzs9EyRmXtwhdRPsfvs7j8hq4SaLCnIVstBJpC/MKTWe0PiwGx8gMB9PJTOI9eyfIoIZooN3I/HSMWEvxIeObPBk4wTFmawgl3tc1TyooupNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=YVT5GH1r; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5786CxY822791750, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754633580; bh=QV1dI7BnsSx40zU0QcUovo7odve4DRWsuVQ5J2sWvcw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=YVT5GH1rsOVXn83K4lhe32uPkO16VXXFuC7O8qfYk88OV18rp5lNh6yjHUrcxnFSE
	 Q1Z5IxzcUsmpnPm1ShaB7sBwdf5QAfvyMG9TTF03JpjmlFn0cfUGnCigwrSBB4yru4
	 RQgh2CwMDVNTaoIbcv33FMXuYnrxappTmWVBsEBCfY+ysyOocrPIc2hH77Tme54jr6
	 9tB7Nk+1EiFHoXPRKp3pCNIYirSrtt4lt3cdBULYipgcQzTJLM/tHFzNfgk5cogBNO
	 QiZXsRRROKZgT9LYAjjsR/gaXwc3kGFE0xbbEInTT0mj9rAZXcVGbaWRgxXkpTmjNu
	 FIp6e/fShtaMw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5786CxY822791750
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 14:12:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Aug 2025 14:13:00 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc%10]) with mapi id
 15.02.1544.011; Fri, 8 Aug 2025 14:13:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 10/11] wifi: rtw89: Add rtw8852cu.c
Thread-Topic: [PATCH rtw-next v2 10/11] wifi: rtw89: Add rtw8852cu.c
Thread-Index: AQHcAyguUXncGE9dLkuGr7z1LXmSf7RYUJUA
Date: Fri, 8 Aug 2025 06:13:00 +0000
Message-ID: <b26fc7f2f3354f76b061b448c8d09ab6@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
 <d48aa985-2955-4ebf-ac9d-aa384313eb6e@gmail.com>
In-Reply-To: <d48aa985-2955-4ebf-ac9d-aa384313eb6e@gmail.com>
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
IGlzIHRoZSBlbnRyeSBwb2ludCBmb3IgdGhlIG5ldyBydHc4OV84ODUyY3UgbW9kdWxlLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5j
b20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

