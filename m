Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD42640EAC
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Dec 2022 20:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbiLBTpc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Dec 2022 14:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiLBTp1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Dec 2022 14:45:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21779F3F86
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 11:45:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9A6762035
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 19:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF3AC433D6;
        Fri,  2 Dec 2022 19:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670010326;
        bh=+vuLtTA0VXJm+0+wd3FJqvgQoko7iiNr/V34abeWt+4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=AeMR5nZ1GsW19O1s90l2bgS//XMUCQfX7zk79BPSO7Hi13KQ4Nlm5asBzN9WmPmpG
         Vpua0CmP3atR2KzhsvxOvOfjxWFn0qgspXhllfkAAE4ZucnEOkFo7L73aliLDLWOWW
         sDHFxU0ZbDQdwQMvJexcSvQAXjt6OTY5LhcHSFRjGcxOvw1zwDye6+1BPf6bLU5uO7
         G9ZoFNHGcBmhe/StsaFWPRlKnyZVyT8NW4G3ddL5X3zH3/Z/eCzSC6xbBcRvAL1yZg
         1PgKqXkNSiMhZMNJiLY3BTF1qEGBk/Z28WO6H3ocoMeLlkuch0jIboAW0XmJ8FBNK7
         /iGxe5RNgTkKA==
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
Message-ID: <167001032276.14016.8815714083482597468.kvalo@kernel.org>
Date:   Fri,  2 Dec 2022 19:45:24 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Kathirvel <quic_kathirve@quicinc.com> wrote:

> A crash happens when running the traffic with multiple clients:
> 
> Crash Signature : Unable to handle kernel paging request at
> virtual address ffffffd700970918 During the crash, PC points to
> "ieee80211_tx_rate_update+0x30/0x68 [mac80211]"
> LR points to "ath11k_dp_htt_htc_t2h_msg_handler+0x5a8/0x8a0 [ath11k]".
> 
> Struct ppdu_stats_info is allocated and accessed from event callback via copy
> engine tasklet, this has a problem when freeing it from ath11k_mac_op_stop().
> 
> Use data_lock during entire ath11k_dp_htt_get_ppdu_desc() call to protect
> struct htt_ppdu_stats_info access and to avoid race condition when accessing it
> from ath11k_mac_op_stop().
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Govindaraj Saminathan <quic_gsaminat@quicinc.com>
> Co-developed-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

e44de90453bb wifi: ath11k: Fix race condition with struct htt_ppdu_stats_info

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221124071104.22506-1-quic_kathirve@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

