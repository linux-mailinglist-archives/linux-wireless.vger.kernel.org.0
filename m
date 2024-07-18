Return-Path: <linux-wireless+bounces-10337-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF1A934844
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 08:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E58F28138D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 06:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45A241C89;
	Thu, 18 Jul 2024 06:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Xnt6djGr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D0243147
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 06:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721285113; cv=none; b=m2GHIkPUWUeZru7BdJn/HWVMkaxXJgQemSuhrkw8w/nC5NDOp6iZIeoBAzP+JnwNqppRSevOtqfYrB1/6asoYfkavzHJuCI/e86izQ6DvjbFcQ8bYNVCPkSqrOhfulTaXuutaH45VS+lEnrSPcMhMEeUcQTm9aIo4Nr1CWmpxjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721285113; c=relaxed/simple;
	bh=wvHfGGpkm9IExTJWscpMZfJjynz5ptxpsjhZsxDwvPA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=elmK5AHY6lOtzxLNlaQ2qvyeEIs/gbWBmxhmHSK1cB2yuO16gFrSnDsYBoMvpLxSBuUyJzyD2VPmzqnXHPDJLnGddYbAyAGdFLDU457oXTuXiZSYrWyFhfg1GQzdm12dxFyichXoZW1g/Sh/bzCklC75kfY/KMmeWfYvWpFfmKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Xnt6djGr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46I6j7Qw93082227, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721285107; bh=wvHfGGpkm9IExTJWscpMZfJjynz5ptxpsjhZsxDwvPA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Xnt6djGrfP08PIEx4/DckScV2kIA1YQ7HxIUqILnOHNiaZC4QGz3uVNOVyY4HPbW+
	 Mc9zHjeZz7bw+dc8fvQ1zT9RWsnfIHzuGfP8UmOcFY+48ffGi9I8lbV38JNjTUtoD2
	 wkO1zB5IAwIkCoF0yvp4wufNqGHLnzkBJgMQUUy1QKniA8dy19u6dHMQFTHLr4RYW0
	 SlG1s1JmCc5K8b0p6r4A8rcKOUB2fnWCgGCG4qhMVldTs/P3HWozwxvH8plp3AdNBd
	 jgsXTV7O0iPkBMMoBPZwWxrePiWc1dKRClkZdWYId5U5gSdtHSFWGfL0pSLj0uSUaK
	 NpZT2x65cu7/Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46I6j7Qw93082227
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 14:45:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 14:45:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jul 2024 14:45:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 18 Jul 2024 14:45:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Subject: RE: rtw88: The debugfs interface reads registers from the wrong device
Thread-Topic: rtw88: The debugfs interface reads registers from the wrong
 device
Thread-Index: AQHa1qbdlNhPu3M8PEuf9XqbWbxrtbH3IEAAgADosQCAABroAIAD6nIQ
Date: Thu, 18 Jul 2024 06:45:07 +0000
Message-ID: <faca434662df418bb7bb070434a6da48@realtek.com>
References: <e28bbf72-678a-438b-b5dc-d4ae8b8f71f0@gmail.com>
	 <77b8adc4-daa9-4869-8773-c5de9eb84299@gmail.com>
	 <1d00170b5f0a39bdff6f759de300a402209ace03.camel@realtek.com>
 <cd6a2acf3c2c36d938b40140b52a779516f446a9.camel@realtek.com>
In-Reply-To: <cd6a2acf3c2c36d938b40140b52a779516f446a9.camel@realtek.com>
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

PiANCj4gVGhpbmsgYSBsaXR0bGUgYml0IGZ1cnRoZXIuIEkgd2lsbCB0cnkgdG8gZHVwbGljYXRl
IHN0YXRpYyB2YXJpYWJsZXMNCj4gdG8gc3VwcG9ydCBtdWx0aXBsZSBhZGFwdGVycy4NCj4gDQoN
Ckkgc2VudCBhIHBhdGNoIFsxXS4gUGxlYXNlIGhlbHAgdG8gdGVzdCBpZiBpdCBjYW4gd29yayBp
biB5b3VyIHNpZGUuDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13aXJlbGVz
cy8yMDI0MDcxODA2NDE1NS4zODk1NS0xLXBrc2hpaEByZWFsdGVrLmNvbS9ULyN1DQoNCg==

