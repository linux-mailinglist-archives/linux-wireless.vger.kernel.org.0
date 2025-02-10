Return-Path: <linux-wireless+bounces-18676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3013BA2E205
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 02:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDAE8164AA0
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 01:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374BD17BD6;
	Mon, 10 Feb 2025 01:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="EHwHlQwh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E68F9FE
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 01:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739150930; cv=none; b=S7K6WgNVDMna6xzw6pr1NoI+a9o456jRko6bDb4QJM13pgAIMBqRXpg/SRhlFtWSh9kDY09tZ5exL0vSMJcCmagq+uQX5nL8MMAkDQZZJ4LvLIOd3ZRfJMpJnrMJHLxIIkbC8reFLNMF4jL2NxnhjDVx5zjcZq7c2eWwU9PVioA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739150930; c=relaxed/simple;
	bh=ddYEqDc79TFgqK/zZvLWB53E5i+B8CaqZb4/9a3wCfo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dgP73RYaWZfw+NkXmg3SuceFUoNJ0OahEZYIJlwtOmb/oAMW1qHwfgJSAgItVegsJW5wchKelvOo9iQBBdUb8OTRM97+GSrdwtFoR3eYAcNY2p9MAbLJVv0ixGMmOc4BiuVLL9003HnwI5tlZ2erzXjuVr8shVqe/zGGkz9pdiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=EHwHlQwh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51A1SgYjA1400808, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739150922; bh=ddYEqDc79TFgqK/zZvLWB53E5i+B8CaqZb4/9a3wCfo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=EHwHlQwhXzzwXTxqB1PoC5kt47PBQ439g/sNtEq17ty8znmi9/T/XJosEhv/Rerw7
	 yxlGjj4pDplcHuKUNKCV6KgidQP/CEHlpKwzYAoz4isYVd3V57gE8P9jBYuQUnUzSc
	 9i8XG/a/BJ5UQL8GHKkRsqYV6/As+efJRTyjOroKlGnyJhs56hCFmYVMgyU5LQS60Q
	 SN/U+QJhgM/RCwxFDqNrqJ0upfKddrcJniXZC9esObpEdjlU+LjHB8mPm34wJ5gCuA
	 L3/ayHhwurcfZCShdcEkcChNjxzMl8LWSqwL+L53WOnQKL7ZNDow0cIduxpLmvEyji
	 nj23y6RIAvYQQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51A1SgYjA1400808
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 09:28:42 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Feb 2025 09:28:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 10 Feb 2025 09:28:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Mon, 10 Feb 2025 09:28:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 4/9] wifi: rtw88: Extend rf_base_addr and rf_sipi_addr for RTL8814AU
Thread-Topic: [PATCH v2 4/9] wifi: rtw88: Extend rf_base_addr and rf_sipi_addr
 for RTL8814AU
Thread-Index: AQHbdzQIwkdRfJiAO06BozptRW7kr7M/x8CQ
Date: Mon, 10 Feb 2025 01:28:42 +0000
Message-ID: <1b579cb840f741f5926ae98356b347e4@realtek.com>
References: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
 <7a4d8209-b8af-4943-b5de-f53d6edf591a@gmail.com>
In-Reply-To: <7a4d8209-b8af-4943-b5de-f53d6edf591a@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGVz
ZSBtZW1iZXJzIG9mIHN0cnVjdCBydHdfY2hpcF9pbmZvIGVhY2ggaGF2ZSBhIHNpemUgb2YgMi4g
SW5jcmVhc2UNCj4gdGhlaXIgc2l6ZSB0byA0LCB3aGljaCBpcyB0aGUgbnVtYmVyIG9mIFJGIHBh
dGhzIHRoZSBSVEw4ODE0QVUgaGFzLg0KPiANCj4gVGhpcyBpcyByZXF1aXJlZCB0byByZWFkIGFu
ZCB3cml0ZSB0aGUgUkYgcmVnaXN0ZXJzIG9mIHRoZSBSVEw4ODE0QVUuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNr
ZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCg==

