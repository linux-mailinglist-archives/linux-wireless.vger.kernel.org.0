Return-Path: <linux-wireless+bounces-29072-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41786C670DA
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 03:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id EDDAE29E12
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 02:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4400329CF5;
	Tue, 18 Nov 2025 02:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="cEBWWD88"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9DB84039
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 02:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763434023; cv=none; b=snVKnl2a1GHKNJcd+6CAJCeX/HuBDzTyXI6gMIY6+ml9AePHUrXBmsEA0ZgROvG+90uQyUptQ1gdPXXm7eRc6kaGUSk8UJFJA2UOKALSFbNkRwnG/9cWc2U1nRcasMj7NOb5xtjUWTL5ZWLCk/76zOSKK0F4/JWn1pNqNfwHmwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763434023; c=relaxed/simple;
	bh=ApHOFBlkUddmvSCWgSdJ1e//YSBx+Sge/JRC4YXI1AM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pJ2V87OhedGC1m2I0IHxNJx93R//5YVf53pqBfXEhzuflYs3AYG+Rcwr5h45vy7njI+WsgGPYU+Oaws+j45ZjC4FLoeuVFi9J1v68Wa15eLwRX4HnmOLpa7rgsqmiS0VNf3Ci6MgjsIJMiF8Q0rQ2Zy/vuoNwNtwHvqDViFs5V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=cEBWWD88; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AI2kvWJ3663486, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763434017; bh=ApHOFBlkUddmvSCWgSdJ1e//YSBx+Sge/JRC4YXI1AM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=cEBWWD885kEijk9xmaYzCuWBPZfsNcm214TBcfX8dzWT4mWi5piFB2UO1FgwKKGEa
	 aIq/917ym9sPyA+0XiJ2uBOYx63+q4Bg5AO/3OgoCTQ//ejKH5pgFsEUp3TuPsD476
	 4lIHFi0hC2wzEmri2Okp6q6vlp0M/rATdXmEEDVMZIO5Aq9U3TVbW8csq1PGWglyuY
	 NH4+GlqA0O4+us/WQI/iLZ7iM76WMD+w20w7PrQttBHDhBKy1irODLwn4URy7wdGef
	 gRfCYdZXg4rxrS8/cQJWHRvfjVAYGb0AvoEAZyLgpETCcsOF9xXPHEKPg10+vf0Wzx
	 Uf2W6gRM+beZQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AI2kvWJ3663486
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:46:57 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 18 Nov 2025 10:46:57 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 18 Nov 2025 10:46:57 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Tue, 18 Nov 2025 10:46:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH rtw-next 2/5] wifi: rtl8xxxu: Make RTL8192CU, RTL8723AU TX
 with 40 MHz width
Thread-Topic: [PATCH rtw-next 2/5] wifi: rtl8xxxu: Make RTL8192CU, RTL8723AU
 TX with 40 MHz width
Thread-Index: AQHcVzePc+p0p3ZZpEi4sBysiB3uH7T3vKwA
Date: Tue, 18 Nov 2025 02:46:57 +0000
Message-ID: <512c36c68c79406888607c78a09c6084@realtek.com>
References: <b735b9c6-f17f-405a-8972-a7c98f3c89e2@gmail.com>
 <393fd2fd-9724-4e3b-beda-e871fe402b66@gmail.com>
In-Reply-To: <393fd2fd-9724-4e3b-beda-e871fe402b66@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBTZXQg
dGhlIHJlcXVpcmVkIGZpZWxkcyBpbiB0aGUgVFggZGVzY3JpcHRvciB0byBhbGxvdyB0aGVzZSBj
aGlwcyB0bw0KPiB0cmFuc21pdCB3aXRoIDQwIE1IeiBjaGFubmVsIHdpZHRoIHdoZW4gdGhlIGFj
Y2VzcyBwb2ludCBzdXBwb3J0cyBpdC4NCj4gDQo+IFRlc3RlZCBvbmx5IHdpdGggUlRMODE5MkNV
LCBidXQgdGhlc2Ugc2V0dGluZ3MgYXJlIGlkZW50aWNhbCBmb3INCj4gUlRMODcyM0FVLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5j
b20+DQoNClJldmlld2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0K

