Return-Path: <linux-wireless+bounces-18897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB310A338ED
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 08:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FFDE1889D26
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 07:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EEE208984;
	Thu, 13 Feb 2025 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="VSlWfwK9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C112054E7
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432129; cv=none; b=Wu82dGgtLpkL751wvZ1o5B6cmtWrB+wZDgRmBZyv/9mV/szVyynRHvWlEvPMPvQsNvJpabhvrB8xpMFC4Qf4ePY/4LFmzZmMDJOze+hQ1SWWQj1h1xzRxycFaRB2wEvdNpOYCqCg5KRfODfjQqJ7KGo64bmx9TPLzP0ZCoJOCkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432129; c=relaxed/simple;
	bh=qZmctWawKNpCEB4/x9ucrH25/KI1U8WoweMkpmyHw1c=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QXrFCGcphplrH2BPcrKpxhtYQ96WLqVTZWjmJv/Dhsjw+GaeDkMFVMIWzYIKQUKxan8BybjelfzAZxxE9AKjVh3VXo8deLziEpSNtUL/vSWFRCmv1MrwcfnKVzOmCTPO+/TjoIvJD81SXXEF5fGkWItY8yaOUbhxMiINudysIfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=VSlWfwK9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51D7ZOwpC573291, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739432124; bh=qZmctWawKNpCEB4/x9ucrH25/KI1U8WoweMkpmyHw1c=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=VSlWfwK9il0GWqgghSaL/qj1r504C8SXjXad8styO1oLcLBopyrdhvnmHeZdVrPHV
	 YPNtTtkvvavGSh85Zobm7FZyh6eJkCGs1TB0XCRHY0RHqfyTJKv2e77+mNbjTt3YBb
	 749lqC5jSiaQ+tzUNDmMZdSXROVp12lpKU50f+wRQGDHG0sfYA7K5VXUOYj/t31bfB
	 kIwDoAvdSWV4QkavqsFo/dUldelwa/U8uWFGyZdTR5ZuWj7niWFMydk+zjGAW5C76Z
	 IKwGcAoWkaKQM/8ig6eN8ILZ2Zz5Qafc1ZBem0F66xoKfB302T5IYd68FZv4rCYswU
	 kzYX31r50zqdA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51D7ZOwpC573291
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 15:35:24 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Feb 2025 15:35:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 13 Feb 2025 15:35:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Thu, 13 Feb 2025 15:35:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 3/8] wifi: rtw88: Fix rtw_init_ht_cap() for RTL8814AU
Thread-Topic: [PATCH 3/8] wifi: rtw88: Fix rtw_init_ht_cap() for RTL8814AU
Thread-Index: AQHbfNORrGYx2Sr3nkuY2NiScSX02rNE2eng
Date: Thu, 13 Feb 2025 07:35:23 +0000
Message-ID: <eea02ea1514540a5825e8963e02dc5a9@realtek.com>
References: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
 <afb71646-e164-4635-861d-e2f5b4e16aa3@gmail.com>
In-Reply-To: <afb71646-e164-4635-861d-e2f5b4e16aa3@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBTZXQg
dGhlIFJYIG1hc2sgYW5kIHRoZSBoaWdoZXN0IFJYIHJhdGUgYWNjb3JkaW5nIHRvIHRoZSBudW1i
ZXIgb2YNCj4gc3BhdGlhbCBzdHJlYW1zIHRoZSBjaGlwIGNhbiByZWNlaXZlLiBGb3IgUlRMODgx
NEFVIHRoYXQgaXMgMy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0
bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhA
cmVhbHRlay5jb20+DQoNCg==

