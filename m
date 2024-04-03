Return-Path: <linux-wireless+bounces-5779-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016268962A9
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 04:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92AAD1F2474A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 02:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4424C8F;
	Wed,  3 Apr 2024 02:49:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3461C1FA4
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 02:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712112589; cv=none; b=BEq1jgPWiPis3TYrFWX0RyctaD4muon2WY7hwy0rMpihtvHHE6XpUSfKta6vtc53ghaucNEjyQzDiWD3oULTgckwcuLjfg8k/dRduwiQTRAqqTgzGyvPdTdztXHjgbEADmkCvEZJcSyyCt75znrDqyFC4lb1lBv1e3rNqOEL8Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712112589; c=relaxed/simple;
	bh=9//frEWvpaazfAi3+LRgHcTqgJyaqwPv4M+WponPvoA=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=b1t2OzZbqG2+ExFiML1gwQ7ySMzRNbsNhxXVUZUQnf8Wqc5XKx5wIykQakfp6u2xk94lG6BF5fiZ6oWVJDDqn2a4u/S3a5FQCCYXLCAct0NikEhKdooPy2VKiYphM/Vc2JBmKFLfSsGs8kC8kC9DjfEp1ddyJpgz3x2Gqd/ykvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4332niWcB444279, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4332niWcB444279
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 3 Apr 2024 10:49:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 10:49:45 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 10:49:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <kevin_yang@realtek.com>
Subject: Re: [PATCH 1/4] wifi: rtw89: download firmware with five times retry
In-Reply-To: <20240329015251.22762-2-pkshih@realtek.com>
References: <20240329015251.22762-1-pkshih@realtek.com> <20240329015251.22762-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <7e0254ab-d35d-47aa-a6fb-f1b618f30bb7@RTEXMBS04.realtek.com.tw>
Date: Wed, 3 Apr 2024 10:49:44 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chia-Yuan Li <leo.li@realtek.com>
> 
> After firmware boots, it reads keys info from efuse and checks secure
> checksum, but suddenly failed to access efuse resulting in probe failure,
> and driver throws messages:
> 
>   rtw89_8852be 0000:03:00.0: fw security fail
>   rtw89_8852be 0000:03:00.0: download firmware fail
>   rtw89_8852be 0000:03:00.0: [ERR]fwdl 0x1E0 = 0xe2
>   rtw89_8852be 0000:03:00.0: [ERR]fwdl 0x83F0 = 0x210090
> 
> Retry five times to resolve rare abnormal hardware state.
> 
> Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patch(es) applied to rtw-next branch of rtw.git, thanks.

a9e1b0ec5bde wifi: rtw89: download firmware with five times retry
973719185ad1 wifi: rtw89: 8852c: update TX power tables to R69
5b919d726b61 wifi: rtw89: 8852c: add quirk to set PCI BER for certain platforms
a78d33a1286c wifi: rtw89: 8852c: disable PCI PHY EQ to improve compatibility

---
https://github.com/pkshih/rtw.git


