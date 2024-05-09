Return-Path: <linux-wireless+bounces-7373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5536D8C0B75
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 08:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB331F23601
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 06:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736171494C7;
	Thu,  9 May 2024 06:18:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1661494BF;
	Thu,  9 May 2024 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715235519; cv=none; b=g4nhVJjkLBeKpp+TpPgWbAu/ptt+ev3XEKqSC8WbQG7a4KhtUBr8Wbr7O5yOCbQ7aqjJEapAzgSXeDNWsPrYKwncM7R4ep+AWL72slNr0yFNyeYKl/SNbJ6Ft/5OtL9/xh+QfZ//T/hUCsCHKUQao7tEfV/+K5FfTOkRNHUujZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715235519; c=relaxed/simple;
	bh=gPqv6nzvHzay/hvE5oduB03E6BeJvF7ve6vMLpAxcpI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=PscVYsXc6EXNrebunPz2G0qVX+9fCjXDAeWoCfFnoEJUog38sWx4FSVXTSSNyMMBg4zIUYOchL9RC6sZGoxKXg3ABaepY4Jg4Evhf635v8VcnNeopMwu2zViUp2BzVP1DAByu6yJUhFortvzXx1/krYQT/XeFm4YwJqCcDMvvwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4496INeS41288956, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4496INeS41288956
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 May 2024 14:18:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 14:18:23 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 9 May
 2024 14:18:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Breno Leitao <leitao@debian.org>, Ping-Ke Shih <pkshih@realtek.com>,
        "Kalle Valo" <kvalo@kernel.org>
CC: <leit@meta.com>,
        "open list:REALTEK WIRELESS DRIVER (rtw88)"
	<linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH wireless-next] wifi: rtw88: Un-embed dummy device
In-Reply-To: <20240425082910.2824393-1-leitao@debian.org>
References: <20240425082910.2824393-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <4f5f34de-16ef-49aa-a438-455597b81935@RTEXMBS04.realtek.com.tw>
Date: Thu, 9 May 2024 14:18:23 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Breno Leitao <leitao@debian.org> wrote:

> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_device from the private struct by converting it
> into a pointer. Then use the leverage the new alloc_netdev_dummy()
> helper to allocate and initialize dummy devices.
> 
> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

d0bcb10e7b94 wifi: rtw88: Un-embed dummy device

---
https://github.com/pkshih/rtw.git


