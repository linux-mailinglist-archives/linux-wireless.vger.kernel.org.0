Return-Path: <linux-wireless+bounces-25637-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3BEB09B3C
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 08:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2CB188DC72
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 06:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D4A1E521B;
	Fri, 18 Jul 2025 06:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="A7RwwXQg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E141552FD
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752819521; cv=none; b=SjvkEdFNtyDxeJeywVTJnmbCwqn2WEULDoPZ5dvQjEc78kROzszJ2pQ1sWZFmAXQIakzdr4d8xmXg+TJLp+poS8Ou54VTa5pwfDYHV1d2ZoBYaXYr7UJsmTGq3UIoCk8aGA0LPBBLdMpQWuUAK1ksf49EpPILPFyIgdEm7sUaT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752819521; c=relaxed/simple;
	bh=pRGMVnhZzWrQn8HP3PSWaQkQ4qVGoNSJqWuKHNqrkuI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=JWtNyCmkTW3kzHSzDnOkyxD1+JOIT9KCqW6rQk7SM/lD7/wD8kfk0Jw8TAbj7whW8cxxBnoofjTvfLtVrOv065NxMrjbQfocyzf3DIHTcuaXlcpHydgEHee2bnG5uXLrfSBrXTrpUlXS1m5BNfIp9zq8IWFDr5+jQPryeudIn6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=A7RwwXQg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56I6IaGtA1135474, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752819516; bh=l4T0teDVADnYdlxdObHUdBBfZhMod7i/dch8QPY+FFQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=A7RwwXQg1L/VIlUrADDCiz9FPmOakmyBZQN3fBpJXt9wZDRcjYElNpDA1hyziTmCy
	 B3AVG3CfobtQykAjR3o9/F0wVmoVa7Y0jxn8WL4wo7fkwZJF/em5lk9IT7C+YbtE8h
	 vraQFUg1sBymYR/yKYcYmAv0lYl2YlMkGfHa6+FZOFC1pZ0iQQ9LjtBkSGsQHPi6Ic
	 PtThLDliLLSxZvlcNy7A4juQYjKQGLl+0It8F+enn95rnDU3q202K5NEeLXclY9+xv
	 F7J40Vrb8rpl8xXhMoThs+M6jZ619IQudLmJXN4LLSZk+tGZD2uD1zTj9kPSWbdr9N
	 U8KuUs1bj88bg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56I6IaGtA1135474
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 14:18:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Jul 2025 14:18:36 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 18 Jul
 2025 14:18:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <damon.chen@realtek.com>
Subject: Re: [PATCH rtw-next 1/5] wifi: rtw89: trigger TX stuck if FIFO full
In-Reply-To: <20250715035259.45061-2-pkshih@realtek.com>
References: <20250715035259.45061-1-pkshih@realtek.com> <20250715035259.45061-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <bedb24c2-4b19-4e91-b7bb-a07c32482c8f@RTEXMBS04.realtek.com.tw>
Date: Fri, 18 Jul 2025 14:18:35 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chia-Yuan Li <leo.li@realtek.com>
> 
> In order for the situation where the dispatcher blocking
> causes HAXIDMA to be unable to TX to be reported as
> a TX stuck, so that subsequent recovery can be handled.
> 
> Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patch(es) applied to rtw-next branch of rtw.git, thanks.

cbf510e21e0c wifi: rtw89: trigger TX stuck if FIFO full
8552f2b3153e wifi: rtw89: mac: reduce PPDU status length for WiFi 6 chips
b552a3ef8a3d wifi: rtw89: dynamically update EHT preamble puncturing
f1000385d47b wifi: rtw89: purge obsoleted scan events with software sequence number
8b4a02773881 wifi: rtw89: check path range before using in rtw89_fw_h2c_rf_ps_info()

---
https://github.com/pkshih/rtw.git


