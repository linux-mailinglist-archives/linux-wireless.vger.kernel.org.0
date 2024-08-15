Return-Path: <linux-wireless+bounces-11459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0032D95296B
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 08:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19BC1F21E76
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 06:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3AF1804A;
	Thu, 15 Aug 2024 06:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="BsL3SHa0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CA8176FAE
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 06:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703664; cv=none; b=dYhTbO1oAN5lrmciNn3QTT82SsFvW92pX9bonfpSwHLDmxGYUoibPVtMgg1q2Z/99UQ6YPPqRHDTJAmik461rjvy9tb+YNxnEbnNhuLDsRJUUNXG/n4dXQDYJNfFqMWkdeXLHNFt8t0edCwC+5GDVkTwIk1RNFBidO9av0ZnXEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703664; c=relaxed/simple;
	bh=f+ooALvoxVGpKRrdv+VcwMD9wzoi+1jI6rtw0CK0QuQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YlZeaJYUx5P00z4yk/ZAAGgqnt+O6PfDNxSuX81Buf6OZ+CWNMW/xNA0RETt1xVbQlhfGAfgLCvAtiY7qBCWqzPHQEdjkMR9+BlkSDWCtAqQPV9oU8Ma2S3Q6kyyRbqWnQASj2oVGC08TCrxd7KPmyFXmPLsWDvXbP09DgIRIFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=BsL3SHa0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47F6YHvyC3702838, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723703657; bh=f+ooALvoxVGpKRrdv+VcwMD9wzoi+1jI6rtw0CK0QuQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=BsL3SHa0Dbo4KKwj8dbPCdaRmOedGuBPGtjRX+nq46HAK+YOR8g5nKuONVyfAlDo+
	 c8KLyaAS/3gcAfibGsPgSphaavDB7JHXfl02qphRCmF6oUqdU3EVuJP/kG2sTr/l7n
	 5BAq47ECdlBrkdqFp5mRcVw0bjTQTWDc0ab2ZTx4sn72icq9o/L5+ih1zpFcYkCXOQ
	 ECMsetEMnDfzTwFxT8u3BgvnbHU/BjoXqLXWfdWmIJmjLgYUxrIFuAnq7xjk6kBqLP
	 BD0PNIbE0BaAhlFEKxAnvgFYsLSkWZyMJTy3tZbMRcqzgZTRVyBi0G6yifp4I6nO3L
	 bZplwzTA9ueUg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47F6YHvyC3702838
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 14:34:17 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 14:34:18 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Aug 2024 14:34:17 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0]) by
 RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0%5]) with mapi id
 15.01.2507.035; Thu, 15 Aug 2024 14:34:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 01/20] wifi: rtw88: Add some definitions for RTL8821AU/RTL8812AU
Thread-Topic: [PATCH 01/20] wifi: rtw88: Add some definitions for
 RTL8821AU/RTL8812AU
Thread-Index: AQHa7DChIdQWzhAwXUeoZbt70JeCT7In4dmw
Date: Thu, 15 Aug 2024 06:34:17 +0000
Message-ID: <1657a6421ee64b25aaebfe2d315e5bfd@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <0394f438-11c0-45b1-aaf1-509b87496c5d@gmail.com>
In-Reply-To: <0394f438-11c0-45b1-aaf1-509b87496c5d@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBZGQg
ODgyMUEgYW5kIDg4MTJBIGNoaXAgdHlwZSBlbnVtcy4NCj4gDQo+IEFkZCBjY2tfaGlnaF9wb3dl
ciBtZW1iZXIgdG8gc3RydWN0IHJ0d19oYWwuIFRoaXMgd2lsbCBiZSB1c2VkIHRvDQo+IGNhbGN1
bGF0ZSB0aGUgUlggc2lnbmFsIHN0cmVuZ3RoLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVy
Ymx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBQaW5n
LUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

