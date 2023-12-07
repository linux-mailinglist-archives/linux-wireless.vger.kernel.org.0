Return-Path: <linux-wireless+bounces-549-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AB4808C23
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 16:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DEA128174D
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 15:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E8544C8D;
	Thu,  7 Dec 2023 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0d1vBL/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CE41D54E
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 15:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE7CC433C7;
	Thu,  7 Dec 2023 15:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701964057;
	bh=/ZDHgbY7Qojq5NSOaS3ODtQuPI8wdf01S4O6ylvQ4SI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=E0d1vBL/4aGpOEQtNh5W274I6t+fB4VirOSjzn/XML6rDD+UnjGgt3ohtFvMsmqNk
	 ULIKqdgiezEcVjB0XHj11u352aB1aytMQu4vUdVvuHkRoJ+aFKF4McyjRL4VEi1Qhl
	 xrFBVyfCJSKpeTDlKEeCrfFNDc4OlG4SZXUGmBUvnr2TNKnRInua8KVfQPBLX55c0Y
	 dLfr4vcVFqJaJGI9Zds4Yttd65AJ4Dl/0bW2mVjBTz6+GsqH5+yqLRrIneEjby7zWw
	 hDBvMB8lIsM50U0q+QYzni0m5RLobflwPK90M9v64AtEGugT6ItS5d1VUWSmrcEjlC
	 htfNe6paRjfsA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw89: avoid stringop-overflow warning
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231204073020.1105416-1-arnd@kernel.org>
References: <20231204073020.1105416-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Ching-Te Ku <ku920601@realtek.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170196405395.2897000.836367709392997740.kvalo@kernel.org>
Date: Thu,  7 Dec 2023 15:47:35 +0000 (UTC)

Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> After -Wstringop-overflow got enabled, the rtw89 driver produced
> two odd warnings with gcc-13:
> 
> drivers/net/wireless/realtek/rtw89/coex.c: In function 'rtw89_btc_ntfy_scan_start':
> drivers/net/wireless/realtek/rtw89/coex.c:5362:50: error: writing 1 byte into a region of size 0 [-Werror=stringop-overflow=]
>  5362 |                 wl->dbcc_info.scan_band[phy_idx] = band;
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> In file included from drivers/net/wireless/realtek/rtw89/coex.h:8,
>                  from drivers/net/wireless/realtek/rtw89/coex.c:5:
> drivers/net/wireless/realtek/rtw89/core.h:1441:12: note: at offset [64, 255] into destination object 'scan_band' of size 2
>  1441 |         u8 scan_band[RTW89_PHY_MAX]; /* scan band in  each phy */
>       |            ^~~~~~~~~
> drivers/net/wireless/realtek/rtw89/coex.c: In function 'rtw89_btc_ntfy_switch_band':
> drivers/net/wireless/realtek/rtw89/coex.c:5406:50: error: writing 1 byte into a region of size 0 [-Werror=stringop-overflow=]
>  5406 |                 wl->dbcc_info.scan_band[phy_idx] = band;
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> drivers/net/wireless/realtek/rtw89/core.h:1441:12: note: at offset [64, 255] into destination object 'scan_band' of size 2
>  1441 |         u8 scan_band[RTW89_PHY_MAX]; /* scan band in  each phy */
>       |            ^~~~~~~~~
> 
> I don't know what happened here, but adding an explicit range check
> shuts up the output.
> 
> Fixes: 89741e7e42f6 ("Makefile: Enable -Wstringop-overflow globally")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

ERROR: 'wifi:' prefix missing: '[PATCH] rtw89: avoid stringop-overflow warning'
ERROR: Failed to find commit id: Fixes: 89741e7e42f6 ("Makefile: Enable -Wstringop-overflow globally")

I can add the "wifi:" prefix but where can I find the commit 89741e7e42f6?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231204073020.1105416-1-arnd@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


