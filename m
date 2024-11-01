Return-Path: <linux-wireless+bounces-14798-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED4C9B893A
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 03:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193D91F244A2
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 02:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04076374D1;
	Fri,  1 Nov 2024 02:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="a0xe7y4X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65DB61FF2
	for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2024 02:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730427519; cv=none; b=hqcw6NLmT5c9KnKrynUAV/GiTZDY4STcBND0NjBJYsaCNJw3XpMteTYZQQHjRki3Nnysi/y77NuLBv1PWk9MqqEVNwO8V+SGS5OdAuZL9ikQxl1mo1Mo9Gbo0R2ufegSsj99UI/UzEhutL2cROn4Ksfq2kvdrgurHc6N47zZpZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730427519; c=relaxed/simple;
	bh=opvqX8BzYUskZJPd/daF0U8HRzjmXujpXxal0LMCKEM=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=Lh533hv8dsFpl9FKuD/1W9nyIuzor+/MurZRke8MGmua0xvO1z7ZAinEQz3PXDePBoooWDDGq2frFNxzTWy3M30F7tOeEqJfcif5y7500yC8M5vyrznaIToaUgM33fPbg5eryVZkeSOX2MmRBeKY6xPw3nwmPGNQXt6WQxzcCm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=a0xe7y4X; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A12IUSf82349430, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730427510; bh=opvqX8BzYUskZJPd/daF0U8HRzjmXujpXxal0LMCKEM=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=a0xe7y4XTvYtcd/ZqMeu375Frk7YAuId4RV64KaSw6PtSPa7vqRDUqcey+fUHHW7n
	 ADxunapFrSQKleY0FPVUOzBCisHxZaRpzWODhLc9xvRp5VRGZcqRHXjtFwYmuzIuqV
	 uV4zUik+5atBb95nrbj57anJVcCFFW8Z/Lqu99c70SFMVt6x2pBZWEieQDDkQHTIM3
	 Jwljt3ZLFtvDA47TXD5/RpWXzBFNw3VaEM8ynxmZQ2wIZZcEGNc9dg5wDoUeDr4n+t
	 PnuHRbGLc8q9IByet9Jjt1mMZ8Wju9RcoLsHyl34dL9BiPZkTYxJ+juhHjyDgiNl7S
	 z/tRWICNUBhmA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A12IUSf82349430
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 1 Nov 2024 10:18:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 10:18:30 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 1 Nov
 2024 10:18:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: set pause_data field to avoid transmitting data in scan channels
In-Reply-To: <20241026022143.7304-1-pkshih@realtek.com>
References: <20241026022143.7304-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <6566383c-3471-48b5-973f-8008a697c70c@RTEXMBS04.realtek.com.tw>
Date: Fri, 1 Nov 2024 10:18:30 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chih-Kang Chang <gary.chang@realtek.com>
> 
> Set pause_data to all of the scan channels, excluding the OP channel,
> to prevent data frame transmission to the scan channels, which causes
> retransmission. Additionally, this flag won't affect the transmission
> of probe requests from the scan channels.
> 
> Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

3e407dae7151 wifi: rtw89: set pause_data field to avoid transmitting data in scan channels

---
https://github.com/pkshih/rtw.git


