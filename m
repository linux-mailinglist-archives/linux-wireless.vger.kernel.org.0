Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936905E5D2A
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 10:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiIVIOZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 04:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIVIOV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 04:14:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD77CD1FD
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 01:14:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E5F1B834F6
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 08:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0925CC433C1;
        Thu, 22 Sep 2022 08:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663834456;
        bh=MOlPCXwskFQ/i1ybWs2kBQNxkSgAaolnyrvqwJkqiPc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=vMfNQZiW3ju9qqzEjJwLl1pXNkLE2+RFj7PtzTqMI6dCP1PHYm5ZO/VvhS1+sHRgD
         4ZLnVDEVHIkL517pqzH41s34teA4zfr4dQmind97msIUx8K97MsY0tXpmpipxvaNfs
         +b7zhFM3w5rL6kya+X7PdsafjmE30YjcffgCjWjNrzG27g+lvv1A01YCo2Xe3VMH8V
         V7sdLOmJIMYfbie1Qp03U9PWdeU8xX8X6UYGYkCHCOTHfdNWnAsQLOnC6Qyw7QhFXd
         HtUNW1izNBBajwq67swfgb3kKHfIPQ4EoxDUDNa6x9BijcFxuWHY0PPFcGi5DDpysl
         6IRy18SC26Pbw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: reduce the timeout value back for hw scan
 from
 10 seconds to 1 second
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220919024121.24820-1-quic_wgong@quicinc.com>
References: <20220919024121.24820-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166383445202.9473.8707216192194973891.kvalo@kernel.org>
Date:   Thu, 22 Sep 2022 08:14:14 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> For 11d scan, commit 9dcf6808b253 ("ath11k: add 11d scan offload support")
> increased the timeout from one second to max 10 seconds when 11d scan
> offload enabled and 6 GHz enabled, it is reasonable for the commit, it
> is because the first 11d scan request is sent to firmware before the
> first hw scan request after wlan load, then the hw scan started event
> will reported from firmware after the 11d scan finished, it needs about
> 6 seconds when 6 GHz enabled, so increased it from one second to 10
> seconds in the commit to avoid timed out for hw scan started. Then
> another commit 1f682dc9fb37 ("ath11k: reduce the wait time of 11d scan
> and hw scan while add interface") change the sequence of the first 11d
> scan and hw scan, then ath11k will receive the hw scan started event
> from firmware immediately for the first hw scan, thus ath11k does not
> need set the timeout value to max 10 seconds again, and this is to set
> the timeout value back from 10 seconds to 1 second.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

With this patch I started seeing new errors:

[ 1194.815104] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
[ 1196.864157] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
[ 1198.911926] ath11k_pci 0000:06:00.0: failed to start hw scan: -110

This seems to happen after my suspend tests, but didn't have time to
investigate further.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220919024121.24820-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

