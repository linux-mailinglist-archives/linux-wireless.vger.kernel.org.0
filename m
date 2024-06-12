Return-Path: <linux-wireless+bounces-8844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2091904E76
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 10:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E0E2831E5
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 08:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0155016D32C;
	Wed, 12 Jun 2024 08:49:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBF7757F8;
	Wed, 12 Jun 2024 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182164; cv=none; b=jrMIoUvl/W2LZGi4/9B/OZ2qMMJCgzDzoU0lsO/magzR5Pq1G3RD/5C5Dsu4cuufUb9SCm8H0a+Yw9jZxAEdFXPwPyRJH8Qm4wboo/aGmRw7eZ+gLWrv+/cGdIHlRX7P+qjPvSQ2otRPfd6RBWFltmgXg3H9gsG21gkBfLmzVHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182164; c=relaxed/simple;
	bh=8BYKYT7nbcxHMwXCfS6yDYlVvYbSKQQIBbC8Yh7ZINs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HAgQsAuVAen5D4Zz6XlTOqr3Cvdr/XTwcUjbEFgpR3l3zyV32Tb7MkX7WaeqKNQBPPaY5ZMaS40QVO9rGKkUlRRjlKeJaj3Svp9z83cAfu35WTEXLMigeBKye2pQ36IB3O27CbM4Ea8XzcDGtOhiW2QWyXWMxUFAZEizDh8JCfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45C8n3Kt91121079, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45C8n3Kt91121079
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 16:49:03 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 16:49:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 12 Jun 2024 16:49:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 12 Jun 2024 16:49:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Thorsten Leemhuis
	<regressions@leemhuis.info>,
        Savyasaachi Vanga <savyasaachiv@gmail.com>,
        Christian Heusel <christian@heusel.eu>
CC: Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>
Subject: RE: [REGRESSION][BISECTED] wifi: RTL8821CE does not work in monitor mode
Thread-Topic: [REGRESSION][BISECTED] wifi: RTL8821CE does not work in monitor
 mode
Thread-Index: AQHasIGBiI2kIPT9xk+a42EavL0uE7GryNkAgASPDICABOUZsIANAvMAgAEhOED//+X0AIAADk4AgACRnyD//3uQgIAAhlxg
Date: Wed, 12 Jun 2024 08:49:02 +0000
Message-ID: <c5d177ae537b4ef383fc24a96b833775@realtek.com>
References: <chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl>
	 <a51f223f-18ac-4d67-9120-8da1c169b7eb@leemhuis.info>
	 <809d2332-625e-4a46-a77e-ca2e49b0d651@leemhuis.info>
	 <0e65ca6b471b4186a370b9a57de11abe@realtek.com>
	 <36c1f49acfcc2cc16c7e54ffeb76f1e93cb96e91.camel@sipsolutions.net>
	 <5318640d6eb74301b1fbf6d9385ba69e@realtek.com>
	 <6a88e0d3e47ebbd1f0f383094e4804a627c41870.camel@sipsolutions.net>
	 <7869b9b29b6796c95fd5af649e4bd6696e56dcaf.camel@sipsolutions.net>
	 <3dd46abad6f8485fa74d36278dda46ac@realtek.com>
 <9e0a886ea6830f5fa230a8377952335b1fd2da56.camel@sipsolutions.net>
In-Reply-To: <9e0a886ea6830f5fa230a8377952335b1fd2da56.camel@sipsolutions.net>
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

Sm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4gd3JvdGU6DQo+IE9uIFdl
ZCwgMjAyNC0wNi0xMiBhdCAwODo0MyArMDAwMCwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+DQo+
ID4gVGVzdGVkIG9uIDYuOS4yIHdpdGggUlRMODgyMkNFLg0KPiA+DQo+ID4gQmVmb3JlIHRoaXMg
cGF0Y2gsIGl0IGNhbiBjYXB0dXJlIHBhY2tldHMgYnV0IGFsd2F5cyBzdGF5cyBvbiBjaGFubmVs
IDEuDQo+ID4gV2l0aCB0aGlzIHBhdGNoLCBJIHN3aXRjaCBjaGFubmVsIDEgLS0+IDM2IC0tPiAx
NDkgLS0+IDExLg0KPiA+IEFsbCBhcmUgZXhwZWN0ZWQuDQo+ID4NCj4gDQo+IE9LIGNvb2wsIG5v
IHdhcm5pbmdzPw0KPiANCg0Kbm8ga2VybmVsIHdhcm5pbmdzLCBubyBjb21waWxlciB3YXJuaW5n
cy4gDQoNCkkgZGlkIGFkZGl0aW9uYWxseSBzaW1wbGUgY29ubmVjdGlvbiB0ZXN0LCBzdGlsbCBu
byB3YXJuaW5ncy4gDQoNClBpbmctS2UgDQoNCg==

