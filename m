Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFDA640DC7
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Dec 2022 19:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbiLBSrg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Dec 2022 13:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbiLBSrC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Dec 2022 13:47:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB487D826D
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 10:46:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D7DC6237E
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 18:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A63C433D7;
        Fri,  2 Dec 2022 18:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670006810;
        bh=1A9oppjyFCLaD25OsGPdEgZGbHr5BCt2AbllX8MIjgA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=S/Zvz3aOcZzMFwPPZAKpo64sxIfJKLb+t3GAw8NYiVibQ9KqDMQJrFPVmT3Gc7Mrv
         qr5Vaf+a0u4G4HWpnGzLNd8Hy6uVw6l/5gZmec0iM+TTFrPrLG26FYvZwJoXokGKto
         pO7EP1Yq8kszCDu991NmIMaMPt3dbSgV0mGAi6cPEgpP+yNiaLewQVDua8U73hERGs
         MpqRoY9ESMzu0qYpgvNh+LJIfETp3Q+A93SpvhdVEOJGptcdFghCpbD4Nkyqse9a3w
         8IW82NHjIsAh9IMG7hXVKt4J5+NcZdtQPJyMwHxrdRmRfd9VZ1QJQjW7v9D2khN54y
         k2aqXbK6FWgaQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: failed to insert STA entry for the AP (error -2)
References: <20221130122807.GA31720@lst.de> <87o7so4nr2.fsf@kernel.org>
        <20221130125236.GA865@lst.de> <87k03c4mdb.fsf@kernel.org>
        <20221130133016.GC3055@lst.de>
Date:   Fri, 02 Dec 2022 20:46:45 +0200
In-Reply-To: <20221130133016.GC3055@lst.de> (Christoph Hellwig's message of
        "Wed, 30 Nov 2022 14:30:16 +0100")
Message-ID: <87sfhx3ap6.fsf@kernel.org>
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

Christoph Hellwig <hch@lst.de> writes:

> I'm seeing this fun churn of warns when trying to connect to my AP
> with a brand new Thinkpad T14s Gen3 AMD that I'm trying to install
> Debian on.
>
> The kernel is linux-image-6.0.0-5-amd64 from Debian unstable, which is
> identical to the latest 6.0-stable for ath11k.
>
> [ 280.585881] ath11k_pci 0000:01:00.0: BAR 0: assigned [mem
> 0x98000000-0x981fffff 64bit]
> [  280.586362] ath11k_pci 0000:01:00.0: MSI vectors: 32
> [  280.586368] ath11k_pci 0000:01:00.0: wcn6855 hw2.1
> [  280.741846] mhi mhi0: Requested to power ON
> [  280.741860] mhi mhi0: Power on setup success
> [ 280.743578] mhi mhi0: firmware: direct-loading firmware
> ath11k/WCN6855/hw2.1/amss.bin
> [  280.834744] mhi mhi0: Wait for device to enter SBL or Mission mode
> [ 281.468934] ath11k_pci 0000:01:00.0: chip_id 0x12 chip_family 0xb
> board_id 0xff soc_id 0x400c1211
> [ 281.468944] ath11k_pci 0000:01:00.0: fw_version 0x11090c35
> fw_build_timestamp 2022-04-18 20:23 fw_build_id
> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9
> [ 281.469461] ath11k_pci 0000:01:00.0: firmware: direct-loading
> firmware ath11k/WCN6855/hw2.1/board-2.bin
> [ 281.469544] ath11k_pci 0000:01:00.0: firmware: direct-loading
> firmware ath11k/WCN6855/hw2.1/regdb.bin
> [ 281.479138] ath11k_pci 0000:01:00.0: firmware: direct-loading
> firmware ath11k/WCN6855/hw2.1/board-2.bin
> [ 281.510539] ath11k_pci 0000:01:00.0: firmware: direct-loading
> firmware ath11k/WCN6855/hw2.1/m3.bin
> [  281.802394] ath11k_pci 0000:01:00.0 wlp1s0: renamed from wlan0
> [  341.715380] wlp1s0: authenticate with 0c:70:4a:89:bc:64
> [  341.730641] wlp1s0: Invalid HE elem, Disable HE
> [  341.769475] ath11k_pci 0000:01:00.0: failed to setup rx defrag context

Haven't seen this before either. Really unfortunate that the warning
message message is not printing the error value (missed that during
review), but I suspect the error is coming from crypto_alloc_shash()
call:

int ath11k_peer_rx_frag_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id)
{
	struct ath11k_base *ab = ar->ab;
	struct crypto_shash *tfm;
	struct ath11k_peer *peer;
	struct dp_rx_tid *rx_tid;
	int i;

	tfm = crypto_alloc_shash("michael_mic", 0, 0);
	if (IS_ERR(tfm))
		return PTR_ERR(tfm);

Any chance you could check that? Also please check that
CONFIG_CRYPTO_MICHAEL_MIC is enabled (it should be as CONFIG_ATH11K
depends on it).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
