Return-Path: <linux-wireless+bounces-11154-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BC894C7E8
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 03:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B858B1F225CB
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 01:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DADA38B;
	Fri,  9 Aug 2024 01:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="YOxS4OFh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A845933D1
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 01:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723165857; cv=none; b=pogQ8o+L7fHkcZ/CsfSL6tH3HeZbEHIt5lH+M/39D6+xRfWSM3/rOBsOyi96R2xxo2OEO1YcqPJyQ6FRq0FZJGuJQbHODAOw7sFHI08GdmCjeFHRD6fShJK7CjxteKxDGT6bx3XxeZY4R5hrRSAU+xNvReknsMh6RAK8fOL5FhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723165857; c=relaxed/simple;
	bh=1VwRo5nB7/t5fkj8d8ee12IAgasVBM5Ji/fIqONT3GQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=NfUGXHUzHQJHwTXdqNFm9p9IHF3GlIZMeqiIhaXOL4761U6HCh2FIprE7+PjDmaWVv1OeIQQckHxhnX61nMGwVRD22X+g0QQRzH/gH/hytPBeyCLlt0/Zp6gNV98vrU33G8oIgZgbb3Kl41rAmsECOUgifVVuo13+f+1Da2cz5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=YOxS4OFh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4791AlQ32144457, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723165847; bh=1VwRo5nB7/t5fkj8d8ee12IAgasVBM5Ji/fIqONT3GQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=YOxS4OFh31FH93TiT9WJZ4tUiMUwSJGjyqGAqbyhT/pzs2DOdVHVKdFlxLvSuosi8
	 wF+r/mfrzkyCWgcB0rK6k9JhLUSD9H+uWesdwyIAzWO+IRjkucxXe3PntbRwynCx6k
	 ovZP01HMO2Bot58AdxdsLZc7R5zbsskUs5YIt6sC35oonRDnzdkuNFkySI/KwV+pPa
	 OlknO3HRS5OBKvploNQzMijxvumPztKeasdZ7efVpO8tld33scvbeD3bZWst0dzf++
	 0tyozn0+p8InDMoOxbJuKz1zLJ5Ko+9E1Lk2C5wGyWu4SOLDhVJv6SImlR3R9jf8C/
	 AEg6pP9fdELRQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4791AlQ32144457
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Aug 2024 09:10:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 09:10:48 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 9 Aug
 2024 09:10:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Peter Robinson <pbrobinson@gmail.com>,
        Jes Sorensen
	<Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        <linux-wireless@vger.kernel.org>
CC: Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH] wifi: rtl8xxxu: add missing rtl8192cu USB IDs
In-Reply-To: <20240806082233.3837436-1-pbrobinson@gmail.com>
References: <20240806082233.3837436-1-pbrobinson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <48049c1b-8888-47dc-b97c-893e838352ae@RTEXMBS04.realtek.com.tw>
Date: Fri, 9 Aug 2024 09:10:47 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Peter Robinson <pbrobinson@gmail.com> wrote:

> The rtl8xxxu has all the rtl8192cu USB IDs except for the
> following 3 so add them to the untested section so they
> can be used with the rtl8xxxu as the rtl8192cu are well
> supported.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

e24f825a93e2 wifi: rtl8xxxu: add missing rtl8192cu USB IDs

---
https://github.com/pkshih/rtw.git


