Return-Path: <linux-wireless+bounces-16803-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B17219FC75E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 02:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08B737A1229
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 01:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B481B4409;
	Thu, 26 Dec 2024 01:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="eBq/3WML"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF694211C;
	Thu, 26 Dec 2024 01:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735176177; cv=none; b=ThEb2Q1pZWDpNQ8+qrC7a246gB7nt7xhIb1LvBMWH5heKn1viPKJ5r3gKSXgOo/kR+jkPlVb0ubarR6eRV1Hp9qA43s9NsmO42Ea3wBh8eN4YQ8c7J81nzF/KphgWakn0PRalopDuDBU6huFcARx/CW6f0kv8NcLwLH030fIz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735176177; c=relaxed/simple;
	bh=dJZs5KgRk8P9AJ5VynRzyfjUIUtwQ8kiFDjHQ+VgoHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dNkRmAq/AewmCrJLivwBAPqTSGApTmpC4UnTb3M9nb1yzNJTqnHMgF7SuUZ+e9BOshkpmrFX8KLFCBosnFIiSIDF34tqcapMHGuzz7UkN4PmjYuzOmNpzXNpLwRuDuLxcNjTQj+cFgB8xcttO0rGWB/XiUZ+B+0BowxpWlSwthg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=eBq/3WML; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BQ1LYekC1702214, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1735176094; bh=dJZs5KgRk8P9AJ5VynRzyfjUIUtwQ8kiFDjHQ+VgoHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=eBq/3WMLhRfoPgQKQu71SS9Zzf1tikpkZ6X0de+0EDBQeqgidbxTu+1lK7Yg5cKZY
	 6Lc+gBtdxfUYtj/ioY7zvi14ND7W+dStcBRxoDUEul6ppbNobuI+pGLL18ya7xmLaO
	 I2RD1oQ7BJWxz0nADP9m7aIpnM1+IvDBu3QxiF5r+N5IUbkQ9SISHVrk9e9G2VvCvN
	 FdZ/5XHw8t2oXY7I8dbudoOIro5iR4Y/5LV5Gn4DfTR41vl8cCclOSV/HijRF6Xenk
	 R95ycUxhDPdrqMddRwszPuhuVZJc0wAs6CQEQHCzlKSYCOowDWA4p+IZ8qjoTMoWar
	 W9d3gJfIVcFyg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BQ1LYekC1702214
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Dec 2024 09:21:34 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Dec 2024 09:21:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 26 Dec 2024 09:21:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 26 Dec 2024 09:21:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: zhangkunbo <zhangkunbo@huawei.com>
CC: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>,
        "chris.zjh@huawei.com"
	<chris.zjh@huawei.com>,
        "deren.wu@mediatek.com" <deren.wu@mediatek.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "liaochang1@huawei.com"
	<liaochang1@huawei.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mingyen.hsieh@mediatek.com" <mingyen.hsieh@mediatek.com>,
        "nbd@nbd.name"
	<nbd@nbd.name>,
        "ryder.lee@mediatek.com" <ryder.lee@mediatek.com>,
        "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
        "shayne.chen@mediatek.com"
	<shayne.chen@mediatek.com>
Subject: RE: [PATCH -next] wifi: mt76: mt7925:: replace zero-length array with flexible-array member
Thread-Topic: [PATCH -next] wifi: mt76: mt7925:: replace zero-length array
 with flexible-array member
Thread-Index: AQHbUSIelWjT+gzvmUWChDYoiKFvSrL2LIeAgAGZmIA=
Date: Thu, 26 Dec 2024 01:21:34 +0000
Message-ID: <4d7c50df29ce45389a5186f9d9eddc7b@realtek.com>
References: <20241218074552.3271542-1-zhangkunbo@huawei.com>
 <7e456e10-23a0-412b-8bf8-8860aef436dd@huawei.com>
In-Reply-To: <7e456e10-23a0-412b-8bf8-8860aef436dd@huawei.com>
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

DQp6aGFuZ2t1bmJvIDx6aGFuZ2t1bmJvQGh1YXdlaS5jb20+IHdyb3RlOg0KPiANCj4gcGluZyBn
ZW50bHkuDQo+IA0KDQpIYXZlIHlvdSBjaGVja2VkIHBhdGNod29yaz8NCkFzIHBhdGNoIHN0YXRl
IGlzIG5ldyBbMV0sIEkgdGhpbmsgbWFpbnRhaW5lcnMgd2hvIGhhdmUgbmV3IHllYXIgaG9saWRh
eQ0KZG9uJ3QgbWlzcyBpdC4gDQoNClsxXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3By
b2plY3QvbGludXgtd2lyZWxlc3MvcGF0Y2gvMjAyNDEyMTgwNzQ1NTIuMzI3MTU0Mi0xLXpoYW5n
a3VuYm9AaHVhd2VpLmNvbS8NCg0K

