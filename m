Return-Path: <linux-wireless+bounces-18685-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA01A2E2BD
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 04:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D060165D96
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 03:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FB96F06B;
	Mon, 10 Feb 2025 03:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Rt6NoaBB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE235957
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 03:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739158106; cv=none; b=htmHGEVDSp0576TaJRs1Z7L3E4tnuoP+3EXfw7FGN6MoCIOLk+KmhFMigeOxtMqVlcx2TMnwUbrkC5WIYb2WPNw36k/odhTjOpQkXWxYXiObgC1Ma0/mYjkPRQWzx+hYQQEFGn+ejUsolgEQ9x+N7ubwkOZtGVFGbTzSHhiG68M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739158106; c=relaxed/simple;
	bh=EPx6LZ7mrxekxMEy0jgo3G+/QyiYup2OfAE3F6PLPyM=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=XUYQBjOlzT7+3x0mFA0iLU5aLpRCdBcypvjtAPFcI9YqhkXKyRO9kZBYOHRde3QfNnYdWe4eqNNaj7z0ExZDutzeRPLuQnzdcN/VOnEIa6MHe39au6UF9ygbxFPNWPB/x+hrsxoLIenQoELVTWOMyInIMkV8hDF/VsnTtm0/7F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Rt6NoaBB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51A3SKSC01574428, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739158100; bh=EPx6LZ7mrxekxMEy0jgo3G+/QyiYup2OfAE3F6PLPyM=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=Rt6NoaBBvMme8RzN2gCPsOJxZtXIOUTemXYP9TWfZUoytdZk66fmumrGZTCFxhoqB
	 zVj4GGSBtUdrBLDhIuOUe5q+YBu/vaYrsTcm1bFtbKX5kGvzBwJEjVUTcY9+tO2LY2
	 LYzjilrUELOWtl/+AEp87+bLyTpvymJxfCq54EnL9Ubank6DkPPYD+C6e0PbXdm+oe
	 wM6Lc0XmTvuDUFd92DeYIrVWJY/1bv3m1QhcM/CWxsXb6ft/lnS+R9zbeRxX68euqO
	 1CldObgvSmBgDplZHRcD78yfmKStDiSDHztKTRvuCP6NKXoFk8XMmSASmPuQa3VhkH
	 UO9dMl0GPkw3Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51A3SKSC01574428
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 11:28:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Feb 2025 11:28:21 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 10 Feb
 2025 11:28:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: regd: avoid using BITMAP_FROM_U64() to assign function bitmap
In-Reply-To: <20250205014051.13765-1-pkshih@realtek.com>
References: <20250205014051.13765-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <58293fb9-cf7d-4d0a-add2-7f9b2a1d66f9@RTEXMBS04.realtek.com.tw>
Date: Mon, 10 Feb 2025 11:28:20 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Since there are two function features for now, func_bitmap[] has single
> one element, which BITMAP_FROM_U64() generating two elements is exceeded.
> Change to assign function bitmap barely.
> 
> With i386-allmodconfig (a 32 bit system), it throws
> 
>  >> include/linux/bitmap.h:736:33: warning: excess elements in array initializer
>       736 |                                 ((unsigned long) ((u64)(n) >> 32))
>           |                                 ^
>     drivers/net/wireless/realtek/rtw89/regd.c:16:34: note: in expansion of macro 'BITMAP_FROM_U64'
>        16 |                 .func_bitmap = { BITMAP_FROM_U64(_fmap), },     \
>           |                                  ^~~~~~~~~~~~~~~
>     drivers/net/wireless/realtek/rtw89/regd.c:20:9: note: in expansion of macro 'COUNTRY_REGD'
>        20 |         COUNTRY_REGD("00", RTW89_WW, RTW89_WW, RTW89_WW, 0x0);
>           |         ^~~~~~~~~~~~
> 
> Fixes: 79a36fc56bea ("wifi: rtw89: regd: handle supported regulatory functions by country")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502031932.BMQ4lhJT-lkp@intel.com/
> Cc: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

85c726b20f59 wifi: rtw89: regd: avoid using BITMAP_FROM_U64() to assign function bitmap

---
https://github.com/pkshih/rtw.git


