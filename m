Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6467D67A4
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 11:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbjJYJyu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 05:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjJYJyt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 05:54:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3923192
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 02:54:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B126FC433C8;
        Wed, 25 Oct 2023 09:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698227686;
        bh=yaAsiujagvZOvQ/PZwj5xUzfTRKtOWgXCQg/2408jBA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=m+tu1xFnEA69yPdgsePYfRs0i3vP7Lxr6ub4xdGpFSPPKNu1iDZBP6N7rXG83tZvL
         Zq2sgl/rpQvJu8qk7ABR0hNPAyCpr5ENBTkezMMwgEUXHflTeVfZYyb5iGtSUCMt06
         x/h76Ylb+so3oF9ZZV9AarumiUad/KPDN2F6C8jojq8UX4C3cWJ3d/wSKxQcLWTKdA
         R87jTfWBF54nB3ufllxIoWKUogEsSJ6/WPtSUXTJ5ROCbM7NDqw2vo8DDe942TLise
         W1OLTG0+UI+J3D8daZkfnQQB2um5XRP8qs9dwViO+J01sbwds7qmH7kPamzBWp/okK
         gR/Sq9vjVtOEQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 2/3] wifi: ath11k: qmi: refactor ath11k_qmi_m3_load()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230727100430.3603551-3-kvalo@kernel.org>
References: <20230727100430.3603551-3-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     mhi@lists.linux.dev, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169822768265.891844.9494809896760074747.kvalo@kernel.org>
Date:   Wed, 25 Oct 2023 09:54:45 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> Simple refactoring to make it easier to add firmware-2.bin support in the
> following patch.
> 
> Earlier ath11k_qmi_m3_load() supported changing m3.bin contents while ath11k is
> running. But that's not going to actually work, m3.bin is supposed to be the
> same during the lifetime of ath11k, for example we don't support changing the
> firmware capabilities on the fly. Due to this ath11k requests m3.bin firmware
> file first and only then checks m3_mem->vaddr, so we are basically requesting
> the firmware file even if it's not needed. Reverse the code so that m3_mem
> buffer is checked first, and only if it doesn't exist, then m3.bin is requested
> from user space.
> 
> Checking for m3_mem->size is redundant when m3_mem->vaddr is NULL, we would
> not be able to use the buffer in that case. So remove the check for size.
> 
> Simplify the exit handling and use 'goto out'.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

b49381d3de3a wifi: ath11k: qmi: refactor ath11k_qmi_m3_load()
7db88b962f06 wifi: ath11k: add firmware-2.bin support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230727100430.3603551-3-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

