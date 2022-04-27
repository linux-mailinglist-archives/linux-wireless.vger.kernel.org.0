Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C390C511087
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 07:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357859AbiD0Ffo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 01:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiD0Ffl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 01:35:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA641A392;
        Tue, 26 Apr 2022 22:32:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83527B824AE;
        Wed, 27 Apr 2022 05:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B299C385A9;
        Wed, 27 Apr 2022 05:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651037548;
        bh=eYExc3IcRuFN+bZXf/jvEOc9j7k3Wa1qVp0FWo3fSbY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=PVUN3YP6FTcXStqJfdeiQd+80A81M6mVQ/TQ8yqYpXixc2HlfmBwcbRl0o3nO4Kc4
         rNey10o8VdVJTK7501dMPf1N5eezaTYvDoqukTPH3UdyunpzSOv2tVNa6rHUTZIT+o
         Yq291Nqb1GCTwqRQVfST0dxLqqcSPQ34Li6W33uBRQyFw07d90EJuEmil8ilrlXesr
         Iygerr/GCn76Z9V/MRuPstj8DeAImuWBS8bxKfyDrPTF4iYUv+FGTXRm+tbLJDIEGZ
         j080Jfn3by/rF09uRr+sOa5VhfmJTPvCepshVBoo+qM2dVukSSnUqWrS1/FDbu9CHW
         MuMyPUuxFi92g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
Subject: Re: [PATCH v2 12/19] ath11k: Datapath changes to support WCN6750
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
        <1642337235-8618-13-git-send-email-quic_mpubbise@quicinc.com>
Date:   Wed, 27 Apr 2022 08:32:23 +0300
In-Reply-To: <1642337235-8618-13-git-send-email-quic_mpubbise@quicinc.com>
        (Manikanta Pubbisetty's message of "Sun, 16 Jan 2022 18:17:08 +0530")
Message-ID: <87ilqvgkgo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> HAL RX descriptor for WCN6750 is same as QCN9074, so use
> the DP APIs of QCN9074 for WCN6750. There is one change
> wrt to REO configuration though, REO configuration for
> WCN6750 is same as WCN6855; Therefore, use reo_setup()
> of WCN6855 for WCN6750.
>
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/core.c |  1 +
>  drivers/net/wireless/ath/ath11k/hw.c   | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 347131a..f65347c 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -458,6 +458,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.num_vdevs = 16 + 1,
>  		.num_peers = 512,
>  		.supports_suspend = false,
> +		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),

You mention nothing about this change in the commit log, I'll add that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
