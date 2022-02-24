Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888394C2799
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Feb 2022 10:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiBXJGW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Feb 2022 04:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiBXJGV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Feb 2022 04:06:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3BD189AA6
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 01:05:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7113B81C4A
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 09:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2947CC340E9;
        Thu, 24 Feb 2022 09:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645693549;
        bh=CC5AEFMLTxhckHWBk6hNVR6HRUe2MZlQmHha6NARgFs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=n9q/7wze2pqaRf1hOdY60Lg8OnOyrKuLq5mrIedNfqWb/6u5LwEAkaJAXD69lOQql
         1tYb9pNAuNMBh1FqdZYbiyLHbdtRRRjECR0Z5v1YvHSLEkoCAK/CzMejUdeVm746Dg
         Ft7WrfvXB8v88kDsCN8pJIXTKt+WDNcq6+X+3tahC/dLXmIT3IjA94O6xOJKZprECY
         NzB1bucdudP44mGrqs51OifgUhfZYU5X6aoWITxpNQOMErzUxVwMd0YUKWRctfwh6W
         qQDCIDOpjnMzQPNXpDQKP9/f4/CytMEdxBIcYu6EhiDmuWH9/f3DjrATXfyGyu9u46
         EAj4GyFnCZK2g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath10k: fix pointer arithmetic error in trace call
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220221122638.7971-1-franciman12@gmail.com>
References: <20220221122638.7971-1-franciman12@gmail.com>
To:     Francesco Magliocca <franciman12@gmail.com>
Cc:     ath10k@lists.infradead.org, dan.carpenter@oracle.com,
        rmanohar@qti.qualcomm.com, linux-wireless@vger.kernel.org,
        Francesco Magliocca <franciman12@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164569354432.30378.1243222511176407812.kvalo@kernel.org>
Date:   Thu, 24 Feb 2022 09:05:47 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Francesco Magliocca <franciman12@gmail.com> wrote:

> Reading through the commit history, it looks like
> there is no special need why we must skip the first 4 bytes
> in this trace call:
> 
> trace_ath10k_htt_rx_desc(ar, (void*)rx_desc + sizeof(u32),
>                          hw->rx_desc_ops->rx_desc_size - sizeof(u32));
> 
> found in the function ath10k_htt_rx_amsdu_pop in the file htt_rx.c
> 
> i think the original author
> (who is also the one who added rx_desc tracing capabilities
> in a0883cf7e75a) just wanted to trace the rx_desc contents,
> ignoring the fw_rx_desc_base info field
> (which is the part being skipped over).
> But the trace_ath10k_htt_rx_desc later added
> don't care about skipping it, so it may be good
> to uniform this call to the others in the file.
> But this would change the output of the trace and
> thus it may be a problem for tools that rely on it.
> Therefore I propose until further discussion
> to just keep it as it is and just fix the pointer arithmetic bug.
> 
> Add missing void* cast to rx descriptor pointer in order to
> properly skip the initial 4 bytes of the rx descriptor
> when passing it to trace_ath10k_htt_rx_desc trace function.
> 
> This fixes the pointer arithmetic error detected
> by Dan Carpenter's static analysis tool.
> 
> Fixes: 6bae9de622d3 ("ath10k: abstract htt_rx_desc structure")
> 
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00157-QCARMSWPZ-1
> 
> Signed-off-by: Francesco Magliocca <franciman12@gmail.com>
> Link: https://lore.kernel.org/ath10k/20220201130900.GD22458@kili/
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

49ffac5907a8 ath10k: fix pointer arithmetic error in trace call

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220221122638.7971-1-franciman12@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

