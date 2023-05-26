Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013D97123B0
	for <lists+linux-wireless@lfdr.de>; Fri, 26 May 2023 11:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243158AbjEZJcK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 May 2023 05:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243090AbjEZJcI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 May 2023 05:32:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E487B3
        for <linux-wireless@vger.kernel.org>; Fri, 26 May 2023 02:32:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9D7964E87
        for <linux-wireless@vger.kernel.org>; Fri, 26 May 2023 09:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667FFC4339B;
        Fri, 26 May 2023 09:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685093526;
        bh=y/K1EmIoa3slmOujvbe2/SbxkjnvSTEeTtaX5VkJ+p8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=CJn/FCYxpSMDmdMxY4QeTgaNfSry0JtSNSvrVd83JCRawbKh4Xf0hhjlupcDworBs
         gdaPr9/FgBeT4/0D0NsjV0/C9Bm+3IG0CHKsg6wJPPvoELYLsSp2Zdz5knQfrorqTH
         Yvpgcui/DmQCyYELBIxYfm2UOwkEVk0mbahLNoQLsYtdKj3tQld5tMQAXjnia0HSf9
         KyC9HI8SgPCdRxtA23n9qN16oRl9F759fWOzJWFEClIyDL19d18EWsEHhH4B8iMfQv
         19XWD9aktnOe6rAg88F2x/02kK7UqrlPenh+exTfOeePfNtKfHETavtcC6bZ/gSVyd
         TvtW+V3+zmJyA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: ath12k: Use msdu_end to check MCBC
References: <20230509033638.3228-1-quic_bqiang@quicinc.com>
Date:   Fri, 26 May 2023 12:32:00 +0300
In-Reply-To: <20230509033638.3228-1-quic_bqiang@quicinc.com> (Baochen Qiang's
        message of "Tue, 9 May 2023 11:36:38 +0800")
Message-ID: <878rdbl9pr.fsf@kernel.org>
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

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> We are seeing a very low TCP throughput testing with some specific
> tools. This is because for sub-frames of an AMSDU, MCBC flag in
> mpdu_start may be not valid, and as a result those frames would be
> dropped by kernel.
>
> Add a new helper to get it from msdu_end.
>
> Since original helper is not used for now, add __maybe_unused
> attribute to make GCC happy.
>
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
> v2:
>  1. add a new helper according to Vasanth's comment.
>  2. change to use __le16_to_cpu instead of __le32_to_cpu
>
>  drivers/net/wireless/ath/ath12k/dp_rx.c | 13 ++++++++++---
>  drivers/net/wireless/ath/ath12k/hal.c   | 14 ++++++++++++++
>  drivers/net/wireless/ath/ath12k/hal.h   |  1 +
>  3 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index 8c8162fbe5c6..972034b7f159 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -193,13 +193,20 @@ static void ath12k_dp_rxdesc_set_msdu_len(struct ath12k_base *ab,
>  	ab->hw_params->hal_ops->rx_desc_set_msdu_len(desc, len);
>  }
>  
> -static bool ath12k_dp_rx_h_is_mcbc(struct ath12k_base *ab,
> -				   struct hal_rx_desc *desc)
> +static __maybe_unused bool ath12k_dp_rx_h_is_mcbc(struct ath12k_base *ab,
> +						  struct hal_rx_desc *desc)
>  {
>  	return (ath12k_dp_rx_h_first_msdu(ab, desc) &&
>  		ab->hw_params->hal_ops->rx_desc_is_mcbc(desc));
>  }

Using __maybe_unused is usually a bad idea, it should be used only on
very special cases.

But why do you leave struct hal_ops::rx_desc_is_mcbc? Nobody is using it
and we should not have dead code lying around.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
