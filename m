Return-Path: <linux-wireless+bounces-10705-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFABA9425E8
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 07:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26161C225D7
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 05:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA224965C;
	Wed, 31 Jul 2024 05:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="wEOsMAjd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958FB4AECE
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 05:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722404644; cv=none; b=ux9E36H3Bgh8AfuVEVGNmTAA07hT9ncSKgueX1wqBCrnSTPP7zAY3BK1xrh0m4m6YXNDUrGvSQO4QFm9+BVBto1xllD9iGdOrS+r7PG8T1gorBLvyaqKFI4btVFZkSkArNO9n0GswCEcH8LL8NGqNX1Afk7MpIGoWOjv9I4XVy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722404644; c=relaxed/simple;
	bh=5KyNKupEBmnEyuUnr7vaIJEM7B4iiLpsSqMYoAfgPLI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=P2cRhmpp9dJ8eMvDfNS/yjGOLKERfb4DLVo1esQLAoMp5ak1al2ionOybjJQ682G20BqfLGHg1s+oi2imy79yj7XoTgWlbuJsZOn9pEe/6TwyTU+Wl9PZT6cE8zLlhVssruOOs6KA1L1Ps/96DaqGlbhWX9cVn1Q/AUSfNVU5pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=wEOsMAjd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46V5huoD71999960, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722404636; bh=5KyNKupEBmnEyuUnr7vaIJEM7B4iiLpsSqMYoAfgPLI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=wEOsMAjdDzAVNVwgGBMEYeQb80OzHvric1fFnSyQ0iFUkOaD47bDWMCeMGlRcyRIp
	 gC4syi3jwmTs/khsY6/Dy8hypQkSP+Z/pz0/74D7W4uSeAOEArg0AbKlAq2V9Gr6HQ
	 wEUtDU71q/oenE+8vWT1U2Q0y0vrT7yXXQn2DSFvAE+jdVF9oWlvfq3K3IyzwW52a9
	 AXH/Ndvk5y3rpEyzs8NNkCnCFqiDuEMC61SqHIsbXxNtrTUmtirrC0z0o4OSl+w6To
	 hg2Ah5LYEnGgEEI23fJr3eZtDqYDgr4QOsFq6eM2WoxBxvGmNlGaRHbHTlSINjcbWb
	 h4tuFdyA/6T0g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46V5huoD71999960
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 13:43:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 13:43:56 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 31 Jul
 2024 13:43:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH] wifi: rtw88: debugfs: support multiple adapters debugging
In-Reply-To: <20240718064155.38955-1-pkshih@realtek.com>
References: <20240718064155.38955-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <1f4976c9-71a1-4349-8d5d-3c9472fbcd72@RTEXMBS04.realtek.com.tw>
Date: Wed, 31 Jul 2024 13:43:56 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Originally in order to read partial registers from large area, we write
> a range value stored into a static variable and read registers according
> to the static variable.
> 
> However, if we install more than one adapters supported by this driver,
> the static variables will be overwritten by latter adapters. To resolve
> the problem, move the static variables to struct rtw_dev for each adapter.
> 
> With changes, smatch spends too much time to parse rtw_debugfs_init():
>     debug.c:1289 rtw_debugfs_init() parse error: turning off implications
>     after 60 seconds
> Move stuffs of adding debugfs entries to three rtw_debugfs_add_xxx()
> functions.
> 
> Reported-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Closes: https://lore.kernel.org/linux-wireless/cd6a2acf3c2c36d938b40140b52a779516f446a9.camel@realtek.com/T/#m27662022c70d9f893ba96f6c6a8dd8fce2434dfe
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

8db6c1ca6466 wifi: rtw88: debugfs: support multiple adapters debugging

---
https://github.com/pkshih/rtw.git


