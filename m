Return-Path: <linux-wireless+bounces-4584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D758878D46
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 03:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC221F21B41
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 02:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E81E79E0;
	Tue, 12 Mar 2024 02:59:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE787494;
	Tue, 12 Mar 2024 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710212351; cv=none; b=iLUw4HZc5lWLth+stupRElCvni5C2kJbl5YVPY1egYEBMkQt6yvO8roRbtUmiJq4mDZouL9xSGoXgyOA9y+Cg4Nz/SgL8X/H2SEzeknZLxoQVZtImMDguSypdSY3oEYygp+eOvCEX7Q5kexsj/z+nbkWxNi26XTZgoQWS8CeZ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710212351; c=relaxed/simple;
	bh=Ajib7Nw3YDfMpRsYKGm2Yn8NZxQi1F+VzNfoJVumbzo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SyhZzIGDyPr4g8WPNRfinwdF7NM8aEiw7+IwfUx0r4FwgHzyGPBCU90P+LUXnhmhm+OwLqEUmnb2/FcK9FMpe3tXKSFRdbZwr2NUEs9H5mMYXt/iW9Hu5D6Bz0jR3QAEd5SGh1ThzCecCbKmQVOVzEMEQ/LPqRHVTPCU2q6aej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42C2weibF4003397, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42C2weibF4003397
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 10:58:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 10:58:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 10:58:41 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Tue, 12 Mar 2024 10:58:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fiona Klute <fiona.klute@gmx.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Pavel Machek
	<pavel@ucw.cz>,
        =?utf-8?B?T25kxZllaiBKaXJtYW4=?= <megi@xff.cz>
Subject: RE: [PATCH v4 0/9] rtw88: Add support for RTL8723CS/RTL8703B
Thread-Topic: [PATCH v4 0/9] rtw88: Add support for RTL8723CS/RTL8703B
Thread-Index: AQHac6A1Psbdiic/Xku5IpChPAWGprEzakIQ
Date: Tue, 12 Mar 2024 02:58:40 +0000
Message-ID: <e540243c657043f9a6d0a8d5314191d3@realtek.com>
References: <20240311103735.615541-1-fiona.klute@gmx.de>
In-Reply-To: <20240311103735.615541-1-fiona.klute@gmx.de>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

DQo+IHY0Og0KPiAgICogTW92ZSBkZWZpbml0aW9uIG9mIEdFVF9SWF9ERVNDX0JXIGZyb20gcnR3
ODcwM2IuYyB0byByeC5oIChub3cgaW4NCj4gICAgIHBhdGNoIDMvOSAid2lmaTogcnR3ODg6IEFk
ZCBkZWZpbml0aW9ucyBmb3IgODcwM2IgY2hpcCIpDQoNCnY0IGxvb2tzIGdvb2QgdG8gbWUuIFRo
YW5rcyBmb3IgdGhlIGdyZWF0IHdvcmshIA0KDQpJIGFsc28gaGF2ZSBydW4gc3BhcnNlL3NtYXRj
aCB3aXRoIHY0LCBubyB3YXJuaW5nL2Vycm9yLg0KDQpQaW5nLUtlDQoNCg==

