Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE205E5C63
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 09:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiIVH2q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 03:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiIVH2m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 03:28:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3352DD12FF
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 00:28:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4C8AB834E4
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 07:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68048C433D7;
        Thu, 22 Sep 2022 07:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663831716;
        bh=OETM/LB+WTZFmvT1tGIOQMPKrF6tiG2SAGz/f2wY4ng=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WkOYrqt4UXyzt6Iqtnh2Em8oqX2+LgbOYjgjZgBx4TrxznmZgzzBV3FZkuDIxjF7O
         cDGobuzax9iEOs5GmM8pwth5tZS22M+1MdH6MRFby2jq2RbofhVMKG8qarfro3kqoM
         2+Lvs+kSSIeRG9wQeYQI6kGAOHHOtLXeMuAeI9Q3BUh2/vyUkVb8YFFeL1rc/nGOgO
         AVjn/8pe8F6TyrgaD0yQN3+5ffPGO6LUKP5QVTWAN9mkyGNm+PwGuciW3aoVG5btRC
         X9kKkUmE1icB8Q/IHwLXCuZ3U51X3QB3PhjMf3d3hxdPtIVUFGAPLZSERmS3Jfc3KJ
         oCz5rOIZ4A5ZA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/2] ath11k: move firmware stats out of debugfs
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220603082814.31466-2-quic_adisi@quicinc.com>
References: <20220603082814.31466-2-quic_adisi@quicinc.com>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166383171041.28267.6068680325009994115.kvalo@kernel.org>
Date:   Thu, 22 Sep 2022 07:28:35 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

2 patches applied to ath-next branch of ath.git, thanks.

ec8918f922b8 wifi: ath11k: move firmware stats out of debugfs
9a2aa68afe3d wifi: ath11k: add get_txpower mac ops

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220603082814.31466-2-quic_adisi@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

