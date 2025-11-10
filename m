Return-Path: <linux-wireless+bounces-28727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E14DC45744
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 09:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CDAB4E19BD
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 08:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C077248891;
	Mon, 10 Nov 2025 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="lqRJU7Kb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87F7A926
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764811; cv=none; b=B6CqpJNeCoocWZlDLPcXhsOkaubiTabHLTEkVpea6PvpR7n0AKNeRdy0LMPdryeVSV8Ypfvzcyx+LWZjYnb/UQLsE1lKJeVxSa5kwGK/E41PlhPsx4KA1Zlu+UolOv9fNp1eBVrqdndOLTzAsQcPEVZKorieRwTFj2ywvJbun2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764811; c=relaxed/simple;
	bh=ZlmHhH5VK+qmLvFRqZUSySkAYXlepOCKOyQ+6EpEMYU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AdyeBYldjOaeg19lH7mqo19K+1zwYMnBuEsZMF4jDKS4ygMAvuU1FulHVnTUDz9faL0Ge6S6I6dE79ZBox5SphzzoEcnWrFGe7vSH855oWbeHx4QD5CsDERqhsk04Al5qXzkIDp+yJTCT1RUVfYTKpvjXAe8kOvZU0LGp1XLHoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=lqRJU7Kb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AA8rPV911410302, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762764805; bh=ZlmHhH5VK+qmLvFRqZUSySkAYXlepOCKOyQ+6EpEMYU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=lqRJU7KbmBjpP7APixqev6KjCYHE4COND1QR3vIuVESXUXmPkHHREY5BHbn467Nqx
	 HPGt0e0xkX62FHdbiOPHI4+h2lFTq5bhibF1bZ7Qqtza5DRad77gEFszlUI6Mj7GnM
	 wJwbubE4hHCCZcwL7itTyKURFx8m/kQftgj+mKzLX/pLAQkY7UFZxPKHvfJbwGlFKB
	 lhiBNTUHP68csJUfVh24HNdGgLd2p08wj82VESuLbnZy5FJ/U+c+ltsQcVk8OXLIoo
	 +YZbe7eQkmBfSpVFX/eEHZyuceoay2dJ25ud1mzIOMkCDfWQ5yagbcGxfeopvqgU1k
	 8juxB5jz3ZMvA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AA8rPV911410302
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 16:53:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 10 Nov 2025 16:53:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 10 Nov 2025 16:53:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Mon, 10 Nov 2025 16:53:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 2/6] wifi: rtw89: Add rtw8852a_dle_mem_usb
Thread-Topic: [PATCH rtw-next 2/6] wifi: rtw89: Add rtw8852a_dle_mem_usb
Thread-Index: AQHcUACUZMkWJdIuy0WTjpkqG53LF7TrntZg
Date: Mon, 10 Nov 2025 08:53:24 +0000
Message-ID: <012882ddce4f4149a862477522b6f381@realtek.com>
References: <f0021b8c-efc7-4993-b0a8-8954c682d13b@gmail.com>
 <d0a09039-97a8-4501-b023-510c126d8c61@gmail.com>
In-Reply-To: <d0a09039-97a8-4501-b023-510c126d8c61@gmail.com>
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
cnR3ODg1MmFfZGxlX21lbV91c2IgYW5kIGl0cyB2YXJpb3VzIHF1b3RhcyBhbmQgc2l6ZXMgaW4g
c3RydWN0DQo+IHJ0dzg5X21hY19zaXplX3NldC4NCj4gDQo+ICJkbGUiIGNvdWxkIGJlICJEYXRh
IExpbmsgRW5naW5lIiBvciAiRG91YmxlIExpbmsgRW5naW5lIi4gVGhlc2UgYXJlDQo+IHNvbWUg
cGFyYW1ldGVycyBuZWVkZWQgZm9yIFJUTDg4NTJBVS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJp
dHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogUGlu
Zy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg==

