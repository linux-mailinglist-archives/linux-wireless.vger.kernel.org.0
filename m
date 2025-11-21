Return-Path: <linux-wireless+bounces-29215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7478C76C83
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 01:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F8F935AB83
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 00:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F4C1D6DB5;
	Fri, 21 Nov 2025 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="wXmwLMr/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9B53C465
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 00:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763685408; cv=none; b=gssdtDVkkaJI/Fm+JPVtrO/OD2RRUfK6PQQ1pym0qDP8ge26ssoRtDbEaXzZFPrIjITC55FZ5s0T0YCi+VdpJG9DKiOheuNvCShBg4ZCFki8UhxZ3HdhcmtYsjqSLvC13Qax59zlkoFzA7Z4ECqzThqBk4ijm4N20xyOfFU7XAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763685408; c=relaxed/simple;
	bh=+SY1v1rmGbSHlBEqMmFcH5ADnIWhidewM1VG+w5WY4U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fhFqItjdgH4BLJMMzWvRpsRwRdJFMnmPsv+nirPNSnqPqbqMfchqgZ0s9SpJ9NcrMMiMJcfQh/r7jXdYueXjYdRDROafbDoMwqkk4hQ3Cu07pXKEyankSQWuXzHRxsgmDtZeUAwTaj7E+Gxv0pTcXgWSMGu+B0ylk97Hbyy43gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=wXmwLMr/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AL0aeazF2540692, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763685400; bh=+SY1v1rmGbSHlBEqMmFcH5ADnIWhidewM1VG+w5WY4U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=wXmwLMr/dV3ZjrgrVi7NEtyzyVCmWQ1bftWfmNFS0LcZ/rclsE7R4yCMXizKixCCU
	 8NAVdgmQHgjvrEfqqnQKqpHj1NSPqTUzRG3AjpzDAp+iBZBrq6QEMs3Lrzkwj8N3Et
	 oR5RJhUa3pi46WeJSFLsAXkpIzeVhKyRO61Q+LVKrec/mCE/6FvMPri0jcC/vy+f3Z
	 BqG6aJ1gPGWR1hzCbMeF41nTIudSMfWaCePXx7PmPGX/bgIit4tj6o2v8kM+S9pCjp
	 f0C+8q4QSbQgfoeiPXTT1DAH/Lu7h+zgPQ3+NnKU3imCZ1YhM3VcRTJ4j77r07ATpf
	 myc83WXcKNR9A==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AL0aeazF2540692
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 08:36:40 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 21 Nov 2025 08:36:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 21 Nov 2025 08:36:40 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Fri, 21 Nov 2025 08:36:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH rtw-next v2 4/5] wifi: rtl8xxxu: Fix RX channel width
 reported by RTL8192FU
Thread-Topic: [PATCH rtw-next v2 4/5] wifi: rtl8xxxu: Fix RX channel width
 reported by RTL8192FU
Thread-Index: AQHcWifV7AeCMIfMnEKXEBEzRdUgvLT8SWZw
Date: Fri, 21 Nov 2025 00:36:40 +0000
Message-ID: <20737df4ccea489cbc89486d1046b65d@realtek.com>
References: <c54a69c8-9c7a-4249-ac9c-8d6544483ae9@gmail.com>
 <1c6c1fd4-92f6-4327-a24e-f0747ab21819@gmail.com>
In-Reply-To: <1c6c1fd4-92f6-4327-a24e-f0747ab21819@gmail.com>
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
b3RoZXIgY2hpcHMgcmVwb3J0IHRoZSBSWCBjaGFubmVsIHdpZHRoIGluIHRoZSBSWCBkZXNjcmlw
dG9yLA0KPiBidXQgdGhpcyBvbmUgZG9lc24ndC4NCj4gDQo+IEdldCB0aGUgUlggY2hhbm5lbCB3
aWR0aCBmcm9tIHRoZSBQSFkgc3RhdHVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1
ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBQaW5nLUtl
IFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

