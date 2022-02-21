Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529354BDFE2
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 18:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355690AbiBULJ5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 06:09:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348346AbiBULJq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 06:09:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBBF427E5
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 02:38:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 077D4B80F92
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 10:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E85AC340E9;
        Mon, 21 Feb 2022 10:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645439917;
        bh=k67oTdFxyxFIxvYJ9Sn6gF8YVh449cAmOqjQ8+8GbgQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=vRrgryJeNAKoZb19AT5jv/LYNeQClPvQBT2qVAU5/n8hoWfWffXPOSUwkUDTeCt1S
         e5FLvn+kMuI/MmVOE4ti1hNwolDhwnI1WoI74icB902bykFiofFqEZ1MjgpxF4KMUR
         HtUFyhkyfxRexQ0gE+YMaEsvWfccS9GUli/L6DNB1ODHjgr87mtg2cZdUCfsTWjfzz
         Zapq1Z0nPfnUhbJZmUvJ+tnnNcjDjeOJb5TNGV5Qp5nAd6Ob2p56zKRnDptSv9rvkB
         3HXeg/Syt8lDSgESAERVtrZCJ/A3Xac8sIZ4SKp35iZ690kvhWtrHHPwjQG0P1bam5
         YLJCiJUnsFevQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Francesco Magliocca <franciman12@gmail.com>
Cc:     ath10k@lists.infradead.org, dan.carpenter@oracle.com,
        rmanohar@qti.qualcomm.com,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath10k: fix pointer arithmetic error in trace call
References: <20220219113257.5459-1-franciman12@gmail.com>
Date:   Mon, 21 Feb 2022 12:38:33 +0200
In-Reply-To: <20220219113257.5459-1-franciman12@gmail.com> (Francesco
        Magliocca's message of "Sat, 19 Feb 2022 12:32:57 +0100")
Message-ID: <87r17wwlli.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

Francesco Magliocca <franciman12@gmail.com> writes:

> Reading through the commit history, it looks like
> there is no special need why we must skip the first 4 bytes
> in this trace call:
>
> trace_ath10k_htt_rx_desc(ar, (void*)rx_desc + sizeof(u32),
> 			 hw->rx_desc_ops->rx_desc_size - sizeof(u32));
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

Please submit v2 and CC also linux-wireless, otherwise patchwork won't
see the patch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
