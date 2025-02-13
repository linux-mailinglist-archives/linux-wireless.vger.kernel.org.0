Return-Path: <linux-wireless+bounces-18898-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C54A33907
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 08:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5789E1885C7F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 07:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA2420ADE0;
	Thu, 13 Feb 2025 07:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="uvAvdkR2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5B4208984
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 07:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432398; cv=none; b=oi43TuHfSzNrX1R/9HuMLiKh1zxxs+QsMfuIgNP0MBEAJt09SnFmTVl3QhEzPnKElMRFhWsMw2wvVyVojiMnCJ9mYfgCoCzTXyqV+X1/8v9Kb3na32KDek5LkTfZG8wSf2kTqGhJEesv4RTjlqYk5KRyRORp86clGy9jfgZBlE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432398; c=relaxed/simple;
	bh=DDjR/m0MxQoaOKv5F0DU/pcAYsJlbIeHtdAg1KDNwjs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kdi0tDmSnZuN+ffTe9tFqwwE7o9w2OoQ2y/CzyAKnhsBPH+rV9PJgApcFBxxlecKDyQ0LypwDv+7r4YEUiyhzLZJ9SMXIqDSL8vo4PQ/GqsEbm6sk30cnPf9N/iOqLdxohEyt/Inxbz+HKl75iNT7PFH1Mm8Sf3z4AJ14+gUZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=uvAvdkR2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51D7drgE7576736, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739432393; bh=DDjR/m0MxQoaOKv5F0DU/pcAYsJlbIeHtdAg1KDNwjs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=uvAvdkR2/rr+OP1Im/W6sJyz5I4vlzCjT7Ms0xYdYOAIj7ndPLBcGxk0RSFA6m/o+
	 xU4x68sbYFVFbZNNUUHCxAjhsF5yIuhHXJVffnOmaJfryNnaCXnerKBZX96Oe/Qr2e
	 cBqdBOXGu2s7NKvhqc9z+k7XyFfiQ30G815U3BVzBwjMqZ4UUvM7tVOtsGyMI3TImK
	 t2ags+/u6VEt4bjgDeVPjrJVxImvIYd0NCQRPF9CXBbXV/NioNuSsMgwY4v+pzI03d
	 pycfrieTKNAi4abzYooeSWRji8YHx/lcjA8EImGNFWXV2DAvcdkzuDq1gvY9wyGk7i
	 GSktYEjvLesoQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51D7drgE7576736
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 15:39:53 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Feb 2025 15:39:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 13 Feb 2025 15:39:52 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Thu, 13 Feb 2025 15:39:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 4/8] wifi: rtw88: Fix rtw_init_vht_cap() for RTL8814AU
Thread-Topic: [PATCH 4/8] wifi: rtw88: Fix rtw_init_vht_cap() for RTL8814AU
Thread-Index: AQHbfNOmcGrECE3dJU+4vWegv5CydLNE2y3A
Date: Thu, 13 Feb 2025 07:39:52 +0000
Message-ID: <fe4081c1433a4627aa5669fd4b5fe5b3@realtek.com>
References: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
 <26c2ef1a-b382-4901-b286-d1b48d808900@gmail.com>
In-Reply-To: <26c2ef1a-b382-4901-b286-d1b48d808900@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBTZXQg
dGhlIE1DUyBtYXBzIGFuZCB0aGUgaGlnaGVzdCByYXRlcyBhY2NvcmRpbmcgdG8gdGhlIG51bWJl
ciBvZg0KPiBzcGF0aWFsIHN0cmVhbXMgdGhlIGNoaXAgaGFzLiBGb3IgUlRMODgxNEFVIHRoYXQg
aXMgMy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJm
ZTJAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5j
b20+DQoNCg0K

