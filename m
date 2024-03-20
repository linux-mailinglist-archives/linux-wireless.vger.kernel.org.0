Return-Path: <linux-wireless+bounces-4940-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6522B88095A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 03:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16DD71F22C50
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 02:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4768C0B;
	Wed, 20 Mar 2024 02:04:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FB77489
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 02:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710900257; cv=none; b=dcv+932cL8lMpt2XV98qM8g93PynDS0YNcAKS3shSAt20HpMw48PE1+iBN+88Lus0O4rjz0Z8ihw1nCf/1ppwIapIySLiNQmvjGjQ5HsOf5HA+qb7dRP4l/FDDp30mVq+E5cVDxPTtlUnjdkSOfLBpeG+wBGoNz/Rc7tdkA+g0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710900257; c=relaxed/simple;
	bh=SHa113Ate6V9jWx3JHJkM8Vd8NUaAW8PAJeYonjZTCs=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=QRMp+QvqTJtqMq80pUFfaWIz6O7W1NUz1X2Sv/MIvcsRLrInoq2+1tOIFCxYmNQSKsIO69xccgs/vLHqyAFWhZq6n+MOm6fy95rH0t06E/mro1DyyRmJvcfeytIgSZoKD+JRBrc3iqfL/VSxl/c42J4ZUWykXOL8FCOOVa5ZKtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42K23qgD6162607, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42K23qgD6162607
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 10:03:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 10:03:52 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 20 Mar
 2024 10:03:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH] wifi: rtl8xxxu: enable MFP support
In-Reply-To: <20240314164850.86432-1-martin.kaistra@linutronix.de>
References: <20240314164850.86432-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <c8ac7891-cd01-416f-b853-c5d001cfd2f5@RTEXMBS04.realtek.com.tw>
Date: Wed, 20 Mar 2024 10:03:51 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Martin Kaistra <martin.kaistra@linutronix.de> wrote:

> In order to connect to networks which require 802.11w, add the
> MFP_CAPABLE flag and let mac80211 do the actual crypto in software.
> 
> When a robust management frames is received, rx_dec->swdec is not set,
> even though the HW did not decrypt it. Extend the check and don't set
> RX_FLAG_DECRYPTED for these frames in order to use SW decryption.
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

77f5924fc41c wifi: rtl8xxxu: enable MFP support

---
https://github.com/pkshih/rtw.git


