Return-Path: <linux-wireless+bounces-11720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6178959485
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 08:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B441C20ADD
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 06:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B0416B38E;
	Wed, 21 Aug 2024 06:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ob0sXeUK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0521D1C6B5
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 06:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724221556; cv=none; b=fJROtEsAjLkEaVQyAsR/yiOvorSviIMT5ZYs8SeqhpDr1WsayzUhXx+2IOU0rIvCc5QWdy4ZC4j9RRv3ayXFbawOZ+JIEVmK500+ONE/sv91Mll/G0VV/tqeyYbGbPAnoAFKk6vKgJ9qCWv2qm1INUBdTL5+H2dx9tOAIOrTPt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724221556; c=relaxed/simple;
	bh=qAXeJgm+Qf4xXSXA58AqH3rKsU6yDRcpJzogQRf+Cp8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NPjaLGnTqM+RMjjP/FBSV8lac7RMzP5BCqVgw0U4i4b1Q1lCcXSdwJIOA6HEV666zUP9dq17Qd0bj/1EHSXf8HuclLXJ7wepzmK1F6lqW0Kgn3sThQAtoQVfxqhmVbQPvts5WI4QoTZ5ahOABx0H4CMBeFQIeuxNf9Z7IcmWImc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ob0sXeUK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47L6Pb7822383194, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724221537; bh=qAXeJgm+Qf4xXSXA58AqH3rKsU6yDRcpJzogQRf+Cp8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ob0sXeUKfb+wkti02bvJnLEvOkjBUFMIXgzjOBlcv6aTf4IUm5U7KRoaIQ0klShWY
	 g62TlOEEkUerytQ4Argdi5pMvvfvb+SqCt6XOMce5lX9Cv10/CEISMIJVu4K4XIRGS
	 0xZnQ2m4a39IfCt6RBpK0jm2EsnT80en4ASpJfamOW4o+3xwWF8TwSZtZiBcg9Xn8c
	 V3Qcxw8g3K6HxSCEu0aRXBjpi47qTkd2/Dl89PvEXcgYeaWPxWdTjyVhRtui11hP9m
	 i6R/wfDv6PSJ5Km+IqX6OK/elcGYT+BAQFRh6TzSxb/bor5VEkcc0oYUq6X79tD6l6
	 lu8ZM+/7x7RqQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47L6Pb7822383194
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 14:25:37 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 14:25:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Aug 2024 14:25:37 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 21 Aug 2024 14:25:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>,
        Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
Subject: RE: [PATCH 1/2] wifi: rtw88: Fix USB devices not transmitting beacons
Thread-Topic: [PATCH 1/2] wifi: rtw88: Fix USB devices not transmitting
 beacons
Thread-Index: AQHa4UB0rdjEjlHrdU2FqSD7y/ZODbIxYnRQ
Date: Wed, 21 Aug 2024 06:25:37 +0000
Message-ID: <b6fccaa0143a414a8513bc7c9276038b@realtek.com>
References: <9174a776-4771-4351-85fa-476e240d8ace@gmail.com>
In-Reply-To: <9174a776-4771-4351-85fa-476e240d8ace@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBJJ20g
bm90IHN1cmUgaWYgU0RJTyBkZXZpY2VzIGhhdmUgdGhlIHNhbWUgcHJvYmxlbS4NCg0KQSBTRElP
IHVzZXIgaGFzIGNvbmZpcm1lZCB0aGlzIGNoYW5nZSBjYW4gbWFrZSBTRElPIGRldmljZXMgc2Vu
ZCBvdXQgYmVhY29uLA0KYnV0IHN0aWxsIGhhdmUgb3RoZXIgcHJvYmxlbXMgdGhvdWdoLiANCg0K
QnkgdjIsIEkgd2lsbCB0YWtlIHRoaXMgcGF0Y2ggYW5kIGNoYW5nZSBjb25kaXRpb24gDQogICAg
aWYgKHJ0d19oY2lfdHlwZShydHdkZXYpICE9IFJUV19IQ0lfVFlQRV9VU0IpDQp0bw0KICAgIGlm
IChydHdfaGNpX3R5cGUocnR3ZGV2KSA9PSBSVFdfSENJX1RZUEVfUENJRSkNCg0KDQo=

