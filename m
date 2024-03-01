Return-Path: <linux-wireless+bounces-4282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EA686D87D
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 01:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0968828479C
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 00:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B1617550;
	Fri,  1 Mar 2024 00:58:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A725514F7A;
	Fri,  1 Mar 2024 00:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709254682; cv=none; b=OcaHw0UvTzRkqcen8K5eNxj/mmFCrUuDWV8+iQy3UD03XNvMXV/EDivbz+JBY/CTu5EcbZ0UQE8Y8Zm2SIUpIavhlTVaE4efZT3pO+45yPY6kAI484xTP04Y7Hz0Rr/4aFMxdxjgF5zQM/iWQ4FnigbmcaPgASJNkXlk7RJjqWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709254682; c=relaxed/simple;
	bh=pwCX/E0k7EwsEKk3v9azU19A3exTb1vYXc/2gyI4x2U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NENSVDTnDV3klbED2pSQGVM1RNT850yi3vr24HJfo7sMUiiQ9u6794CrVusPb3S8fxeR6tx1YYn9frztokxWTNCjq1ygqz12O+H6jFxePs+jc3SyoBfTrXMh4dQI//+vE2uHIsJB2YfVjQuBoFfp2ZgusRizcbjcfiHt2gtoWH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4210vZppD1743211, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4210vZppD1743211
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 08:57:35 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 1 Mar 2024 08:57:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 08:57:35 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Fri, 1 Mar 2024 08:57:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fiona Klute <fiona.klute@gmx.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "kvalo@kernel.org" <kvalo@kernel.org>,
        "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "megi@xff.cz"
	<megi@xff.cz>
Subject: RE: [PATCH v2 0/9] rtw88: Add support for RTL8723CS/RTL8703B
Thread-Topic: [PATCH v2 0/9] rtw88: Add support for RTL8723CS/RTL8703B
Thread-Index: AQHaadiBpVQLHkii4E2ByhEDok10+bEg35uwgACqAYCAAIk3UA==
Date: Fri, 1 Mar 2024 00:57:29 +0000
Message-ID: <0ee4679bd3e2442f9e57e6d63ccf2927@realtek.com>
References: <20240227235507.781615-1-fiona.klute@gmx.de>
 <61980d74cdb24dd38a2f2e12c79125e2@realtek.com>
 <31dd8a43-0df0-4f1b-905d-67b1a63fab0e@gmx.de>
In-Reply-To: <31dd8a43-0df0-4f1b-905d-67b1a63fab0e@gmx.de>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmlvbmEgS2x1dGUgPGZp
b25hLmtsdXRlQGdteC5kZT4NCj4gU2VudDogRnJpZGF5LCBNYXJjaCAxLCAyMDI0IDg6NDUgQU0N
Cj4gVG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPjsgbGludXgtd2lyZWxlc3NA
dmdlci5rZXJuZWwub3JnDQo+IENjOiBrdmFsb0BrZXJuZWwub3JnOyB1bGYuaGFuc3NvbkBsaW5h
cm8ub3JnOyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBwYXZlbEB1Y3cuY3o7IG1lZ2lAeGZm
LmN6DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMC85XSBydHc4ODogQWRkIHN1cHBvcnQgZm9y
IFJUTDg3MjNDUy9SVEw4NzAzQg0KPiANCj4gVGhlIGJpZ2dlciBjaGFuZ2VzIGFyZSBhbGwgaW4g
cnR3ODcwM2IuaCAocGF0Y2ggNDsgdGhlIFBIWSBzdGF0dXMgc3RydWN0DQo+IGluc3RlYWQgb2Yg
bWFjcm9zKSBhbmQgcnR3ODcwM2IuYyAocGF0Y2ggNTsgUEhZIHN0YXR1cyBwYXJzaW5nLCBNQUMN
Cj4gYWRkcmVzcyByZXRyaWV2YWwsIGFuZCBJS1EgZG9uZSB3YWl0KS4gVGhlIFBIWSBzdGF0dXMg
c3RydWN0IGlzDQo+IGJhc2ljYWxseSB0aGUgc2FtZSBhcyBpbiB0aGUgdmVuZG9yIGRyaXZlciwg
SSBqdXN0IHJlc29sdmVkIHNvbWUgbWFjcm8NCj4gZGV0b3VycyBmb3IgYmlnL2xpdHRsZSBlbmRp
YW4gZGV0ZWN0aW9uIGFuZCBzcGVsbGVkIG91dCAicmVzZXJ2ZWQiIGluDQo+IGZpZWxkIG5hbWVz
Lg0KPiANCj4gQ2hhbmdlcyBpbiB0aGUgb3RoZXIgcGF0Y2hlcyBhcmUgbWluaW1hbDogYWRkaXRp
b25hbCBNT0RVTEVfQVVUSE9SIGluDQo+IHJ0dzg3MjN4LmMsIG1pc3NpbmcgInN0YXRpYyJzIGlu
IHJ0dzg3MjN4LmMgYW5kIHJ0dzg3MjN4LmgsIGZvcm1hdHRpbmcsDQo+IGFuZCB1c2luZyBydHdf
cmVhZDhfbWFzayBpbiB0aGUgZmlybXdhcmUgcmVzZXQgKHBhdGNoIDYpLg0KDQpUaGFua3MgZm9y
IHRoZSBpbmZvLiANCg0KUGluZy1LZSANCg0K

