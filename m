Return-Path: <linux-wireless+bounces-6545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CBB8AA69D
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 03:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D6F1C21CF6
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 01:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2C910FF;
	Fri, 19 Apr 2024 01:44:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBFC10F9
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 01:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713491043; cv=none; b=KlqZklJemQoVsPUh929gZB7Mplsq4B91zGcsQSV6QgpJ+gvFumdb5S6LhUK/3AFQum6424WUi0G74fgGZ3eOOQW27OLtJ6wL2W4nPgANdI0kULG35UVDPHMet2CY/5MWOxkLJDMGnE+sslA+xa25PWK1LH42lGH9uXCID985Uls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713491043; c=relaxed/simple;
	bh=NkfquWLKcqgyXGSpH2trZEw0PJiJQkBeWZ1fWYqOf54=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=WgsZklFe/kgfcofbFNB+ESArznP9mIEoEojA7NGZHzdOMGEfGYB0IQEdvORsBcDnD5hYNI7SbhTd9Rm5jWwPh6UopvOwpEE7TS8rAiopUXrqcX/4YeXK3ZqjprCbllP6go6HyzD+8jDJuK7g6PVzMQSN/XZgqQz7iESuxwA2RFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43J1hswhF876899, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43J1hswhF876899
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 09:43:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 09:43:54 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Apr
 2024 09:43:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH v2] wifi: rtl8xxxu: Fix the TX power of RTL8192CU, RTL8723AU
In-Reply-To: <6ae5945b-644e-45e4-a78f-4c7d9c987910@gmail.com>
References: <6ae5945b-644e-45e4-a78f-4c7d9c987910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <5fb760ee-fd98-422e-b670-8e6a1060a5c0@RTEXMBS04.realtek.com.tw>
Date: Fri, 19 Apr 2024 09:43:53 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Don't subtract 1 from the power index. This was added in commit
> 2fc0b8e5a17d ("rtl8xxxu: Add TX power base values for gen1 parts")
> for unknown reasons. The vendor drivers don't do this.
> 
> Also correct the calculations of values written to
> REG_OFDM0_X{C,D}_TX_IQ_IMBALANCE. According to the vendor driver,
> these are used for TX power training.
> 
> With these changes rtl8xxxu sets the TX power of RTL8192CU the same
> as the vendor driver.
> 
> None of this appears to have any effect on my RTL8192CU device.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

08b5d052d17a wifi: rtl8xxxu: Fix the TX power of RTL8192CU, RTL8723AU

---
https://github.com/pkshih/rtw.git


