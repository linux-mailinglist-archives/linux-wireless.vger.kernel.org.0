Return-Path: <linux-wireless+bounces-26281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 713A5B219B9
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 02:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E60E1903185
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 00:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E452236E8;
	Tue, 12 Aug 2025 00:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Z6oAAsL+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392012877FE
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 00:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754957990; cv=none; b=Iafo7gIrJlrq1QR3+d/Y4LuA4xBFQ0nKMTM9DfHpyGb052ciG8uIT9Wodm4FwscuzBroAd8nlnmQiPsakDUJ+P47NhbQDROIHJQ1GfhilM9yBhB8xVbWdAr6y+tlVwbd26rPkajkf9bUyGblPm/dr6pRU66tctrE9tzQinHdTSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754957990; c=relaxed/simple;
	bh=vCGNdpEgpYaVgDzf2i0wz0YLGgZZq/5wp4vhgv7JIAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DSw0efM2U3nojYQfb7KrAmmcxHk8DmGGLQ2+j1dz/FtPtn20ofgv+fg7zW+KsV/AsC5MuRrF2EIPD/LFPh13Z3d0jrDGjhncGhD+F4Amb8HLfr34A9ekiFHSB2MeFeIrzzLWyC345RBSmFB1+RJ+c5TeCWgwTuJBLHy7pVrkh3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Z6oAAsL+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57C0JessE955792, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754957980; bh=vCGNdpEgpYaVgDzf2i0wz0YLGgZZq/5wp4vhgv7JIAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Z6oAAsL+M9Zab7zKlvkFAGm/ZDbf3LhO0Rig+yM6j0hMqnddlrTK2q0aJ1Hoe5tLj
	 zt9GN9ShIfaD7QY0AIzvSI90+z00OZOBys4EmDSNYqiy06RgBYynvquBpEYW19Mg5w
	 3R8OkRN8hDwl3qFrVOs/vYroMAFUX+4aUS3JEiupPGsdPRgnTyJZzCmg9uqWiH6KQ3
	 Ylk2eU8o68ag/Dl5IK7LCr1w8JmPEriIamFL4FgV2BMenNxxgnnfAQ2Oj2UawTFvt5
	 RVBYHCgROvLjtPoPy49NnLP1vewyA70zteBj1evHtGg4mVS9TBaO0//rXv3fA7u/fp
	 Pg5HLtadwQksg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57C0JessE955792
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 08:19:40 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Aug 2025 08:19:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc%10]) with mapi id
 15.02.1544.011; Tue, 12 Aug 2025 08:19:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Helge Deller <deller@gmx.de>
Subject: RE: [PATCH rtw-next 2/2] wifi: rtl8xxxu: Don't claim USB ID 07b8:8188
Thread-Topic: [PATCH rtw-next 2/2] wifi: rtl8xxxu: Don't claim USB ID
 07b8:8188
Thread-Index: AQHcCtVNRFUq2d026U+9n66/bDw5MbReJ9lg
Date: Tue, 12 Aug 2025 00:19:41 +0000
Message-ID: <30d2378c6fe04127aa72104b83aed193@realtek.com>
References: <2e5e2348-bdb3-44b2-92b2-0231dbf464b0@gmail.com>
 <f147b2ab-4505-435a-aa32-62964e4f1f1e@gmail.com>
In-Reply-To: <f147b2ab-4505-435a-aa32-62964e4f1f1e@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGlz
IElEIGFwcGVhcnMgdG8gYmUgUlRMODE4OFNVLCBub3QgUlRMODE4OENVLiBUaGlzIGlzIHRoZSB3
cm9uZyBkcml2ZXINCj4gZm9yIFJUTDgxODhTVS4gVGhlIHI4NzEydSBkcml2ZXIgZnJvbSBzdGFn
aW5nIHVzZWQgdG8gaGFuZGxlIHRoaXMgSUQuDQo+IA0KPiBDbG9zZXM6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzL2VlMGFjZmVmLWE3NTMtNGY5MC04N2RmLTE1ZjhlYWE5
YzNhOEBnbXguZGUvDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYt
Ynk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpSZXZpZXdl
ZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg==

