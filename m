Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B04A47347C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 19:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239828AbhLMS5W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 13:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbhLMS5W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 13:57:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC9CC061574
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 10:57:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6DECB8122C
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 18:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D71C34602;
        Mon, 13 Dec 2021 18:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639421839;
        bh=SyUiuPj3TkWDEPedMrUsU5igx8BzToBMowSTetsv8D8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=FoZvTw6LWojbmB4ZcWD2atvj1tiTSvFoWhdSKUo55jXyI1wU5gpU2i3m7ycCV7M6a
         Ukoj+Eu8+441AJyxFbyTUt6MfIoEySfKjNKtznJGVDlcDnQnYP9sRDmT4dxyRaRHsq
         wkDAEXWE+/34Tmzv7UdoE2/SC9sYd3ldguEc1G3NsXiFcFipPQzAGh5DnOmLLtvRCH
         1btn0RdgXg6SiMOvHvrZ5cf20DZOFn9GahZ3mURJCbFpD7H9w7YnqiqF3HTJ0qhiKa
         klF4KQYdXbvTfBrjZStBGjiUl77Lc2xgvAaD6TDGPSSglznveMgwGFlKGBaUiNroJA
         a7T4vZn+DnOuA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmfmac: Fix incorrect type assignments for keep-alive
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1638953708-29192-1-git-send-email-loic.poulain@linaro.org>
References: <1638953708-29192-1-git-send-email-loic.poulain@linaro.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-wireless@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163942183691.6700.15831682111724282439.kvalo@kernel.org>
Date:   Mon, 13 Dec 2021 18:57:18 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loic Poulain <loic.poulain@linaro.org> wrote:

> cpu_to_le16 has been used for all keep-alive fields, but 'perdio_msec'
> is a 32-bit field and 'keep_alive_id' a 8-bit one. Fix that.
> 
> Fixes: 7a6cfe28ae3e ("brcmfmac:  Configure keep-alive packet on suspend")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>

Patch applied to wireless-drivers-next.git, thanks.

78da5cca6ece brcmfmac: Fix incorrect type assignments for keep-alive

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1638953708-29192-1-git-send-email-loic.poulain@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

