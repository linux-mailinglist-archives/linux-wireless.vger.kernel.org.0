Return-Path: <linux-wireless+bounces-14201-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D059A3579
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 08:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9144D1F22169
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 06:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC5F15FD13;
	Fri, 18 Oct 2024 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="tWMfqq4y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAF020E30E
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233229; cv=none; b=OBengihH+qILlJmBouoxJqJKvTjIJW3X4TcyPeDOKKMNx8S6fbYDfn44bK5Nyc6RFwmsFNdjT7ZIceB/tK8EhjDYASz0pXpJ3sDSHAbjwClV7P0UKKo0DLcLhkdZdS441nWsq+iLsB4O6VrUeYm7rmunHYUgxzMcFfVpnwS3USg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233229; c=relaxed/simple;
	bh=sFRE4uCs7036DGpJltFakq/Rx9COycL66pRPebNTJN0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZAi07guHqb4MVCc3RNimhxdgRoU+L+hbULYKDTzN2u0AeO8Bc221R2/WVmg97rwMpQk6R4ybneF+kzTkvDRIiGLQcF3qG+n8vzfKBB4FHbW2GOLCLKz2ZUvEhLHlL1Hk42LeSD0NJ5k8Aa3gMaa/4ShO87qZm3pdvkB+o6loCUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=tWMfqq4y; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49I6XgKhA1628268, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729233222; bh=sFRE4uCs7036DGpJltFakq/Rx9COycL66pRPebNTJN0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=tWMfqq4yXmSXm3zeJCEY6I6+ekjo3CsUoQPDqb4YqgcyLZWV61BvVXEsy9aPpK/Y4
	 /uy/+b5gCGpq4gHD5pHHGYh9Ft5aZal1zelcIyPN9YsYVgT3X2XFPCJ7ve5T85HyEK
	 6KBVEeJLA6yE+1Jl0Oz+uDdjfaW3fn7VvfZ95pwtW+1x8RLZHRoojsddCiJ0g+5Nye
	 yGKIej0KcEu46g6pIqi0yXpdW9BkN1fZpS7q1GpbipdYtm+nppOmBZLbgX94NwNcIv
	 16HASsonGK5wzWAChmwcK5N9XvO4W0PxYnGdIsVDOa0rlvTsk9tLJFW4uFE6AV5DZB
	 6cXLZqrpfgsOQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49I6XgKhA1628268
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 14:33:42 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 14:33:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 18 Oct 2024 14:33:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 18 Oct 2024 14:33:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 09/22] wifi: rtw88: Support TX page sizes bigger than 128
Thread-Topic: [PATCH v2 09/22] wifi: rtw88: Support TX page sizes bigger than
 128
Thread-Index: AQHbHB8+Jxokcj4uCEK0QbnKfxTngrKMFr/A
Date: Fri, 18 Oct 2024 06:33:42 +0000
Message-ID: <57174594f2a043cdb139ecc055f538aa@realtek.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
 <5dfb2493-cd39-4c89-be22-9b04f21610a4@gmail.com>
In-Reply-To: <5dfb2493-cd39-4c89-be22-9b04f21610a4@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBAQCAt
MTYwNyw3ICsxNjA3LDcgQEAgc3RhdGljIHU4ICpydHdfYnVpbGRfcnN2ZF9wYWdlKHN0cnVjdCBy
dHdfZGV2ICpydHdkZXYsIHUzMiAqc2l6ZSkNCj4gICAgICAgICBzdHJ1Y3QgcnR3X3JzdmRfcGFn
ZSAqcnN2ZF9wa3Q7DQo+ICAgICAgICAgdTMyIHBhZ2UgPSAwOw0KPiAgICAgICAgIHU4IHRvdGFs
X3BhZ2UgPSAwOw0KPiAtICAgICAgIHU4IHBhZ2Vfc2l6ZSwgcGFnZV9tYXJnaW4sIHR4X2Rlc2Nf
c3o7DQo+ICsgICAgICAgdTE2IHBhZ2Vfc2l6ZSwgcGFnZV9tYXJnaW4sIHR4X2Rlc2Nfc3o7DQo+
ICAgICAgICAgdTggKmJ1ZjsNCj4gICAgICAgICBpbnQgcmV0Ow0KDQpJbiByZXZlcnNlIFgnbWFz
IHRyZWUgb3JkZXIsIGJ1dCBzdGlsbCBrZWVwIHN0cnVjdCBhdCBiZWdpbm5pbmcuIA0KDQo+IA0K
PiBAQCAtMjAxMyw3ICsyMDEzLDggQEAgc3RhdGljIGludCBfcnR3X2h3X3NjYW5fdXBkYXRlX3By
b2JlX3JlcShzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LCB1OCBudW1fcHJvYmVzLA0KPiAgew0KPiAg
ICAgICAgIGNvbnN0IHN0cnVjdCBydHdfY2hpcF9pbmZvICpjaGlwID0gcnR3ZGV2LT5jaGlwOw0K
PiAgICAgICAgIHN0cnVjdCBza19idWZmICpza2IsICp0bXA7DQo+IC0gICAgICAgdTggcGFnZV9v
ZmZzZXQgPSAxLCAqYnVmLCBwYWdlX3NpemUgPSBjaGlwLT5wYWdlX3NpemU7DQo+ICsgICAgICAg
dTggcGFnZV9vZmZzZXQgPSAxLCAqYnVmOw0KPiArICAgICAgIHUxNiBwYWdlX3NpemUgPSBjaGlw
LT5wYWdlX3NpemU7DQo+ICAgICAgICAgdTE2IHBnX2FkZHIgPSBydHdkZXYtPmZpZm8ucnN2ZF9o
MmNfaW5mb19hZGRyLCBsb2M7DQo+ICAgICAgICAgdTE2IGJ1Zl9vZmZzZXQgPSBwYWdlX3NpemUg
KiBwYWdlX29mZnNldDsNCj4gICAgICAgICB1OCB0eF9kZXNjX3N6ID0gY2hpcC0+dHhfcGt0X2Rl
c2Nfc3o7DQoNCmRpdHRvLiANCg0K

