Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAB8666DE9
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jan 2023 10:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239938AbjALJRZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Jan 2023 04:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240008AbjALJQs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Jan 2023 04:16:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA3250052
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 01:09:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEE4161FAB
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 09:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93078C433D2;
        Thu, 12 Jan 2023 09:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673514564;
        bh=rrrY0mwZBiE2S9b+NOyUnVV3BWYMdajkh1hhqZrk2vE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dGILvNc5uMcKYgPlrMWrBZnl+YW5fWCeWcMxMYJ01CrHU2xR5Owyniz+3EpXmeCav
         vO7RkxlJlLga/N/qKBEiFfKaKbNnCOzadCESjovjUln8qmMD3bW3X5q8VISDEb/mm3
         NFyEXVj/fVJV45ZqgkD1ec1uszwIkhnISsyWIdWKna0AP/ASa+ySMhl07Rosq5B6a+
         4h2hmdsQ02tBk8kYdzaRRDerRs7rKQz1e22FRPpSas/lOG5oh52S0Cdr49NopQZNm8
         E1cqGU3jUd6CJ+/PC2Ssu5+mguj8WDMEgE5GEyxbWu7lxFnI8HQn3xZsc1vVGbqBHG
         mSXG8UN4p8FKw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath11k: debugfs: fix to work with multiple PCI devices
References: <20221220121231.20120-1-kvalo@kernel.org>
        <CA+HBbNGBKemtF9ZsFBFCe7_1eqMJ80QhEPCsinOJY2LQ4+tiFg@mail.gmail.com>
Date:   Thu, 12 Jan 2023 11:09:21 +0200
In-Reply-To: <CA+HBbNGBKemtF9ZsFBFCe7_1eqMJ80QhEPCsinOJY2LQ4+tiFg@mail.gmail.com>
        (Robert Marko's message of "Mon, 2 Jan 2023 16:42:55 +0100")
Message-ID: <87k01sdsqm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Robert Marko <robert.marko@sartura.hr> writes:

> On Tue, Dec 20, 2022 at 1:16 PM Kalle Valo <kvalo@kernel.org> wrote:
>>
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>
>> ath11k fails to load if there are multiple ath11k PCI devices with same name:
>>
>>  ath11k_pci 0000:01:00.0: Hardware name qcn9074 hw1.0
>>  debugfs: Directory 'ath11k' with parent '/' already present!
>>  ath11k_pci 0000:01:00.0: failed to create ath11k debugfs
>>  ath11k_pci 0000:01:00.0: failed to create soc core: -17
>>  ath11k_pci 0000:01:00.0: failed to init core: -17
>>  ath11k_pci: probe of 0000:01:00.0 failed with error -17
>>
>> Fix this by creating a directory for each ath11k device using schema
>> <bus>-<devname>, for example "pci-0000:06:00.0". This directory created under
>> the top-level ath11k directory, for example /sys/kernel/debug/ath11k.
>>
>> The reference to the toplevel ath11k directory is not stored anymore within ath11k, instead
>> it's retrieved using debugfs_lookup(). If the directory does not exist it will
>> be created. After the last directory from the ath11k directory is removed, for
>> example when doing rmmod ath11k, the empty ath11k directory is left in place,
>> it's a minor cosmetic issue anyway.
>>
>> Here's an example hierarchy with one WCN6855:
>>
>> ath11k
>> `-- pci-0000:06:00.0
>>     |-- mac0
>>     |   |-- dfs_block_radar_events
>>     |   |-- dfs_simulate_radar
>>     |   |-- ext_rx_stats
>>     |   |-- ext_tx_stats
>>     |   |-- fw_dbglog_config
>>     |   |-- fw_stats
>>     |   |   |-- beacon_stats
>>     |   |   |-- pdev_stats
>>     |   |   `-- vdev_stats
>>     |   |-- htt_stats
>>     |   |-- htt_stats_reset
>>     |   |-- htt_stats_type
>>     |   `-- pktlog_filter
>>     |-- simulate_fw_crash
>>     `-- soc_dp_stats
>>
>> I didn't have a test setup where I could connect multiple ath11k devices to the
>> same the host, so I have only tested this with one device.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9
>
>
> I can confirm that this works on a combination of IPQ8074 with an
> external QCN9074 radio which would previously clash and error out, so:
>
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1
> Tested-by: Robert Marko <robert.marko@sartura.hr>

Great, thank you for testing this. Very much appreciated. I added the
tags tags to the commit.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
