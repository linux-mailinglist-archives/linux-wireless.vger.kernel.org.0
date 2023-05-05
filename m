Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67EC6F83D4
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 15:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjEENWA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 May 2023 09:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjEENV7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 May 2023 09:21:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B331E1F490
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 06:21:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B5BE63E14
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 13:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D96C433D2;
        Fri,  5 May 2023 13:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683292917;
        bh=HcqxHOun+ldbY6nh4o6lZNFHceYBOx2rf7QWpaVUt38=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=PB1PexEP983bQiVIC8yrkkhY0BfaFq8TXGZv8ipZ2cOWHRVEH9Z5wY0hXIvo0y1Gh
         EYtMU/EKjKm8CUa1soGExVx1cF8UShzxsfxAdRDNB7RXELMDrQBALtW0GSg0nmx8Fc
         U4vVoHczOnmNT6o+ZtoJQNhI3yMX/3KHo13fW3wudTceRScBlEGw+Qce80tXmCwCmn
         OX6SXOQiqeMc40ypjYRWguS4fPAr8aSOjvXCtQxG3B+bOlAAX5hbcDFi5eCEZEL/90
         LSU94T5Ev4elV+x94jd1cMPyUDilczvpT3XRftBMv1Cq9b9WCDcYrj7bwiDCZ2rtQG
         thKUfHDHmI5Uw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Cc:     ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Aishwarya R <quic_aisr@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: increase vdev setup timeout
References: <20230428091041.20033-1-quic_rgnanase@quicinc.com>
Date:   Fri, 05 May 2023 16:21:52 +0300
In-Reply-To: <20230428091041.20033-1-quic_rgnanase@quicinc.com> (Ramya
        Gnanasekar's message of "Fri, 28 Apr 2023 14:40:41 +0530")
Message-ID: <87354aq5fz.fsf@kernel.org>
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

Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:

> From: Aishwarya R <quic_aisr@quicinc.com>
>
> When vdev start/stop happens, response from firmware is received with delay
> and hence there is a timeout before VDEV can be up/down.
> Also, with maximum peers connected and when vdev stop occurs, firmware
> will take time to clean up all the peers and vap queues.
> In such cases as well, vdev start/stop response is sent by firmware with delay.
>
> Increase the vdev setup timeout as recommended by firmware team.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-02903-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Aishwarya R <quic_aisr@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 2 ++
>  drivers/net/wireless/ath/ath12k/wmi.h | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 8c401145a221..d720d95eba96 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -771,6 +771,8 @@ static int ath12k_mac_vdev_setup_sync(struct ath12k *ar)
>  	if (test_bit(ATH12K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))
>  		return -ESHUTDOWN;
>  
> +	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "ath12k vdev setup timeout %d\n",
> +		   ATH12K_VDEV_SETUP_TIMEOUT_HZ);

There's no reason to have string "ath12k" in the debug message so I
removed that in the pending branch. I also added an empty line after the
debug message.

No need to resend because of these.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
