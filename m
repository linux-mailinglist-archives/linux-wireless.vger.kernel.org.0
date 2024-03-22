Return-Path: <linux-wireless+bounces-5146-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB3A886891
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 09:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C8CBB24937
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 08:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30E3179B8;
	Fri, 22 Mar 2024 08:53:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F1D18EC0
	for <linux-wireless@vger.kernel.org>; Fri, 22 Mar 2024 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097604; cv=none; b=OjxBdjQXDFBb9ODIpcjvBN8tAb9rjrsl40yaZrGlW5VaRf0YnzR0bE+RZk62wv8roZk+l4MOp7IzxkWTkXPYCSTyzxRxZ2vPmtsnPkMBWhQyTIug8HcQuUpJggOkvAEF1mdQU7DbEpqc+Eyosnb6zBERoiAm51PTdXHYZfLpiLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097604; c=relaxed/simple;
	bh=neXq4uOg8GPFki0xsr3nwuUn19IanPco6MnEm+IyiMQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sbCToxPCHqftmz9W5GzlchKF/W1CckzzKNRvG/B2+YTcxMNm2rVshDPnrlMGu85Iy8595JPDgKdanU7OEpqbauHHArRHIGqNHGDskIuzdEvsy50Q+rAqOIV9it+IGXk7sCUxD7r3McmiyZPCNp2pjRUqcDd+XiPD3IhQuXq49qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42M8rAoL51589440, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42M8rAoL51589440
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 16:53:10 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 16:53:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 16:53:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Fri, 22 Mar 2024 16:53:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH 1/2] wifi: rtlwifi: drop WMM stubs from rtl8192cu
Thread-Topic: [PATCH 1/2] wifi: rtlwifi: drop WMM stubs from rtl8192cu
Thread-Index: AQHaeqPjW2/BnerMkUaWeJvPehqsv7FC0KeAgAAdW4CAAIi3cA==
Date: Fri, 22 Mar 2024 08:53:10 +0000
Message-ID: <22c82eb2c73645f3aba5e8607ffdd232@realtek.com>
References: <20240320084324.109506-1-dmantipov@yandex.ru>
 <167eca8d-0a6b-4203-b8c8-f7ea431547c3@RTEXMBS04.realtek.com.tw>
 <5b0ae31f-11e0-4c31-928e-8b0e22abb799@yandex.ru>
In-Reply-To: <5b0ae31f-11e0-4c31-928e-8b0e22abb799@yandex.ru>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

DQo+IFRoYW5rcy4gU2hvdWxkIEkgdXNlIHJ0dy1uZXh0IG9mIHJ0dy5naXQgZm9yIGZ1cnRoZXIg
c2ltaWxhcg0KPiBjbGVhbnVwcyAoaWYgdGhlcmUgd2lsbCBiZSk/DQo+IA0KDQpZZXMsIGJ1dCB3
ZSBwcmVmZXIgcmVhbCBmaXhlcyB3aXRoIHBvdGVudGlhbCByaXNrcy4gQ2xlYW51cHMgYXJlIGV4
dHJhIGxvYWQgZm9yIHVzLiANCg0KUGluZy1LZSANCg0K

