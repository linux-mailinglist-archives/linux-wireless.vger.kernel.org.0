Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5B44BFA0D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Feb 2022 14:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiBVN7v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Feb 2022 08:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiBVN7v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Feb 2022 08:59:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D431275F3
        for <linux-wireless@vger.kernel.org>; Tue, 22 Feb 2022 05:59:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C12DB819DC
        for <linux-wireless@vger.kernel.org>; Tue, 22 Feb 2022 13:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6CFC340F0;
        Tue, 22 Feb 2022 13:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645538361;
        bh=rtz7aWSvmntqAWBV99EZHtfJhVdnAExUNXGQfA4GKoA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GcsBiMrQVdchgpJyrOwhjT5Zz/eOhcG2Vsyt9gIJIgwazPslkIoFtwzbqGp62HDnb
         LJALhRHpJ5QJMGQ9vay1m8HRMwCc4G9R1dwWALNmFYz59CqDf2CnhRA0cvP4Qoq0wb
         lViRMQ8zDqVg38JqzHDn/MM/ogv4jRzXRIltPvVp39Q+51ERW/OiOSpAduVg+Zuxfr
         8ORNaW7hRcK2Yufpz5JMOMtkENduSUPgRESg2pw1XYvyW22FWJRgQoe/SO3em1kqhf
         3R5OUOb1QosFAEzQs5k8tKwEEWMo4b8hlAmEieTVDqXlVMb+hkcHGSqkSRCPFGqQ6g
         fC/9F7vbl8KXA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Carl Huang <quic_cjhuang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] ath11k: Add basic WoW functionalities
References: <1644308006-22784-2-git-send-email-quic_cjhuang@quicinc.com>
        <164553444424.23898.1586617399462118980.kvalo@kernel.org>
Date:   Tue, 22 Feb 2022 15:59:19 +0200
In-Reply-To: <164553444424.23898.1586617399462118980.kvalo@kernel.org> (Kalle
        Valo's message of "Tue, 22 Feb 2022 12:54:06 +0000 (UTC)")
Message-ID: <871qzvvw7c.fsf@kernel.org>
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

Kalle Valo <kvalo@kernel.org> writes:

> Carl Huang <quic_cjhuang@quicinc.com> wrote:
>
>> Implement basic WoW functionalities such as magic-packet, disconnect
>> and pattern. The logic is very similar to ath10k.
>> 
>> When WoW is configured, ath11k_core_suspend and ath11k_core_resume
>> are skipped as WoW configuration and hif suspend/resume are done in
>> ath11k_wow_op_suspend() and ath11k_wow_op_resume().
>> 
>> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>> 
>> Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>
> This patchset adds new warnings:
>
> drivers/net/wireless/ath/ath11k/mac.c:7284:5: warning: no previous
> prototype for 'ath11k_mac_flush_tx_complete' [-Wmissing-prototypes]
> drivers/net/wireless/ath/ath11k/mac.c:7284:5: warning: symbol
> 'ath11k_mac_flush_tx_complete' was not declared. Should it be static?
> drivers/net/wireless/ath/ath11k/mac.c:8218:34: warning: cast to restricted __be64
> drivers/net/wireless/ath/ath11k/wow.c:409: line length of 98 exceeds 90 columns
> drivers/net/wireless/ath/ath11k/wow.c:527: line length of 96 exceeds 90 columns
> drivers/net/wireless/ath/ath11k/wow.c:528: line length of 92 exceeds 90 columns
> drivers/net/wireless/ath/ath11k/mac.c:8111: line length of 96 exceeds 90 columns
> drivers/net/wireless/ath/ath11k/mac.c:8168: line length of 92 exceeds 90 columns
> drivers/net/wireless/ath/ath11k/mac.c:8188: line length of 92 exceeds 90 columns

I fixed all these warnings in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
