Return-Path: <linux-wireless+bounces-22424-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FCAAA8B19
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 04:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88A017082F
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 02:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D35318DB2B;
	Mon,  5 May 2025 02:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="nTabwhIS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186DBC2C9;
	Mon,  5 May 2025 02:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746411674; cv=none; b=rkJhCf5h8cI83vv/mQ/jDko1tn2GCBG0OpYlQrmpdzoiSF2n6bcI9Obs6H/MV0id8vXWM2Gp+8L3ikASMddwiuYq7YcIYePKi1tMJCr+HwoA+qZH/0d8x7FkRU6JUQ2byFU0uXJOyquHhnBtQpE+D8beDonBDmGCK+tvNVME3J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746411674; c=relaxed/simple;
	bh=Hs9uGhA2d6ZQuqVdnmtfV7sdzpnhGklyEq/S/uGIeEQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=RTJr4PAOHxEJgadpdjhRUPB6sUmuXrZoKcgzYhRP1M8KBv1twgleWW9xsnyrP13r00u8vuB6m0YSchS1YwSXQrx4Tc0hVszvng7zWOl59/LkELqNk7jbZVu+6WAB9qm0csfMr5Zgk+kI2GY/ZG4Ag1+GILExH7GiCyVvfZ0EjJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=nTabwhIS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5452L6fS43443253, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746411666; bh=Hs9uGhA2d6ZQuqVdnmtfV7sdzpnhGklyEq/S/uGIeEQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=nTabwhISYPx+xo2YY6ECn53oFxxUMK0jSdybrR/yHdS3pA5qQtTQXx3PGQZVERgIR
	 mOpQlMhhXUhZaxH1DPsRoIGPAH/Hgs/RPCWv+E/QTEn6Q4XgGJnAGxITvub3ZZg3mA
	 vEMIlx1zYW5FGXXG02FwRC/Vx/LJqqkeo+iOA8HmOPGTD+7lKqKzd1bdMsyUYbLfoI
	 sNF280NX32qQd1tQ6iqHdeTF87YqFdreoelBE1uZRWO0zC8zP5nIddPdPiUR9XltaN
	 2kf0g0noDFlmBnUCcsygMkFfkMnp4mka5x4xAI7/TqJJ4cEtP8xEwHnnkY9fBhga7i
	 +8DrJ1bk6KvCw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5452L6fS43443253
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 May 2025 10:21:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 May 2025 10:21:06 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 May
 2025 10:21:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
        Ping-Ke Shih
	<pkshih@realtek.com>
CC: Ondrej Jirman <megi@xff.cz>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rtw-next v3 1/2] wifi: rtw89: Convert rtw89_core_set_supported_band to use devm_*
In-Reply-To: <20250429122916.1734879-2-megi@xff.cz>
References: <20250429122916.1734879-1-megi@xff.cz> <20250429122916.1734879-2-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <d2bcabad-9b35-4efd-8fd5-e004b7ab4a28@RTEXMBS04.realtek.com.tw>
Date: Mon, 5 May 2025 10:21:05 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

=?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz> wrote:

> From: Ondrej Jirman <megi@xff.cz>
> 
> The code can be simplified by using device managed memory
> allocations. Simplify it.
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

145df52a8671 wifi: rtw89: Convert rtw89_core_set_supported_band to use devm_*
0ae36391c804 wifi: rtw89: Fix inadverent sharing of struct ieee80211_supported_band data

---
https://github.com/pkshih/rtw.git


