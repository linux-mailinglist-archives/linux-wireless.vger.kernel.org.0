Return-Path: <linux-wireless+bounces-14705-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1607C9B5A20
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 03:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C2A2843D2
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 02:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25744126C0A;
	Wed, 30 Oct 2024 02:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="VoTpTj0s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C12F4437
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 02:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730256863; cv=none; b=ZyXrr+Fx0g0Gw+N+yfbxx/6wrJXXP+XMlw9w9YDVIBTfNTn3tITB/4BvoJcqWs0s2iTT3/Xa+/Wg16+0y7oV3g/eLy1FAd1MUnnQp9Jd0Ea+kSoKnMPy/z1ZitkCPHYK5mfsfwRz/rxEh5DGCakODsQ3GVMqEKBgotYE8kurnN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730256863; c=relaxed/simple;
	bh=wBC1HHKDzgU/nyH5lFp9drQ9W2yTs7tWjgxiljQ8/Kg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MxMhFEBF4ExLLBI+I9D1WTHOyP4sa0NoylIZ4MX1hleuSUalbrhVQWaUu3FUQeT2sM2UOV1gADHk3rvNr1JBizY6VCzyRYYgkUFC5o2ylw28Kg14Xg0hN/WH5dbTcLDxVaweD5BSa9RAuIEQGfQwGJoBFua5seJLX/PfSLcUnYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=VoTpTj0s; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49U2sGBS13362497, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730256856; bh=wBC1HHKDzgU/nyH5lFp9drQ9W2yTs7tWjgxiljQ8/Kg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=VoTpTj0s89IVbYT0CL6Svpoh2eCRg5izlZgtTkQE7lOcQ9mRiIaUQLMbqXHMMVoR/
	 ytgkNllFHC7X/fg2MfHyDumqjIlu5xykJG1kmu1g6m4BtVTD3cDgr53+1uYfqxCXlo
	 drvUvHAb0DN/WayRX64bTMGX6hiB5HgepASoI/BRKseclL/2iMrw0DB8AAJdyB0CGC
	 uckmdgQ9jOTQUXpBcZlG1cMJLYiZAJswCyVK8rydp+iVRBmfEIQ+tiy7WQkrp0XZF1
	 n9iEkSJD7vCdTmPNDnW8K5enGO4UGlRWkfls2HM9eTBevX7PfQsd/XE374JxDgJiGt
	 V0/1hyjfMv7gQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49U2sGBS13362497
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 10:54:16 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 10:54:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 30 Oct 2024 10:54:16 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 30 Oct 2024 10:54:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v3 01/22] wifi: rtw88: Add some definitions for RTL8821AU/RTL8812AU
Thread-Topic: [PATCH v3 01/22] wifi: rtw88: Add some definitions for
 RTL8821AU/RTL8812AU
Thread-Index: AQHbJVQBGGaVtBFl4EulRX6Co1fJ17Kco4gAgACZpACAAWV1kA==
Date: Wed, 30 Oct 2024 02:54:16 +0000
Message-ID: <092a85f224a3459baa6f86da653179c1@realtek.com>
References: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
 <9279a9cd-6f86-4dc3-a095-7c36cb9b9d06@gmail.com>
 <808c66fa-60a2-4878-b1f8-65d064735692@RTEXMBS04.realtek.com.tw>
 <207adc8d-06db-46cf-a87b-6dc2a1efd6d0@gmail.com>
In-Reply-To: <207adc8d-06db-46cf-a87b-6dc2a1efd6d0@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

PiA+DQo+ID4gU21hdGNoIHdhcm5zDQo+ID4NCj4gPiAgIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODgvcnR3ODgxMmEuYzo2MTkgcnR3ODgxMmFfaXFrKCkgZXJyb3I6IHVuaW5pdGlh
bGl6ZWQgc3ltYm9sDQo+ICd0eF94MScuDQo+ID4gICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0dzg4L3J0dzg4MTJhLmM6NjIxIHJ0dzg4MTJhX2lxaygpIGVycm9yOiB1bmluaXRpYWxp
emVkIHN5bWJvbA0KPiAndHhfeTEnLg0KPiA+DQo+IA0KPiBUaGVzZSBhcmUgZmFsc2UgcG9zaXRp
dmVzLiBUaGUgdmFyaWFibGVzIGFyZSBpbml0aWFsaXNlZCBpbnNpZGUNCj4gcnR3ODh4eGFfaXFr
X2ZpbmlzaCgpLiBCdXQgSSdsbCBpbml0aWFsaXNlIHRoZW0gd2hlbiB0aGV5IGFyZQ0KPiBkZWNs
YXJlZC4NCg0KSSBzZWUsIGJ1dCB0aGUgc2V0dGluZyB1bmRlciBjb25kaXRpb25zLiANCg0KQnkg
dGhlIHdheSwgdHhfeDAgYW5kIHR4X3kwIGFyZSB2ZXJ5IHNpbWlsYXIgcGF0dGVybiwgYnV0IHNt
YXRjaCBkb2Vzbid0IA0Kd2FybiB0aGVtLiBQbGVhc2UgcnVuIHNtYXRjaCBhZ2FpbiBhZnRlciB5
b3UgZml4IHR4X3gxL3R4X3kxLg0KDQoNCg==

