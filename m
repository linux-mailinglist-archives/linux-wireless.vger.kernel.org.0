Return-Path: <linux-wireless+bounces-19677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C543A4B5E4
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 02:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C13D16B8CE
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 01:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3692C181;
	Mon,  3 Mar 2025 01:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="YCGTOdF/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A4B2B9A6
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 01:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740966967; cv=none; b=Ia4la1hO2gypB93u9t3kslo/M5f/rkRDZ5Al1lcr5ZFkg2ULWlMBO1qFlZ1T4dNO6FkYxp7SFFvfwiuQyB9lVcScXaugu08TDcU2RGRWIFJOnTWWod7NWS5ZGIzOgglba7PJ1IFjSqY35RN0TZIEw9gW2EoQYWKEVVzHY5vIIHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740966967; c=relaxed/simple;
	bh=DihVu5dyJabwTOi55IO5/Zc2HP3At154bvb6f0N5E8Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iu2h+xGqslCW0UkiJDU7yE97e2q7lWEURwymfue0R+sFA4FaiuGksb5/d2o7tGgYKT4YnUcAwRdqD04Ofv+eTIC5gglNuwDN8jtWP4Hk+jmLF3QmfkxWJPZxcfcLxG2HVd5DI9NL0Bg+Cn4uc2b/VggAQMJr478dq38dBFOM57I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=YCGTOdF/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5231u0omD385905, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740966961; bh=DihVu5dyJabwTOi55IO5/Zc2HP3At154bvb6f0N5E8Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=YCGTOdF/m/EeFtjwrH4Bh6d1uPEGFnjg+CY24bPQF6f90HNR6+sNtHYwHHDJYiX8C
	 LI5u/Kmtp4MFj/kRN/MQ2tvS9hd/xnQMlARmRPm4sxuVdke6VQ0zvBzlao24iNcmDf
	 552TAm2iklRjMZc/N94j8i0yHW0geAVdl/v2KvSPyhzR4KoEUwc4d/LIR71E1iTkRF
	 UFVoamDJqXag6o8QFMLnm8gyrTZwHXNqUq/NB1pDVopNJ7hE6pFHGvhb088bjwVzJY
	 D4hXmq0t2rovyrd0KGlrD7cxvDMWrV/eZOgvlpwMhVpYDwGGho7Jbdvjp1ycEQht3g
	 Wc21HHU6MajJQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5231u0omD385905
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 09:56:01 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Mar 2025 09:56:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 3 Mar 2025 09:56:01 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Mon, 3 Mar 2025 09:56:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 3/7] wifi: rtw88: Add rtw8814a_table.c (part 2/2)
Thread-Topic: [PATCH rtw-next 3/7] wifi: rtw88: Add rtw8814a_table.c (part
 2/2)
Thread-Index: AQHbiLAzhzCCVbtnjUyZ7xW4ZNChYbNgrVmw
Date: Mon, 3 Mar 2025 01:56:01 +0000
Message-ID: <2f8e8fccc7b24731b4723fa29d6e5a6b@realtek.com>
References: <8e9d900e-0721-425c-8466-bd57742c9f86@gmail.com>
 <2b5829e4-197b-4ed9-be70-26190dd6327e@gmail.com>
In-Reply-To: <2b5829e4-197b-4ed9-be70-26190dd6327e@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGlz
IGNvbnRhaW5zIHZhcmlvdXMgdGFibGVzIGZvciBpbml0aWFsaXNpbmcgdGhlIFJUTDg4MTRBLCBw
bHVzIFRYDQo+IHBvd2VyIGxpbWl0cy4NCj4gDQo+IEFsc28gYWRkIHJ0dzg4MTRhX3RhYmxlLmgu
DQo+IA0KPiBTcGxpdCBpbnRvIHR3byBwYXRjaGVzIGJlY2F1c2UgdGhleSBhcmUgYmlnLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5j
b20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0K

