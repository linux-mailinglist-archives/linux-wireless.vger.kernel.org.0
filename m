Return-Path: <linux-wireless+bounces-14197-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FA99A351D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 08:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2881F2128F
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 06:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869DC17C208;
	Fri, 18 Oct 2024 06:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="mJY1vxUy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5D320E30C
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 06:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729231905; cv=none; b=FYphw6jk1YkwPQnyp2ySD9s9i0wLclVza8fKUSoQmjteYEfrm7ewx9+g7f4kKZvo+W2/Q5/oISvjpM0c3VEBoG7Rv3LiOwVDlYbqYHyqCgaqG+yaBeTko0t1Xyo8gAlom8+fmkNtF2VOQ15DiGWmAXDQVNloj/MROPRNqUyzx7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729231905; c=relaxed/simple;
	bh=ykK3dIo7sL6Nl8JvKUPnSZTvCWPFH1PJz5FmSGcvbEU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sgg94iDvtvEhEL5YoJrlQ6R91mcEePFgabnNrippuyHD1mxB1VzWyJMnKgF1a0GBRWSUYF55tIIy9R1aKpuUFKp2YN+FxiAHDyAEG+OC0T8vLginC5wVwjbrpxXm9n9uAtPezdTqmVCMRtRatjoa5hcklxzZl+PPo7H1atq1tJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=mJY1vxUy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49I6BdWV21606023, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729231899; bh=ykK3dIo7sL6Nl8JvKUPnSZTvCWPFH1PJz5FmSGcvbEU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=mJY1vxUykiEtiH9H5nNAOt1QyBCin+VABoWq9uWEQqnAB6d+nNELZZgShe74aPQ76
	 OLW008tsbvsf5Y3nJXPg0PNMIVqK1x4hAlspa1ecsoytUwI6aoP65DXTAqDTRYQVpB
	 h/qow47EKTY71+3gF7xP27b+JDowXz/uErj8hCwnP0zI1Y6Z6lL+uI1IzDvuerO0CF
	 JZUNMpHqu29OBHpj4B4IGQNH5e35KOapdmV71LLXzoc7M8xQKNr1DFZFVA/o/FrkF1
	 kc6BneQpZVGjR5LCHd5A/boNy5oXgwHO7q54iMmojTDstz4kqFqUAFrlS7JXTqT16r
	 S4xo1X7MRMULg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49I6BdWV21606023
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 14:11:39 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 14:11:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 18 Oct 2024 14:11:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 18 Oct 2024 14:11:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 03/22] wifi: rtw88: Allow different C2H RA report sizes
Thread-Topic: [PATCH v2 03/22] wifi: rtw88: Allow different C2H RA report
 sizes
Thread-Index: AQHbHB7DbelXLbMAA0iB4Je5oBc8q7KMEA1w
Date: Fri, 18 Oct 2024 06:11:39 +0000
Message-ID: <ba1f00c4fb1d4780ab85048ca6f4e02f@realtek.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
 <9bbe0502-dabb-4a95-b201-505dfc9ab688@gmail.com>
In-Reply-To: <9bbe0502-dabb-4a95-b201-505dfc9ab688@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
K3N0cnVjdCBydHdfYzJoX3JhX3JwdCB7DQo+ICsgICAgICAgdTggcmF0ZV9zZ2k7DQo+ICsgICAg
ICAgdTggbWFjX2lkOw0KPiArICAgICAgIHU4IGJ5dGUyOw0KPiArICAgICAgIHU4IHN0YXR1czsN
Cj4gKyAgICAgICB1OCBieXRlNDsNCj4gKyAgICAgICB1OCByYV9yYXRpbzsNCj4gKyAgICAgICB1
OCBidzsNCj4gKyAgICAgICB1OCB0eGNsc19yYXRlOw0KPiArfSBfX3BhY2tlZDsNCj4gKw0KDQpU
aGUgJ2MyaF9yYV9yZXBvcnRfc2l6ZScgaXMgNywgYnV0IHN0cnVjdCBzaXplIGlzIDguIFdoeT8N
CkhhdmUgeW91IGV2ZXIgc2VlbiBzaXplIG9mIFJBIHJlcG9ydCBpcyBsYXJnZXIgdGhhbiA3Pw0K
DQoNCg==

