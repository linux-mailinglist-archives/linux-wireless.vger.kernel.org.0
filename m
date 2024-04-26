Return-Path: <linux-wireless+bounces-6912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAC38B2EBA
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 04:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E6A6B21C63
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 02:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514654687;
	Fri, 26 Apr 2024 02:34:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4A11C3E
	for <linux-wireless@vger.kernel.org>; Fri, 26 Apr 2024 02:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714098844; cv=none; b=n5jMlUucXUatDwsLMxZmfTT8QVr7B/raq2XzMlYxPpWinGUOK/Dn1u+4ob6nlVNfKp85qPedprKjNF5Y/U5qO6FL5VSrI/KifAMFt/Zy+FKJuWLp/tcMoEYLFmxCmAaKbWgkaUEJEZZMtwvb+oUW/GLLO7HXBsavs8g6Ql6HWpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714098844; c=relaxed/simple;
	bh=e5S54h868rvmXezLZ+xkaQnV3941udcwsNnmV6sw2gA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gO9o1BO5zKIj292AhjnNDGBAut3QTgWJ4OeHGniSbTdR+dhu0KioohfzUFp3NrvQ9gYHLHF4szgS40ApFl6Jv4zOwf1nOFip+huH6YpQKFeC3Ihfkdy2VMF9Mn61p5xY0jHeyrx1Zi9xLubFa/dIiQfARP8LyTl8bAg/DxRr2p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43Q2XETL04183681, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43Q2XETL04183681
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 10:33:14 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 10:33:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 10:33:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 26 Apr 2024 10:33:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
        Harshitha Prem
	<quic_hprem@quicinc.com>,
        "ath12k@lists.infradead.org"
	<ath12k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: RE: [PATCH v2 8/8] wifi: ath12k: move ath12k_hw from per soc to group
Thread-Topic: [PATCH v2 8/8] wifi: ath12k: move ath12k_hw from per soc to
 group
Thread-Index: AQHaltXZghg8V4u0RkuNNwIxmVXtqLF4/oaAgADWYqA=
Date: Fri, 26 Apr 2024 02:33:14 +0000
Message-ID: <6e2df4425fe442ce8c6a1afd56dbc4da@realtek.com>
References: <20240425055759.1181165-1-quic_hprem@quicinc.com>
 <20240425055759.1181165-9-quic_hprem@quicinc.com>
 <a02ee04a-23af-4103-bb0e-2b989a59342d@quicinc.com>
In-Reply-To: <a02ee04a-23af-4103-bb0e-2b989a59342d@quicinc.com>
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

SGkgSmVmZiwNCg0KSmVmZiBKb2huc29uIDxxdWljX2pqb2huc29uQHF1aWNpbmMuY29tPiB3cm90
ZToNCj4gDQo+IE9uIDQvMjQvMjAyNCAxMDo1NyBQTSwgSGFyc2hpdGhhIFByZW0gd3JvdGU6DQo+
ID4gRnJvbTogS2FydGhpa2V5YW4gUGVyaXlhc2FteSA8cXVpY19wZXJpeWFzYUBxdWljaW5jLmNv
bT4NCj4gPg0KPiA+IFRlc3RlZC1vbjogUUNOOTI3NCBodzIuMCBQQ0kgV0xBTi5XQkUuMS4wLjEt
MDAwMjktUUNBSEtTV1BMX1NJTElDT05aLTENCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEthcnRo
aWtleWFuIFBlcml5YXNhbXkgPHF1aWNfcGVyaXlhc2FAcXVpY2luYy5jb20+DQo+ID4gU2lnbmVk
LW9mZi1ieTogSGFyc2hpdGhhIFByZW0gPHF1aWNfaHByZW1AcXVpY2luYy5jb20+DQo+IA0KPiBU
ZXN0ZWQtb246IFdDTjc4NTAgaHcyLjAgUENJIFdMQU4uSE1ULjEuMC5jNS0wMDQ4MS1RQ0FITVRT
V1BMX1YxLjBfVjIuMF9TSUxJQ09OWi0zDQo+IA0KPiBBY2tlZC1ieTogSmVmZiBKb2huc29uIDxx
dWljX2pqb2huc29uQHF1aWNpbmMuY29tPg0KPiANCg0KV2lsbCBwYXRjaHdvcmsgdGFrZSAnVGVz
dGVkLW9uJyB0YWcgeW91IGFkZGVkIGF1dG9tYXRpY2FsbHk/IE9yIHlvdSBoYXZlIGENCmxvY2Fs
IHNjcmlwdCB0byBhZGQgdGhhdCB0YWcuIEkgdXNlIHB3Y2xpZW50IHRvIGdyYWIgdGhpcyBwYXRj
aCwgYnV0IG9ubHkNCnlvdXIgYWNrZWQtYnkgaXMgYWRkZWQgYXV0b21hdGljYWxseS4gDQoNCkkg
aGF2ZSB0aGlzIHF1ZXN0aW9uIGp1c3QgYmVjYXVzZSBJIHdhbnQgdG8gcmVmaW5lIG15IHdvcmtm
bG93IG9mIHBhdGNod29yay4NCg0KUGluZy1LZQ0KDQo=

