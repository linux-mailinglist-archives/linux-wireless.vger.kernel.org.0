Return-Path: <linux-wireless+bounces-20416-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E8AA63C1B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 03:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70C3188EF4A
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 02:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533001459F7;
	Mon, 17 Mar 2025 02:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="LcL2HcAq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0637E2FB6
	for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 02:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742180002; cv=none; b=lG+zfjdUXnHqaLp6O93jZ6npsLi/XXWIM/MKPCYxeZppuK678SnJYFPKVCCWENcfUHiG2fMFhVOSjL0+cs4tq+lWwBmX7x6Y0HlNwCicfKQ5FjPPE8VmOHpbUNO0DUq2keGnqK2tLk+Nb0tz0q8ppNwt8C4wmLdaGR5CMoVj8p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742180002; c=relaxed/simple;
	bh=BXFJwiamhbsORSbnXqK9G+r+bQ4UvBr9kQv+qufFng0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nVJRu9E1YUhVmRE4VYZCoyiSqza/yawJC24/t7g5VhO0pku8g8mkO+xh8vtWdKEPMd7t1ZEGRzMe9Apx5jFViecq4dfwV5/vGgfnp/H3Ei9dGtWbSuosq8STLoXln67lByjRnvSxUWSB4Ik5Mw++y7qCS5A0zI87aShYr9LSMfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=LcL2HcAq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52H2rG0W13986501, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742179996; bh=BXFJwiamhbsORSbnXqK9G+r+bQ4UvBr9kQv+qufFng0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=LcL2HcAqJHNGlCR6u5VyMfXzVb9BfGhbaJ4mMHgxZqtF3/FzuvB1Usw2yF9Ah0qeD
	 26ftt2Ta0aMZHJl8WqtnnwjfNCtv8mTz8Q4CyF6uW5PaL+qtEl+GOoiKs1CIX7bPcL
	 aZcWQZ4Vdz/SYKcrlBJILh/cn9k152gupcIbrJCGSUOcYDSOFGzSVw+jpnC1AVfPg4
	 Bu18nyEddAC16vqHz9giXHfmwMKbUQq11grEpJ7amZQjVDEuHsRxVmZQaVkPQjhLWw
	 iwHzsPl1rDK4vRy4XcH9+gDdxY6Jykv39B4PyU05V/dRZEOpDDHr69vfQo/3p4JMzX
	 NdI1iBBqtJR4Q==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52H2rG0W13986501
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 10:53:16 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Mar 2025 10:53:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 17 Mar 2025 10:53:16 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 17 Mar 2025 10:53:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 2/4] wifi: rtw88: usb: Enable RX aggregation for RTL8814AU
Thread-Topic: [PATCH rtw-next 2/4] wifi: rtw88: usb: Enable RX aggregation for
 RTL8814AU
Thread-Index: AQHblFT4yNEJ8ojmmUuQWH7b8mRgWbN2prjg
Date: Mon, 17 Mar 2025 02:53:16 +0000
Message-ID: <da62016c9db54d5ba65075a69825a9a7@realtek.com>
References: <c845ff10-08d9-4057-8f54-1579a548788d@gmail.com>
 <1cf5d430-82c2-4b7c-96f3-035aa5b899fe@gmail.com>
In-Reply-To: <1cf5d430-82c2-4b7c-96f3-035aa5b899fe@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBMZXQg
dGhlIGNoaXAgdHJhbnNmZXIgc2V2ZXJhbCBmcmFtZXMgaW4gYSBzaW5nbGUgVVNCIFJlcXVlc3Qg
QmxvY2suDQo+IFRoaXMgaXMgc3VwcG9zZWQgdG8gaW1wcm92ZSB0aGUgUlggc3BlZWQuDQo+IA0K
PiBJdCBjYW4gdXNlIHRoZSBzYW1lIGNvZGUgdXNlZCBmb3IgUlRMODgyMkNVLCBSVEw4ODIyQlUs
IGFuZCBSVEw4ODIxQ1UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxy
dGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGlo
QHJlYWx0ZWsuY29tPg0KDQoNCg==

