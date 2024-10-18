Return-Path: <linux-wireless+bounces-14203-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3E89A35DD
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 08:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5936E1C23DAD
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 06:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D2917DFEB;
	Fri, 18 Oct 2024 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Q8DPqCbr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1E1188008
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233784; cv=none; b=HcJ2L5EskEHYzNVOLtINQg1F6eoxdhGeexsIPohEqic1mza5HMeFQUXxjXE9Db5hPrttriRsmTnFeKX1zcQ11EPF2c4p77CpvmekhW6GJ+/VNv6wqyfPatguHXMzDAOg1HIRiH+U4jRzmnNCKMAsaQtSjAi0DQD+AxrmxJ44SgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233784; c=relaxed/simple;
	bh=ehqlEzgfnwK1YpLfZjTZt8k0DMZiNEW1gbBOJGavYz0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oANozkjMDS2VoJ+hMX/68UrqE7N9oKyysY15XZct0h8JmIiejNi6AiTsIUrm5VCenR9hrVzQC6CxRqPc02t5MrQ2w90wuRtVdblccxzNrxSLOBznJcsjIIW6mxdyvol6GKTH95YwcwJRn60kTnU/NX8XWRn+kyBwjF38ATANnUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Q8DPqCbr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49I6gwJdB1634227, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729233778; bh=ehqlEzgfnwK1YpLfZjTZt8k0DMZiNEW1gbBOJGavYz0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Q8DPqCbrwyUNhF+v4dR9YBD2Ve8BuTmRMaQ+gzMO/5frmzx5gY+QBBjVJs4v/e38p
	 FcyajhIE3kFbkuRUI3Irt3wXRCmpLwunq8SpzzZQzd8PwSqiACaLhoQiabnmIKlJNI
	 XeliO3jLLjY1ffedbYOZeOVyCwnrUYve7ZjkwNDFqtLRiWCDvNcqIKeK/pzssCeYU1
	 AUiHpIY8A3UNWlme5TCMQ2adSIcJplrXIVcL1dqm1ZQfFcixLk/DnHUNq+c3yCfi5Z
	 ciZkx4QgEM7vmB+nVJKUqUG19xBq7TfUTux35XqCghrDXYC00DD/KYb01ZCOuNpOg0
	 jAg+rrFOEU4PA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49I6gwJdB1634227
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 14:42:58 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 14:42:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 18 Oct 2024 14:42:58 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 18 Oct 2024 14:42:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 11/22] wifi: rtw88: usb: Set pkt_info.ls for the reserved page
Thread-Topic: [PATCH v2 11/22] wifi: rtw88: usb: Set pkt_info.ls for the
 reserved page
Thread-Index: AQHbHB9kVx5wXLEGAkmL+SBRaFWki7KMGWtw
Date: Fri, 18 Oct 2024 06:42:58 +0000
Message-ID: <eac3dd74228c4cd782d4751f45f0b9f5@realtek.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
 <92c49ebb-0408-48e7-9025-566ada0197b0@gmail.com>
In-Reply-To: <92c49ebb-0408-48e7-9025-566ada0197b0@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
ImxzIiBtZWFuaW5nICJsYXN0IHNlZ21lbnQiLiBXaXRob3V0IHRoaXMgUlRMODgxMkFVIGNhbid0
IHVwbG9hZCB0aGUNCj4gcmVzZXJ2ZWQgcGFnZSBpbiBVU0IgMiBtb2RlLiAoU29tZWhvdyBpdCdz
IGZpbmUgaW4gVVNCIDMgbW9kZS4pDQoNClRoaXMgc2V0dGluZyBhZmZlY3RzIHdob2xlIFVTQiBk
ZXZpY2VzLiBQbGVhc2UgbWVudGlvbiB0aGUgZGV2aWNlcyB5b3UgdGVzdGVkLg0KDQoNCg==

