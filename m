Return-Path: <linux-wireless+bounces-11462-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C74952981
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 08:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BE6DB22188
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 06:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6A617839C;
	Thu, 15 Aug 2024 06:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Ls1aOxsn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7C1BA53
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723704627; cv=none; b=uAlk1LeOrQpkP+6+KPp/FRL8a2ZRvP9SwIt+QMjfCIhDcHMI3aIGl186GUDsufbZjRRptIknQITmwXish84y5Q5WTB30nJxg4NpRGUxLVcrSKhqQOdN1H9bA2zDXymu44s033hA0a0Yz3AJ9q1ZEB0q/2AkfCAVBeEvES30nLT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723704627; c=relaxed/simple;
	bh=LSdSSE8D+7uWHPs08QhO0ARTWw4bX/zdSz5DoPpiSlc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nQ8hJa3sql1p2JdWRd+GSFz2ab6fA99MmwryEl34vNbMYsJnsNMvxpyvEf0v08XF3I9sTc2Ec7MPv0dWPmcmWPja+k3rInx68C4xh2JzwSwX02abthTttHHohbCIvvRb6Fr9xwCwXB9JxmQSol3UG29PUrppFlvy7tgbbVAxrN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ls1aOxsn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47F6oK2G13713153, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723704620; bh=LSdSSE8D+7uWHPs08QhO0ARTWw4bX/zdSz5DoPpiSlc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Ls1aOxsnkWvSrW/+gwzMduonJzQzps3pyi+dkbXdWtHhDP2L8m7MRB6v1bCBYCMyS
	 b79GgbQkA4hxDs6uQ3HFkp6Dgt6MrhrHhDV2amy+pINczQEnRcUYkrbjxuC/PqZ6C5
	 DM0xRBXT1yNddGoi0fgkhPQYW/XSTenwAMkEGIsqBhmbKWW32HuU9G+r4FzAJxzGJl
	 9e+JWmrbr1nmx/maiAo10wGetPj2nnqkw3Flh1rYvtspJAKzD7ZXtFf+dxjTkePqtO
	 vIUBhijTpliCGTS1CD9dATngMNUXk+ezk2ED2d959+1tdd7u6qCTaXNTo4N7c1xG3O
	 iUOYUYzjC3+GQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47F6oK2G13713153
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 14:50:20 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 14:50:21 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Aug 2024 14:50:20 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0]) by
 RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0%5]) with mapi id
 15.01.2507.035; Thu, 15 Aug 2024 14:50:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 08/20] wifi: rtw88: Make txagc_remnant_ofdm an array
Thread-Topic: [PATCH 08/20] wifi: rtw88: Make txagc_remnant_ofdm an array
Thread-Index: AQHa7DF8W18bLETX10WV7ZIlluZuobIn5lEQ
Date: Thu, 15 Aug 2024 06:50:20 +0000
Message-ID: <8044199498a24cbaad0dd7f5e37b4beb@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <6bdb5f3a-7d7b-488b-b795-68e66279f9e9@gmail.com>
In-Reply-To: <6bdb5f3a-7d7b-488b-b795-68e66279f9e9@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiB0eGFn
Y19yZW1uYW50X29mZG0gbWVtYmVyIG9mIHN0cnVjdCBydHdfZG1faW5mbyBzaG91bGQgYmUgZGlm
ZmVyZW50IGZvcg0KPiBlYWNoIFJGIHBhdGgsIHNvIG1ha2UgaXQgYW4gYXJyYXkgb2Ygc2l6ZSBS
VFdfUkZfUEFUSF9NQVggKDQpLg0KPiANCj4gVW50aWwgbm93IGFsbCB0aGUgY2hpcHMgdXNpbmcg
dGhpcyBoYWQgb25seSBvbmUgUkYgcGF0aCwgYnV0IFJUTDg4MTJBVQ0KPiBoYXMgdHdvLCBhbmQg
UlRMODgxNEFVIGhhcyBmb3VyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBr
c2hpaEByZWFsdGVrLmNvbT4NCg0K

