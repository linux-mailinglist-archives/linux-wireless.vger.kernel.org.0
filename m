Return-Path: <linux-wireless+bounces-24118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD35ADA6B3
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 05:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B76D16DAA6
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 03:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94B728E59C;
	Mon, 16 Jun 2025 03:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="UM+ceqfU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FCC2E11D0
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 03:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750043536; cv=none; b=h0iojS9ls9RERggnu5cSCI6wWURNJmfTaea7WlETCeFrRTlaDFKGyG/3vPZXlXxkcmRad158y0Q3DaQiZyzRnC+A9purEkaBO10zv9OEv4rqFCwx8andaDFy+e0cSvUdiV7ieYQGk5ACzwXqOqdYYkCNs+bqb6/q57t4FO2vwXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750043536; c=relaxed/simple;
	bh=YeACEKbZZx5etm5DomCfWEYu11ZHfhQfqO6xuZW5el0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bvpLQCO0WWQUGFkTJvFSIgnh227zdw02RVuFCcefxceDO3BntdWcwQjFLUuAhHbvvGsPczw0B3HbwMe85qp2VBqRm6bR46dmjDqOf92hwNtjdI+Ff/G/XiZ8I885SLUjoa2JAV1mn+Q/MnBVDcO6y6Jb5RV1Q87qkXKmWgtphpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=UM+ceqfU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G3CAFn83964918, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750043530; bh=YeACEKbZZx5etm5DomCfWEYu11ZHfhQfqO6xuZW5el0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=UM+ceqfUGqexwBRSqYvnUrvgt+sgg76S2qyaSBejZBWhbJticmHN9tAq3WEohbfOk
	 lQLUOjXj7wgXreiyoi4I0les535e29713f233oPV97Yx2ruEohbswYb5Z0mNmCOYkq
	 HZSte/tcr2DzrEzfggDE4oddudTxAJkE1q3ibdelB7geP/5e507JOYzW9svUmUums6
	 BnHC4Xax5ycUyUcxuUmXA28HY2jW0EnGI+JTEjwm6G0e0tikt+8DjEU2OGicFSlnmN
	 n0c8I4S4BBlckszPDCqfMrgP/yDfuZx9aOhTKyXheNLNwAcdmMbENZ30Qc9k8iuH1N
	 yM4HnFMkyOytg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G3CAFn83964918
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 11:12:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 11:11:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 16 Jun 2025 11:11:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 16 Jun 2025 11:11:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 13/14] wifi: rtw89: Add rtw8851bu.c
Thread-Topic: [PATCH rtw-next v2 13/14] wifi: rtw89: Add rtw8851bu.c
Thread-Index: AQHb2XVY6ezMb/VtH0KK6HPOwUcGE7QFJb7g
Date: Mon, 16 Jun 2025 03:11:45 +0000
Message-ID: <7a777dbb6efc43d7ac010f6c566b0775@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
 <327a8202-30b0-4617-87e4-bd5d7916ab2b@gmail.com>
In-Reply-To: <327a8202-30b0-4617-87e4-bd5d7916ab2b@gmail.com>
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
b20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

