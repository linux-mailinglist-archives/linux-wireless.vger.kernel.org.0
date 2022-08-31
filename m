Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3855A7613
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Aug 2022 07:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiHaF7K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Aug 2022 01:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiHaF7J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Aug 2022 01:59:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA00FBA9C0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Aug 2022 22:59:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C1E9B81EE5
        for <linux-wireless@vger.kernel.org>; Wed, 31 Aug 2022 05:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631BCC433D7;
        Wed, 31 Aug 2022 05:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661925546;
        bh=HPwYuqsQzg9kc/XS6VUuHVSn/Oej/5p/qbDHnbjBZ78=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=qn7cppFohyqOriqjSH78ZnV0CyVihFmA6hV5jmu8Lf/NYFtvwDAUyOQRYYJWISU1P
         NSbpweaUhy4Ru3pEZzy2TOdTY22oVz0M9WJc41HUk0wSaqLjCa3S78Blb4taZK+QoE
         KxtMzipyVKdhVTwfiNallCARoLsb4mdCNG8ptwIjbzjcYJ63mlZYw72FoU1G/aoTJQ
         fTT67ZKUbaReHtN1KBbBrY5zCtx3KRi8u4H2RPcHuVN4rVM+IOnv1Z32739UJjq87l
         iV1HpJ20qNTSYYbV6KjU8mSzdaCyUonXx3Uspro9qfQ3kKTTt7z5f23PL4hEog2MH2
         K5y+gqD9e/hLw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Add support to connect to non-transmit MBSSID
 profiles
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220720134622.15293-1-quic_mpubbise@quicinc.com>
References: <20220720134622.15293-1-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166192554340.26203.2447393721716803657.kvalo@kernel.org>
Date:   Wed, 31 Aug 2022 05:59:05 +0000 (UTC)
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

> Add support to connect to a non-transmit MBSSID AP profile.
> 
> Non-transmit MBSSID profile parameters are passed to the firmware
> via WMI VDEV UP command and this helps firmware to track MBSSID
> profile within the multi-BSS beacon and report beacon loss if
> any.
> 
> WCN6750, QCA6390 & WCN6855 firmwares have the support and hence
> enable the support on these hardwares.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>

Failed to apply. Again please use --base.

error: patch failed: drivers/net/wireless/ath/ath11k/core.c:111
error: drivers/net/wireless/ath/ath11k/core.c: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath11k/hw.h:205
error: drivers/net/wireless/ath/ath11k/hw.h: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220720134622.15293-1-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

