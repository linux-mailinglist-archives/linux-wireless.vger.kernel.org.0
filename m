Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241E16F2308
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Apr 2023 07:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjD2FN5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Apr 2023 01:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjD2FNz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Apr 2023 01:13:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0D32706
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 22:13:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54AA860B3B
        for <linux-wireless@vger.kernel.org>; Sat, 29 Apr 2023 05:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7EDC433D2;
        Sat, 29 Apr 2023 05:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682745233;
        bh=r5E86GbWJoJSovVkNlKmvYTpBcDKf9qHb5WfgtRMnPU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AkqJM+UZ3+8pA/CHuwgCuvbc2YkQmbPyqgdP/+NN815bVfV72mcp58BJoA9d9fDx6
         l5eyFs3T8Rz5cIvnjxrH8xotThEpDRpVxxm9VU/g1pavD0qSGgwTEDxlc3VCrGWJ+d
         0kb4gjThSlv0eg9RJyqh4ZxLiwibr5ZHG0QTUEXDh20+YbjL0j69wJdlvc/tU82twQ
         fSlv8WCDFeZkg23UiW5Y1UYFIPR+D+s/krPFlYHkcZuk2g7aGqgW8W9DypNp8h/dKl
         PktU8PXhLCDUEPzIHbRvimQgHSqQN14qHY3xarNpONueVkCaK02KB2+XeRLBklffgG
         JKqaimEqqaZmQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: Use msdu_end to check MCBC
References: <20230427013021.29792-1-quic_bqiang@quicinc.com>
Date:   Sat, 29 Apr 2023 08:13:48 +0300
In-Reply-To: <20230427013021.29792-1-quic_bqiang@quicinc.com> (Baochen Qiang's
        message of "Thu, 27 Apr 2023 09:30:21 +0800")
Message-ID: <87zg6rqnhv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
> Change to get it from msdu_end.
>
> Tested-on: WCN7850 hw2.0 PCI
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/hal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath12k/hal.c
> b/drivers/net/wireless/ath/ath12k/hal.c
> index 0ec53afe9915..980ec2024b37 100644
> --- a/drivers/net/wireless/ath/ath12k/hal.c
> +++ b/drivers/net/wireless/ath/ath12k/hal.c
> @@ -889,8 +889,8 @@ static u8
> *ath12k_hw_wcn7850_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
>  
>  static bool ath12k_hw_wcn7850_rx_desc_is_mcbc(struct hal_rx_desc *desc)
>  {
> -	return __le32_to_cpu(desc->u.wcn7850.mpdu_start.info6) &
> -	       RX_MPDU_START_INFO6_MCAST_BCAST;
> +	return __le32_to_cpu(desc->u.wcn7850.msdu_end.info5) &
> +	       RX_MSDU_END_INFO5_DA_IS_MCBC;

New warnings:

drivers/net/wireless/ath/ath12k/hal.c:892:16: warning: cast to restricted __le32
drivers/net/wireless/ath/ath12k/hal.c:892:16: warning: cast from restricted __le16

Please remember always run ath12k-check (with sparse installed).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
