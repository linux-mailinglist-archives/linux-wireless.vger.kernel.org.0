Return-Path: <linux-wireless+bounces-17094-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDDFA01D00
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 02:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452921882E25
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 01:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D894A0C;
	Mon,  6 Jan 2025 01:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="HI4TV40U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BBB647
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jan 2025 01:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736126354; cv=none; b=T9AXZslTX62AFsX2KUgElpJGyP4HB/vBRRXh9C4Bt27hkbGXkmmBtF26aRef2WVcHA//SAo+3dOSTIrk0EZ0HdR4+HiqCACT7SmpjxZD2SW/AdCqgWorTfyOlZ0BK2r5x0CLNWAj18Y0AauiUUv3q4rqWcprBBWQ9T5UAg5vq90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736126354; c=relaxed/simple;
	bh=Rc3rUVXUypukEiLdEDf8EbR6PLXg2XiZsf504HENhLM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fDkxJY0pBYPcel5lZ2syKzdaYbo0kemn7bOXd3KR08aQsvszKu0MW6ReqC4oA7z4DINMTY+TrB/eoCIFd1LDh8vW3asvkRkmBf3VYhEUjSdY5IXfyGzY+PiDbe7L2PxI5ADz+Hf1bOEDHuK47fAqWGArSc/pTB70IFzkbgPd06o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=HI4TV40U; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5061J60B01351698, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736126347; bh=Rc3rUVXUypukEiLdEDf8EbR6PLXg2XiZsf504HENhLM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=HI4TV40UoGQri1bIbYvpRLwsjc+INPDYh3+CKE2FFBLhGX/TcZFdAYmvzd7dSyJUC
	 ur2/vDJqBVJoZrrBlUPXFuUHypoD6QTeafJlmgwTejY83z3fDZapzdd6ZcHeF74bbQ
	 fKsixUHQrWY1qNU8OugHUgFJYWU4LkKJk1kblDB3aY9zEWqU5rIRbncj9ggau/RpTu
	 wmylx+nyIrbu1emaxJdDj+oofWkN1ngxU3lFF5P/a6A51hRoI5rI8EGtTodTBdhq6g
	 RV+cFYQJi8d0KRwplsv/1aT77/eXUJleWFk7iaetSglJ+1Kxpa5rN6ckm118UGr2ig
	 cV4Fh2KSZaaTw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5061J60B01351698
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jan 2025 09:19:06 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 6 Jan 2025 09:19:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 Jan 2025 09:19:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Mon, 6 Jan 2025 09:19:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: rtw88: Add support for LED blinking
Thread-Topic: [PATCH v2] wifi: rtw88: Add support for LED blinking
Thread-Index: AQHbX6USMgYFR0rPTUaMgQ9rRgfsCbMI8iKg
Date: Mon, 6 Jan 2025 01:19:07 +0000
Message-ID: <d3a2e2ccf26f43248d42d6e5ccdf0231@realtek.com>
References: <57c7d192-97ee-4da1-87a8-f040e9b8e3d1@gmail.com>
In-Reply-To: <57c7d192-97ee-4da1-87a8-f040e9b8e3d1@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KDQpbLi4u
XQ0KDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbGVkLmgNCj4g
QEAgLTAsMCArMSwyNSBAQA0KPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAg
T1IgQlNELTMtQ2xhdXNlICovDQo+ICsvKiBDb3B5cmlnaHQoYykgMjAyNSAgUmVhbHRlayBDb3Jw
b3JhdGlvbg0KPiArICovDQo+ICsNCj4gKyNpZm5kZWYgX19SVFdfTEVEX0gNCj4gKyNkZWZpbmUg
X19SVFdfTEVEX0gNCj4gKw0KPiArI2lmZGVmIENPTkZJR19MRURTX0NMQVNTDQo+ICsNCj4gK3Zv
aWQgcnR3X2xlZF9pbml0KHN0cnVjdCBydHdfZGV2ICpydHdkZXYpOw0KPiArdm9pZCBydHdfbGVk
X2RlaW5pdChzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2KTsNCj4gKw0KPiArI2Vsc2UNCj4gKw0KPiAr
c3RhdGljIHZvaWQgcnR3X2xlZF9pbml0KHN0cnVjdCBydHdfZGV2ICpydHdkZXYpDQoNCnN0YXRp
YyBpbmxpbmUgdm9pZCAuLi4NCg0KPiArew0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBydHdf
bGVkX2RlaW5pdChzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2KQ0KDQpzdGF0aWMgaW5saW5lIHZvaWQg
Li4uDQoNCj4gK3sNCj4gK30NCj4gKw0KPiArI2VuZGlmDQo+ICsNCj4gKyNlbmRpZg0KDQoNCg==

