Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762F35FAEB0
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 10:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJKIrl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 04:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiJKIri (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 04:47:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776F77437E
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 01:47:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1325D6114C
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 08:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63D5C433B5;
        Tue, 11 Oct 2022 08:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665478048;
        bh=saxwjGV6hGTefLrXaszgH3oibC7+Saqip5+hLH2o8I8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=F7jlc94pkNG+shZJ1+jRgxWaC1FnONUOcMfJhsEpEQDux021GPLBIvmkgsvOvAP4V
         NZocqz49Ex4FnT4/5Rm99Ewdb7iTGYEHZO3eMxGDDO2Cw7Kj+Rb247faRYK1J4XbHu
         9RYLLhBkcXkXhtz7Qkc2m/Q8Atk75RiwOKEL9Ks2hU379QubU+JAqZvhkNl/7o01yr
         nQqBSf7ggc8DqOXaaA8A6e+wtHAl2WX7LLnCpUeRVYhCf2/caQXscwcA4bFDMSeT25
         Q7/M7sp0IMaO8JZJqje5rt8vrjeUuQ4BQxsd7vyHI2U1zKI78Z2yskzPLQBS4OghMH
         w5Y5wl/5lL3Kg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v6.1] wifi: ath11k: mac: fix reading 16 bytes from a region of
 size 0 warning
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221010160638.20152-1-kvalo@kernel.org>
References: <20221010160638.20152-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166547804564.14345.9360761569012199041.kvalo@kernel.org>
Date:   Tue, 11 Oct 2022 08:47:27 +0000 (UTC)
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
> Linaro reported stringop-overread warnings in ath11k (this is one of many):
> 
> drivers/net/wireless/ath/ath11k/mac.c:2238:29: error: 'ath11k_peer_assoc_h_he_limit' reading 16 bytes from a region of size 0 [-Werror=stringop-overread]
> 
> My further investigation showed that these warnings happen on GCC 11.3 but not
> with GCC 12.2, and with only the kernel config Linaro provided:
> 
> https://builds.tuxbuild.com/2F4W7nZHNx3T88RB0gaCZ9hBX6c/config
> 
> I saw the same warnings both with arm64 and x86_64 builds and KASAN seems to be
> the reason triggering these warnings with GCC 11.  Nobody else has reported
> this so this seems to be quite rare corner case. I don't know what specific
> commit started emitting this warning so I can't provide a Fixes tag. The
> function hasn't been touched for a year.
> 
> I decided to workaround this by converting the pointer to a new array in stack,
> and then copying the data to the new array. It's only 16 bytes anyway and this
> is executed during association, so not in a hotpath.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Link: https://lore.kernel.org/all/CA+G9fYsZ_qypa=jHY_dJ=tqX4515+qrV9n2SWXVDHve826nF7Q@mail.gmail.com/
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to wireless.git, thanks.

abf93f369419 wifi: ath11k: mac: fix reading 16 bytes from a region of size 0 warning

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221010160638.20152-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

