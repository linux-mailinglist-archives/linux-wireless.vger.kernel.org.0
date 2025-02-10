Return-Path: <linux-wireless+bounces-18675-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9B6A2E1FF
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 02:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1045F1887864
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 01:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C27C179A7;
	Mon, 10 Feb 2025 01:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="JxVCQgFz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC0612B73
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 01:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739150728; cv=none; b=kNXw5c+UhH/DhQdBc+5JqTlK+NyUH4yB0U8ejKnLlFlPtj+x8Fw9K7TkbmejLDrycxtGFXMVril18Oe/YwqH+mZZOLe8KpXUp7WueA8vYyWgLhk7i7JTMGBQxZfaZ8fAttpaUt3J78KYSO5MXQBbkcpI8QazChG5n0J6OanUBlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739150728; c=relaxed/simple;
	bh=nlVf43bD8tu+XSIRlC83zoC8dgn3R+DBVvtkN10Sn+4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hafuGYCVIiCX8N0/ItXSe3hXNBrPLdU7oiKGMMw+c/xOon4HHy5p5nxKOJbuCmnm8Q9rLIUYyaGHQA1YiL/cn9zMdIp1nYM+RHFR5dOGZRpJy3z04N45OxH9GMAjMVp7ErQQUAaoUAOai/vGAIkjfn4MDehFgyAmOGl8+dH7elU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=JxVCQgFz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51A1PMB301398110, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739150722; bh=nlVf43bD8tu+XSIRlC83zoC8dgn3R+DBVvtkN10Sn+4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=JxVCQgFzUCZdwn6rctnQGlmjvIHawRdh52S1UwZ7qdc4qczzkttqA2uW0lfx2UyU9
	 sN4NrtXy2aD85eg0LnU5z/PSsrAHk63DbzzD0eKx4Di+6fLPcPHTALc4oeFCMORwaS
	 nx2AQrhxPKGqo1ctUR2UaogFcC3pqnO6tvdLrBLGr2SwJlcT8QHkJqkPD5LgdzMUcL
	 +G5nCihbAaoplBCeC01e2ey3wHVDdbSwynLOHKmJNXSSqh+L09CI08ICwgU9aoL1VD
	 c53/yJr2u9KgSmLrngAAHCSQWwN2zNj5gyKt309SA3yNxDbdeYSS6mp4+xg2oVukts
	 2COYAdB9XhLWw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51A1PMB301398110
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 09:25:22 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Feb 2025 09:25:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 10 Feb 2025 09:25:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Mon, 10 Feb 2025 09:25:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 3/9] wifi: rtw88: Extend struct rtw_pwr_track_tbl for RTL8814AU
Thread-Topic: [PATCH v2 3/9] wifi: rtw88: Extend struct rtw_pwr_track_tbl for
 RTL8814AU
Thread-Index: AQHbdzP45F+92OA1Kk2KZ872olzCpbM/xtIg
Date: Mon, 10 Feb 2025 01:25:22 +0000
Message-ID: <dfe6446e24084aa5b59217bcc746d54b@realtek.com>
References: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
 <be5a73f4-a0fe-43d6-9457-930cde199284@gmail.com>
In-Reply-To: <be5a73f4-a0fe-43d6-9457-930cde199284@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBDdXJy
ZW50bHkgdGhpcyBzdHJ1Y3QgaGFzIHRoZSBtZW1iZXJzIHJlcXVpcmVkIGZvciBjaGlwcyB3aXRo
IDIgUkYNCj4gcGF0aHMuIEFkZCBtb3JlIG1lbWJlcnMgdG8gc3VwcG9ydCBjaGlwcyB3aXRoIDQg
UkYgcGF0aHMsIGxpa2UgdGhlDQo+IFJUTDg4MTRBVS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJp
dHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogUGlu
Zy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg==

