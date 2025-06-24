Return-Path: <linux-wireless+bounces-24396-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FBEAE5BFF
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 07:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77013A5BD6
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 05:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75054246BAF;
	Tue, 24 Jun 2025 05:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QWnoqaAp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18D123E344
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 05:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750743939; cv=none; b=hsJlHm0vCn77ZYz3xUGEZCAXdX9SfxFXUhrcqjeM8o16JGpj5OtV2gPm+nUh5crXjaCl4wYsI245H0ZpguAeuu+Y8Aouj9oe9V/1a24P6RW9A8KoQkt/B4jOlAphA6zGtryvt4bESXRbSHvTQ6ATbreUmC1eu35+2VOPyo9dhCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750743939; c=relaxed/simple;
	bh=evsPnYZSoNuxQCExzduNUD0Vw4TSfkrhVmn7lILyHWg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Iv00pYgxPcUO4zUp5uunr7rasth8nWAqivGP5I8YxPQBbypiDl7rrNxmB6W8ZFe6/illHogJT5M/DlISDkSd3klesE+ikxC8UhITarxiAlL86xM+EEoY1gNiYmDn7+RlTvMlTjbWcEZS4Rwc6CXenkK+6OBLS2njitpla02Oca4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QWnoqaAp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55O5jVp153098220, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750743931; bh=evsPnYZSoNuxQCExzduNUD0Vw4TSfkrhVmn7lILyHWg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=QWnoqaAp+JPuvggQ/lKk0lhGITyvMSQbIhJ1hNrFFAIkKELb0zhoIjnH6uVcQjg7c
	 S0zZFUU99bJ1dWpun+luARvSfoWY65TV66CrhpCS/2A97XjEMBzbMrROKCiz5kTxp9
	 /F6VlxQrLgv1X3SpAWYDq/ZmfpVQm/AeLmicoU3+d8k/xWVhNdcCLZazrwb5SVgJxi
	 W366kII6sfs2ZE9/nYgiHU8KjtSpJZhXnxTVFT1qWFvI/BqvC3xYrdaR2KLznK8t5O
	 wtBQ91jU6tBN5eRgqUd6HvjPo5eDDK0NTO1EkQIu93ZBZ0MJOUcsPcMDMiAc7WeZ3b
	 1bYtZAdpIsCVg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55O5jVp153098220
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 13:45:31 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Jun 2025 13:45:45 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 24 Jun 2025 13:45:44 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Tue, 24 Jun 2025 13:45:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v3 03/14] wifi: rtw89: Make hfc_param_ini in rtw89_chip_info an array
Thread-Topic: [PATCH rtw-next v3 03/14] wifi: rtw89: Make hfc_param_ini in
 rtw89_chip_info an array
Thread-Index: AQHb4hUBb1SjQ4bH/kioewYFObZtMbQR0fZw
Date: Tue, 24 Jun 2025 05:45:44 +0000
Message-ID: <dec828612ba54819a783bcab609c8e31@realtek.com>
References: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
 <4fedeea5-d3a4-44ca-b1a7-83de381eff8d@gmail.com>
In-Reply-To: <4fedeea5-d3a4-44ca-b1a7-83de381eff8d@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBVU0Ig
YW5kIFNESU8gd2lsbCBuZWVkIGRpZmZlcmVudCBzZXRzIG9mIHZhbHVlcywgc28gbWFrZSBoZmNf
cGFyYW1faW5pDQo+IGluIHN0cnVjdCBydHc4OV9jaGlwX2luZm8gYW4gYXJyYXkuDQo+IA0KPiBB
bHNvIG1ha2UgcGFyYW1faW5pIGEgcG9pbnRlciBpbnN0ZWFkIG9mIGNvcHlpbmcgdGhlIHN0cnVj
dC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJA
Z21haWwuY29tPg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+
DQoNCg0K

