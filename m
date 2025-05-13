Return-Path: <linux-wireless+bounces-22896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD96AB4BC8
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 08:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96DD27A396F
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 06:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743361E98EA;
	Tue, 13 May 2025 06:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="cZpMk3JP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D8F1E47BA
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747116847; cv=none; b=eaZ9NBO+PzAXosxNr08ai9n5B8peZSxv+n2dJVOHGnHYdhqcN3h4mS0ewBWYFa7SH2s2YKg8+PALXp0Uj1dQnLFrCBREBnds9mORI1JDeLj5ai0sLs9BV0i2kHs7Z3R4oxk3ReIJUwVFJjwFD65cxcf6I5XV1bn7f2rxBf2XMn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747116847; c=relaxed/simple;
	bh=65gXDKD2g20IOsS9tdLoPm2BGC8M3K4jBD4Z+SWaPR0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ejwfA65nVtM43fnqIW8WLZM1yrY3AXsAbpZy8/Hi1HDoOzRr2kMKhFiMMsCq/ol0SojpWFgJ3bocZKwEyeRQd8XzInnkplhgYyQgXufhoYucHT2Jd/3GV8bAy8MNpzaDxw6pWN7iMxCY2l6/br4mVmF+57MTXWn4uAZndWg11e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=cZpMk3JP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54D6E1tU43823934, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747116841; bh=65gXDKD2g20IOsS9tdLoPm2BGC8M3K4jBD4Z+SWaPR0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=cZpMk3JP4Cay7H1teMWRdUdjxdIizh+TT9iYHcEYqHEY8fn7kxMdDeYklmbDsfkjX
	 mZp+zkT5PSLzUrBacnONjMTnTxg1lN09zTs+v4zi/pe0l1CtzjjnfiALsIcYr5vqhj
	 vy7Km0UEGFb5jIT/RggS/zWIPRZe8o3kXt+KD9NYvBFEZzvbyo5X1vYfGpcF/eihSc
	 c6fSkM+m5TsGzKiL6/wLMLX9yKuIkTGgn3ahxh6kMy1VwbZTukMdxhGrQiuQR9Ymi9
	 nbViTH1fg/vvSuF7PKARYeDQR1ZFm7ZpxuGtpSAKw2Vnp18/xEMc6zMEooAdEMEFF8
	 HaZxswE1aTEDw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54D6E1tU43823934
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 14:14:01 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 May 2025 14:14:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 May 2025 14:14:01 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 13 May 2025 14:14:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v1 12/13] wifi: rtw89: Add rtw8851bu.c
Thread-Topic: [PATCH rtw-next v1 12/13] wifi: rtw89: Add rtw8851bu.c
Thread-Index: AQHbvTbBgcvuTNuciEGrQ+PUCBx+8LPQIecg
Date: Tue, 13 May 2025 06:14:01 +0000
Message-ID: <ed6c22d183c444949899d74cb4dda274@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <f404b504-6acb-481e-b21c-ea2535c3b1e1@gmail.com>
In-Reply-To: <f404b504-6acb-481e-b21c-ea2535c3b1e1@gmail.com>
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
IGlzIHRoZSBlbnRyeSBwb2ludCBmb3IgdGhlIG5ldyBydHc4OV84ODUxYnUgbW9kdWxlLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5j
b20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0K

