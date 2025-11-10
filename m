Return-Path: <linux-wireless+bounces-28729-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF31FC4576B
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 09:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39B42347532
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 08:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A17FA926;
	Mon, 10 Nov 2025 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="uF7O6jQ7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D71324E4B4
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764900; cv=none; b=t9UgZL3Hy1rm3P2bWmKUR0SWZI8mR2Rd3f5u4gdpHvtFHaFDmz+642LD5unEU7SPl57dU33g1J4EZQeNiOBTsd8s2GaqMVpfpit1thkFkAYdeI/gYmhZR+wyQZpTr+EaeWGJMfCaQ6jPm8yU9QGr+JgvEJHzl8/P+ANrrDEBW1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764900; c=relaxed/simple;
	bh=Pe3UvhpYiIAjEhIUptJ4GyqVIkzS2AoNvEd3bBILhac=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mD6rzXJ42AF6F5z88BW4Pj66EytMX0d/6L0Txk+gKIcq1y5oFfkbqzLkU89lVnBRiPCeGJbv2qkJStOFcHEMYn+r45EGS2Rp9vSMjBlzLFqZy5XCbRtgtmz0Ihg5XDVGZrjJgbAlDPr+obGH2/q9Hz5MHrfevEZLxHog6kAGhWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=uF7O6jQ7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AA8ssMY31411646, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762764894; bh=Pe3UvhpYiIAjEhIUptJ4GyqVIkzS2AoNvEd3bBILhac=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=uF7O6jQ7DVs9GlTSeBtphG2/bKJXg2tRCg9M7ki2aRV+mJVeURHd7QflNBzcy3cHi
	 zsLHMrdO4YPt36gv96RZxwA22UtXwAqlBvfDpwaJbIftKThiA+xPHcncF0GZ9jPL9V
	 vzuTRpC+2NWJ2XNZoAqSbmb/MfI33iHeak67MbWe4oN4bGgRd+xxQ8rvZOi8qz6sJW
	 hbNg9hxqSz+cDYcgsErNz91Z047tn8DuUegTrPrII/CensJB5GYjZpiw/WMV3Twnfp
	 O+5iHm/M6lfmvADbgnbjYe7muPBYPrTmjec6CxIyy+Lrl5sTAy2VXKWOOx+RARKI40
	 aXe0GzHTuaHnQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AA8ssMY31411646
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 16:54:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 10 Nov 2025 16:54:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Mon, 10 Nov 2025 16:54:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 4/6] wifi: rtw89: 8852a: Accept USB devices and
 load their MAC address
Thread-Topic: [PATCH rtw-next 4/6] wifi: rtw89: 8852a: Accept USB devices and
 load their MAC address
Thread-Index: AQHcUADP0SzqQ5x3ZUGZEjOtA7aAVrTrn0Tg
Date: Mon, 10 Nov 2025 08:54:54 +0000
Message-ID: <c0869e8f397c43378e0cb79df27932b7@realtek.com>
References: <f0021b8c-efc7-4993-b0a8-8954c682d13b@gmail.com>
 <97412e2c-ac98-403c-9056-9d9fe1ed9f28@gmail.com>
In-Reply-To: <97412e2c-ac98-403c-9056-9d9fe1ed9f28@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBNYWtl
IHJ0dzg4NTJhX3JlYWRfZWZ1c2UoKSBhY2NlcHQgVVNCIGRldmljZXMgYW5kIGxvYWQgdGhlIE1B
Qw0KPiBhZGRyZXNzIGZyb20gdGhlIGNvcnJlY3Qgb2Zmc2V0Lg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5
OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0K

