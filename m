Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C401C706290
	for <lists+linux-wireless@lfdr.de>; Wed, 17 May 2023 10:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjEQIPw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 May 2023 04:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjEQIPt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 May 2023 04:15:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F7D55A8
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 01:15:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 627A160F01
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 08:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEDDC433EF;
        Wed, 17 May 2023 08:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684311338;
        bh=5ChUSQwcuXz2s8bngl3k5z0Fzx1B8kCa+r5+BP3DRpQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=UsMA7L6DxgVwWa0P+9O6f3Odc09hEsbft+sCZSTFnPI6FJ3D8VB48uI7WbUh8kTQF
         CwbY5+sDO+pcrw24JhPE8vieblJCWD2XEFXp9X9jEDaQTUC4mBeCjlY/IQDw2xK2zx
         DCHL0BPPunhizZuvoKm0C7J6Q+On0DSTcAUefgi5b5uREGmMdU+JdtgoDQ/xzSGkZx
         7zQtOo7l8VbqEuGF3pon/Zd4/5kZXG0/eT/bA30w0iM8l+2T4ZtoGUoluJPRs4niDz
         +2yHtNmnQUMHXpl4aL78rb7pMB99986aP8eYuvwyJJ780rKqyusP0gGtJlxhcFGteK
         BD+LyD+Cp899Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: increase vdev setup timeout
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230428091041.20033-1-quic_rgnanase@quicinc.com>
References: <20230428091041.20033-1-quic_rgnanase@quicinc.com>
To:     Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Cc:     ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Aishwarya R <quic_aisr@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168431133246.15787.4737554911874210134.kvalo@kernel.org>
Date:   Wed, 17 May 2023 08:15:37 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ramya Gnanasekar <quic_rgnanase@quicinc.com> wrote:

> When vdev start/stop happens, response from firmware is received with delay
> and hence there is a timeout before VDEV can be up/down.
> Also, with maximum peers connected and when vdev stop occurs, firmware
> will take time to clean up all the peers and vap queues.
> In such cases as well, vdev start/stop response is sent by firmware with delay.
> 
> Increase the vdev setup timeout as recommended by firmware team.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-02903-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aishwarya R <quic_aisr@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

1fd2c3f93c3e wifi: ath12k: increase vdev setup timeout

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230428091041.20033-1-quic_rgnanase@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

