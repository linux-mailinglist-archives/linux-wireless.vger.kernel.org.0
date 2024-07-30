Return-Path: <linux-wireless+bounces-10669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F23049409FF
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 09:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A7A5B21B10
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 07:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D895915FCEB;
	Tue, 30 Jul 2024 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="qFi+Uduh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1AB13B780
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325035; cv=none; b=J5CDbyc6g10wuNAhVaGiHGDMVvRghHsJTgMELSI/sSe4W3rHRczLMbNgPmTHtv9p7hJddLjFc63BlzHS6Pp9BMnTedpl4uL0ytaQDLKnxuuanwKnGiOOEchNkxSzE89sOwmfelmaxVe1Vz+sYXrRMSGighdp/CK9KNisbZTesEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325035; c=relaxed/simple;
	bh=VMGu8vHaITigWXxW8eVFtEufnfk8j9AA5mikNvM6J0M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PujQdiWD16ix/+oPOFcaAxghBrFXUUtXo88M5Jz1/czTtGU7Ad+KADOC2UKxjzIgIzqMdHH2u4cGhutXJtP2P/19TB8GoYpyUY3hQCX8zcnU2bEhBouj0kBR/VjEeU6opZHWr6cN8/np2GmBII/7+uL7rLY+N0U01VAX8h79YB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=qFi+Uduh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46U7aveW7856948, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722325017; bh=VMGu8vHaITigWXxW8eVFtEufnfk8j9AA5mikNvM6J0M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qFi+UduhZycaNUc7rZznleL05OmFBb3fG0VmX5E1zIuRMSmFUEEQfmp3/l799cTUl
	 hU9jf0iKymt9tq/7xiGzu6aciA/YwJZK93Nk/QlaAJ4uN82NBk6RFMy9lOMY4yj/Qi
	 tSH+Hcx6l9wuLKMFdhreBKs3ldwDIyBHGZSl0IpNX6D0rAYFRR1g/GjHtkXANoH9LH
	 VNOr7pRBxJBoJCo79Yd5hPsaByXzEEmTn62Op53Kouq106WTTbXVm8C9g1Ykd0Ucq4
	 zU6U6sVV3KAlFb1yB3ShMqP0uyMwXqEK7EurPtdu17u2rQNbXk7OR+R/BZ7VzGwlgQ
	 D9Ao1ggkxj/YQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46U7aveW7856948
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 15:36:57 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 15:36:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jul 2024 15:36:56 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 30 Jul 2024 15:36:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>,
        Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
Subject: RE: [PATCH 1/2] wifi: rtw88: Fix USB devices not transmitting beacons
Thread-Topic: [PATCH 1/2] wifi: rtw88: Fix USB devices not transmitting
 beacons
Thread-Index: AQHa4UB0rdjEjlHrdU2FqSD7y/ZODbIO41dQ
Date: Tue, 30 Jul 2024 07:36:56 +0000
Message-ID: <e45001bc03ef4856909246de5c753596@realtek.com>
References: <9174a776-4771-4351-85fa-476e240d8ace@gmail.com>
In-Reply-To: <9174a776-4771-4351-85fa-476e240d8ace@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBbGwg
VVNCIGRldmljZXMgc3VwcG9ydGVkIGJ5IHJ0dzg4IGhhdmUgdGhlIHNhbWUgcHJvYmxlbTogdGhl
eSBkb24ndA0KPiB0cmFuc21pdCBiZWFjb25zIGluIEFQIG1vZGUuIFRoZSBjYXVzZSBhcHBlYXJz
IHRvIGJlIGNsZWFyaW5nDQo+IEJJVF9FTl9CQ05RX0RMIG9mIFJFR19GV0hXX1RYUV9DVFJMIGJl
Zm9yZSB1cGxvYWRpbmcgdGhlIGJlYWNvbiByZXNlcnZlZA0KPiBwYWdlLCBzbyBkb24ndCBjbGVh
ciB0aGUgYml0IGZvciBVU0IgZGV2aWNlcy4NCj4gDQo+IFRlc3RlZCB3aXRoIFJUTDg4MTFDVSBh
bmQgUlRMODcyM0RVLg0KPiANCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyA2LjYueA0K
PiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNv
bT4NCj4gLS0tDQo+IEknbSBub3Qgc3VyZSBpZiBTRElPIGRldmljZXMgaGF2ZSB0aGUgc2FtZSBw
cm9ibGVtLiBBbHNvLCBzaG91bGQNCj4gQklUX0VOX0JDTlFfREwgZXZlciBiZSBjbGVhcmVkIGlu
IHRoaXMgZnVuY3Rpb24/IFRoZSByZWxldmFudCBjb2RlIGlzDQo+IGRpc2FibGVkIGluIGFsbCB0
aGVzZSBkcml2ZXJzOg0KDQpJIGNoZWNrZWQgaW50ZXJuYWwgdGhlIGxhdGVzdCBkcml2ZXIsIHdo
aWNoIGNvZGVzIGFyZSBjaGFuZ2VkIGFnYWluLiANCldlIHdpbGwgY2hlY2sgZmxvdyBpbnRlcm5h
bGx5IGFuZCBwcmVwYXJlIGEgcGF0Y2ggZm9yIHRoaXMgcHJvYmxlbS4NCg0KVGhpcyBwYXRjaCBn
aXZlcyB1cyBnb29kIGhpbnRzIHRvIGFkZHJlc3MgcHJvYmxlbS4gVGhhbmtzLg0KDQoNCg==

