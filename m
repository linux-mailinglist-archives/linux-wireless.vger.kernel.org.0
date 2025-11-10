Return-Path: <linux-wireless+bounces-28723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 767BFC456CF
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 09:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6760C4E1871
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 08:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E8A2FD1C1;
	Mon, 10 Nov 2025 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="iSJrw10e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D09F2FCBF7
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764505; cv=none; b=jDOHUjiSKHDNZhX+5PO9LrCCbu5pD1FNdndkoNjHGJeLl6Q7nfjf9MOd8txwo7TpGG0xrDLzvBzyKZrl0xFdxEFsJs5J3nYs9yLYhrktwh0Gw3gfXZAn5c89mS9SoBoy2leO9+MeUivais5OtePegLDWX/YBWs6zFXCk+C/DuFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764505; c=relaxed/simple;
	bh=rYHBg55k/wUWXwxcd3rJrmS7WEen2i/NZ59oubrXySA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CvyQrO3llUFn8ApAVB9kb9ce8UaGIisBq4V00qyF2RFdwxv3vFJ7/lmOcpQCABKzjQtsQYTFl2OcTBLhWly+I9XMf4Pp5RpwUp1lmdK/EKeJObb4X0wOkL36w18FzWQvQ6vRJ+PXReg7OETJMI2sWIMrw8xF2oynVtII+gyh8Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=iSJrw10e; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AA8mIJ711403430, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762764498; bh=rYHBg55k/wUWXwxcd3rJrmS7WEen2i/NZ59oubrXySA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=iSJrw10egQsf/P705qr1u6HYsnfctqzZuraaLfCSxld/PmIn7rS7hHzyWPRKzOxDO
	 DQOODisKx2DkcVQ4I4eYqrayC0bjQq41UX7q8PXL1oWEgvYs9CFcoSYbecOVT52K7M
	 OxqmfuAuV1TWNEWa0SXU6Hb4rqaATGXf6ENAVYsulDOSGBKvXFn5JmiabnBEZ6U/Hf
	 bUC0VAOGRrYzlhdLgQ7GiGhZUzDb38AuVjUlCypC8pEowa7Z5Gu04asoPtMQH9QLjx
	 yL0TrrH0f6rfgtgadxjFj7dNudWAYYiav8v5eli5W4tPo7YOtsWaANOYFg01A/ZTkB
	 jv5BKKVVaPY1g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AA8mIJ711403430
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 16:48:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 10 Nov 2025 16:48:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Mon, 10 Nov 2025 16:48:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 1/6] wifi: rtw89: Use the correct power sequences
 for USB/SDIO
Thread-Topic: [PATCH rtw-next 1/6] wifi: rtw89: Use the correct power
 sequences for USB/SDIO
Thread-Index: AQHcUAB9DhxSP+tuFEacde/UyieqvLTrnWTg
Date: Mon, 10 Nov 2025 08:48:18 +0000
Message-ID: <beee9921889e4f1a9d5a231c53e10861@realtek.com>
References: <f0021b8c-efc7-4993-b0a8-8954c682d13b@gmail.com>
 <dec13310-06eb-429e-acb8-4c5b62656836@gmail.com>
In-Reply-To: <dec13310-06eb-429e-acb8-4c5b62656836@gmail.com>
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

DQpCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+IE1h
a2UgcnR3ODlfbWFjX3B3cl9zZXEoKSBzZWxlY3QgdGhlIHJpZ2h0IHBhcnRzIG9mIHRoZSBwb3dl
ciBzZXF1ZW5jZXMNCj4gYmFzZWQgb24gdGhlIGludGVyZmFjZSB0eXBlLg0KPiANCj4gVGhpcyBp
cyBvbmx5IHJlbGV2YW50IGZvciBSVEw4ODUyQS4gVGhlIG90aGVyIGNoaXBzIGRvbid0IHVzZSBw
b3dlcg0KPiBzZXF1ZW5jZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRo
IDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtz
aGloQHJlYWx0ZWsuY29tPg0KDQo=

