Return-Path: <linux-wireless+bounces-26855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAC5B3B320
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 08:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962D14609FA
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 06:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A085921CFFA;
	Fri, 29 Aug 2025 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="AasvgjlO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C817404E
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756448169; cv=none; b=tEZi30UarAyvzl3RvzJb8ujM/G0twZtkMRtaAhxYH0016kW+cARJKN2WOHTZg6UVFW5/r/MYQsTcNgD7UU5lE2z1/Df4Vc+MuBzZwCkF6ndfktLFuhdifEeuBHldFF+4pJu2Rhc8zZ+6wkyJRVgRMJ8fWEJgbVWIS38xcsb+vwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756448169; c=relaxed/simple;
	bh=9lR4h+D6J/bCbvKUfJNUrSnE11wnqZjJC+NW5xrgCAA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p1oQdaBKbqlxU2DhIFWlId0BEExjdnnUKoiCHule+F3RTL9BFHNxdoCPRkZzzFQ3seDpu2Srgi9ES4KNA2wIzYbBxg34K4DInlO2B0fON04AGHZNFy/vmLckgKLwOKljTHjieIHVyPLBRfiqFKm6MPXmiTzlOer5+LSzXL4AedM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=AasvgjlO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57T6G3Tu83106896, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756448163; bh=9lR4h+D6J/bCbvKUfJNUrSnE11wnqZjJC+NW5xrgCAA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=AasvgjlOu0Kq4ml7lZ51xXd6YK34busDxeeZ8+a4ioyszHgXYX9Fb/26Q9/RwZMa9
	 eEcq88wOPNLEehyXu8yUrkdaECYiKVomw/eAwBTx3k6mcaTr3B8TYg3RPjKBA5yuFk
	 CV/9OxWLMCs0KF0OTeYcGrOwppiBZqmS1JfgYoT0tw8PyOdIeeKdAvTvOmpAP5brON
	 T3REChZYVBDT99NE9Tgn6nrNSW8fmf0YSH15oQeNSz6sxmBFN/5qh8IMcdqMnsDpGF
	 3ldsTGbGO95sJPdDv2soP72r9SA+nMYD06BBbv03Qwn70hlUO3ZKLS4utT2iJ49XLW
	 G76OdPXPWzYNw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57T6G3Tu83106896
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 14:16:03 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 29 Aug 2025 14:16:04 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 29 Aug 2025 14:16:03 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Fri, 29 Aug 2025 14:16:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v3 03/11] wifi: rtw89: usb: Prepare rtw89_usb_ops_mac_pre_init() for RTL8852CU
Thread-Topic: [PATCH rtw-next v3 03/11] wifi: rtw89: usb: Prepare
 rtw89_usb_ops_mac_pre_init() for RTL8852CU
Thread-Index: AQHcF3LHDa7O+KJFfEazG3MKrMX7xbR5KdDw
Date: Fri, 29 Aug 2025 06:16:03 +0000
Message-ID: <3d9b967537724f6b995a7a8013146a44@realtek.com>
References: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
 <95a0f788-e80e-4864-b07d-02d4cb721763@gmail.com>
In-Reply-To: <95a0f788-e80e-4864-b07d-02d4cb721763@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGUg
cmVnaXN0ZXJzIHVzZWQgaW4gcnR3ODlfdXNiX29wc19tYWNfcHJlX2luaXQoKSBhcmUgbG9jYXRl
ZCBhdA0KPiBkaWZmZXJlbnQgb2Zmc2V0cyBpbiBSVEw4ODUyQ1UsIHNvIG1vdmUgdGhlbSB0byBz
dHJ1Y3QgcnR3ODlfdXNiX2luZm8sDQo+IHdoaWNoIGlzIGZpbGxlZCBpbiBlYWNoIGNoaXAncyBk
cml2ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2Vy
ZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsu
Y29tPg0KDQoNCg==

