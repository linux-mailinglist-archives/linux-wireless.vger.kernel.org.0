Return-Path: <linux-wireless+bounces-14962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3AE9BDEF0
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 07:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88925283E46
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 06:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE171191F89;
	Wed,  6 Nov 2024 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="gCvhAC2y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCD0824A3;
	Wed,  6 Nov 2024 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730875212; cv=none; b=NOKLApRsxlw5FdjCNPwD9gnkaKT8sI+tAWFTLHfTerZbZJcEiRj1Pt4j3ZzAIbkqfAOW45xoMeSeVwFr3J8fv51mvS9u3qL1z09Ms+CqMDgS1c5FIukUb6Fip/vJQiwe2lZ3Lbr/dOdaFfHFhZEOjzN7O9cL29yS5DYiE0d8DjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730875212; c=relaxed/simple;
	bh=0ppA4cCtZYT3Pm4Zg7yV2SvTmCrBeaeXp1O9gjZ2dXo=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=o4v4+P+lc0kNmL8snkDdsFdFxGVeIUIpFoVAomP7Ox0uDPuPOOiiDe3vlJ9poHJeFLc3ahC5La7OGXdfoQKnL/aDpJysg2uirBwI53f9pjy1a1QnFjkFr1Fr50okiLJjD0uLYyFefAbnH2Z6hssfaZ/HbSxX3A0CpYWrej3u8wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=gCvhAC2y; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A66e0Xc92338297, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730875200; bh=0ppA4cCtZYT3Pm4Zg7yV2SvTmCrBeaeXp1O9gjZ2dXo=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=gCvhAC2y4L0FXtyBibm53SEjb4Zh96F/Elw7S3HeARAPcFaBE7lBAMjJ3jUrXZhmq
	 RncBYdJKmtWi7cp09Vb3L2WioOhruL/g2rF1rMcgN2oZRId3QOy0j1ZddhwLkGQSPX
	 Sc+xz5D9opa/OTIwJquG9KcTUlzGJUGQlmbZit1+R0LB4wRIs9CwDf2bK5Tr+yqAIU
	 qtlzYp5sNtF4j5KgSubLTcJFPsL3AlEC7a6+W6CgiaGQfeIXwX6WuSubeUxg+p5gwU
	 1YxGHgPvX9SjZovuSXsi2G/8FfNKzJ3qqLAYBxhneftfKxYZahBQiGK3AydnIbyORB
	 1rTUNFgWDCUZQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A66e0Xc92338297
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Nov 2024 14:40:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 14:40:00 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Nov
 2024 14:39:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux@treblig.org>, <pkshih@realtek.com>, <kvalo@kernel.org>,
        <linux-wireless@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert"
	<linux@treblig.org>
Subject: Re: [PATCH v2] wifi: rtlwifi: Remove some exhalbtc deadcode
In-Reply-To: <20241104144331.29262-1-linux@treblig.org>
References: <20241104144331.29262-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <a50793d9-889e-4bcc-baa2-f639989aa66d@RTEXMBS04.realtek.com.tw>
Date: Wed, 6 Nov 2024 14:39:59 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

linux@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> exhalbtc_rf_status_notify(), exhalbtc_coex_dm_switch() and
> exhalbtc_antenna_detection() are unused since they were added in 2017's
> commit 7937f02d1953 ("rtlwifi: btcoex: hook external functions for newer
> chips")
> 
> Remove them.
> 
> This leaves ex_btc8723b1ant_coex_dm_reset() unused.
> 
> Remove it.
> 
> exhalbtc_dbg_control(), exhalbtc_stack_update_profile_info(),
> exhalbtc_set_hci_version(), and exhalbtc_set_bt_patch_version() are
> unused since their addition in 2014 by
> commit aa45a673b291 ("rtlwifi: btcoexist: Add new mini driver")
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

d41df04183db wifi: rtlwifi: Remove some exhalbtc deadcode

---
https://github.com/pkshih/rtw.git


