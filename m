Return-Path: <linux-wireless+bounces-24810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E26FAF873A
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 07:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D86540B22
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 05:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18551FBEB0;
	Fri,  4 Jul 2025 05:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="VuknEi1T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0251F8755
	for <linux-wireless@vger.kernel.org>; Fri,  4 Jul 2025 05:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751606997; cv=none; b=FQKVdmGY/QPJKOwEk1X3W/6+JojWRWBqOZrtI5Njk3j9OulQ2dAhOm4CkqnLjVk1TTZkCyeC5+vAmTjYDHb6rjXQksGemn+diPjCPfLHiK4WhGxBCcR/HP73QHiKGHHSPsUmZM6BwgLlkIuOLpbfvariJD8TLo30qXCbL2IrVxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751606997; c=relaxed/simple;
	bh=fp7GAkcII4hU5p7SzxkydLvpqHJysN6X4ZBnxfyvoQo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q8SlRs9k7Ai9kZPajdbJpVJ27DeiQ0AtgZijMCcLGoBdNIj+9uEYeQu7lvC/7emY29h9pCAUZmWHAUGKwmezFNWC4LNr7eEc55uNtFlWC9zgKJFtwyexAJVFReLLl/50a3JJsNvqMIXe3ouQISpYTq8m+8wKoZ6Qib2sFveFRa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=VuknEi1T; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5645TooE63796418, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1751606990; bh=fp7GAkcII4hU5p7SzxkydLvpqHJysN6X4ZBnxfyvoQo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=VuknEi1TiA31Ev+gVaT0cPu1XAbg+gPyoWVaN+YHrbbv24OkZQWY5Qa35FZCaOS/M
	 fcqy/vnkRFZiuvGdJyRr2Z/ExXQTpWsUFIzf/BVeFjCPxBrXdq/+QMzULudNQHl8pM
	 nwEyB/OHoIKgXi7Ml+EIh1Ez3T6dyi6zyqKBhIKKWq2BNY8Gh78FJgL/f+m7MQ4q/f
	 ZMf09Xamct9wu+LSUDU2eyz0mg5FkXLXCzLDJlcEYcaKmIFmhky+johhwSV2SYC8U7
	 xQn0oNzoGAx63nQveybpFeiBL9MMW13jNsPvhccgzFZ7y4Y1ve7kv1LzYxCrQwA6mp
	 02MhsKOMueVCA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5645TooE63796418
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Jul 2025 13:29:50 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 4 Jul 2025 13:30:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 4 Jul 2025 13:30:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Fri, 4 Jul 2025 13:30:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 2/6] wifi: rtw89: 8852b: Fix rtw8852b_pwr_{on,off}_func() for USB
Thread-Topic: [PATCH rtw-next 2/6] wifi: rtw89: 8852b: Fix
 rtw8852b_pwr_{on,off}_func() for USB
Thread-Index: AQHb6qGcTxEAvv+dNEm/wFJYGEnWArQhdBLw
Date: Fri, 4 Jul 2025 05:30:14 +0000
Message-ID: <389f1040211946988b0e967117ac1201@realtek.com>
References: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
 <6557111a-e8d8-4d4b-8613-2c944e7b9586@gmail.com>
In-Reply-To: <6557111a-e8d8-4d4b-8613-2c944e7b9586@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGVy
ZSBhcmUgYSBmZXcgZGlmZmVyZW5jZXMgaW4gdGhlIHBvd2VyIG9uL29mZiBmdW5jdGlvbnMgYmV0
d2VlbiBQQ0lFDQo+IGFuZCBVU0IuIFRoZSBjaGFuZ2VzIGluIHRoZSBwb3dlciBvZmYgZnVuY3Rp
b24gaW4gcGFydGljdWxhciBhcmUgbmVlZGVkDQo+IGZvciB0aGUgUlRMODgzMkJVIHRvIGJlIGFi
bGUgdG8gcG93ZXIgb24gYWdhaW4gYWZ0ZXIgaXQncyBwb3dlcmVkIG9mZi4NCj4gDQo+IFdoaWxl
IHRoZSBSVEw4ODMyQlUgYXBwZWFycyB0byB3b3JrIHdpdGhvdXQgdGhlIGNoYW5nZXMgaW4gdGhl
IHBvd2VyIG9uDQo+IGZ1bmN0aW9uLCBpdCdzIHByb2JhYmx5IGJlc3QgdG8gaW1wbGVtZW50IHRo
ZW0sIGluIGNhc2UgdGhleSBhcmUgbmVlZGVkDQo+IGluIHNvbWUgc2l0dWF0aW9ucy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29t
Pg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg==

