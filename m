Return-Path: <linux-wireless+bounces-18677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42F6A2E209
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 02:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B81C164AC6
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 01:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA7C8BF8;
	Mon, 10 Feb 2025 01:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="LI8EwPmE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C757A23CB
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739151230; cv=none; b=QFBSXH4NGtmn2++akPWvft35adZujxo3/C50Yc8Wj76gQfbx6K214AguQxdM4n1Qlk7WEDi7wSjh59NEmuGaKLTagodjEXHl9Sve6zOewWEboRD5NxV2JrqJnoCzwHFegpK3eqofTSArfx2MXi/eVpqTzpPqz0oFn4S3O53axpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739151230; c=relaxed/simple;
	bh=lKjVRAY72W0gS0x6Uh0umyx1kJtPqTYRZCHN/G9Yvk0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WPlclJVKjR9gHpEYoaMKwinedVlZsD7XmCokieWG+iB6CG+4L7oAQMErBXCQsi6NzTO3sKIWE3LZagrfr4zzPekmx2FXMxmYFk5qfmQqWtLZUGqWgvwtcmbSZb43heDn3t7c0dAuv37l8HMpL2DaT/L04q1W2u7Kep0d42j02qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=LI8EwPmE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51A1XiwY61405979, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739151224; bh=lKjVRAY72W0gS0x6Uh0umyx1kJtPqTYRZCHN/G9Yvk0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=LI8EwPmE/4RR4PE4b0wP/1ZT/9uZOg+twNIfx8qN/+rsO3cOjFBw0r4zbRrskPMkB
	 DTGzpBEnWH0yY1/6TwLshzTbErTddInSFZO9aXvc5BLUs5x+mkTFmpigqTdLV/oH7g
	 C8KI5LgYIpEbb1LMdqyB87n4YVT5zIb1R1Zr1Eisu+OIzcoCYPic5G+ODiSRE/Eb3a
	 ujM+/GTOM0vFqcdTSt4rYBlYqWguj5p1l55yQnvLoY58TSAT3XyGRsjrulA4Gpn0xK
	 UoBo6UbNUxkQIkSvlaQZMGXT5xak5Ik+Xf/HU8qIf+XjiByKzsAbNtC07Dc6NxU1Fs
	 bOSyuxGM2XO3w==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51A1XiwY61405979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 09:33:44 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Feb 2025 09:33:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 10 Feb 2025 09:33:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Mon, 10 Feb 2025 09:33:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 5/9] wifi: rtw88: Extend rtw_fw_send_ra_info() for RTL8814AU
Thread-Topic: [PATCH v2 5/9] wifi: rtw88: Extend rtw_fw_send_ra_info() for
 RTL8814AU
Thread-Index: AQHbdzQjYwVRV8a/s06+TFSe/XweXbM/yQgw
Date: Mon, 10 Feb 2025 01:33:44 +0000
Message-ID: <06f3612c163445108a38641a07c5722c@realtek.com>
References: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
 <08e2f328-1aab-4e50-93ac-c1e5dd9541ac@gmail.com>
In-Reply-To: <08e2f328-1aab-4e50-93ac-c1e5dd9541ac@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGUg
ZXhpc3RpbmcgY29kZSBpcyBzdWl0YWJsZSBmb3IgY2hpcHMgd2l0aCB1cCB0byAyIHNwYXRpYWwg
c3RyZWFtcy4NCj4gSW5mb3JtIHRoZSBmaXJtd2FyZSBhYm91dCB0aGUgcmF0ZXMgaXQncyBhbGxv
d2VkIHRvIHVzZSB3aGVuDQo+IHRyYW5zbWl0dGluZyAzIHNwYXRpYWwgc3RyZWFtcy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29t
Pg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg==

