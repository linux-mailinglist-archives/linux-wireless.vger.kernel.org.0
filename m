Return-Path: <linux-wireless+bounces-18674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3708BA2E1FE
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 02:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B95917A27D0
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 01:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC09EAC7;
	Mon, 10 Feb 2025 01:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="T7xUFahl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE2B243370
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 01:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739150695; cv=none; b=hwC+cdYR9jJqZrrc09vxgkH+hBWYM/1dJMQ3zmMmBbLrbmsH3TkLXy1Wbu+oZHHbYTnduVFgBQAVRpKlP2FOKakt+xGyAWaDPdJ9Wpxcy9H/PgibnwkmU60pn2giart7lXWQLHbLPBodtCrYJMuBNaFJOkFS7ONlhfq3dkJN7So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739150695; c=relaxed/simple;
	bh=LF2FStY6maldjpzWln8vS8tm5Psh235DuOwCuEKudWQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hny8k9uEpBoY3Vel71pn205Bn0ZZ0nM8gTQm5W6JCDaKpdBkeMrIO480dwQRT2zjzppsTRTttW04r3pSquDMjX0u/E7cY4uJyVULQPZV3CCvWV5/5iPyx2UvMaibuJrXd9nGxvwV/hUbzywdAynOX/RhF+pSfB3d88ewhj/bMr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=T7xUFahl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51A1OnF221398051, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739150689; bh=LF2FStY6maldjpzWln8vS8tm5Psh235DuOwCuEKudWQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=T7xUFahlhT5xkpWmSYxPH5M0BHvtGNGUk2IBs4srDtIN+j7L3gyfPbHA6nqLJnEc4
	 cGmPHTPYjXNd1yFidoRcoGXMinNmfPEpLkcDlt8sb8Vc8hodEIMDBP+okeBWYk4MPD
	 b3Vg9e+srM9RfcTxa20owFQ8Z8j9DFR8/q9PDxH3DUtB+9yfIkzA6tSIYhccnexvMA
	 5llHMFzBeXEUDyBZvhLNMbHpuaBAE2dLuB9Ku3zbD2oWxdMphcajo9YooVwDJxAHpQ
	 7ro6ukNljKJW6zVD807roX50kbOv1oOZOvK7rveMnlkOCypIQhvxruT+0aKvnMi+Iv
	 OTd2pTn2EOEOQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51A1OnF221398051
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 09:24:49 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Feb 2025 09:24:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 10 Feb 2025 09:24:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Mon, 10 Feb 2025 09:24:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 2/9] wifi: rtw88: Fix download_firmware_validate() for RTL8814AU
Thread-Topic: [PATCH v2 2/9] wifi: rtw88: Fix download_firmware_validate() for
 RTL8814AU
Thread-Index: AQHbdzPhOiskQiUfW0KIsRwJzqGAr7M/xoUw
Date: Mon, 10 Feb 2025 01:24:49 +0000
Message-ID: <25d454bb40c142a18bc6b28b1d08a909@realtek.com>
References: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
 <049d2887-22fc-47b7-9e59-62627cb525f8@gmail.com>
In-Reply-To: <049d2887-22fc-47b7-9e59-62627cb525f8@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBZnRl
ciB0aGUgZmlybXdhcmUgaXMgdXBsb2FkZWQsIGRvd25sb2FkX2Zpcm13YXJlX3ZhbGlkYXRlKCkg
Y2hlY2tzIHNvbWUNCj4gYml0cyBpbiBSRUdfTUNVRldfQ1RSTCB0byBzZWUgaWYgZXZlcnl0aGlu
ZyB3ZW50IG9rYXkuIFRoZQ0KPiBSVEw4ODE0QVUgcG93ZXIgb24gc2VxdWVuY2Ugc2V0cyBiaXRz
IDEzIGFuZCAxMiB0byAyLCB3aGljaCB0aGlzDQo+IGZ1bmN0aW9uIGRvZXMgbm90IGV4cGVjdCwg
c28gaXQgdGhpbmtzIHRoZSBmaXJtd2FyZSB1cGxvYWQgZmFpbGVkLg0KPiANCj4gTWFrZSBkb3du
bG9hZF9maXJtd2FyZV92YWxpZGF0ZSgpIGlnbm9yZSBiaXRzIDEzIGFuZCAxMi4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0K
DQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg0K

