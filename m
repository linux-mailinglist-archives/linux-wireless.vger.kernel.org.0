Return-Path: <linux-wireless+bounces-19676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927E6A4B5E3
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 02:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9AD3A4FC1
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 01:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2E52C181;
	Mon,  3 Mar 2025 01:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="cN4WRPSF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABC02B9A6
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740966942; cv=none; b=Dh8E77ZEGXHqZgWeySXSbVpsW1fbLvvBXhcMlh6Kkkwuh1wE1adJbRV/6kW82ZSa+FRmTqWQD+jlyGvmtY+TaeadgFrOHb4I/90ONovuflwpCppucDDF+MIlOW+eWHIp0iSacWrlGoAlC2ZAFUAhuaPH3R1npfDe3fPpmO4wzsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740966942; c=relaxed/simple;
	bh=g7bN7l9Erch6qb7NxybFVKOmyPx6qAww9HpeDk0aylY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e0EJDrKLR1OcdocVUODHZ+wXl5v0HtZZj/Z24GX70jLJuns2tWpW5PkPTnSqHWp/RLWjmyimx4JScdDJ8MbbnlNQMEQ/+cF0PCodl6Bu4I8/qvoE642DFHuP1/gWfpDKh5BHnPxagqAKA+4JDPzOKawSvWFGsvltITzD4WyJnmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=cN4WRPSF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5231taF63385842, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740966936; bh=g7bN7l9Erch6qb7NxybFVKOmyPx6qAww9HpeDk0aylY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=cN4WRPSFaE1zMWNZxFVzSi4A5wazRWxf2U2hG0isV35UY2QGpbX5zxHm+Br4nWJHJ
	 WeUYSKYUFXL2toult7+mc0GBvEMyuKz9MLOLZoE1ajwojRYqv+DD6ylBoh1AmQqrOm
	 VgyBR/hc77MdbxaZ9oXePkgzc9c04SKKzvKKFenlj3GZY43IOwXdizqyMa1FSaFD4l
	 gXU4NVkEzrdahZV+UsXeXiYU3O2aT4jrdj6ZDx9QemeD5EkLtYn8UAe9vIVaoDJ7Du
	 AnWdJUVhm9dNCau8G0NKM7evfxhQuA44yg1NnnzcETpkRj7CXB27oi09KrBamYupl4
	 eAxEa1+eBlo7A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5231taF63385842
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 09:55:36 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Mar 2025 09:55:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 3 Mar 2025 09:55:35 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Mon, 3 Mar 2025 09:55:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 2/7] wifi: rtw88: Add rtw8814a_table.c (part 1/2)
Thread-Topic: [PATCH rtw-next 2/7] wifi: rtw88: Add rtw8814a_table.c (part
 1/2)
Thread-Index: AQHbiK/htrK6r2LZfUOZGeCF81K+JLNgrTRA
Date: Mon, 3 Mar 2025 01:55:35 +0000
Message-ID: <3d84b597a1fd4ec78bb0ec0b5aa7e387@realtek.com>
References: <8e9d900e-0721-425c-8466-bd57742c9f86@gmail.com>
 <98f26157-ceb8-43c3-ba1e-1a45da066625@gmail.com>
In-Reply-To: <98f26157-ceb8-43c3-ba1e-1a45da066625@gmail.com>
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
IGNvbnRhaW5zIHZhcmlvdXMgdGFibGVzIGZvciBpbml0aWFsaXNpbmcgdGhlIFJUTDg4MTRBLCBw
bHVzIFRYDQo+IHBvd2VyIGxpbWl0cy4NCj4gDQo+IFNwbGl0IGludG8gdHdvIHBhdGNoZXMgYmVj
YXVzZSB0aGV5IGFyZSBiaWcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRo
IDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtz
aGloQHJlYWx0ZWsuY29tPg0KDQoNCg==

