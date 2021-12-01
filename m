Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC1B464FA1
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 15:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349935AbhLAOba (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 09:31:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38364 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349928AbhLAOao (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 09:30:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FC8BB81F4B
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 14:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6095AC53FAD;
        Wed,  1 Dec 2021 14:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638368835;
        bh=cABx7SjPkF7eMidshLb5+U7AF+87bMcGUj3Fg4iQhYA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=igHWq+zfP6VtYDxqML3FvR+5Z14u1Mce7zWLeCHoOYz5OdbxZPRkzJ+tpM6km3u+G
         aF8/eKwr4gvx4P+hVRVzZBLTuQnfNW+D/Kb8yXEzBftY1qcW3krXUpMUlbrSxJ7cfr
         S51OUhoF4WR/Xx5c/gx2DlkgjgWOwGPH2QuVdXcjEsZlYbF9B+VfBQeDFDwMgrK0TD
         Sjmt3fMpmOcor8JExeYlcMfhliuBOHKlIJHTbt+23KNe1gUxwAxVUfVpcpKkEN0+AB
         mVhj91WETrU4Uqu29YdbFsRBTKg2EWZsPmYvsK18RHnVEi5B0QszimEj5ustSFiYqm
         gkmpWOOqrAL3Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Fabio Estevam <festevam@denx.de>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong@codeaurora.org
Subject: Re: [PATCH v3] ath10k: Fix the MTU size on QCA9377 SDIO
References: <20211124131047.713756-1-festevam@denx.de>
Date:   Wed, 01 Dec 2021 16:27:07 +0200
In-Reply-To: <20211124131047.713756-1-festevam@denx.de> (Fabio Estevam's
        message of "Wed, 24 Nov 2021 10:10:47 -0300")
Message-ID: <87sfvcl7t0.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fabio Estevam <festevam@denx.de> writes:

> On an imx6dl-pico-pi board with a QCA9377 SDIO chip, simply trying to
> connect via ssh to another machine causes:
>
> [   55.824159] ath10k_sdio mmc1:0001:1: failed to transmit packet, dropping: -12
> [   55.832169] ath10k_sdio mmc1:0001:1: failed to submit frame: -12
> [   55.838529] ath10k_sdio mmc1:0001:1: failed to push frame: -12
> [   55.905863] ath10k_sdio mmc1:0001:1: failed to transmit packet, dropping: -12
> [   55.913650] ath10k_sdio mmc1:0001:1: failed to submit frame: -12
> [   55.919887] ath10k_sdio mmc1:0001:1: failed to push frame: -12
>
> , leading to an ssh connection failure.
>
> One user inspected the size of frames on Wireshark and reported
> the followig:
>
> "I was able to narrow the issue down to the mtu. If I set the mtu for
> the wlan0 device to 1486 instead of 1500, the issue does not happen.
>
> The size of frames that I see on Wireshark is exactly 1500 after
> setting it to 1486."
>
> Clearing the HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE avoids the problem and
> the ssh command works successfully after that.
>
> Introduce a 'credit_size_workaround' field to ath10k_hw_params for
> the QCA9377 SDIO, so that the HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE
> is not set in this case.
>
> Tested with QCA9377 SDIO with firmware WLAN.TF.1.1.1-00061-QCATFSWPZ-1.
>
> Fixes: 2f918ea98606 ("ath10k: enable alt data of TX path for sdio")
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v2:
> - Set the credit_size_workaround field as true for QCA9377 SDIO.
>
>  drivers/net/wireless/ath/ath10k/core.c | 4 +++-
>  drivers/net/wireless/ath/ath10k/hw.h   | 3 +++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
> index 72a366aa9f60..8a325ae97b0e 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -571,6 +571,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
>  		.ast_skid_limit = 0x10,
>  		.num_wds_entries = 0x20,
>  		.uart_pin_workaround = true,
> +		.credit_size_workaround = true,

I prefer to have also the false cases for every hardware so in the
pending branch I added those:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=afbf52bffb36bc25e7a1e81e1f975bb75696d3c8

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
