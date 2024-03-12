Return-Path: <linux-wireless+bounces-4592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC1C879033
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 10:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33756B212B7
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 09:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA41677F12;
	Tue, 12 Mar 2024 09:00:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577F4C8DD;
	Tue, 12 Mar 2024 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710234052; cv=none; b=OCCaJ6Wpiy8gmI7ddfEMA/v7jbAS3gk054PTkFqFYd5bjoNROQhFeu1gSzMmwqeaUN1vOOlyCGoHZ6r8ejioIc2R1y3AZyqDEnbtZW5iilu6uxUDUYmQ3yVbHF1QnSDcwzJykNIB3TrEDBNAwbWDBq7dvtA3m5Dgo7axuQbQfrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710234052; c=relaxed/simple;
	bh=liCt9vEPzADuRhCwLdH5GsdPKWKLGTOcnnozfCA2GEI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T1Mh5WoFoFYGgYebUdVK3+BuAF3Q25QSSAIehKSl7N0MveXGCxw/NnReZxfLPckfKx1hVdr5HZNvkCakH601lk4sxGEtF5/+eqxtlTHJErCKOYDuqVqyfvfIOd3JQMK4zZrE4lS3xQnkOrBVq3fd0HJoFgsK4se+fZnuEBYef2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42C90PvtC4145030, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42C90PvtC4145030
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 17:00:25 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 17:00:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 17:00:25 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Tue, 12 Mar 2024 17:00:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "pavel@ucw.cz" <pavel@ucw.cz>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>, "megi@xff.cz" <megi@xff.cz>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "fiona.klute@gmx.de"
	<fiona.klute@gmx.de>
Subject: Re: [PATCH v4 0/9] rtw88: Add support for RTL8723CS/RTL8703B
Thread-Topic: [PATCH v4 0/9] rtw88: Add support for RTL8723CS/RTL8703B
Thread-Index: AQHac6A1Psbdiic/Xku5IpChPAWGprEzakIQ///a9ACAAASaAA==
Date: Tue, 12 Mar 2024 09:00:24 +0000
Message-ID: <6c73784ecc04cadbcaae3f7e073ffb120e13853c.camel@realtek.com>
References: <20240311103735.615541-1-fiona.klute@gmx.de>
	 <e540243c657043f9a6d0a8d5314191d3@realtek.com>
	 <ZfAVlEhsMwYMq9BY@amd.ucw.cz>
In-Reply-To: <ZfAVlEhsMwYMq9BY@amd.ucw.cz>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <337C7FD1B2E2B54581DC849DC7A8F2E7@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI0LTAzLTEyIGF0IDA5OjQzICswMTAwLCBQYXZlbCBNYWNoZWsgd3JvdGU6DQo+
IEhpIQ0KPiANCj4gPiA+IHY0Og0KPiA+ID4gICAqIE1vdmUgZGVmaW5pdGlvbiBvZiBHRVRfUlhf
REVTQ19CVyBmcm9tIHJ0dzg3MDNiLmMgdG8gcnguaCAobm93IGluDQo+ID4gPiAgICAgcGF0Y2gg
My85ICJ3aWZpOiBydHc4ODogQWRkIGRlZmluaXRpb25zIGZvciA4NzAzYiBjaGlwIikNCj4gPiAN
Cj4gPiB2NCBsb29rcyBnb29kIHRvIG1lLiBUaGFua3MgZm9yIHRoZSBncmVhdCB3b3JrISANCj4g
PiANCj4gPiBJIGFsc28gaGF2ZSBydW4gc3BhcnNlL3NtYXRjaCB3aXRoIHY0LCBubyB3YXJuaW5n
L2Vycm9yLg0KPiANCj4gRG9lcyBpdCBtZWFuIHlvdSBxdWV1ZWQgdGhlIHBhdGNoLCBvciBpcyBz
b21lb25lIGVsc2UgZXhwZWN0ZWQgdG8gZG8NCj4gdGhhdD8NCj4gDQoNCkkgbWVhbiB0aGlzIHBh
dGNoc2V0IGlzIG9rYXkgdG8gbWUsIGFuZCBLYWxsZSB3aWxsIGhlbHAgdG8gYXBwbHkgdGhpcw0K
cGF0Y2hzZXQgdG8gd2lyZWxlc3MtbmV4dCB0cmVlLiBJIHN1cHBvc2UgbmV4dCBuZXh0IGtlcm5l
bCB2Ni4xMCB3aWxsDQpoYXZlIHRoaXMuIA0KDQpQaW5nLUtlIA0KDQoNCg0KDQo=

