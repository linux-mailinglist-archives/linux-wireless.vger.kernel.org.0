Return-Path: <linux-wireless+bounces-18899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCE2A33917
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 08:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ECDC188567E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 07:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550A520A5E4;
	Thu, 13 Feb 2025 07:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GYXwLD9i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C1A2AD21
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432632; cv=none; b=tFlpKoqouVuPrt+NAa+LBXmLJXrZ10Jb2SNKz6u0Ls468zJ29RpFsavb0hzD1tBGNHDI2FIbLuhE2DsJc8siFmnKX7m0X1Vl9NqjNq1T6/DxcqRtuOnG0epbnWU4PV6SJlmi9lWyV2psBB1/5temwYNeQFTj8QQb1wDgnCe784A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432632; c=relaxed/simple;
	bh=i7KsezhhOsNZclEW8yYPsAoQcQhXQbZEjj7aEXFHeiE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FkDu3ZIWDBKVY3Vqxn5+vbBUb75HuxabQo3mkjmgo2FK7ifPK7yyt1nAVbkMbf8skluS4kbvoyp0YxmgN1pGDNsj0yHHBGJFylhG9qRYfpZLxUYK59n3JLt1rLRWgQW/VskegIhQgBil5piNFtdfOgvQGEkHL7VqAakj4H22nEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GYXwLD9i; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51D7hkxR7594674, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739432626; bh=i7KsezhhOsNZclEW8yYPsAoQcQhXQbZEjj7aEXFHeiE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GYXwLD9iiGVsaI8IbHxtDGir052oqU5AFg/BEnx+Th8GjcTiJdm7qGg0bi+vR96Zm
	 p7XgjU/vnqG8gmreRxtb4oxnX6Ed8X+0c+8P3UXtEfTjLLwzQyhLg4nwFp2HPBdk2t
	 kVHKEZsmSN4vIu+JAKkA6yy7MOm0rroJ1H28eGVV7dtIwiVQLm9wlftHwDU6TtENHf
	 G94fcFXyjaNU0wurpwoAO0QM/faRVMrgFrx4ORZxKP7lEAFEWjMuurlNDnyVXPH2At
	 QGbc5yGfGelGf0X+Fcr/+3ll+0fVmjaYxOTEnEKSFMlGTaYt6KemHTf4kpsvbnseWN
	 NrNQ8PUT4KAYg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51D7hkxR7594674
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 15:43:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Feb 2025 15:43:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 13 Feb 2025 15:43:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Thu, 13 Feb 2025 15:43:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 5/8] wifi: rtw88: Fix rtw_rx_phy_stat() for RTL8814AU
Thread-Topic: [PATCH 5/8] wifi: rtw88: Fix rtw_rx_phy_stat() for RTL8814AU
Thread-Index: AQHbfNO9nlZwqtrhsUit/s1M1HPTVrNE3EbQ
Date: Thu, 13 Feb 2025 07:43:45 +0000
Message-ID: <85feded3518144d7ad130b5deffc757d@realtek.com>
References: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
 <222fe9d5-804c-4521-9983-fb0620414810@gmail.com>
In-Reply-To: <222fe9d5-804c-4521-9983-fb0620414810@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBSZWNv
cmQgc3RhdGlzdGljcyBmb3IgdGhlIDNTUyByYXRlcyB0b28uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6
IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCg==

