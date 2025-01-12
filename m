Return-Path: <linux-wireless+bounces-17365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B00A0A6E9
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 03:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615D03A0426
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 02:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181FD8BFF;
	Sun, 12 Jan 2025 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="VxrRoSDP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643D12941C;
	Sun, 12 Jan 2025 02:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736647624; cv=none; b=SXCWUnmpI3y459iFvzLCnxMTXPo7DG2e6zc0zSUYpuXmgoi1/0kl9zjMqdaqwhA5BayXWyZ+6KrMqTBaoDLvP+U1oesRLzPrgs3FChVP7UNYkNh6yuiLwqLj0xAb65K2AoQDopM75P74l/pe5d9zdoEsCSu7ZyQsjzkDVTcODmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736647624; c=relaxed/simple;
	bh=EXduenhBlExus6a4hRXadJFL+mrCbt4iayPqKfZIEXE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=FMm5zSYWHZAMHtyxbJnVGn8Mwx3Yia0CpoExWhxHVkMbUaywGyZK/iJJDrTuE61w9EaJl5Spqq/MFt4jWBlenHcp9iOovHK/nMv0otK5eWWb8cSHBewzJns/jABXo7EfRtxT8j0OjWNRwrEzUFYY451f28yX1gGgyq1NaIbm/mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=VxrRoSDP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50C26n2921606720, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736647609; bh=EXduenhBlExus6a4hRXadJFL+mrCbt4iayPqKfZIEXE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=VxrRoSDP7NYp9pVQm6zZca8C0VWDDalVpJ4wvmT2nak0cDx2hteU0ArhNh0Qjm5QB
	 Cn5jkO82HcE4zNghvVHfbhkrJbk8N+pBNpq/6zsFjVQKFo/qVF7Uctl3UbjqtXAOO5
	 d4yL3X+9lTbV77w5qZ+yVlai2y3nMSuZOf3WuT7e3WFhEd+As0ig4bPiz+zIATatrc
	 jR2dSOjxZQHzIPqggChd/oU1FMpivmtGUgxjAU3DNX778IY8rNjtmuf/SlCklr9+NV
	 GaumMQCOZA/yrk5XL8k0ISpcv/Xz9QIrr+r0N69msZ0wk2X0NMFvo3U/NuoV7cy0y5
	 +gNPAjw06tFxQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50C26n2921606720
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Jan 2025 10:06:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 12 Jan 2025 10:06:49 +0800
Received: from [127.0.1.1] (172.16.16.103) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 12 Jan
 2025 10:06:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fiona Klute <fiona.klute@gmx.de>, Ping-Ke Shih <pkshih@realtek.com>,
        <linux-wireless@vger.kernel.org>
CC: Vasily Khoruzhick <anarsoul@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Ondrej Jirman <megi@xff.cz>, Fiona Klute <fiona.klute@gmx.de>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw88: sdio: Fix disconnection after beacon loss
In-Reply-To: <20250106135434.35936-1-fiona.klute@gmx.de>
References: <20250106135434.35936-1-fiona.klute@gmx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <b80d58db-7ac8-417e-8c07-d14bca7c46e8@RTEXMBS04.realtek.com.tw>
Date: Sun, 12 Jan 2025 10:06:48 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Fiona Klute <fiona.klute@gmx.de> wrote:

> This is the equivalent of 28818b4d871bc93cc4f5c7c7d7c526a6a096c09c
> "wifi: rtw88: usb: Fix disconnection after beacon loss" for SDIO
> chips. Tested on Pinephone (RTL8723CS), random disconnections became
> rare, instead of a frequent nuisance.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> Tested-by: Vasily Khoruzhick <anarsoul@gmail.com> # Tested on Pinebook
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

fb2fcfbe5eef wifi: rtw88: sdio: Fix disconnection after beacon loss

---
https://github.com/pkshih/rtw.git


