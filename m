Return-Path: <linux-wireless+bounces-19238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077B9A3EA31
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 02:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944A43AD410
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 01:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96361876;
	Fri, 21 Feb 2025 01:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="R+D+OEpc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7C3A94A
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 01:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101952; cv=none; b=kRwpeMXF6G7nnmBtczXA5vQTxJlmeTiVDNGpQJ0CbzRY+1ZAcnd+AP6WxnxC62leFZq8p8zBz0ZtpLrZcY9qP1++JA2Fr8oamXThs0q3NDDOcdSpnOi3jtAIqQugJN+Y1m38mvcQnsyDb1rH3bv0t1Dquq0Lg7Tv6/N197MF+qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101952; c=relaxed/simple;
	bh=qu1a7outzBNF5W5kU44uWsWeXsH18izmZFpriiWSGAo=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=VFA+pMh6bxjYFUbVJHGr0Yqw4U3qKbJwn0lSlU6SfBJY2007NvqXSUfNy4f/Xi+A2QRMNzBFJKTuT4b51tVR0vj5qNNNzw831lg8AfAKC8tA352UjVp+axbLVcii8PZVvwxrdnL9ti8/el36NWrHEsuYKIl93BuYVFQkqfei5e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=R+D+OEpc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51L1d69L1792768, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740101947; bh=qu1a7outzBNF5W5kU44uWsWeXsH18izmZFpriiWSGAo=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=R+D+OEpcmz7haqUwk/UfM9gNLVc/PC+8b7te/OgHmvleEj0lpNlfqpvO7eVLp3WMm
	 M9TZGVQxLpKljjX2yTAJz7+D1VTjj9/RcLg6Ca8A/ObWDfjntQTKlpVGSz9lZEYQ4B
	 A9FJ0GuTT7bzI1usgCV97sqAMLpfZj/UkeTNUfk05HP3NxjT18jZMrtJlTv93Gwgjd
	 ENRfmny3E8vuAuSB38W8aY4M42uzCOGORMR2wELfeEfer/U2drKfYkTAzwXg0a+RAg
	 a5w9UbNFKa8CY1wgJ9Y+VvXsR5MytpVDoSrHr3nWDDzcQlheB8MmCPG2p5Ye9wAdFD
	 qTj5ZBcUBoq9w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51L1d69L1792768
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 09:39:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Feb 2025 09:39:07 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 21 Feb
 2025 09:39:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: 8922a: fix incorrect STA-ID in EHT MU PPDU
In-Reply-To: <20250217061235.32031-1-pkshih@realtek.com>
References: <20250217061235.32031-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <362aef62-dd3f-4783-bb65-f608850415d5@RTEXMBS04.realtek.com.tw>
Date: Fri, 21 Feb 2025 09:39:07 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Kuan-Chung Chen <damon.chen@realtek.com>
> 
> EHT MU PPDU contains user field of EHT-SIG field with STA-ID that
> must match AID subfield in the Associate Response. Add a necessary
> setting to prevent these from being inconsistent.
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

bdce0574243b wifi: rtw89: 8922a: fix incorrect STA-ID in EHT MU PPDU

---
https://github.com/pkshih/rtw.git


