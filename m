Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC67640D0D
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Dec 2022 19:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiLBSYv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Dec 2022 13:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiLBSYu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Dec 2022 13:24:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D25CCEFB8
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 10:24:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C27D7B80A09
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 18:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0A1C433D6;
        Fri,  2 Dec 2022 18:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670005487;
        bh=daFI3VrqJ1nxDaMH4ZCDmVBTFhL9mnMuXznIP5kTJ/g=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=W2lyL0VGcY4Ji15/vMmd/Y43cIiQn05WSZ7EP3qeqeg2NXexle/dhSlwf6U10JiYJ
         r54RZlxCKngzGoHJLVAPjNrRzPnd2yydl7azuL3KAJ16k9LnSXIQqLOR2Rz+apsuvy
         PM/L/IO7zT/iN3RHy/3jYfEbyMTl+8SWNCBOWnao6wnAisy9iW0f6sBfncMRJtVJAI
         Ya6Uh74NuUxyDKUlhsjTZN9kLblyXyy5cUGueUg0aG76FxiiE7xDsNKrKnNhTX3Vfo
         KagHHr9enK6XH20wrhkvZIuahD7Yssw3ntlrELZGihYtmDFoheoHMt8tqulWwPxfYO
         dkMy+BSmHEsjQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath10k: fix QCOM_SMEM dependency
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221202103027.25974-1-kvalo@kernel.org>
References: <20221202103027.25974-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167000548228.19912.958966715275438470.kvalo@kernel.org>
Date:   Fri,  2 Dec 2022 18:24:46 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Nathan noticed that when HWSPINLOCK is disabled there's a Kconfig warning:
> 
>   WARNING: unmet direct dependencies detected for QCOM_SMEM
>     Depends on [n]: (ARCH_QCOM [=y] || COMPILE_TEST [=n]) && HWSPINLOCK [=n]
>     Selected by [m]:
>     - ATH10K_SNOC [=m] && NETDEVICES [=y] && WLAN [=y] && WLAN_VENDOR_ATH [=y] && ATH10K [=m] && (ARCH_QCOM [=y] || COMPILE_TEST [=n])
> 
> The problem here is that QCOM_SMEM depends on HWSPINLOCK so we cannot select
> QCOM_SMEM and instead we neeed to use 'depends on'.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/all/Y4YsyaIW+CPdHWv3@dev-arch.thelio-3990X/
> Fixes: 4d79f6f34bbb ("wifi: ath10k: Store WLAN firmware version in SMEM image table")
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to wireless-next.git, thanks.

d03407183d97 wifi: ath10k: fix QCOM_SMEM dependency

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221202103027.25974-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

