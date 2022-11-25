Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EBA6388EC
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Nov 2022 12:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiKYLk0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Nov 2022 06:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKYLkZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Nov 2022 06:40:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DA0193C9
        for <linux-wireless@vger.kernel.org>; Fri, 25 Nov 2022 03:40:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3BB3623A5
        for <linux-wireless@vger.kernel.org>; Fri, 25 Nov 2022 11:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04363C433D6;
        Fri, 25 Nov 2022 11:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669376424;
        bh=DOrrhLoSridluknHWsDTp9LWzfwnL3Uj7q7jyBqzW/k=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=dD/4UzJhfd7h7XDpEaihTEP9Q5wE/LbPknLiz+1FebuW2+4dNiVzh4BVEIgqEwypG
         i+uh0DAiwKTw5sJLqIasuNGiX3v9hn2SCtThCWpe4/HYYr/EawAOeV34dn2ocv2oEn
         XxpwAbihRG3HTwbbCx3tspbi12NG1SlHdv+HPR9m7U6GqCa0GcnLirUUKRC7n2XZ2R
         QyTPnsxFd9ynrWgDWHShAjDbG5IsZ9gG7fIatTZzGbeNHkbcD8DrM7bhjfJhXlixWn
         x7z8LeF5sWllmtUhzMAMyFdmlJWMqr9Hg0+f0BM6Wb/n85CzqWyu0VWa0YceeEwVHf
         kQhS6yp5iIyaw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCHv2] wifi: ath11k: Fix race condition with
 htt_ppdu_stats_info
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221124071104.22506-1-quic_kathirve@quicinc.com>
References: <20221124071104.22506-1-quic_kathirve@quicinc.com>
To:     Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Govindaraj Saminathan <quic_gsaminat@quicinc.com>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166937642084.32083.1451291046866929367.kvalo@kernel.org>
Date:   Fri, 25 Nov 2022 11:40:22 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Kathirvel <quic_kathirve@quicinc.com> wrote:

> The below crash happens when running the traffic with multiple clients
> 
> Crash Signature : Unable to handle kernel paging request at
> virtual address ffffffd700970918 During the crash, PC points to
> "ieee80211_tx_rate_update+0x30/0x68 [mac80211]"
> LR points to "ath11k_dp_htt_htc_t2h_msg_handler+0x5a8/0x8a0 [ath11k]".
> 
> ppdu_stats_info is allocated and accessed from event callback via copy
> engine tasklet, this has a problem when freeing it from ath11k_mac_op_stop.
> 
> Add spin lock to protect htt_ppdu_stats_info and to avoid race condition
> when accessing it from ath11k_mac_op_stop.
> 
> Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Govindaraj Saminathan <quic_gsaminat@quicinc.com>
> Co-developed-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

This patch added a new checkpatch warning:

drivers/net/wireless/ath/ath11k/dp_rx.c:1542: braces {} are not necessary for single statement blocks

I fixed it in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221124071104.22506-1-quic_kathirve@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

