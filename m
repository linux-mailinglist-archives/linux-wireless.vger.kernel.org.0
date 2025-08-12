Return-Path: <linux-wireless+bounces-26280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8A0B219B8
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 02:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380C2427CAD
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 00:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B972285CA4;
	Tue, 12 Aug 2025 00:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Fr4HX8+r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF4F2236E8
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 00:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754957980; cv=none; b=ioIZJRXLeaH7qirEkMHBEe6Yabo/vanNrHsxBH6ti5rJdxTHHHkA+q1cH0d9VwXUYBQ2CRRp2GSPVN7ut8tImdBPOmm0D/+tKRxsW81YpcDux0VcDa45m0rM5O0KVZERz5f7W1p6Ey8+iNF94louUrPKEKT5WmpRbZ3vfvFOZbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754957980; c=relaxed/simple;
	bh=AAtvePSSRxFTuGex5HU2IyHwNq6weITLsOrnA08ypNY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=awBBqPhQVk4A2peF+UsQ5RnX35Zx5TTkqyyIMlDk5pnQ0FeZ3F5NxpF/1CfPzQng5FagHq/Bt/rEe3RMvxlDMg/OXS6NbFRO1y5vfy+9HQf6u9w7dIqrosT2yrz6Z+q5FREdxglAvC6LaBs2bN8RCdUyE9e0JZ7ibDaRdpfufFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Fr4HX8+r; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57C0JMKT0951522, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754957962; bh=AAtvePSSRxFTuGex5HU2IyHwNq6weITLsOrnA08ypNY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Fr4HX8+rnKyIDgNUn88te+cuTHKWHf/MurZqtxTECRX7FRBtBmmUmz+82OhMnozqY
	 e99rOjssb505CKb+ljVXtproOl/dZD9N3VmkuDSmklrNGbyAayBJax3N/GS/Jm0Mca
	 599rRET+q9TpXAD834YdhyE58SEZprEIleZUf4FQwAtrpwKDNq0xY0fdGNOnA71mhY
	 bS71MTYcL6PMxEncZEcBziOM0mbYxvqHaqk/PXK1kAFTz1/bsc6gtnB77xZo+J+sY6
	 5nIObu0SmCBUR9Jf7qcGI5hIOM2SkiRU+/xc69tFDThD6yG504cVjT9S5av1cbHHrc
	 SzFvvwzmryKmA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57C0JMKT0951522
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 08:19:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Aug 2025 08:19:23 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc%10]) with mapi id
 15.02.1544.011; Tue, 12 Aug 2025 08:19:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Helge Deller <deller@gmx.de>
Subject: RE: [PATCH rtw-next 1/2] wifi: rtlwifi: rtl8192cu: Don't claim USB ID 07b8:8188
Thread-Topic: [PATCH rtw-next 1/2] wifi: rtlwifi: rtl8192cu: Don't claim USB
 ID 07b8:8188
Thread-Index: AQHcCtU6QxjNdNLQ8EeyVjPOOkUsXbReJ64A
Date: Tue, 12 Aug 2025 00:19:22 +0000
Message-ID: <084256307e654f12ad6f468de8233b90@realtek.com>
References: <2e5e2348-bdb3-44b2-92b2-0231dbf464b0@gmail.com>
In-Reply-To: <2e5e2348-bdb3-44b2-92b2-0231dbf464b0@gmail.com>
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
IElEIGFwcGVhcnMgdG8gYmUgUlRMODE4OFNVLCBub3QgUlRMODE4OENVLiBUaGlzIGlzIHRoZSB3
cm9uZyBkcml2ZXINCj4gZm9yIFJUTDgxODhTVS4gVGhlIHI4NzEydSBkcml2ZXIgZnJvbSBzdGFn
aW5nIHVzZWQgdG8gaGFuZGxlIHRoaXMgSUQuDQo+IA0KPiBDbG9zZXM6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzL2VlMGFjZmVmLWE3NTMtNGY5MC04N2RmLTE1ZjhlYWE5
YzNhOEBnbXguZGUvDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYt
Ynk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpBY2tlZC1i
eTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg==

