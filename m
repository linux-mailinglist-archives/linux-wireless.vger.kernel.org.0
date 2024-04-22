Return-Path: <linux-wireless+bounces-6607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E948AC286
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 03:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281AB1C2083D
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 01:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38550ED9;
	Mon, 22 Apr 2024 01:26:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA971391
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 01:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713749169; cv=none; b=ICh01lpBTaZ95nkM9+2kXSf1bpzeurgcLfe0amTH+csOubst/FHAcl1qb+xCU+S7IE1X4UIVlXJyCQK6ZRQ66JoH2LyLGk1zUdr3D3Tma0491jMDzhdRKIWtsDbGXmG0cqkf1CS/vGEA9NR6W0vZJHrgjdqHwYmZQaLtxqWa0xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713749169; c=relaxed/simple;
	bh=s+dAu+iMBIJUX70IGqVUYRnKDHEG5Kr4h+OK/P5gpNQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=OQoEJFY1s+qo9fj9EbdnLc5Ujn6Ca0M25WoLj2VQvj6yWJmLANiJpyG3QDatnsr4GMhJ4ajvEj+i0nFaV04zFeAsbVPdFvkFiTpaiaXd5DWmA53c0Qk71r/PO4/xsSIGX7+NjkjNMLhRE4yUwjRrLuBoKdnEi5GCLNwk9jJCtdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43M1Q1BL03693001, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43M1Q1BL03693001
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 09:26:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 09:26:01 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 09:26:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH v3] wifi: rtl8xxxu: Add LED control code for RTL8723BU
In-Reply-To: <2e3b0b74-8bfc-4ff3-8a0c-ba1bbfa4d535@gmail.com>
References: <2e3b0b74-8bfc-4ff3-8a0c-ba1bbfa4d535@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <3b219f4b-edd0-4bd8-91f0-826265b939c2@RTEXMBS04.realtek.com.tw>
Date: Mon, 22 Apr 2024 09:26:01 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Software control (on/off) and hardware control (automatic blinking)
> tested with EDUP EP-N8568.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

Still warns:

  WARNING: Missing a blank line after declarations
  #28: FILE: drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c:1711:
  +	u8 ledcfg = rtl8xxxu_read8(priv, REG_LEDCFG2);
  +	ledcfg &= LEDCFG2_DPDT_SELECT;

Set patchset state to Changes Requested

[v3] wifi: rtl8xxxu: Add LED control code for RTL8723BU

---
https://github.com/pkshih/rtw.git


