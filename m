Return-Path: <linux-wireless+bounces-7624-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823738C4AFD
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 03:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1203D286FF3
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 01:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFCD125B2;
	Tue, 14 May 2024 01:40:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FA7125AC
	for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 01:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715650845; cv=none; b=JJv8bRkq7sl5HZhE1x9jwb4cPT0n/7iuPHjQGF37laJTx3HKDMqZIin+ykUA8iauisajAB+yz0/BJP3i9IjtGlg93Ov9i3EPiR7O2d5RxdTfNhO3Y6OyCP604D7/rOIyPIrNRQUST/3xJcisJXOdnUf8UVJVRPaG/GndxpI4Qeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715650845; c=relaxed/simple;
	bh=2CIlUJ7AZMOpOVc8zm29K4mZjGxNNkmcW81zk0b20/U=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=gtwQyvxNj77aZ/oSud4qdWrLUeg//ak/djjdA6SKM8aMwttApRxYmqcXHMm9tyOIi2RDgJiE9PKKWOrXz15QPB+UnaHM93j+uRLxJVhXUoVC45m4PlFw9HakubRvAT/k4o5ugcsy+XcJiPppMXQi7qeTpv4K5tEVbyYY35NhocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44E1eeqC72260508, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44E1eeqC72260508
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 09:40:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 09:40:41 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 14 May
 2024 09:40:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: fix HW scan abort not completed issue
In-Reply-To: <20240510130934.5825-1-pkshih@realtek.com>
References: <20240510130934.5825-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <bfd8ae50-1260-4278-8c83-771087cd8468@RTEXMBS04.realtek.com.tw>
Date: Tue, 14 May 2024 09:40:41 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chih-Kang Chang <gary.chang@realtek.com>
> 
> When scan happens before suspending, rtw89_hw_scan_complete() might
> happen after suspend flow. This causes the scan to be unable to
> properly indicate scan completion to mac80211 before suspending. To
> fix this issue, we modify to execute rtw89_hw_scan_complete() when
> rtw89_hw_scan_abort() is called, regardless of result of
> rtw89_hw_scan_offload().
> 
> Cc: stable@vger.kernel.org
> Fixes: bcbefbd032df ("wifi: rtw89: add wait/completion for abort scan")
> Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

It seems have better way to fix this problem. Drop this patch for now.


