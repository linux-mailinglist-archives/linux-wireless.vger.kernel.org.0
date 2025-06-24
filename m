Return-Path: <linux-wireless+bounces-24395-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9E6AE5BE6
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 07:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C2F1B67647
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 05:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B794716D9C2;
	Tue, 24 Jun 2025 05:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FW17Otjm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD322CCC1
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 05:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750743756; cv=none; b=U04TMwQ0RKzD/FxLDf8j0gYUKnMjfCLxHJcdOw9gqD/bkN5cpml/x3lxSpHakB4a9JbxNApmGhkOrp9a9JlEuG6i6Q8GOQpFaeY+WN9GgdWbXJ/XSTeG4dW2nw13hQqYiMhkOn8jksufdkK+rlpZw8ASm8WlGpvJypMkUJjfRXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750743756; c=relaxed/simple;
	bh=xS/xwLbCENK80NNPyi+yguW9fCYGu6C6qcCCnBsyui0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QiHtkEa2xBzavASduDOS4VT7nVMsxIZXqAyDiy/tjhSjqdRcGjLsPLKvI9yWXFYYf4+ARG6oFOyxy50EYGrTE1tOOD8McuOtsEyiiW6OBSZ8+7ibveoWSgDuXAg/CId1Qs0smaQ6CsKiEG3FyUF6z3jsbDNaizam2McxkElLUyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FW17Otjm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55O5gTekD3094935, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750743749; bh=xS/xwLbCENK80NNPyi+yguW9fCYGu6C6qcCCnBsyui0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=FW17Otjm5KkLOG3ep+NLfkLRFe0ajufsSH8BcedNVseSZIgssKUGNC7EFgPYhQ02G
	 1RfXj6d2JKISJ+hZfefB9TpFNjhEVahHPZD7hRRikxcAcOWCso+79wMr06xaPd3DAB
	 Sj6e7xfnVnnpXLUWxD+pEbZIngt+DK2Cf29nJjTTTn03pFYViwl73bhwmkmkFjldBG
	 y6X7DGEmKN6PCKAb2dF8BL4ocVTKrvE+8rv4i0HUDXZ9MYvSCwXwxJ/bw8SwBisdyy
	 VwNVdOYmnsthLa123guGPKeQLPYFVFx5TwdUjUVzTcXGaxQ99UnTUye570y9uQdtZ5
	 QNBuEabL5j7Aw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55O5gTekD3094935
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 13:42:29 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Jun 2025 13:42:43 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 24 Jun 2025 13:42:42 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Tue, 24 Jun 2025 13:42:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v3 02/14] wifi: rtw89: Make dle_mem in rtw89_chip_info an array
Thread-Topic: [PATCH rtw-next v3 02/14] wifi: rtw89: Make dle_mem in
 rtw89_chip_info an array
Thread-Index: AQHb4hTABDmJnTymWEmDu9HKZ7MfU7QR0VEQ
Date: Tue, 24 Jun 2025 05:42:42 +0000
Message-ID: <48029e46aca34c02b8ba5f462a8c78d0@realtek.com>
References: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
 <62339c51-87c8-4064-ae9c-9f34127632e5@gmail.com>
In-Reply-To: <62339c51-87c8-4064-ae9c-9f34127632e5@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBVU0Ig
MiwgVVNCIDMsIGFuZCBTRElPIHdpbGwgbmVlZCBkaWZmZXJlbnQgc2V0cyBvZiB2YWx1ZXMgY29t
cGFyZWQgdG8NCj4gUENJZS4NCj4gDQo+IEFkZCBhIG5ldyBkbGVfdHlwZSBtZW1iZXIgaW4gc3Ry
dWN0IHJ0dzg5X2hjaV9pbmZvIGFuZCBtYWtlIGRsZV9tZW0gaW4NCj4gc3RydWN0IHJ0dzg5X2No
aXBfaW5mbyBhbiBhcnJheSB0byBob2xkIHRoZSBmb3VyIGRpZmZlcmVudCBzZXRzIG9mDQo+IHZh
bHVlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJm
ZTJAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5j
b20+DQoNCg0K

