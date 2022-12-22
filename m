Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B57654457
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Dec 2022 16:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbiLVP23 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Dec 2022 10:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbiLVP2X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Dec 2022 10:28:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C7628759
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 07:28:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E2CEB80185
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 15:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D25C433D2;
        Thu, 22 Dec 2022 15:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671722899;
        bh=KsnoqTPaGbCsUNb4K8sISomHfCTSNpMkJmK/bkrjvvg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=j4K2VSyevxAJPgjlmRhxJ+Ce20Y5Dk7VDpSsR6+OE6SqrsXPon+AUzojKZ55VOnLK
         yfEr5vVRlnbYhiYiJO3OuZtWZIBrEjakHLSNtX1wAEE7fxIF12X2zEbP/3Z2dCSdEh
         NFHZ91K9FQO+FoVZPbfxBat3IzvF/jdVbfVFahEZvGrU08siWyM7uJK9DO4YtHJFm7
         IPKCTmOvvT9huHzX7bflgC4Dwvod61O/EGqaiTxZuJLuQob0Hr7GnIUnPa5Cy7ljmO
         jVhBStAglDLxfBrvPNjRBbSKVogWzjJHSwT92gYBku63xWX2qUzYGhprstglZzLbqk
         q98dOBEBDsOrw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: update debugfs support for mupltiple radios in
 PCI
 bus
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1614160542-27882-1-git-send-email-akolli@codeaurora.org>
References: <1614160542-27882-1-git-send-email-akolli@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167172289467.8231.1004330123245787946.kvalo@kernel.org>
Date:   Thu, 22 Dec 2022 15:28:18 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> wrote:

> debugfs_ath11k struct is moved to ath11k_core, since its common
> for both pci and ahb.
> 
> Current ath11k_pci insmod fails if there are multiple PCI rdaios,
> 
>  ath11k_pci 0000:01:00.0: Hardware name qcn9074 hw1.0
>  debugfs: Directory 'ath11k' with parent '/' already present!
>  ath11k_pci 0000:01:00.0: failed to create ath11k debugfs
>  ath11k_pci 0000:01:00.0: failed to create soc core: -17
>  ath11k_pci 0000:01:00.0: failed to init core: -17
>  ath11k_pci: probe of 0000:01:00.0 failed with error -17
> 
> To avoid the failure, debugfs directory is created with soc_name
> and bus_id to allow creating debugfs directory for second PCI radio.
> 
> with this Debugfs entries looks like,
>  # ls -l /sys/kernel/debug/ath11k/
>  ipq8074 hw2.0 qcn9000 hw1.0_0000:01:00.0 qcn9000 hw1.0_0001:01:00.0
> 
>  # ls -l /sys/kernel/debug/ath11k/ipq8074 hw2.0/
>   mac0  mac1 simulate_fw_crash soc_dp_stats
> 
>  # ls -l /sys/kernel/debug/ath11k/qcn9000 hw1.0_0000:01:00.0
>   mac0 simulate_fw_crash soc_dp_stats
> 
>  # /sys/kernel/debug/ath11k/qcn9000 hw1.0_0001:01:00.0:
>    mac0  simulate_fw_crash soc_dp_stats
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>

I submitted my version here:

https://patchwork.kernel.org/project/linux-wireless/patch/20221220121231.20120-1-kvalo@kernel.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1614160542-27882-1-git-send-email-akolli@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

