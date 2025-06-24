Return-Path: <linux-wireless+bounces-24398-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF25AE5C10
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 07:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC7B1BC009D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 05:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D0920EB;
	Tue, 24 Jun 2025 05:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="n+HCTjsF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B884F22D9ED
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 05:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750744292; cv=none; b=Y3iGR/DPzJxH4kTgm6A8nSjAfB+VtjQlbjO0Tqio1zNEJukDC9KVvWCBJpTdmO0VAe5PVhgxQolcsfAQLDNOBr2vfJ15wuesxdqxv/fGBK0K9CzAuG9NgJrnlBQAAjwSLOwBBD5s3XKiZFVqffKNoglt0nZlKoJbw/4a8It7AuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750744292; c=relaxed/simple;
	bh=NKcjN6SV5ApctxFEnq9TXk5XzObelu1s9iEjwJAa1pE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V13FRCl3fsZ/x3t30DUtIio5PDHk0WmFdhGumba19gppS/axXhd708Z4kGrwVGcJirBLBp1oqmGHPdP5APPImJFc9rsyymUn6OEm9+6+IfTZomQPhCsnRzD0SClzsI4DqGdynVsrNxlmUtO4SFfHqRzoxSF/egMWusfW9LNjOk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=n+HCTjsF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55O5pPXp93103198, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750744286; bh=NKcjN6SV5ApctxFEnq9TXk5XzObelu1s9iEjwJAa1pE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=n+HCTjsFygkyyuss7pfI8HG1zrVZLkdahVqwRsoBZLXR33BWowwle2YP+CPAP4T3s
	 9zQKj2mY5cV3f1uvzLbtOal5fRNS/PAvZZm/qLQL03DgdqqA/o1eLwqCHzuOeXiDAq
	 E4ac+H5GUZj9/GptI4vUrbqYgvFzRL1tRX5ATbUBtFIsz98/GTozMNVRYqAOHbsm2X
	 3NXnM8xPhvmMKyScFDj3QNtJ0ZIIAuzzf4Z8Nc5L0ZbuZ97y8Yipl5zhjLfBLqWWqY
	 0qxrYXn+TXfbEZhN5mjysIFxbrzmwJ5SdGzZXbmhEJeoCtfUp7p8L6yX6xPBsn8JEx
	 HfxPuGVemI4iQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55O5pPXp93103198
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 13:51:25 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Jun 2025 13:51:39 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 24 Jun 2025 13:51:39 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Tue, 24 Jun 2025 13:51:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v3 09/14] wifi: rtw89: 8851b: Modify rtw8851b_pwr_{on,off}_func() for USB
Thread-Topic: [PATCH rtw-next v3 09/14] wifi: rtw89: 8851b: Modify
 rtw8851b_pwr_{on,off}_func() for USB
Thread-Index: AQHb4hW80nz9+T9vkkiHV+WPtJTys7QR09OA
Date: Tue, 24 Jun 2025 05:51:39 +0000
Message-ID: <01f82284e8084e618dbf14b3aced3028@realtek.com>
References: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
 <a7cb3d99-33c8-42e5-95aa-86247c7a9d43@gmail.com>
In-Reply-To: <a7cb3d99-33c8-42e5-95aa-86247c7a9d43@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGVy
ZSBhcmUgYSBmZXcgZGlmZmVyZW5jZXMgaW4gdGhlIHBvd2VyIG9uL29mZiBmdW5jdGlvbnMgYmV0
d2VlbiBQQ0lFDQo+IGFuZCBVU0IuDQo+IA0KPiBXaGlsZSB0aGUgUlRMODg1MUJVIGFwcGVhcnMg
dG8gd29yayB3aXRob3V0IHRoZXNlIGNoYW5nZXMsIGl0J3MNCj4gcHJvYmFibHkgYmVzdCB0byBp
bXBsZW1lbnQgdGhlbSwgaW4gY2FzZSB0aGV5IGFyZSBuZWVkZWQgaW4gc29tZQ0KPiBzaXR1YXRp
b25zLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZl
MkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNv
bT4NCg0KDQo=

