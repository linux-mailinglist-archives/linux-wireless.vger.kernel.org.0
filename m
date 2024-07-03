Return-Path: <linux-wireless+bounces-9880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C856924CC4
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 02:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4A71F23655
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 00:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0645637;
	Wed,  3 Jul 2024 00:30:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76734391;
	Wed,  3 Jul 2024 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719966635; cv=none; b=KuVJaWWq5AVtyDpVWERd+4LAUSLhYizgCfSNoOSQeL4lcsx80vOVB3+VnteH4nNmayeyqXe6F+pjdF0AbUWVyT9Dr9laESNbzV4ZLWVSybonccQjvUE6l3cJtL85xcVlZ3yfKOWWP7xq4yBKGNO6Eyj+sWnOk2kP37tXJzAlepE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719966635; c=relaxed/simple;
	bh=raqoEpBV0Mpr/RDiRvzJcoV44b341bKzX5P6mYI4HLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d2O5R1UV9VlrGkG2sRs5ADbndmtYgqwtSVxlL/VMLyygmMOxy2Xi7jhfVmbzVnraKWh8djyyP3YND2g9lqwgbZG5B3UGrx/jgPj/VdyfQjMpbGnWUmRFWURJKjy484G1Rj/Hy+Ii6BDowAqGxZzu0KCmtGvscC28wHMbKzgkM3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4630U19K01538754, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4630U19K01538754
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jul 2024 08:30:01 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 08:30:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jul 2024 08:30:01 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 3 Jul 2024 08:30:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?RnJlZHJpayBMw7ZubmVncmVu?= <fredrik@frelon.se>,
        Kalle Valo
	<kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rtlwifi: fix comment typo
Thread-Topic: [PATCH] rtlwifi: fix comment typo
Thread-Index: AQHazH0vmgBNTpZiXUq16WOYK6nxprHkJsjA
Date: Wed, 3 Jul 2024 00:30:01 +0000
Message-ID: <bcc37f918d994755b7f3af689e54c9dd@realtek.com>
References: <20240702123048.14829-1-fredrik@frelon.se>
In-Reply-To: <20240702123048.14829-1-fredrik@frelon.se>
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

RnJlZHJpayBMw7ZubmVncmVuIDxmcmVkcmlrQGZyZWxvbi5zZT4gd3JvdGU6DQoNCj4gU3ViamVj
dDogW1BBVENIXSBydGx3aWZpOiBmaXggY29tbWVudCB0eXBvDQoNClN1YmplY3QgcHJlZml4IHNo
b3VsZCBiZSAid2lmaTogcnRsd2lmaTogLi4uIiwgYW5kIGl0IHdvdWxkIGJlIGJldHRlciB0byBw
b2ludA0Kb3V0IHdoYXQgeW91IGNoYW5nZSBpcyAnZGVmYXVsdCcuIA0KDQoNCj4gQ2hhbmdlICdk
ZWZ1bHQnIHRvICdkZWZhdWx0JyBpbiBjb21tZW50cyBpbiBzZXZlcmFsIHJ0bHdpZmkgZHJpdmVy
cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZyZWRyaWsgTMO2bm5lZ3JlbiA8ZnJlZHJpa0BmcmVs
b24uc2U+DQoNCg0K

