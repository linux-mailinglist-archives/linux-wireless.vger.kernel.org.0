Return-Path: <linux-wireless+bounces-19067-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4464BA37D81
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 09:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F3837A1241
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 08:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6C519E7FA;
	Mon, 17 Feb 2025 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="dOhaxvvJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390DC1922E6
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782387; cv=none; b=lwmUHKsUzbZ7dhkgyHBMnNtGmweoqqXZCNDa31jKDAe8VDOzxlTLrTyliB7TLAeQzO9oTyC+ZFJhLmz3ggit/tJtRqY0Lq4969FN6PG51Ejbn7IIllYR0q6kt0/8Mb+P8C208rgEgwVLM8Hn5to1s9ENW3dZth+vRwZJusyW2/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782387; c=relaxed/simple;
	bh=wAT2Iwym3GcklLDCiBPFhpJv1yxiOA3uuQCGhFnUuQg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MTQhLoXOLOaz61dwfkaLm3Y9/IphyXyU5RpFhn6UimgbW35/TcSFfHItU8hq/jSUJwBsOabwZIYws6+FnXondM4jx2j6H4+JkRfw8Xwe7po8vJAG6GGInMzo5mtr33E4FW3KnrD3YN6m9f2g0yS3N2NPkkPO7y3qf7P55Lz0cwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=dOhaxvvJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51H8r0ymD2816663, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739782380; bh=wAT2Iwym3GcklLDCiBPFhpJv1yxiOA3uuQCGhFnUuQg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dOhaxvvJ37184eubU2IDwOgOkZAWyCY09kD7iyHlikhxOWUoMMy9d77P2vgKRMxv9
	 RMpT+fXVphwwXRf+0a4zAjxReHRvSUJ+wyjwFLSShqsUgYF5arv/OFHcRgEbIbuu+d
	 vP3qhU0vyQDY2casAwpvXLOhdWhMTHAF+3Hv3l85ut+tDPfiI6ayY3oH++SG/sEW08
	 Cr466bnJOvEX+S9WrbPqboKboqeWoEes8p/Qj0abTlf/o8V8IAnl4i5i2nU3+0enXr
	 /TS6Wr05Cru4hZVNTokycN0UDS2NUdW1qXU0rgGjy9+clJB0X+NKX8Z6PX+K4deB1u
	 rFO0CwV2ec0jg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51H8r0ymD2816663
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 16:53:00 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Feb 2025 16:53:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 17 Feb 2025 16:53:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Mon, 17 Feb 2025 16:53:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 8/8] wifi: rtw88: Extend rtw_debugfs_get_tx_pwr_tbl() for RTL8814AU
Thread-Topic: [PATCH v2 8/8] wifi: rtw88: Extend rtw_debugfs_get_tx_pwr_tbl()
 for RTL8814AU
Thread-Index: AQHbf/VfA6tnNkEjREq7sB+dI45cnLNLMrDg
Date: Mon, 17 Feb 2025 08:53:00 +0000
Message-ID: <57c4b16b7f3c42cfb1e99d8a22140273@realtek.com>
References: <12ab9180-45e9-40e5-98e0-6ef7b6c463d5@gmail.com>
 <db9d68ca-a2ed-4f07-a80c-adf1bf403000@gmail.com>
In-Reply-To: <db9d68ca-a2ed-4f07-a80c-adf1bf403000@gmail.com>
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
IGl0IHByaW50IHRoZSBUWCBwb3dlciBkZXRhaWxzIGZvciBhbGwgUkYgcGF0aHMsIG5vdCBqdXN0
IEEgYW5kIEIsDQo+IGFuZCBmb3IgYWxsIHRoZSByYXRlcyBzdXBwb3J0ZWQgYnkgdGhlIGNoaXAs
IG5vdCBqdXN0IDFTUyBhbmQgMlNTDQo+IHJhdGVzLg0KPiANCj4gQWxzbyBza2lwIHRoZSBSRiBw
YXRocyBhbmQgcmF0ZXMgbm90IHN1cHBvcnRlZCBieSB0aGUgY2hpcC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpBY2tl
ZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg0K

