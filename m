Return-Path: <linux-wireless+bounces-10722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2559428E0
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 10:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF753284EC1
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 08:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B17F1A7206;
	Wed, 31 Jul 2024 08:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="r8AzvCAy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5699A1A7F8E
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 08:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722413457; cv=none; b=BreZv+yBqiHsMjs/3kq3b7FGBfVgHlrb+QOLdNSxVZDyBRVoikCfYa3D43IF13yQie1/ehD2/HP+41Ri5GqR3SyQ4EXrDr2dC4Y1/+fQBDn05tVF0h7IhaOUjNMuvXQ3gvn6Car3n8NbyqZ3bIFq5LenmIbdbmU2+2WM8P/B2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722413457; c=relaxed/simple;
	bh=OqPPud1BlBbrjlV7viSjJCYF1sfVIzoGzRBoZdL3aYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=RzWj3RGiurrWe5nC7MW1KkR9ByIxuwS7UaHXaijKDH4QoibzUevp+nJ9C0uLo7usSv66n9m9zmo9MuG1VE9aZs8AHq4ycQ37IRxDp2Ls8rYxFXMKxy+c0+ut4ijTOy/HihiYS+yKyABGGbQjIZyPCGDz8Z6SejUOeWO9E97GP/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=r8AzvCAy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46V8AYRp82132534, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722413434; bh=OqPPud1BlBbrjlV7viSjJCYF1sfVIzoGzRBoZdL3aYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=r8AzvCAyaEHH2YixV7xMhu79mgGcZIQyD6ELMbqaANXWw6DzM1oT0ycEHocyHovri
	 j/vL/4lIxZWbmeLPisc6lvm4DUSyZ3MzR18zbh3bbMKCCUQ2iT3csFvVxqz7G1z5YP
	 56b3KEZ1SLjRf3YrNPFB9GHNX6CpMez0k6yxIz02Lzpi9l3pKS2fsX4NvUOXh/1kW1
	 Gjh8z/EWDL1c83eiqirFeqQ3ebqN6CCTqSFC9FpW9lI7XQYFjFZMCagf73B7B1mERe
	 uz+j5UWJB/M6XDTJgHpX19dHdIaFBQmoY6LI1T1OmZEXwE5H08+dt9hfUxrnQzzClM
	 NRIjLvFqaFBOA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46V8AYRp82132534
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 16:10:34 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 16:10:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jul 2024 16:10:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 31 Jul 2024 16:10:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>,
        Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
Subject: RE: [PATCH 2/2] wifi: rtw88: Avoid using macid 0 in AP mode
Thread-Topic: [PATCH 2/2] wifi: rtw88: Avoid using macid 0 in AP mode
Thread-Index: AQHa4UC4lZ9xsp59ME2YErnRO2fzALIO0JLQ///mdQCAAUpa0IAAepOw
Date: Wed, 31 Jul 2024 08:10:33 +0000
Message-ID: <232e34480fdb4cc6b1bc236409ccd050@realtek.com>
References: <9174a776-4771-4351-85fa-476e240d8ace@gmail.com>
 <e4be0a75-43b2-4ae5-9aab-5c4a88e78097@gmail.com>
 <9356af89520243ccacc0be72b8b03252@realtek.com>
 <4f052989-5fb9-4c5c-950e-a3d34e6499ab@gmail.com> 
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

SGkgQml0dGVyYmx1ZSBTbWl0aCwNCg0KPiA+DQo+ID4gQWxzbywgZG8geW91IG1lYW4gdGhhdCB5
b3Ugd2lsbCBkbyBhbGwgdGhpcz8gSXQncyBub3QgY2xlYXIgdG8gbWUuDQo+IA0KPiBJIGNhbiBk
byBpdC4gT3IgYXJlIHlvdSBpbnRlcmVzdGVkIGluIHRoaXM/DQo+IA0KDQpGWUkuDQpJIGhhdmUg
bWFkZSBhIGRyYWZ0IHZlcnNpb24sIGFuZCB3aWxsIHNlbmQgaXQgb3V0IGFmdGVyd2FyZC4gDQoN
Cg0K

