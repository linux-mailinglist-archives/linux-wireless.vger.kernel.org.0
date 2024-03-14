Return-Path: <linux-wireless+bounces-4716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58ABE87B5BA
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 01:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA09B284DEA
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 00:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BFB63D;
	Thu, 14 Mar 2024 00:19:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819F17F;
	Thu, 14 Mar 2024 00:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710375556; cv=none; b=QEOzB8dgQO3jK9fMGpD2gSxHPUhjXVyeIeYA7mheMUUebJ7nrZcn/iwQ8tPzxKKkk8fw2ltAmR6tEAlVV8WN+7G0eW0jhCvbojch7ad0yPw4vo6er8iOjy8XBCpAecCbCu/CLGfU6ZgZ9re+a7CX/NWDvDgBLzzJWmT2cljRZ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710375556; c=relaxed/simple;
	bh=NfnEMUvDnrnJTF/DEiBJxxTzwBHO/iEmpBZnnE9wW9I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gg8WfHYDsTGl6jus4LdT/Kf9hH3d3wq5T7j/EamjhUcUhR3OknWqsjhSYU2+EvPTFmnjxF/fwjFVWDXF2Iz2oWPEx4WlJUpS+C4oLdp+9MyVE7huhuJqtbwbROkZMap9nme5+TP4dwq1aCebJ3pC6tCfqglJeaOMvwugZO+dRDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42E0IgpkE1048147, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42E0IgpkE1048147
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 08:18:42 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 08:18:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 08:18:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Thu, 14 Mar 2024 08:18:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "pavel@ucw.cz" <pavel@ucw.cz>, "fiona.klute@gmx.de" <fiona.klute@gmx.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>, "megi@xff.cz" <megi@xff.cz>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v4 0/9] rtw88: Add support for RTL8723CS/RTL8703B
Thread-Topic: [PATCH v4 0/9] rtw88: Add support for RTL8723CS/RTL8703B
Thread-Index: AQHac6A1Psbdiic/Xku5IpChPAWGprEzakIQ///a9ACAAASaAIAB2eSAgAC5AoA=
Date: Thu, 14 Mar 2024 00:18:42 +0000
Message-ID: <063926329b2507ce4073dd05fdfc47929f3bb038.camel@realtek.com>
References: <20240311103735.615541-1-fiona.klute@gmx.de>
	 <e540243c657043f9a6d0a8d5314191d3@realtek.com>
	 <ZfAVlEhsMwYMq9BY@amd.ucw.cz>
	 <6c73784ecc04cadbcaae3f7e073ffb120e13853c.camel@realtek.com>
	 <38fc27be-0e46-4677-bbe3-c0b9689dfbd5@gmx.de>
In-Reply-To: <38fc27be-0e46-4677-bbe3-c0b9689dfbd5@gmx.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2FB466B4698BD48BA3DB2E2C16E6329@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQo+IA0KPiBJcyB0aGVyZSBhbnl0aGluZyBJIHN0aWxsIG5lZWQgdG8gZG8gdG8gZ2V0IHRoZSBm
aXJtd2FyZSBpbnRvDQo+IGxpbnV4LWZpcm13YXJlPw0KPiANCg0KUGxlYXNlIHNlbmQgbWUgYSBm
aXJtd2FyZSBwYXRjaCBhZ2Fpbi4gSW4gY2FzZSBJIHNlbmQgd3JvbmcgZmlybXdhcmUgdG8NCmxp
dW54LWZpcm13YXJlLiANCg0KUGluZy1LZSANCg0K

