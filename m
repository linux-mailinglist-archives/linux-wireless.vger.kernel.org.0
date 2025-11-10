Return-Path: <linux-wireless+bounces-28731-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29142C45971
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 10:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154AA3B6332
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 09:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D8A2FE56E;
	Mon, 10 Nov 2025 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="loDHqRMp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647B819C556
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766298; cv=none; b=ASM1gWW9JhIF6dnMmCBdJ6ntjiXEB1gZUQAD7RAuYRT7KjdZ92dFcNe3QFc583iiaZOCIiRocJTiGNWH/qKIPBRTOdgRKmW/TeMkBuEOHEye4vQWhUUpBwxE/IU0MZscrAZdOzG1hGlWqcnMjhCdHm3FsUSuRgYOSPeZSOpUc24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766298; c=relaxed/simple;
	bh=KRmkHIbOPP+ISlvM+3x7UmKKSe1qtcnPJLwby6izzKo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cs4MkKplCHsyFEW6oD2tbfazovuV8OFz3QAaSijVGi4+IELrKro2dhs1PnaT6gtaxOwUR4Cm4rdnJCTNeOpGbWN+uOrFy7qnbVX60Z3ncgx7cj1UV6kzkyGSF1Faz5s+bgxLb5LPiUDswLhAvHpQLZ3pLPWs209jpOU3kbZm114=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=loDHqRMp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AA9ICZR01455315, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762766292; bh=KRmkHIbOPP+ISlvM+3x7UmKKSe1qtcnPJLwby6izzKo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=loDHqRMpGl5ciPH4XprCZ5ypz/CAO0c+tpiVmI3Up2l0qSw5oFDtOHS/zJfBk4yAX
	 Wvk55UIinKh95oddIvs9mhos3lp2P6dDx2z0kBfxZKfxe/XYSGzGoe3QflgfhnCxcA
	 +gKeFOYT4FMZTJLRPs/tztBA/jN1SHjQN4NnnhfRzYoTe1pfG26Zedof+UVUmHgBWU
	 hG/QjtGazwOFndzClz5uBFoQN60/iHdgE1hHAR7Gg35KNv8PgMTjUgZv8N5de2tkbB
	 /HAUQmI3GIg5LXq2s6wxlkxOineWK0oLpAkB6TA8NySxn3ZLn9+SwHql1BmOd7I1pZ
	 x+fjSRnUF7Z6g==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AA9ICZR01455315
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 17:18:12 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 10 Nov 2025 17:18:12 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Mon, 10 Nov 2025 17:18:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 6/6] wifi: rtw89: Enable the new rtw89_8852au
 module
Thread-Topic: [PATCH rtw-next 6/6] wifi: rtw89: Enable the new rtw89_8852au
 module
Thread-Index: AQHcUAEG60gW869WoUOxzXbG9N6zRrTroCuw
Date: Mon, 10 Nov 2025 09:18:12 +0000
Message-ID: <680e023c601f413eb1f88bf4a567459a@realtek.com>
References: <f0021b8c-efc7-4993-b0a8-8954c682d13b@gmail.com>
 <180a5e77-9297-4ffc-80d5-191dfef47661@gmail.com>
In-Reply-To: <180a5e77-9297-4ffc-80d5-191dfef47661@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUZXN0
ZWQgaW4gc3RhdGlvbiBtb2RlIGFuZCBhIGxpdHRsZSBpbiBBUCBtb2RlLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFj
a2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KVGhhbmtzIGZvciB5
b3VyIGdyZWF0IHdvcmshIA0KDQo=

