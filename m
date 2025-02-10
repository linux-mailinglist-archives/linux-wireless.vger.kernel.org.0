Return-Path: <linux-wireless+bounces-18681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73975A2E21B
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 02:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8C71884C6C
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 01:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6732CF4F1;
	Mon, 10 Feb 2025 01:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="tM3VrVAl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAC7A934
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 01:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739152258; cv=none; b=i8jG68fE14Q4gpBqp7eZdzzyJHWh/ZsOGCWeqZXnu0o4rUKsXfNcbxMucn7nXJEawAImxuIavlB1bKST+2cBy7bvgXRcL1aJNLyP49HgkCY+80gRiTzgQxdM7s+zEvTKLXPC8ZLymoqb6s27FR985MMTcki8AvYQzXQchynERKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739152258; c=relaxed/simple;
	bh=Ruv09NdSTnsmHH96ldaixKIknocAxDn2Pt1dP6LLKVc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VrcHcRvqwARNQPpGri1SkTAAKbI4B/VtDcZ3PMrwFVWSEP6rZQfp8Ve7F2ZCGnvNOWABlfBS181scCu5TZELtSO4JW4niMNX80CETzPn+ADCU07qGGLLMN0p4g85chpF7MqOtwdHmxy7opY4K/RTuAQFb4qMM7NMPmzxjrZ2U3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=tM3VrVAl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51A1orenF1426424, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739152253; bh=Ruv09NdSTnsmHH96ldaixKIknocAxDn2Pt1dP6LLKVc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=tM3VrVAlu/z1q1anEJhxPSo5/Q9LYFmdI/4OzMXTsc9oLex9CdXPvV8TypVLxrs0q
	 kohtiHNtvv3MtRG5MyFY76QwFtB982vprrtlP5kRNqDaNhzb5ajqos68Ac6oZpcv85
	 zKT597ZgUilMRXb+IeVUx71h93YHu3cYbMx5G5y9ldWcdJXPS10YeiIZY83TRk7rw5
	 fZcS6tOJY3h9TH2U415JS0gjGuL81qe39albWvXZhUIvEHwy+DjgInQKIqG0alIRbd
	 YxxWstvSAe5cGy52fTGlH1beYSdw+iacyVd7213TtgXWtIEVA1yVdqVVtzNUqtERlm
	 ztDEUGGmYH42A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51A1orenF1426424
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 09:50:53 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Feb 2025 09:50:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 10 Feb 2025 09:50:53 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Mon, 10 Feb 2025 09:50:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 9/9] wifi: rtw88: Fix rtw_update_sta_info() for RTL8814AU
Thread-Topic: [PATCH v2 9/9] wifi: rtw88: Fix rtw_update_sta_info() for
 RTL8814AU
Thread-Index: AQHbdzSCfDk4EjxWCUi47dM9A2lrvLM/zfCQ
Date: Mon, 10 Feb 2025 01:50:52 +0000
Message-ID: <ac7ccc6b9e4846d288681d069ddface4@realtek.com>
References: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
 <48d1d90f-2aeb-4ec5-9a24-0980e10eae1e@gmail.com>
In-Reply-To: <48d1d90f-2aeb-4ec5-9a24-0980e10eae1e@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGlz
IGZ1bmN0aW9uIHRlbGxzIHRoZSBmaXJtd2FyZSB3aGF0IHJhdGVzIGl0IGNhbiB1c2UuDQo+IA0K
PiBQdXQgdGhlIDNTUyBhbmQgNFNTIEhUIHJhdGVzIHN1cHBvcnRlZCBieSB0aGUgb3RoZXIgc3Rh
dGlvbiBpbnRvIHRoZQ0KPiByYXRlIG1hc2suDQo+IA0KPiBSZW1vdmUgdGhlIDNTUyBhbmQgNFNT
IHJhdGVzIGZyb20gdGhlIHJhdGUgbWFzayBpZiB0aGUgaGFyZHdhcmUgb25seSBoYXMNCj4gMiBz
cGF0aWFsIHN0cmVhbXMuDQo+IA0KPiBBbmQgZmluYWxseSwgc2VsZWN0IHRoZSByaWdodCByYXRl
IElEIChhIHBhcmFtZXRlciBmb3IgdGhlIGZpcm13YXJlKQ0KPiB3aGVuIHRoZSBoYXJkd2FyZSBo
YXMgMyBzcGF0aWFsIHN0cmVhbXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNt
aXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8
cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCg==

