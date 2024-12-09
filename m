Return-Path: <linux-wireless+bounces-16023-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757979E8BB9
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 07:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D63281129
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 06:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6672B20FA9A;
	Mon,  9 Dec 2024 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="nlFkzOuf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C951D555;
	Mon,  9 Dec 2024 06:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733727296; cv=none; b=fw+jG09tOpWD9bn3bZbRdJ1mMyXZPMuEpuHu1dvbY4lv4U/FdjH57VaEVQLRJ8HZM2BUZj0Sy9yUAkRfAZk4BMhO5lZL5RGv+aG7iMfvJg18ybm1qWP2N3jIszNs2surx0RsKO6dIua/48sdsSa8LRganjGJHk26Y/Ku6WNTmkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733727296; c=relaxed/simple;
	bh=2mvY0PkgyrPvim+FppH+JlWI+fh1fAdRZ50dodZH00Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kj5rAV6J//yYWnyIQwJvo5ufHta8eNPYDpaQ5MKMm2tQeJHQDV90i7lf4vhqRAbXSvqPSjh/c/yKUsEUhQ6jodsU9Z2I4rNLUXlRUzAR1dfr1ykmx2W0fCYNGlBOcRfmhzK6luMTjKcGbzcL5daEZ+iqb9QLOrXBk6oaS7bwK+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=nlFkzOuf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4B96siVO3175998, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733727284; bh=2mvY0PkgyrPvim+FppH+JlWI+fh1fAdRZ50dodZH00Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=nlFkzOufbuXtnhENVyHW3uo6JPxnKrHHWHhbpzCw01oElM2pw57smJdSbUNrSuIdo
	 Iv4olfkBuXrSx065sVlwVNXLSblhTJLK3WZQlJNbLGnhnHO1VVjjyNyTmRuDAG+1Pd
	 CRgjKbzzuv1d6lN0I3VveLwqK3Sp7BqoQletyL53Q6cOTUZ8EsBy3oQPByBWeNA9A1
	 DBF0TMkhkowPhNzuQv3310qf6Dc5lrP6p76kWo6iYCdmuNk66sUeYNnMMNMcwRDIhk
	 V9JZv4fVoDzDMFAEodvM0Gpg9GA49X1K5PkVjAsobVUfRwNdcy6IDNeNV+fUuHfqpw
	 svhyUMxAatvAA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4B96siVO3175998
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 14:54:44 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 14:54:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 9 Dec 2024 14:54:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Mon, 9 Dec 2024 14:54:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: liujing <liujing@cmss.chinamobile.com>, kvalo <kvalo@kernel.org>,
        suhui
	<suhui@nfschina.com>
CC: linux-wireless <linux-wireless@vger.kernel.org>,
        linux-kernel
	<linux-kernel@vger.kernel.org>
Subject: RE: RE: [PATCH] rtlwifi: rtl8188ee: fix spelling error in _rtl88e_phy_set_rfpath_switch()
Thread-Topic: RE: [PATCH] rtlwifi: rtl8188ee: fix spelling error in
 _rtl88e_phy_set_rfpath_switch()
Thread-Index: AQHbSf4Bnwk1YuLp4kSNEDFg7w8YhbLddJvggAAFsDA=
Date: Mon, 9 Dec 2024 06:54:44 +0000
Message-ID: <f1857a296d324c8c91ec354d99fbbb89@realtek.com>
References: <2024120913484116132252@cmss.chinamobile.com>
 <d6b9d0b67dd14032b458c6e568437a39@realtek.com>
In-Reply-To: <d6b9d0b67dd14032b458c6e568437a39@realtek.com>
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

UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiANCj4gbGl1amluZyA8
bGl1amluZ0BjbXNzLmNoaW5hbW9iaWxlLmNvbT4gIHdyb3RlOg0KPiANCj4gPiBubyBkdXBsaWNh
dGUgaXMgc2VudCwgYnV0IHRoZSBwYXRjaCBvZiB0d28gZmlsZXMgaXMgc3VibWl0dGVkLg0KPiA+
DQo+ID4gT25lOiBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRsODE4OGVl
L3BoeS5jDQo+ID4gVHdvOsKgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0
bDgxOTJlZS9waHkuYw0KPiANCj4gQXMgSSBzZWUsIGJvdGggYXJlIHJ0bDgxODhlZToNCj4gDQo+
IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9wYXRj
aC8yMDI0MTIwOTAzMjEzMy4yOTc0LTEtbGl1amluZ0BjbXNzLmNoaW5hbW9iaQ0KPiBsZS5jb20v
DQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9w
YXRjaC8yMDI0MTIwOTAzMjU0OC4zMTAwLTEtbGl1amluZ0BjbXNzLmNoaW5hbW9iaQ0KPiBsZS5j
b20vDQo+IA0KPiANCj4gQWxzbywgcGxlYXNlIG5vIHRvcCBwb3N0aW5nIGFuZCBpbiBwbGFpbiB0
ZXh0IG1vZGUgZm9yIGxpbnV4LXdpcmVsZXNzLg0KPiBPdGhlcndpc2UsIG1lc3NhZ2VzIHdpbGwg
YmUgaWdub3JlZCBieSBwYXRjaHdvcmsuDQo+IA0KDQpBbmQgc3ViamVjdCBwcmVmaXggc2hvdWxk
IGJlICJ3aWZpOiBydGx3aWZpOiAiDQoNCg==

