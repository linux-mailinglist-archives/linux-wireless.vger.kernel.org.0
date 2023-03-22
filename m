Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CDE6C46EA
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 10:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCVJsv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 05:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjCVJs0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 05:48:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC75420F
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 02:47:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5537761FD1
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 09:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975CEC433EF;
        Wed, 22 Mar 2023 09:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679478452;
        bh=4HxVDzNfjJY6dkkmlEkbzo3As/3oTHbN33xG/hJluJA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=B89Bbu6J/lWiotayPnDPHVfNeTGCqT/v8CLDJNXh7t4dXICawD5rAZJAuGXOzoczm
         IaUasWhyHp7kkhzPGlS/F9UrBi08wn+rfdsNyHeZZEJbgFUI+A0PiXYim98KDZqK3D
         ISfD64TML64uBjBYcbEuLltbGLKz7iAcLIXUUSZGgf9HEN+g0MkrlRzerluGATybXe
         VlBUEhqrkR5GyKYY+UwvIwS1t93oskYFpfC+o0RJySxERhhuji8gP6TakiAvKsIjX6
         f6/xtRiQLKPuIPLBdGqY4LlGcdNxFJoutkHupcE5MRB37Yahq7+3f/dmN6dVr1iCd5
         xXoiLQrzOOyzw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: fix BUFFER_DONE read on monitor ring rx
  buffer
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230309164434.32660-1-quic_hprem@quicinc.com>
References: <20230309164434.32660-1-quic_hprem@quicinc.com>
To:     Harshitha Prem <quic_hprem@quicinc.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167947844748.8844.13661658322623444104.kvalo@kernel.org>
Date:   Wed, 22 Mar 2023 09:47:31 +0000 (UTC)
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Harshitha Prem <quic_hprem@quicinc.com> wrote:

> Perform dma_sync_single_for_cpu() on monitor ring rx buffer before
> reading BUFFER_DONE tag and do dma_unmap_single() only after device
> had set BUFFER_DONE tag to the buffer.
> 
> Also when BUFFER_DONE tag is not set, allow the buffer to get read
> next time without freeing skb.
> 
> This helps to fix AP+Monitor VAP with flood traffic scenario to see
> monitor ring rx buffer overrun missing BUFFER_DONE tag to be set.
> 
> Also remove redundant rx dma buf free performed on DP
> rx_mon_status_refill_ring.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

68e93ac5a31d wifi: ath11k: fix BUFFER_DONE read on monitor ring rx  buffer

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230309164434.32660-1-quic_hprem@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

