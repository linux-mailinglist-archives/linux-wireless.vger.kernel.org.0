Return-Path: <linux-wireless+bounces-28730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA61FC4577D
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 09:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF7F3B4355
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 08:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6D12F25F1;
	Mon, 10 Nov 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HBcVYpDA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5412FD7CF
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765038; cv=none; b=hlYvO4SGQ9nt/TxDaGvRiCMspa+WnhLEvQoBUBIQ6zf/VQFNwI6PmoqprzSVxP7lYc9h6arEwmr3JI7/XwV+vC/XsGScvB5v4FqbE247Zq0Kr7BQrsy25jpuI5rdCjOTeQPcpbTjffqGFy8jy4wp5GAjftuaFdeFPOYGovhtE0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765038; c=relaxed/simple;
	bh=pNzy8i9A0CYqupkPH0Ct1vZGM+3CpxbUrnaXgMlmmAE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gMJjK9WMDp3HMntcSsbWv6l8tQtNJF2aRKCIYELlJ4hvCSnYGFWCX0H5xcqtpz0OWsNC/3fHMFnSsbaWNtcSFE3CYlr4wLykUziA1jEvWvLAK8XcYFtmIsONofBtCB2/SHwODKulBp4f5gq/cGhqXbKMK4Q52AbAyeLO8BRTw/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HBcVYpDA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AA8vDGl91414317, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762765033; bh=pNzy8i9A0CYqupkPH0Ct1vZGM+3CpxbUrnaXgMlmmAE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=HBcVYpDAWd1JjI2uopZTYm5nFh2L5XomBOaZlWenCIBxDGzjqEHG2859F9Bl+VuWN
	 P/MMv1COTX7U7SaZMOB0/f/OcEMcMVOyay2osbGu20txRgTqj0Edx3TQ0zOfCsIGm6
	 ShGX6QiZ9oL8480M1tNJW3OyHlTq+d7vLgbamD8pM44Oq6IABH/eJ+RCgMQQATSRLJ
	 NeyVAD0I3AXrydxUibSkozU8Z58fxgCwcUGT04JxmvLq2lBQbhS315hVFvyLkBcup7
	 jPOSD9NiqMxnQRFMbMceS1edv5N8LP+Vbb97WkkSifEE+ApfuqDqHn1IXbqYWG8Jtg
	 3VeqSdpEgPAhQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AA8vDGl91414317
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 16:57:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 10 Nov 2025 16:57:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Mon, 10 Nov 2025 16:57:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 5/6] wifi: rtw89: Add rtw8852au.c
Thread-Topic: [PATCH rtw-next 5/6] wifi: rtw89: Add rtw8852au.c
Thread-Index: AQHcUADkTIg4ymWRv0qfmnDywbfhd7Trn+Bg
Date: Mon, 10 Nov 2025 08:57:13 +0000
Message-ID: <feb23fcb800b4be0bbf561033155b2f2@realtek.com>
References: <f0021b8c-efc7-4993-b0a8-8954c682d13b@gmail.com>
 <9580e5be-2bd1-45f9-ab75-616b86e25694@gmail.com>
In-Reply-To: <9580e5be-2bd1-45f9-ab75-616b86e25694@gmail.com>
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
IGlzIHRoZSBlbnRyeSBwb2ludCBvZiB0aGUgbmV3IHJ0dzg5Xzg4NTJhdSBtb2R1bGUuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNv
bT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQo=

