Return-Path: <linux-wireless+bounces-26222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF87B1E205
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 08:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F4617E60F
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 06:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3BC225A32;
	Fri,  8 Aug 2025 06:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="LbDZL5dM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6939522258C
	for <linux-wireless@vger.kernel.org>; Fri,  8 Aug 2025 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754633636; cv=none; b=cGPKXZdlE2ztXTkTkEr7eXEGDGe2ZSm6XjXZH3OTVvYVBfBe7OBj/Gktgqvy1OvXOZfiZbAzP2K7PRiF7FK7zjeURrbd8BR25ihGCljfPQ/aZDYTUtg1ARjFPV0Yl658bscAlhC+Db3CgNP7MdFOWJf3aA9D2F2FvF1I8W+FfnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754633636; c=relaxed/simple;
	bh=RK88VD1MnEuh0XXWiwhLtxz5sRsU5fq/NyDUQ5/qhs0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m38fVCK2S9881wc7jLbx9h7Ey3w/PAcmP/aGTzEUoZ6ghDXxu9ExxVmztTwvVTm8xIWoxRC1dINVgZg1ymyTUxUUWfqmhlWMzETDY96/Zn9CN4rifz0wu+w87N+lxiY5T6gUhiGDq8YjWsdncwtBSHbxqyvaSz5NmkTuWZz7JNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=LbDZL5dM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5786DoTH22793885, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754633630; bh=RK88VD1MnEuh0XXWiwhLtxz5sRsU5fq/NyDUQ5/qhs0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=LbDZL5dMZAAduFCuHSAQ7LLTLzxBzWDtxL6K673Fz0HqyzXmDVXqhFrdXU0nxYVeG
	 GWgPKsljwqVTJ2XM3DnbJENwSk7nFeGke1LEy0l6yh03vV9cKPGg7/VGML05uxmxr6
	 pXNpJQgKa7RPdkTf4AQ+QAwdG58CtmTJR3syWeFED2gGcWg1oClQJNGOHrKSCSeTDN
	 hYZZFnn7C4xzhcFsSKEAxxRGbsagXBYBFNZi6Oybimwez4xXLVXs1mWgQWTwbvwWUw
	 u5d13ig/PAmtpbpIYwcP0ILlLM1tqF0nVMn2+64PJKP1/+4+0vmxxEO5oaKyCVEi3p
	 TzOJR+L8NfRwg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5786DoTH22793885
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 14:13:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Aug 2025 14:13:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc%10]) with mapi id
 15.02.1544.011; Fri, 8 Aug 2025 14:13:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 11/11] wifi: rtw89: Enable the new rtw89_8852cu module
Thread-Topic: [PATCH rtw-next v2 11/11] wifi: rtw89: Enable the new
 rtw89_8852cu module
Thread-Index: AQHcAyhKtUzkcRRmoUCc8f3X0CufWLRYUNIA
Date: Fri, 8 Aug 2025 06:13:50 +0000
Message-ID: <3e3fa10355ba4f42b4faede261831408@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
 <cebbc7b8-5330-4f02-8aff-e56b60ce0b48@gmail.com>
In-Reply-To: <cebbc7b8-5330-4f02-8aff-e56b60ce0b48@gmail.com>
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
ZWQgbW9zdGx5IGluIHN0YXRpb24gbW9kZSwgYW5kIGEgbGl0dGxlIGJpdCBpbiBBUCBtb2RlLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFp
bC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0K
DQo=

