Return-Path: <linux-wireless+bounces-1893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E923382D1F4
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jan 2024 20:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C6D1C209CA
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jan 2024 19:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E968D10796;
	Sun, 14 Jan 2024 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW1MSQCi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2AD101D2
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jan 2024 19:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25EEC433C7;
	Sun, 14 Jan 2024 19:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705259404;
	bh=sfiQpP7+TDJLTjHNyWr8gkkCmSbQwzFSm+rs+Rr8xm0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=TW1MSQCi0shp9NgzbBR8PjuoXarhIHO7RSYyOYdQznkk5Pn2iNctWgOTo4O0tOTAI
	 1aYY87AXN5Hfvf3eF3FquVx+oqkSLXbe3fyMEBOaNtniYWq9mkqFdB3z8K1zdrne5W
	 EMcRUMvdmb43ooZ3vVsglBt19SiGW9WWwxMIEOC1wrgadDnLLy/0nc0oPkHklxvJSc
	 mc+wWs8HW96PuCOVxr3jjWTGpCvELdNCPuA+wElaKq+sT1c2ImWIeGGVfCP6XFmzcc
	 BhsyivQ721h+Qixd2SiAnPk/4FWzu8x7zwGanKJA3uOQnYDRi6Ex84XeUNhBLRMxOR
	 ZDz3kQ3PdlNdA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/2] wifi: rtl8xxxu: add cancel_work_sync() for
 c2hcmd_work
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240111163628.320697-2-martin.kaistra@linutronix.de>
References: <20240111163628.320697-2-martin.kaistra@linutronix.de>
To: Martin Kaistra <martin.kaistra@linutronix.de>
Cc: linux-wireless@vger.kernel.org, Jes Sorensen <Jes.Sorensen@gmail.com>,
 Ping-Ke Shih <pkshih@realtek.com>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170525940101.1549893.9097725363739190681.kvalo@kernel.org>
Date: Sun, 14 Jan 2024 19:10:02 +0000 (UTC)

Martin Kaistra <martin.kaistra@linutronix.de> wrote:

> The workqueue might still be running, when the driver is stopped. To
> avoid a use-after-free, call cancel_work_sync() in rtl8xxxu_stop().
> 
> Fixes: e542e66b7c2e ("rtl8xxxu: add bluetooth co-existence support for single antenna")
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

1213acb478a7 wifi: rtl8xxxu: add cancel_work_sync() for c2hcmd_work
ece90a862232 wifi: rtl8xxxu: enable channel switch support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240111163628.320697-2-martin.kaistra@linutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


