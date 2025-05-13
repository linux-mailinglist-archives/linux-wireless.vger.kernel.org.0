Return-Path: <linux-wireless+bounces-22888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7EFAB4A26
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 05:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAEA170980
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 03:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF662EAF9;
	Tue, 13 May 2025 03:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="MKUNft6L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C051DDA15
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 03:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747106940; cv=none; b=t3obee+LUKpGLcjTLIMc4JpDh+ZdmOH27yeaJRNXZ5rmOo5+QkF0/XzHKc21UdVH6uRRcJkjFTLlwq3kSsks/UTo6dAlHeBrZIknnf+/dbb4kY9xyIqSTVaO6BEfUrQx07VNAvKhaXiDtGsA26tru+5VR+m7S6wNhb5E3rjm3xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747106940; c=relaxed/simple;
	bh=s9U2e0CtK5AaTQEt35G2g9BF44LbTRFS0nFRV9L6gXo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rZ8nfKkG6otEvGvWzxZ4LwXVGQAKR6qLkMa2aHh+/pjGWDT/fpiYBPRchHrHC5AgRumK0L1I8TzNayhrq/Yi9qRyvIUSEkRMxVSVRSLB+m5iMW7JQ9dm41iX0O/JmSGH8c2mEr1vNvgu9GBJPdZXko6piHWxa2bbLqS0sEQ+69s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=MKUNft6L; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54D3SsN123605602, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747106934; bh=s9U2e0CtK5AaTQEt35G2g9BF44LbTRFS0nFRV9L6gXo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=MKUNft6LAWGvG02h/vW+M0iHSuQC7aKmreCHTfQcwrhH6Mzp8SpMfQO+a4nmMRrbr
	 MgJF1kAW5ZU8unN49qijGa8EcWz7CfN67GxpzR4buwFM6RSR3oxDvLvkIuxX5SEDlV
	 O/+f9F/aCTzWslrgKvdtIMPnoMFzSOueAQXEZOy+lq2yCudyyY13WHZbfpcFqul4NO
	 DcgF5oyWa0+cuffHvNIwRqVnBm6Dmc4ZKYQkCRbogtrzQBcNbu9i78aP3S37HTltyh
	 4MMh0JldGRzGm4THfJpTlXRo4gy0VOrr450dX7xvtbNpFUbW+uAdRpgZtSG2UZGGzR
	 rONUTo2SoOS+Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54D3SsN123605602
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 11:28:54 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 May 2025 11:28:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 May 2025 11:28:54 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 13 May 2025 11:28:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v1 07/13] wifi: rtw89: Add extra TX headroom for USB
Thread-Topic: [PATCH rtw-next v1 07/13] wifi: rtw89: Add extra TX headroom for
 USB
Thread-Index: AQHbvTZkQnP59zQwtUmQEIOo3lJwdLPP88KA
Date: Tue, 13 May 2025 03:28:54 +0000
Message-ID: <8a825ca897cb4d78bd9188a1cfe7b7d5@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <039543e0-07c4-4e46-9c79-a507a8123467@gmail.com>
In-Reply-To: <039543e0-07c4-4e46-9c79-a507a8123467@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBJbiB0
aGUgY2FzZSBvZiBVU0IgdGhlIFRYIGRlc2NyaXB0b3IgaXMgdHJhbnNtaXR0ZWQgaW4gdGhlIHNh
bWUgYnVmZmVyDQo+IGFzIHRoZSA4MDIuMTEgZnJhbWUsIHNvIGFkZCB0aGUgcmVxdWlyZWQgaGVh
ZHJvb20uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2Vy
ZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsu
Y29tPg0KDQoNCg==

