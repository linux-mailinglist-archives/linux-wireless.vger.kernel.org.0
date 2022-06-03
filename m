Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC6B53C52C
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jun 2022 08:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241664AbiFCGuj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jun 2022 02:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241519AbiFCGui (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jun 2022 02:50:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3884FEE2E
        for <linux-wireless@vger.kernel.org>; Thu,  2 Jun 2022 23:50:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 510D7617E7
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 06:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9102C385A9;
        Fri,  3 Jun 2022 06:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654239035;
        bh=2MJVEub2e7vLG6dbiPUI7bQt18Uy8hMvLml+ugbAsEc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=I/gnqd3hW/y6YonBIR/gU4FtoEHncVLtKbbva3MvEMjjQw9tbQ6AX0IJWxAYJnncq
         quWwhPE4HvHak10k3Isq3DMXWOEw1kC+bd/TAGzcQIOegH2PQ2lnnGuVstUlRyLkXX
         xXpSXBfFSKm0wGYRuaH2P96yByDwSMUTCIEFijyCTDiP/G49/XknpZheTd6qLg5Ru4
         8a24jfqUx/LiRqJ2fEiqNhllhDM+NW3FF59GHKXfcJ6fGXRkh+dH32kfarzYJrOpDm
         BmZqfJetZfj21AcVxFYW4eGa2tBy8V4R8Dc4CIuL+1Uf3/vucmYuCTMBS7xyzHFX1i
         FqvKs4BMBQR8Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath11k: move firmware stats out of debugfs
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220602051425.9265-2-quic_adisi@quicinc.com>
References: <20220602051425.9265-2-quic_adisi@quicinc.com>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165423896462.24941.15580147276579618500.kvalo@kernel.org>
Date:   Fri,  3 Jun 2022 06:50:34 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aditya Kumar Singh <quic_adisi@quicinc.com> wrote:

> Currently, firmware stats, comprising pdev, vdev and beacon stats are
> part of debugfs. In firmware pdev stats, firmware reports the final
> Tx power used to transmit each packet. If driver wants to know the
> final Tx power being used at firmware level, it can leverage from
> firmware pdev stats.
> 
> Move firmware stats out of debugfs context in order to leverage
> the final Tx power reported in it even when debugfs is disabled.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

This added new warnings:

drivers/net/wireless/ath/ath11k/debugfs.c:94: Please don't use multiple blank lines
drivers/net/wireless/ath/ath11k/debugfs.c:976: Blank lines aren't necessary before a close brace '}'

I fixed them in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220602051425.9265-2-quic_adisi@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

