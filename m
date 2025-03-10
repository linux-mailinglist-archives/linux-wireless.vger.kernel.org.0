Return-Path: <linux-wireless+bounces-20102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3178EA58DDE
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 09:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2C227A2DEA
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 08:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564BDF9CB;
	Mon, 10 Mar 2025 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="W5RA7Gtz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F2714A09E
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594677; cv=none; b=CkjSYZvEuXC5VZ9VjLoH3cfosTq7MeVYL10noiFT7k0kyz5yGbol8Hpmgq0nK5TZNGD4Pn2XLSB4nSe0+6vd7ogSRukhPoudTv2tUPCO8LbzKnQvGWGwMdmTaUPsHw2ro+kR23TobV3Zw0qiAY5W4htnMAFXe0dAMR4UnsXlUCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594677; c=relaxed/simple;
	bh=N6wRg0ArvNT9ioe1qNCLi778E/9CRh0UPvKAxkIq5zU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NLkou3KofzSbkF2Q7Bl6pyjETWOY4RPxUNpuaLEBawu/9GExC12t0Wl3uOtWem6dYTA92BsYG5cYN3REtlCXsDfbVVb13/KlTT/B2SpnuEThvt/GmZHjHna4vjvMcgsVikBtmSY4Nm7MCUG7iREVeTbkIEC2iBwE2D6DoFOhz2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=W5RA7Gtz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52A8HnHdA2795203, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741594669; bh=N6wRg0ArvNT9ioe1qNCLi778E/9CRh0UPvKAxkIq5zU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=W5RA7Gtzze411AjlkmopSGii013qkU3YjZj3O6pDFrOTXeDIcKn7qeWEceOVELYqm
	 awTxughOEdKcKiwrX8YDbmaY3ja7PH5SSJfQKfBImpfp15tlBN7yPypkr+GUABeCWd
	 4mhV2arDcsQWorrl9VnYmnk6iYaYQn0BlbkO+wcxK5spAJnc0KJhfSLMcrE5guV/tV
	 bNnViWn/KqCfs4LM9e3/EiWdcpXwazCtibslSadlkhaLlnpBtAUU9x5hU9PJ6F9rRg
	 Zt5cqYhGESAIgK5NcdJDd6YYcPENkKdCuxJ+hggfVNPhyVf/G1jVUWlfy+y8L/Zy5B
	 y/Yne6ej4uvfw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52A8HnHdA2795203
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 16:17:49 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Mar 2025 16:17:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 10 Mar 2025 16:17:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 10 Mar 2025 16:17:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 1/7] wifi: rtw88: Add some definitions for RTL8814AU
Thread-Topic: [PATCH rtw-next v2 1/7] wifi: rtw88: Add some definitions for
 RTL8814AU
Thread-Index: AQHbjvb/RgdD33Ca30OlhC8oPpokRbNsC8dw
Date: Mon, 10 Mar 2025 08:17:49 +0000
Message-ID: <f2af0e17d8f8434d84f36dcf50aebda4@realtek.com>
References: <d25331f4-653d-4ab1-b3dd-0ec1a73209e0@gmail.com>
 <1dcb5abb-26f8-4db5-be36-057de56465e5@gmail.com>
In-Reply-To: <1dcb5abb-26f8-4db5-be36-057de56465e5@gmail.com>
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
ZWsuY29tPg0KDQo=

