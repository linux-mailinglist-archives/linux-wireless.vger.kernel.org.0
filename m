Return-Path: <linux-wireless+bounces-26219-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BECAB1E1EF
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 08:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652E516FC86
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 06:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85CC1E008B;
	Fri,  8 Aug 2025 06:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jtCtbLpX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35829367
	for <linux-wireless@vger.kernel.org>; Fri,  8 Aug 2025 06:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754633228; cv=none; b=QHVDvdHniIwEA+k5fjsnc+uRVQmtZ+HrT7Y+w2H3XABpiPKI0UiBhusZIX1Nx4pL8vfF4doKvEHZAfQ0CaQVKNDl05kbZOrNuhwYfviJHnsoDKci4Ts6Z5Vfi6OXZRm/xvHmad5LhCBylynBqajRNSxRBs7ti0Wie/QhJo+OouY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754633228; c=relaxed/simple;
	bh=k3Fmw2wrnDxkbJg0icdxil87YmKsYW31dbxgXhu9zjI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FY+yXKmGd/fd0TLVM6ihlJtfqE+1mtuvjmQ/3l1aW1aYzp41ssndUWuQMyCX3BaDEFF3IrNnIVlGlIOEcxHENxebMv8bDTDgqSockK+aJ7CnoK3dYsFoYqHnKgV5lKXKw30iOIb2ewv23dJtkRHMKrooPEmGKvDdfFvPCxAh0Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jtCtbLpX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5786738o82787128, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754633223; bh=k3Fmw2wrnDxkbJg0icdxil87YmKsYW31dbxgXhu9zjI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jtCtbLpXuqtFEIFFopi1Y8tJVjOgUObWHOMsZm39PlFjp8LSxiYxpZU5BIw/eUx8C
	 IJoO/SaPA9lw7O6L/38o1m4eMVFpJEJzJr68DU2vAq2t9ZVwjXuP4tE/A9H0TPG+fQ
	 R1bdo4INzyTuKRSRGUjW1uHDJgeb7AVCnZa1bUPcNojq0sDhzdotBanyZxQG1SllSj
	 f65kkjckiiFTq3VF2LwmlUd4RtrKAg+QFW92Ema9a7gzbG1KWLCjl00NkIVgGjNgzK
	 oKV9RlVXB4Y3fWIt0BedYhtNm+wvGoAF5lpoWhjJXKpBru1KirJn0H5yRWRBWL2xts
	 lHLa4/HX0qzvg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5786738o82787128
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 14:07:03 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Aug 2025 14:07:03 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc%10]) with mapi id
 15.02.1544.011; Fri, 8 Aug 2025 14:07:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 08/11] wifi: rtw89: Add rtw8852c_hfc_param_ini_usb
Thread-Topic: [PATCH rtw-next v2 08/11] wifi: rtw89: Add
 rtw8852c_hfc_param_ini_usb
Thread-Index: AQHcAyfEEe7EJ4wnaEKMnYvMLh4+tLRYTuug
Date: Fri, 8 Aug 2025 06:07:03 +0000
Message-ID: <048b4e78009b4791920b2590721798fd@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
 <99456c92-b544-44ed-a5dc-b0ee8994ea92@gmail.com>
In-Reply-To: <99456c92-b544-44ed-a5dc-b0ee8994ea92@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiAiaGZj
IiBtZWFucyAiaGNpIGZjIiB3aGljaCBpcyAiSG9zdCBDb250cm9sIEludGVyZmFjZSBGbG93IENv
bnRyb2wiLg0KPiBUaGVzZSBhcmUgc29tZSBwYXJhbWV0ZXJzIG5lZWRlZCBmb3IgUlRMODg1MkNV
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBn
bWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4N
Cg0K

