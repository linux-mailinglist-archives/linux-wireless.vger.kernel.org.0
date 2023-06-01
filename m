Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D2E7196CF
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 11:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjFAJYE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 05:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjFAJYD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 05:24:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5284997
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 02:24:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E168D64273
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 09:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64814C433EF;
        Thu,  1 Jun 2023 09:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685611440;
        bh=0O/GI9jziIcE0yjMclqjVCTlKdf6tJ8wFmi3ZOU/5vY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=SPO8mQSJq4TScaZqcrB3UdhbYWsgwaaTivSNaa1ZuhFbA9XOt76JKWVWZKPHGISb9
         boUC5jgBPM8Zz2tfswImC3lDPR+DGWX5i6IwPWhoMe1E4hmDhxOyMDLVizFWzEibH7
         ozdeKphKmG9w6SyT4YRZ3HzRHyFnC1w9ULIroiARpLA1+IQ7nqtrVxm7g3qgPv5uW+
         au71NCMfieoYboypMC9yWCf/sBW56nfBlmwIlVHG/QAYWaho9CHxOlxC6suuBPJ23C
         QVfI794e7b7vUlE2CUTvtUI8UC1nJ44dUveFCAkTd7gO2ZblnFbZzokPvDHqQxfT3b
         E7e23naon+P0g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: add support default regdb while searching
 board-2.bin for WCN6855
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230517133959.8224-1-quic_wgong@quicinc.com>
References: <20230517133959.8224-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168561143721.9854.3957851649423510026.kvalo@kernel.org>
Date:   Thu,  1 Jun 2023 09:23:59 +0000 (UTC)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> Sometimes board-2.bin does not have the regdb data which matched the
> parameters such as vendor, device, subsystem-vendor, subsystem-device
> and etc. Add default regdb data with 'bus=%s' into board-2.bin for
> WCN6855, then ath11k use 'bus=pci' to search regdb data in board-2.bin
> for WCN6855.
> 
> kernel: [  122.515808] ath11k_pci 0000:03:00.0: boot using board name 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262'
> kernel: [  122.517240] ath11k_pci 0000:03:00.0: boot firmware request ath11k/WCN6855/hw2.0/board-2.bin size 6179564
> kernel: [  122.517280] ath11k_pci 0000:03:00.0: failed to fetch regdb data for bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262 from ath11k/WCN6855/hw2.0/board-2.bin
> kernel: [  122.517464] ath11k_pci 0000:03:00.0: boot using board name 'bus=pci'
> kernel: [  122.518901] ath11k_pci 0000:03:00.0: boot firmware request ath11k/WCN6855/hw2.0/board-2.bin size 6179564
> kernel: [  122.518915] ath11k_pci 0000:03:00.0: board name
> kernel: [  122.518917] ath11k_pci 0000:03:00.0: 00000000: 62 75 73 3d 70 63 69                             bus=pci
> kernel: [  122.518918] ath11k_pci 0000:03:00.0: boot found match regdb data for name 'bus=pci'
> kernel: [  122.518920] ath11k_pci 0000:03:00.0: boot found regdb data for 'bus=pci'
> kernel: [  122.518921] ath11k_pci 0000:03:00.0: fetched regdb
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

88ca89202f8e wifi: ath11k: add support default regdb while searching board-2.bin for WCN6855

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230517133959.8224-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

