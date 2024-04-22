Return-Path: <linux-wireless+bounces-6610-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8488AC2A8
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 03:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9A61C20D9B
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 01:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B062595;
	Mon, 22 Apr 2024 01:56:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D427C746E
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 01:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713750977; cv=none; b=rlrtC0vneA5S65jFQtZ8YuuQqsB2uAjlIRlQ3eR0HlxcGjiKg4Ud2pYEPwRaG0C38H0YuSXllV55d+a3zduHGT62lp7BBvjXrDLgCDm8kbsYOkA+ePT9oWC1wEeBwdD9IVOGWXXQA92zNLvyMC03EHPjVVPEefADPD8ML1HrUEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713750977; c=relaxed/simple;
	bh=wHmsUfmYAkGAXH6Dyb+5L6fYtTXJAFaVn6nUlhz9vgU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=rAQynPYxa51lbQj5VLeHX2OaV2QJgvW+QrpzECzgyaOkc1GX+vCGUiFJfJVzq0ornFOZvHqQOCxfRPV6X7xU0Nldpg8krygSWFtpnZwAdnIcQkaMHNU163we9wSL8OXbVZ1Qn0XDMacaa2YaIZfWB9M2ZbK/M560MTzrTOBThcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43M1ts4yB3726760, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43M1ts4yB3726760
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 09:55:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 09:55:54 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 09:55:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
Subject: Re: [PATCH v2 1/2] Revert "wifi: rtl8xxxu: enable MFP support"
In-Reply-To: <20240418071813.1883174-2-martin.kaistra@linutronix.de>
References: <20240418071813.1883174-1-martin.kaistra@linutronix.de> <20240418071813.1883174-2-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <88ab612c-0079-461b-ab3e-e603846ede10@RTEXMBS04.realtek.com.tw>
Date: Mon, 22 Apr 2024 09:55:54 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Martin Kaistra <martin.kaistra@linutronix.de> wrote:

> This reverts commit 77f5924fc41c243e907c80ce2576902d3a9cb336.
> 
> There is a more elegant solution to check for not decrypted frames,
> which is to check the security flag in the RX descriptor.
> 
> Revert commit 77f5924fc41c ("wifi: rtl8xxxu: enable MFP support") in
> favor of this to be able to send it to stable.
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

55e2843dd33a Revert "wifi: rtl8xxxu: enable MFP support"
cbfbb4ddbc85 wifi: rtl8xxxu: enable MFP support with security flag of RX descriptor

---
https://github.com/pkshih/rtw.git


