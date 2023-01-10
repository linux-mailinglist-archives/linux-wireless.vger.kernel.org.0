Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC3E6641B4
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jan 2023 14:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjAJN1f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 08:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbjAJN1U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 08:27:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DB03BB
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 05:27:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 963EDB8164F
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 13:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCF8C433D2;
        Tue, 10 Jan 2023 13:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673357235;
        bh=fLMyic9Kl202nlqpBzKTc0Mqy/BXCOzUfblO7YoPzMI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=T1YvgQMLwp7yUO4KNl6fBvq6w3+ujzpfRBb0KwbOjZ8a+KJI0L3ez+n3gAtRoqIC6
         4AVN6ibArKnDb7w25SRIh+vK9ww+27L2cdHi+EMJzrRWV8UXFjGgjGn/SRigOITeuy
         bQECpKYcWzhh/3VkoVqj1t5fypC3Gurfsw/11rW7f2X1zkWzz7AyuT9NMIlcATnIMg
         1CAZe5Zb+eMsHRPVbEUEorE+e/yGd16uWfzmFw9qH3uVSAOc4LP15wMgZx2vz2k90t
         q0j14kgEBLZhO2oqOtlodY+f+zxGaxJC1Qh5RxAto0t+ISRA+Ffx4B3mYgmwIXx8Ca
         6LPzi0pSsNytg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: debugfs: fix to work with multiple PCI devices
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221220121231.20120-1-kvalo@kernel.org>
References: <20221220121231.20120-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167335721814.4132.1940344098269572941.kvalo@kernel.org>
Date:   Tue, 10 Jan 2023 13:27:14 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> ath11k fails to load if there are multiple ath11k PCI devices with same name:
> 
>  ath11k_pci 0000:01:00.0: Hardware name qcn9074 hw1.0
>  debugfs: Directory 'ath11k' with parent '/' already present!
>  ath11k_pci 0000:01:00.0: failed to create ath11k debugfs
>  ath11k_pci 0000:01:00.0: failed to create soc core: -17
>  ath11k_pci 0000:01:00.0: failed to init core: -17
>  ath11k_pci: probe of 0000:01:00.0 failed with error -17
> 
> Fix this by creating a directory for each ath11k device using schema
> <bus>-<devname>, for example "pci-0000:06:00.0". This directory created under
> the top-level ath11k directory, for example /sys/kernel/debug/ath11k.
> 
> The reference to the toplevel ath11k directory is not stored anymore within ath11k, instead
> it's retrieved using debugfs_lookup(). If the directory does not exist it will
> be created. After the last directory from the ath11k directory is removed, for
> example when doing rmmod ath11k, the empty ath11k directory is left in place,
> it's a minor cosmetic issue anyway.
> 
> Here's an example hierarchy with one WCN6855:
> 
> ath11k
> `-- pci-0000:06:00.0
>     |-- mac0
>     |   |-- dfs_block_radar_events
>     |   |-- dfs_simulate_radar
>     |   |-- ext_rx_stats
>     |   |-- ext_tx_stats
>     |   |-- fw_dbglog_config
>     |   |-- fw_stats
>     |   |   |-- beacon_stats
>     |   |   |-- pdev_stats
>     |   |   `-- vdev_stats
>     |   |-- htt_stats
>     |   |-- htt_stats_reset
>     |   |-- htt_stats_type
>     |   `-- pktlog_filter
>     |-- simulate_fw_crash
>     `-- soc_dp_stats
> 
> I didn't have a test setup where I could connect multiple ath11k devices to the
> same the host, so I have only tested this with one device.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1
> 
> Tested-by: Robert Marko <robert.marko@sartura.hr>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

323d91d4684d wifi: ath11k: debugfs: fix to work with multiple PCI devices

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221220121231.20120-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

