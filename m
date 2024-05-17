Return-Path: <linux-wireless+bounces-7754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A728C7F5A
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 02:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB4328286D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 00:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB798633;
	Fri, 17 May 2024 00:55:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43D5622
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 00:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715907321; cv=none; b=NTURvpdHMn9tSKcjZd3G1ddCEAd2lJmeVedo+jS5UpQigYESmYkdh/BgMlK8XQwfGK7fnwtB8YPQjdLYIPegGouiNMRIM0kiYT3eYySHw5sFdvJI+7MF8jp1GLpARkbqLC/CHab4WZuuaUN6lmyI7iFLCQuTSJ/b2XeFJRu0FnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715907321; c=relaxed/simple;
	bh=+VPYxpq1pJ+/BPZdPsojYUb933oERRNj5mGCLEkMvmY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pBEU3JXiYGk2r9dFI8fS4WGCnBcpUEZIpfmtA/uSSx0TTXBnH59ciAt0Q8mkw1ARXOMOcJ5zaGI+1YtvhFPWao0zlpNws3nIqnG7Fow3TZVEGWNEWdbWXd53xArVqFiEsdRsix5SycaSFju+jXjFb/dNJrVjTQF+UVFAo79VeTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44H0t7oiD1770611, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44H0t7oiD1770611
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 08:55:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 17 May 2024 08:55:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 08:55:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 17 May 2024 08:55:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Larry Finger <Larry.Finger@gmail.com>,
        "linux-firmware@vger.kernel.org"
	<linux-firmware@vger.kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry
 Finger" <Larry.Finger@lwfinger.net>
Subject: RE: [PATCH] linux-firmware: Add ordinary firmware for RTL8821AU device
Thread-Topic: [PATCH] linux-firmware: Add ordinary firmware for RTL8821AU
 device
Thread-Index: AQHap6bD+Xfiq2Jq/E+4fpLkIeqV1LGamZSw
Date: Fri, 17 May 2024 00:55:07 +0000
Message-ID: <cd8bc792f1de46d4938e6a11c163f4b4@realtek.com>
References: <4un2klvz1fcd.fWFO2CHkJLwM7KZVnpZutA2@1EHFQ.trk.elasticemail.com>
In-Reply-To: <4un2klvz1fcd.fWFO2CHkJLwM7KZVnpZutA2@1EHFQ.trk.elasticemail.com>
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

SGkgTGFycnksDQoNCkxhcnJ5IEZpbmdlciA8TGFycnkuRmluZ2VyQGdtYWlsLmNvbT4gd3JvdGU6
DQo+IFRoaXMgZmlybXdhcmUgd2FzIGV4dHJhY3RlZCBmcm9tIHRoZSAyMDIxMDcwOCByZWxlYXNl
IG9mIHRoZSB2ZW5kb3INCj4gZHJpdmVyIGZvciB0aGlzIGRldmljZS4gVGhlIGZpcm13YXJlIGNv
cnJlc3BvbmRzIHdpdGggdGhlIGxhdGVzdA0KPiByZWxlYXNlIGJ5IFJlYWx0ZWsuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBMYXJyeSBGaW5nZXIgPExhcnJ5LkZpbmdlckBsd2Zpbmdlci5uZXQ+DQo+
IC0tLQ0KPiAgV0hFTkNFICAgICAgICAgICAgICAgIHwgICAxICsNCj4gIHJ0dzg4L1JFQURNRSAg
ICAgICAgICB8ICAgMyArKysNCj4gIHJ0dzg4L3J0dzg4MjFhX2Z3LmJpbiB8IEJpbiAwIC0+IDMx
ODk4IGJ5dGVzDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IHJ0dzg4L3J0dzg4MjFhX2Z3LmJpbg0KDQpJIHdvdWxkIGxpa2UgdG8gY29t
cGFyZSB0aGUgZmlybXdhcmUgbG9jYWxseSwgc28gYXBwbHkgdGhlIHBhdGNoIGJ5IA0KJCBwd2Ns
aWVudCBnaXQtYW0gMTM2NjYzNDMNCg0KVW5mb3J0dW5hdGVseSB0aGUgc2l6ZSBvZiBydHc4OC9y
dHc4ODIxYV9mdy5iaW4gaXMgMCBpbiBteSBzaWRlOg0KIFdIRU5DRSAgICAgICAgICAgICAgICB8
IDEgKw0KIHJ0dzg4L1JFQURNRSAgICAgICAgICB8IDMgKysrDQogcnR3ODgvcnR3ODgyMWFfZncu
YmluIHwgMA0KIDMgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQoNCk5vdCBzdXJlIHdo
YXQgaGFwcGVucy4gQ291bGQgeW91IHRyeSBpdCBpbiB5b3VyIHNpZGU/DQoNClBpbmctS2UNCg0K

