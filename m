Return-Path: <linux-wireless+bounces-7163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E99288BBB0E
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 14:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C121C20E9D
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 12:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C6C20B35;
	Sat,  4 May 2024 12:11:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7490720B34
	for <linux-wireless@vger.kernel.org>; Sat,  4 May 2024 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714824677; cv=none; b=LE0F7uBM1UWa4J3AtLvYw6eBgDRQC7UrjrDZnxWSBJt14+dCvLof0i5955s1LNI7OdxQRM4PA07aLVORV1a6cAStYtdqdGqFL9Wcf9gnKghVk1WfzogJivJiEqQndqUTAKmcb4kg/qJJfr2Zo9TQxvXsHiALQrn51bQHCARQEYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714824677; c=relaxed/simple;
	bh=lSnP5YRS6yCrjabRL/Xf5URA/cHdBWcJBzwjmWaHjjQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=Os0ZxdT6ojBz1y72ZGeFrHgrQ+9qvEQig1GTfUKEAVg3zM5j5wXCDppis4AH39jR9LLvUvxJnI+WujExrxGz0+txqSMp+aj6YPYV8WYVGrdqwK+ki3ABRYvLhCdGL8uMWQqYWB2Kvxs7OtPK9Ce+IrUFs0K7sQXbFOqcUHG1ds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 444CBAgmC234987, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 444CBAgmC234987
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 4 May 2024 20:11:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 4 May 2024 20:11:10 +0800
Received: from [127.0.1.1] (172.16.16.175) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 4 May
 2024 20:11:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH] wifi: rtlwifi: 8192d: initialize rate_mask in rtl92de_update_hal_rate_mask()
In-Reply-To: <20240504111916.31445-1-pkshih@realtek.com>
References: <20240504111916.31445-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <141c8359-ef40-46c0-bb0d-46e572c41317@RTEXMBS04.realtek.com.tw>
Date: Sat, 4 May 2024 20:11:09 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Ping-Ke Shih <pkshih@realtek.com> wrote:

> le32p_replace_bits() only updates partial bits of rate_mask, and gcc warns
> below. Set initial value to avoid warnings, and prevent random value of
> missed bits (bit 6 of rate_mask.macid_and_short_gi).
> 
> In file included from ./include/linux/fortify-string.h:5,
>                  from ./include/linux/string.h:369,
>                  from ./include/linux/bitmap.h:13,
>                  from ./include/linux/cpumask.h:13,
>                  from ./include/linux/sched.h:16,
>                  from drivers/net/wireless/realtek/rtlwifi/rtl8192d/../wifi.h:9,
>                  from drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c:4:
> In function 'le32p_replace_bits',
>     inlined from 'rtl92de_update_hal_rate_mask.isra' at drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c:986:2:
> ./include/linux/bitfield.h:189:15: warning: 'rate_mask' is used uninitialized [-Wuninitialized]
>   189 |         *p = (*p & ~to(field)) | type##_encode_bits(val, field);        \
>       |               ^~
> ./include/linux/bitfield.h:196:9: note: in expansion of macro '____MAKE_OP'
>   196 |         ____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu) \
>       |         ^~~~~~~~~~~
> ./include/linux/bitfield.h:201:1: note: in expansion of macro '__MAKE_OP'
>   201 | __MAKE_OP(32)
>       | ^~~~~~~~~
> drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c: In function 'rtl92de_update_hal_rate_mask.isra':
> drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c:863:37: note: 'rate_mask' declared here
>   863 |         struct rtl92d_rate_mask_h2c rate_mask;
>       |                                     ^~~~~~~~~
> 
> Fixes: 014bba73b525 ("wifi: rtlwifi: Adjust rtl8192d-common for USB")
> Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

82b85a836a59 wifi: rtlwifi: 8192d: initialize rate_mask in rtl92de_update_hal_rate_mask()

---

This is to quickly fix GCC warning [1] to prevent blocking pull-request.

[1] https://lore.kernel.org/linux-wireless/03e00a7f47c86323f34748853ba38859b4d52695.camel@realtek.com/T/#mdcc6bc74e1600b4c6f4ac3b97a5324ef07816db4

---
https://github.com/pkshih/rtw.git


