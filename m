Return-Path: <linux-wireless+bounces-13873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DB19997E8
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 02:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D001C2506F
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 00:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269E25227;
	Fri, 11 Oct 2024 00:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="MzKSafWj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD64C523A
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 00:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728606411; cv=none; b=azWASVy9I7CNhi30fpCo4eTsH+M3RDSy24hcRCDEosSm13WBafQdtayLDkz2YEpqmTEnxzj5sPXmR6XT8GayizP4YiQS80LXx+ZtI2vMWcQb5Ur7H/bn7cWQqyqS6kkMPmk/RLgvbzEbtWzCUjr3fIKfaAmhoqtZ0hvJdAYoNa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728606411; c=relaxed/simple;
	bh=SpqpEbN2EiIas/bLvyCl0irG2VXqGcv8PhKvTjJejk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GrjfQ24zCgcSl1NlBiVcGfC7VdC7apTPUfXITSCjk/sUIrtOaYA6GHsiqVedBBGMY6bDjg0hpOLh4r0iTxnD032kH+1K8pbSZNIFx5S8UzZ+UHicrN/cmP8P7M1RfPyDakIj1cr/L19DvXAqClwuxV5ACfmQgCtPtKpyNisadh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=MzKSafWj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49B0QVxO43044626, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728606392; bh=SpqpEbN2EiIas/bLvyCl0irG2VXqGcv8PhKvTjJejk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=MzKSafWjTp6vcfpAOpnPqHguErXrWFW4q4ev+De2RxPYYtA5uM+qmSNXUcAafGWxM
	 f+h/2SyDvuV1Wg+o0wqV2ZUGFdP9pKaBE1yP8HHtnHY3zmlfnhSe5Oid6A2xwgSt6A
	 iJRxC77XYGB8uxqlZ5dnfSPAH2z6nOZurQzr1sGbJd4DbL8LUKL2eEAcAkbuMEU/hz
	 pwrk/VrMOY0beToGm0gFSdw0M0ssR38W2Fq03X+jxaulEsl1Jvb6N8hgMpRTSnDTTZ
	 AJ/jouQWefNMyo6Xx2eRQnTsr8xvFHfejQk5SD4IY4oglYInG2lN65j6QkPl0NKLx3
	 jJ/KSSJ7njnFw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49B0QVxO43044626
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 08:26:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 08:26:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 11 Oct 2024 08:26:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 11 Oct 2024 08:26:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dmitry Kandybka <d.kandybka@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Dmitry Antipov
	<dmantipov@yandex.ru>
Subject: RE: [PATCH] wifi: rtw88: coex: remove rf4ce unused code
Thread-Topic: [PATCH] wifi: rtw88: coex: remove rf4ce unused code
Thread-Index: AQHa8sUxjxiORA1LBEm5YsTjoVr5w7J/br2AgAGSKuA=
Date: Fri, 11 Oct 2024 00:26:32 +0000
Message-ID: <9c83fca1a28c4b3f8fb2ca65752ad655@realtek.com>
References: <20240820055244.128644-1-d.kandybka@gmail.com>
 <2c5c0d485df7b334ea0bfbb87325a5fbc7b52663.camel@gmail.com>
In-Reply-To: <2c5c0d485df7b334ea0bfbb87325a5fbc7b52663.camel@gmail.com>
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

DQo+IFRoaXMgaXMga2luZGx5IHJlbWluZGVyLiBDb3VsZCB5b3UgcGF5IHNvbWUgYXR0ZW50aW9u
IHRvIHRoaXMgcGF0Y2ggYW5kDQo+IGNsYXJpZnkgaWYgdGhlIHJmNGNlIGlzIGFjdHVhbCBmb3Ig
dGhpcyBtb21lbnQgYW5kIGZ1dHVyZT8NCg0KWWVzLiBPdXIgY29leCBkZXZlbG9wZXJzIHdhbnQg
dG8ga2VlcCB0aGlzIGNodW5rLiBGb3IgbWUsIHRoaXMga2luZCBvZiBjbGVhbnVwDQpwYXRjaCBp
cyBub3QgdmVyeSBoZWxwIHRvIGRyaXZlciwgYnV0IEkgYW5kIGRldmVsb3BlcnMgbmVlZCBtdWNo
IHRpbWUgdG8NCmNvbmZpcm0gYW5kIGp1ZGdlIGlmIHdlIGtlZXAgb3IgcmVtb3ZlIHRoZW0sIHNv
IEkgd291bGQgd2FudCB0byBpZ25vcmUgdGhpcw0Ka2luZCBvZiBwYXRjaGVzLi4uIA0KDQoNCg==

