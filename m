Return-Path: <linux-wireless+bounces-16280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1AD9EDDD7
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 04:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E616A18804E8
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 03:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF74613A88A;
	Thu, 12 Dec 2024 03:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="azuL7Xu7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574467E765
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 03:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733972909; cv=none; b=kfvvIdj/CoDGqxGCbPehqfJ70iKMzHfxNHZmzcyw4pD0/VNam2iukMOgoHoUHTRgg1G4AHKyiv6HTDSUKgs3dKvgXLzE9rujeZVw1em5gMTevdF/K/hR17dWnMeAeeFEd6YZPHNxQGdBN2OUHtVSsjp5hlCOnYmNRxrQQDFM8Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733972909; c=relaxed/simple;
	bh=iHyJz2TZ9kbuDPCL1htM614970+4NsgueQlB4dqkJjA=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=OVRZ1CcUvcCZFVcg/jNV8LeZb6m2MXRVJvA00tz5B1xAZhbVREHbTm3OFTiyuuzXChpyYLMWPFoLTxJDARSF3wRJtkbi8rEkJLoAfMB5i61L8U5f99toZMjGc/5X9fz+Mxe2w/+82lf8OHAT7d+KK5rzPisqhozoGuAxLQqfDI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=azuL7Xu7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BC38OglC521812, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733972904; bh=iHyJz2TZ9kbuDPCL1htM614970+4NsgueQlB4dqkJjA=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=azuL7Xu7PcWFKwSLy8gYZYOxKGo6TvAYDwKQTQTF1x3W2U3US8x743YKCXvx1+u8i
	 aS4/ebmUqgONWerwX1eGgeoYWZv6WGXy3jDPUJn1lbuqlmWBd/c6eZJtMq609PPihf
	 sNRfN8HSGb43UXYFuGKzKLzdi3/+9I0QCLJs9OLDukPp1lN98svY4rD/S0NuFmhqim
	 HNpoMT2kp60UDDLl3GqHxQXtgNQy2jLgW6pLSwoIphm2dERZRN7kVXC38bFpLczvkX
	 2jCE62xB1ZCmROKub2FW7FLABbERF0Glv8BJ6qVVtJ9RrgDv9G3KU3cpXaPgsxLi5b
	 rxYB+evcgxhnw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BC38OglC521812
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 11:08:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 11:08:24 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 12 Dec
 2024 11:08:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] wifi: rtw89: 8852c: rfk: refine target channel calculation in _rx_dck_channel_calc()
In-Reply-To: <20241209042020.21290-1-pkshih@realtek.com>
References: <20241209042020.21290-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <8d9f20c8-fdc8-4a03-b421-495a59ad0625@RTEXMBS04.realtek.com.tw>
Date: Thu, 12 Dec 2024 11:08:24 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The channel is not possibly 0, so original code is fine. Still want to
> avoid Coverity warning, so ensure -32 offset for the channel number which
> is larger than 125 only. Actually, don't change logic at all.
> 
> Addresses-Coverity-ID: 1628150 ("Overflowed constant")
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

b6c10a193637 wifi: rtw89: 8852c: rfk: refine target channel calculation in _rx_dck_channel_calc()
5fdf5e557f06 wifi: rtw89: 8851b: rfk: remove unnecessary assignment of return value of _dpk_dgain_read()

---
https://github.com/pkshih/rtw.git


