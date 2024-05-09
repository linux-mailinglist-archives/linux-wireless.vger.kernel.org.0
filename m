Return-Path: <linux-wireless+bounces-7372-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4158C0B5D
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 08:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0171C20EB0
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 06:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E260F26AE0;
	Thu,  9 May 2024 06:15:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72552323D;
	Thu,  9 May 2024 06:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715235309; cv=none; b=jKusxN1UNOGOP53jYUW42RA9qwOB1eXDWCmp47SIoba0cL5/vFwdY8im5jgzDLI+r8o9kjvmXCjuKdeUpvAZahlmprsGjiGJFw2XOso5vM8GXD1CbVmJHEWBsDJgAZhc4TyrJ+9MTs/XvHydrgG0ydQ8ir944nSobXEyI0rbj9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715235309; c=relaxed/simple;
	bh=oPlADKq3dZQhdgv+M3VHYgl+ufuBSPhRnb8kHcaUZkk=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=X8HoE59Gq3jU9hdkE9jBhxtuSzmc5Ro/KC8s8dnF3RzuDP2o1J+ztdfOUJg6CGCLBZFBmQ+nPp8EmYDblm0v+2YO8C17aCpN30Dm1Ppy0g6FMIfLJYq1hutiRPCltiDZvN79Q/OWuBtRXyvnSTUG3ELboLnx6prxc1IwmbZNIwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4496EgGxA1286859, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4496EgGxA1286859
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 May 2024 14:14:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 14:14:42 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 9 May
 2024 14:14:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Breno Leitao <leitao@debian.org>, Ping-Ke Shih <pkshih@realtek.com>,
        "Kalle Valo" <kvalo@kernel.org>
CC: <leit@meta.com>,
        "open list:REALTEK WIRELESS DRIVER (rtw89)"
	<linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH wireless] wifi: rtw89: Un-embed dummy device
In-Reply-To: <20240424182351.3936556-1-leitao@debian.org>
References: <20240424182351.3936556-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <ceba33e3-c570-486e-9d93-51722ad5da94@RTEXMBS04.realtek.com.tw>
Date: Thu, 9 May 2024 14:14:41 +0800
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

4c9aa94a39e6 wifi: rtw89: Un-embed dummy device

---
https://github.com/pkshih/rtw.git


