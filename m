Return-Path: <linux-wireless+bounces-11598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823BA95615D
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 05:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD971F22071
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 03:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5F46A33C;
	Mon, 19 Aug 2024 03:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="dLJDUo01"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01B6634;
	Mon, 19 Aug 2024 03:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724036965; cv=none; b=uI3umVRz9MRD+hn1Qhzo53we1t7VdaOAoBX9m+ABs7u0DEMj+NsJIPC/d3SIHAUOt7DS6dwJyZ2pFLFsuC1ooj7Y4jZ5MmO+yVr0pY38vZXM/fyJYA93sWSioxa88oIno8gE0HQse8p8DYjAINPTpeXyLXEGLySjbcNjX/ukobk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724036965; c=relaxed/simple;
	bh=VmKHCZXa1Wo+wssFsSrqTX1GMxQQEagIKzKeLurLojU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JWUp/hgB0aAj9gx2SGSJeCn+7YExvWBcHBtfsYU1zKYkAx95C1i+Plf+Vxu/0E/YFj2iTqQtcGv7elPDyxYDM4cPfOCqEaos1pE18x/uQRWGtCBFe8/sPXmrfEw5xBFxvD+A0R9KTCYoZsoaDGfIBymkJXb51qrx/q5bEZTd1bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=dLJDUo01; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47J38d5jA3786803, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724036919; bh=VmKHCZXa1Wo+wssFsSrqTX1GMxQQEagIKzKeLurLojU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dLJDUo01acOdgToPHMzW1bx8vn5ynNFeDdZWngPqDG3AwJ/UmPkJG2EptOKFgFU8n
	 jH69fI/PYjAXQoxI0ymUZ0YrtYbxMg0Q3FqsGRsrKV/0swJyaIcEQWY1FPdNLjqIJm
	 RMoHRk4pxsJk51NPC3a8nj3x+knmi3YPswI8mjQQvSoIjeZX3ETWaF1LTGOpl4Y6GF
	 nr926GAqyTTiyMeETFF18PlAu1brvvtjpxrGZbZMXCct8G19sk62zgxsQlvcbEC8NQ
	 MkcyMGmMvqmfS3vmBvVd0+EA+ymYBOtse+haTZLTpC+M5gH4+c0tl03vpK0I2sFzXx
	 PZb/xGp9ByB6w==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47J38d5jA3786803
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 11:08:39 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 11:08:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 19 Aug 2024 11:08:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Mon, 19 Aug 2024 11:08:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Marek Vasut <marex@denx.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Chung-Hsien Hsu <stanley.hsu@cypress.com>,
        Chung-Hsien Hsu
	<chung-hsien.hsu@infineon.com>,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Arend van Spriel
	<arend.vanspriel@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Carter
 Chen" <carter.chen@infineon.com>,
        Duoming Zhou <duoming@zju.edu.cn>,
        "Erick
 Archer" <erick.archer@outlook.com>,
        Kalle Valo <kvalo@kernel.org>, Kees Cook
	<kees@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathias Krause <minipli@grsecurity.net>,
        Matthias Brugger
	<mbrugger@suse.com>,
        Owen Huang <Owen.Huang@infineon.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>,
        "brcm80211-dev-list.pdl@broadcom.com"
	<brcm80211-dev-list.pdl@broadcom.com>,
        "brcm80211@lists.linux.dev"
	<brcm80211@lists.linux.dev>
Subject: RE: [PATCH 1/2] wifi: brcmfmac: add support for TRX firmware download
Thread-Topic: [PATCH 1/2] wifi: brcmfmac: add support for TRX firmware
 download
Thread-Index: AQHa8at7m4mut1bZYE+nDwlWmEJv7rIt5ltg
Date: Mon, 19 Aug 2024 03:08:39 +0000
Message-ID: <582df73b7004435f8f0144cbfb1cd3f0@realtek.com>
References: <20240818201533.89669-1-marex@denx.de>
In-Reply-To: <20240818201533.89669-1-marex@denx.de>
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

TWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+IA0KPiBGcm9tOiBDaHVuZy1Ic2llbiBIc3UgPHN0
YW5sZXkuaHN1QGN5cHJlc3MuY29tPg0KPiANCj4gQWRkIHN1cHBvcnQgdG8gZG93bmxvYWQgVFJY
IGZpcm13YXJlIGZvciBQQ0llIGFuZCBTRElPLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2h1bmct
SHNpZW4gSHN1IDxjaHVuZy1oc2llbi5oc3VAaW5maW5lb24uY29tPg0KDQpUaGUgZW1haWwgYWRk
cmVzcyBvZiBGcm9tIGZpZWxkIChhdXRob3IpIGlzIGRpZmZlcmVudCBmcm9tIGZpcnN0IHMtby1i
LiANCg0KDQo=

