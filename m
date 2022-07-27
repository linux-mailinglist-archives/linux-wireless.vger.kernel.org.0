Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5E55823C6
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jul 2022 12:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiG0KGR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 06:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiG0KGQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 06:06:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BD1B1C2
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 03:06:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25C0CB82008
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 10:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967A2C433D7;
        Wed, 27 Jul 2022 10:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658916372;
        bh=QqP7uJQPlIk1uVP+bYHOzL1entRg1wr04Poei7FAjX8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=EXaj1GZSUQFyMelddoAM/DYcCj4ULi5Z62GSUup8wye4LDWN8FRFTgUnNMR4xrqKZ
         /Gs8ewklR9MNJH/BF5caGkEvurFxPzx7IVpW+FKDKMY0pYIg5XybTCw0cMokD5fG8i
         s7ja0YAcoRWO9f98pZkWEiZY1WTJS8lNZk6kLVYzaHII3gW8gfLU52ZFSm4cPoRqkv
         eKANEFmjIRAF6j9SWl940iLP0kGjxzNQx3sOIRbhmURtLnb36KcFqFwCvEjh5r6TzQ
         u4ca6uUlIoCNxaxzJgZcuUuxGHwBgcKfB2IZ8rLae0UruL1G8h5IrX80U9A/+NJ8Sn
         lZ1rkjBkzu2SQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fix register write failure on QCN9074
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220608062954.27792-1-quic_mpubbise@quicinc.com>
References: <20220608062954.27792-1-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        Maxime Bizon <mbizon@freebox.fr>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165891636653.18387.14150045468188764767.kvalo@kernel.org>
Date:   Wed, 27 Jul 2022 10:06:11 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> wrote:

> Commit 56c8ccf331bd ("ath11k: Add register access logic for WCN6750")
> regressed QCN9074. With the above mentioned commit, writes are failing
> for some registers on QCN9074 although the device seems to work
> normally.
> 
> ath11k_pci 0000:03:00.0: failed to set pcie link register0x01e0e0a8: 0xffffffff != 0x00000010
> ath11k_pci 0000:03:00.0: failed to set sysclk: -110
> 
> PCIe devices in ath11k (QCA6390, WCN6855, QCN9074, WCN6750) use window
> concept for register accesses. There are two schemes, dynamic & static
> window.
> 
> In dynamic window scheme, a single window(region in the BAR) is mapped
> either to CE or DP register windows at any give time. QCA6390 & WCN6855
> follow this scheme for register accesses.
> 
> In static window scheme, CE & DP register windows are statically mapped
> to separate regions with in the BAR so that there is no switching of
> register windows between CE & DP register accesses. QCN9074 & WCN6750
> follow this scheme although the window start offsets are different for
> QCN9074 & WCN6750.
> 
> QCN9074 uses 3rd & 2nd window for DP & CE register accesses respectively
> whereas WCN6750 uses 1st & 2nd window for DP & CE. In QCN9074, along with
> 2nd & 3rd windows, 1st window is also used for certain configurations
> which commit 56c8ccf331bd ("ath11k: Add register access logic for WCN6750")
> did not account for and hence the regression.
> 
> Fix this by going back to the original way of accessing the registers on
> QCN9074. Since this diverges from WCN6750 way of accessing registers, it
> is required to register window_read32/window_write32() pci_ops for WCN6750.
> We can also get rid of dp_window_idx & ce_window_idx members in hw_params,
> so remove them.
> 
> Also add a new API ath11k_pcic_register_pci_ops() for registering pci_ops
> to the ath11k core. This API checks for mandatory pci_ops() and reports
> error if those are missing. Also initialize unused pci_ops to NULL.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 56c8ccf331bd ("ath11k: Add register access logic for WCN6750")
> Reported-by: Maxime Bizon <mbizon@freebox.fr>
> Tested-by: Maxime Bizon <mbizon@freebox.fr>
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

867f4eeee862 wifi: ath11k: Fix register write failure on QCN9074

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220608062954.27792-1-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

