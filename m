Return-Path: <linux-wireless+bounces-26216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18801B1E1E9
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 08:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431C3166AF6
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 06:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3F0367;
	Fri,  8 Aug 2025 06:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="M07shez9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761B2A92E
	for <linux-wireless@vger.kernel.org>; Fri,  8 Aug 2025 06:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754632986; cv=none; b=BB9ad366aQ3bdjKnZfeM5+rsmURdOh4rVW0eThqBa7K622gfPb1yOWJVBK6uz+gAupi9mxhNdWPJNZLCWdfCSez5SyXjZ0ExD1nSN3cLianU2gSRBTKttFrT0ab5uipH/CrNcf6HPP3Ftu8f1yexaLtMguTyxRmMtk5FV3Wus14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754632986; c=relaxed/simple;
	bh=w+3+PkRaEtMY/arYEN409zIXQWH+Iw/NUssbK9Dhe/c=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gYcNzApYlt2izzXf3ymqXsqCFV/lvmEE0zNSZUOFrT8SjDn0OTM8x1nbF/6d6aIrpgHyd+cJa2+KZfnRJvdZ1EYssU8q8C1OD+aMKcM6yUYlT6BNGsNong4ExEsP6A0z9VUBpbEvk5XZpjWg8NUKpTgPIiS3L4B2tL+4M8CmYks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=M07shez9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5786309902784001, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754632980; bh=w+3+PkRaEtMY/arYEN409zIXQWH+Iw/NUssbK9Dhe/c=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=M07shez96fXlAfSyJZ20de4PqNwW+prdnNWNEASZPTEf8l8SiWm11+WimSW4Rgphj
	 E9qbGikkyK4pTzfRcD2Mmqm5GTEIqtHHqhJ+nouoVd+a2HRSYH2f4AKphjOc1pcLI1
	 Bu5Pi3fZxcJvKrXPT6GJd/qfUNUPZ8X1RWdFqCwXCOZ7Dh9nuSDfssCZ5XRD+BXdWk
	 JwJvnZIi/6yhpfRMQiqqFABY/pQ/VjhwAyV3RxEzLMWnqgpVPLhrkqGENRWTnjGZNU
	 5yd1b+Ljwp85pSIyJvDU//mf28q+NhxAFL1G8e/XSuf6jwIn3ofoPK3j4L962LeT4S
	 NCq8DFTiMCVdg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5786309902784001
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 14:03:00 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Aug 2025 14:03:01 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Aug 2025 14:03:00 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc%10]) with mapi id
 15.02.1544.011; Fri, 8 Aug 2025 14:03:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 05/11] wifi: rtw89: Fix rtw89_mac_dmac_func_pre_en_ax() for USB/SDIO
Thread-Topic: [PATCH rtw-next v2 05/11] wifi: rtw89: Fix
 rtw89_mac_dmac_func_pre_en_ax() for USB/SDIO
Thread-Index: AQHcAyZzkVWsWdPn7Ey22Q13K8+urrRYTc9g
Date: Fri, 8 Aug 2025 06:03:00 +0000
Message-ID: <32e6b5462802494ca3cd8a4c19a44bf2@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
 <f7a422e4-ad0c-4ca0-ad2a-dc3604918232@gmail.com>
In-Reply-To: <f7a422e4-ad0c-4ca0-ad2a-dc3604918232@gmail.com>
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
dGhlIERNQSBtb2RlIGFjY29yZGluZyB0byB0aGUgaW50ZXJmYWNlIHR5cGUuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0K
QWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCg==

