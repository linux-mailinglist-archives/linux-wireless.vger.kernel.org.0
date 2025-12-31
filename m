Return-Path: <linux-wireless+bounces-30212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6698CEB8B9
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 09:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FE92300C8CE
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 08:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4824230BF59;
	Wed, 31 Dec 2025 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="CSUXp9HJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3677B1ADC97
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767170036; cv=none; b=hfcSsCIizQmqX7jtAOWaWTabDp5GXpn1OznzNIZ6cXD8JZZlm9iKWlKWjFwHdvyeAtpUKa2PlhxX4Q3iac0Ucy7z/UE4gKeeyBwon8LmQAJkANQdJmdv9thZXRPk6L2tUhgMAAfnIRv1+JixZ0qR0n1u0HD+x5eN6jAOw9IdZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767170036; c=relaxed/simple;
	bh=fE8rgbmbgzD9Ud/C2BmbESWEtSrOPzsbm5TNWTzJFE4=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=fqum1/DM+OnuaI5/xpYTMTpLn4EgHk91gFduEVHcu3JAuOg6eO2/mhev3xlcPubCMhCa2tQ8mEZfiy/D/uibOi8QtwYEg6wF5Re1ZY9QqVC/7EjyPAI2Saqck+odR7H1YVSjFsHV+fnuZvLCWvOYW5kvaloy0j+IeEND7U8HvxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=CSUXp9HJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BV8XpwkE826379, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767170031; bh=o91CcTuD0Oyu2YL+Fy9wyVAqxJn7LeAbEVSX7TFgYrQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=CSUXp9HJlu/vGCbniJDib/yXK/k67E1nR/Y+isJ+JfYqGZ68mK/XMY4ruvhSeDP7X
	 Hw1NgBvSdqBqxoskN6Lnv+2gFZb05eYfySG+U2/GYPcn3Iso9UAb9N0MLmO/LOxjJ+
	 INU9PttLGlJRp6DzI1Ybocp0KBnEcjcoOefuC0ece3FLpawd9/8L1Y7tRZm5yWm8d3
	 gSouksl+dc3stWj+IquFv5bfd2SUTAk0B82GajJePxdkRYeKKKyU9PVqF36nbERVPS
	 78OCYU/O0wHiYuEP4XptxDxAj0lfgr5YabBG0b77hNDulqNXxjatabJ2glCeLrNx0B
	 UZkKYvte5G3Tg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BV8XpwkE826379
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 16:33:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 16:33:51 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 16:33:51 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 31 Dec 2025 16:33:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
        <dian_syuan0116@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next v2 01/12] wifi: rtw89: wow: use struct style to fill WOW CAM H2C command
In-Reply-To: <20251229030926.27004-2-pkshih@realtek.com>
References: <20251229030926.27004-1-pkshih@realtek.com> <20251229030926.27004-2-pkshih@realtek.com>
Message-ID: <bf18c3d3-07fc-483f-9d66-d77ad247e231@RTKEXHMBS04.realtek.com.tw>
Date: Wed, 31 Dec 2025 16:33:51 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> The WOW CAM H2C command is used to tell firmware the content
> of pattern match. Use struct instead of macros to fill the data.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

12 patch(es) applied to rtw-next branch of rtw.git, thanks.

0b92c2cc4856 wifi: rtw89: wow: use struct style to fill WOW CAM H2C command
355f38849e75 wifi: rtw89: wow: change type of WoWLAN pattern mask to __le32
295c47806bc5 wifi: rtw89: wow: add WOW_CAM update function for 8922D
cfa262efabb7 wifi: rtw89: wow: abstract DMA check register for RTL8922DE
040af1ac8002 wifi: rtw89: define TX/RX aggregation and MPDU capability per chip
9e389ad5d159 wifi: rtw89: efuse: read hardware version from efuse for WiFi 7 chips
d57ec29478d6 wifi: rtw89: read chip ID for RTL8922D variants
8cb147e23712 wifi: rtw89: add default quirks as features to chip_info
fe17b1852fdf wifi: rtw89: refine TX nulldata judgement when scan with 2 OP channels
9587ffbbd9aa wifi: rtw89: 8922a: configure FW version for SCAN_OFFLOAD_EXTRA_OP feature
8c96752d99c0 wifi: rtw89: regd: 6 GHz power type marks default when inactive
6a0b7392a6f5 wifi: rtw89: enhance connection stability when triggering beacon loss

---
https://github.com/pkshih/rtw.git


