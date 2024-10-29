Return-Path: <linux-wireless+bounces-14621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AF79B3F59
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 01:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A191C213C9
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 00:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D3D11712;
	Tue, 29 Oct 2024 00:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ntRXFOKX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9004A8F5E;
	Tue, 29 Oct 2024 00:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730163048; cv=none; b=lcU8fOXqdSev+plQVTZlhmX3HU72nGgRH3s1/9LZWupeCfNVaz8mWGRCvnd6v1P0s1OB6P274RyHnqq2aBMeekSwdqbVSbXWOA2BZkcpnWN0gytNpYtHrPS4sAdCgPuApYp0iWZIAOgfdDpRf2f+xtnX0gGENYmLI25UlOoU7+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730163048; c=relaxed/simple;
	bh=H4nwA7e+xEkSfJPqmB8gh8xD9ruUFmIIQOVLUDjhB8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t2X/Vjff4IdH/RclcZhZoY2ToHgySYl2U6llW+WHGIAAfbVqg53QcI0d2/Leh/KbR3C7a2L16UHExIkO1ZDmui8BEhSu4Ipnh+VftWMB/Lrzv9H8wUNBjL5nms30j60TRhPHvBoGW8m6puVg7jdCoxhkREKPNZLVVQ7D4K8bu9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ntRXFOKX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49T0oBs951580349, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730163011; bh=H4nwA7e+xEkSfJPqmB8gh8xD9ruUFmIIQOVLUDjhB8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ntRXFOKXHQkjQNJIAKi950F03TIH48qHf/bIr7/6E0AJ0KJJdkJZW7B6/zO867tPJ
	 M1YRhHIKaoIA3HTFZchDpb/SeQmfqUbe6KKgC2VfqG+3gZBnUl0f/plffWtC/kVFxY
	 YEHWp89CLVo3t5+b0xtgXeQSYS5tttJ3x2FTJl8KvxiofExsWaIVYtpq8M9sF8ZcU1
	 C8dTNy9Fb5FanOqX5OfeZjqC+HyqOBwZeCJZKSZkEx3bp0DVmG1Ssf+6tnS01Anu8D
	 AFKl+rz32zriS2JiUVpOl9VUOy8fRkgWLOyskP3XLqUlT2lfjpRIGDnbqp9Oh0AE5G
	 iVrFbvH7TPKog==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49T0oBs951580349
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 08:50:11 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 08:50:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 29 Oct 2024 08:50:12 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Tue, 29 Oct 2024 08:50:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com"
	<syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH] wifi: rtlwifi: Drastically reduce the attempts to read efuse bytes in case of failures
Thread-Topic: [PATCH] wifi: rtlwifi: Drastically reduce the attempts to read
 efuse bytes in case of failures
Thread-Index: AQHbJu7zUNmA/HJ3BESmyQL846u6pbKbY+MggABWlQCAAS+FcA==
Date: Tue, 29 Oct 2024 00:50:11 +0000
Message-ID: <c93c8e9c109b444b91489ac0e88b987c@realtek.com>
References: <20241025150226.896613-1-gpiccoli@igalia.com>
 <ed8114c231d1423893d3c90c458f35f3@realtek.com>
 <61aae4ff-8f80-252e-447a-cd8a51a325a1@igalia.com>
In-Reply-To: <61aae4ff-8f80-252e-447a-cd8a51a325a1@igalia.com>
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

PiANCj4gQnV0IGNhbiB5b3UgaGVscCBtZSBvbiBmaW5kaW5nIGEgVVNCIGFkYXB0ZXIgdGhhdCBy
dW5zIHRoaXMgcGF0aD8gSWYgeW91DQo+IGtub3cgYSBjb21tb2RpdHkgbW9kZWwgdGhhdCB1c2Vz
IHRoaXMgc3BlY2lmaWMgZHJpdmVyLCBjb3VsZCB5b3UgcG9pbnQNCj4gbWUgc28gSSBjYW4gYnV5
IG9uZSBmb3IgdGVzdGluZz8NCj4gDQoNCkkgZG9uJ3Qga25vdyB0aGF0LiBNYXliZSwgQml0dGVy
Ymx1ZSBTbWl0aCAoQ2MnZCkgY2FuIHNoYXJlIGhvdy93aGVyZSBoZSBnb3QNClVTQiBhZGFwdGVy
cy4gDQoNCg0K

