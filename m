Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B3946BEEA
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 16:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbhLGPOT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 10:14:19 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57680 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbhLGPNs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 10:13:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 076B2CE1B75
        for <linux-wireless@vger.kernel.org>; Tue,  7 Dec 2021 15:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99596C341CA;
        Tue,  7 Dec 2021 15:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638889815;
        bh=TpCeGBjQ3MUWVEA4q7VntxzPfqsdrgI5h/iHZsSD7fc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=BtiDYtKPoZuZdaSwVe+gVAmimmwPUBzF65uJ4fBsuhfHSS0CiQBJBVK0xYlWUAY/6
         WbqO+EgJx9HrUBE9ctkmr5PInYoxuyH35oSydaGvVaJbI7sDuvCvTN0KX+WWuUmGLl
         5BPbbQpIEmVpvveN8v5i/XhNiVsI9Z20DiSdXSjjRwC+/m4z4I8tGyWHFuFCsOsWRc
         BBlPkhiCGohWi+kHgh0wEnD7MwlAshMweAin6VTJfTNwgeehlv2KCUwN3mmIsbKNo+
         IZU2IzHuBzTDXxsbLjoyh+4iuZqw93Tmf3Hx0GVIGShdpuRH61kduybG1lTI6t5H+v
         FMoYP1PNRL/jA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] ath10k: Fix the MTU size on QCA9377 SDIO
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211124131047.713756-1-festevam@denx.de>
References: <20211124131047.713756-1-festevam@denx.de>
To:     Fabio Estevam <festevam@denx.de>
Cc:     kvalo@codeaurora.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, wgong@codeaurora.org,
        Fabio Estevam <festevam@denx.de>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163888981163.18601.16356465928600024719.kvalo@kernel.org>
Date:   Tue,  7 Dec 2021 15:10:13 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fabio Estevam <festevam@denx.de> wrote:

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
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

09b8cd69edcf ath10k: Fix the MTU size on QCA9377 SDIO

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211124131047.713756-1-festevam@denx.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

