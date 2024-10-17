Return-Path: <linux-wireless+bounces-14166-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6659A298C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 18:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF971C27D25
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 16:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639851DF27F;
	Thu, 17 Oct 2024 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTnKiKDo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390C71DEFE5;
	Thu, 17 Oct 2024 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183829; cv=none; b=mtXqR/PlAEnTX0TpuDlHm0cxJyo8qqDwpg2tI6oho/59gkw1DKrJsbb+OrO/ats3Jq4CMWIbOOPX7wq0NAZXCa0aMJJsh6zFFVh9pr8HcnowbdQe13glv/Xm/rfp6vDdDR54gIc3dLUzGC3rT18EhejFcS2KSE/xPfUUvVkDsFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183829; c=relaxed/simple;
	bh=UllFQKr9ZAnWaE3xb2CQYdQk61oEW5zaZ5EFbiVCenM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=JnlguOvLMgr4EQI1q4oTZ8Wt/hyM6HeEOW6uCgmBY1xTsYyO39o4EhQisih8+NmhhrPIAcoQsJzE04Dlc2X1y3X3QhoEni1dvRLickrpQBX+m0Tw2dh7OGJx7Zdhf6qK2Up2cWsoJaBPin1Vl/bPsdg4OKiUPc8rctXowQbCR/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTnKiKDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8FFC4CEC3;
	Thu, 17 Oct 2024 16:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183828;
	bh=UllFQKr9ZAnWaE3xb2CQYdQk61oEW5zaZ5EFbiVCenM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=nTnKiKDosjmc+V0CmeMdJQ16bXQCuBHc7PHC8oMXv6fPfODNSOoF2FqoW1naK/kFG
	 W3ir8fKcGARiRqFMI4fNoCvaxo6trgW4CSdAW9QECKMxEyh2oF8Af/P+Cmj5kyhxTP
	 u7sV9/HwY+4aVHL3USy+cktpeYCXBhZC85SI6Xl19E60yplkPx+NHY7EkQo2uLUCgE
	 QBqH3yWZaCg+49AfqdyTOYVQBQtLcg/0sFKtT37iv75lObo0x9tw25+3re4pdvIsz+
	 lf9ODlUUi0jJK6SvGqBv08jfbittowgC1BYYFMTuj6k2aPXVAGQxSpadN03hBTECFp
	 ZOEDGhUQgc2gA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] wifi: mwifiex: Fix memcpy() field-spanning write
 warning in mwifiex_config_scan()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241007222301.24154-1-alpernebiyasak@gmail.com>
References: <20241007222301.24154-1-alpernebiyasak@gmail.com>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Francesco Dolcini <francesco@dolcini.it>,
 Johannes Berg <johannes.berg@intel.com>, Kees Cook <kees@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Dmitry Antipov <dmantipov@yandex.ru>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>,
 Brian Norris <briannorris@chromium.org>, David Lin <yu-hao.lin@nxp.com>,
 linux-hardening@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172918382395.970100.13551398619999494547.kvalo@kernel.org>
Date: Thu, 17 Oct 2024 16:50:25 +0000 (UTC)

Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:

> Replace one-element array with a flexible-array member in `struct
> mwifiex_ie_types_wildcard_ssid_params` to fix the following warning
> on a MT8173 Chromebook (mt8173-elm-hana):
> 
> [  356.775250] ------------[ cut here ]------------
> [  356.784543] memcpy: detected field-spanning write (size 6) of single field "wildcard_ssid_tlv->ssid" at drivers/net/wireless/marvell/mwifiex/scan.c:904 (size 1)
> [  356.813403] WARNING: CPU: 3 PID: 742 at drivers/net/wireless/marvell/mwifiex/scan.c:904 mwifiex_scan_networks+0x4fc/0xf28 [mwifiex]
> 
> The "(size 6)" above is exactly the length of the SSID of the network
> this device was connected to. The source of the warning looks like:
> 
>     ssid_len = user_scan_in->ssid_list[i].ssid_len;
>     [...]
>     memcpy(wildcard_ssid_tlv->ssid,
>            user_scan_in->ssid_list[i].ssid, ssid_len);
> 
> There is a #define WILDCARD_SSID_TLV_MAX_SIZE that uses sizeof() on this
> struct, but it already didn't account for the size of the one-element
> array, so it doesn't need to be changed.
> 
> Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> Acked-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-next.git, thanks.

d241a139c2e9 wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_config_scan()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241007222301.24154-1-alpernebiyasak@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


