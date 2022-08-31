Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97955A760B
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Aug 2022 07:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiHaF6N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Aug 2022 01:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHaF6M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Aug 2022 01:58:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F064CBB00D
        for <linux-wireless@vger.kernel.org>; Tue, 30 Aug 2022 22:58:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA167B81EB8
        for <linux-wireless@vger.kernel.org>; Wed, 31 Aug 2022 05:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD4CC433C1;
        Wed, 31 Aug 2022 05:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661925489;
        bh=duwCTQWFTJPkUcNFvAB5Z2Rj/Xrbs84gsgwZ6kI7J3E=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Lp4yb0sUDFxEUI/jZYjqTqWm7M4sCet2I1aJ/wlF+NgvaYCBAnF6ggewTSlf0iNPF
         MtuE3s3ZYvkyWz0SN3KRX0qdocNx6+oKKZ21V31WBbQKpoXrMmWfoQKzuZT8g4mver
         VHahHq3xtAZLECxttwfXp4BIkX57IxE40ZE+1D4YTnIsR72WTK/VkcMDT6Pco+i8dI
         SIemJEFJ4OuiCj/FH95NUr62ZXX7N4/tumomgYyUnRn/e7t6yCn+D5/WXPu55/rHPH
         4vGStlE4Wqpx7CkSbhAA0kkZU2V/bn3EnD21z1OmIq/0CaDAiLDrGXrvWvl2sqFbXs
         gAnxy6xu1fKaA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Enable remain-on-channel support on WCN6750
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220720134331.14832-1-quic_mpubbise@quicinc.com>
References: <20220720134331.14832-1-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166192548485.26203.10728415761503127962.kvalo@kernel.org>
Date:   Wed, 31 Aug 2022 05:58:08 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> wrote:

> Enable remain on channel support on WCN6750 as it is needed for
> GAS, Passpoint.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>

Failed to apply. And please use --base when submitting ath11k patches.

error: patch failed: drivers/net/wireless/ath/ath11k/core.c:559
error: drivers/net/wireless/ath/ath11k/core.c: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220720134331.14832-1-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

