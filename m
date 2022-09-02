Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F145AB073
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 14:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbiIBMyY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 08:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238074AbiIBMxn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 08:53:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5387C11837
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 05:38:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0FC1B82AAC
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 12:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0558C433B5;
        Fri,  2 Sep 2022 12:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662122231;
        bh=9Op9odOExBlAnpTT0YXqKzP+UiRsRxe3E3JcNy37xdY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Fprsi1qWCKCGcQmDnpbV2aneriA9QuL1RSFFRCrB7/IRYWWaMXpePNS0d/D2bqoKg
         0Or0O5CqeJ9WDP6g5qKuEWqjDX3QihY4IlKv9d6Gq9MaF/XUKFkVdiEIOD83WNhyGS
         zayo2+YyzpmlNoDAvoo+RT6cvBey2kDbUEowumawtkgeUcaNhvctp1RgY7WGx0E+4R
         HPH/JyXRGdvtYU6MeHPOH1xTt9foJ0BeevJ8v4I0GaVksjU3qNhoJW4sMfBdgR5IMR
         puhEwZwXw23V91EEeezsAMk2s6BojwKKfYbI0j4nsDl7pvXHxkcVPFFCyz00XcYAxw
         HOE/gW2yMTOmw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] ath11k: Enable threaded NAPI on WCN6750
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220720135113.15755-2-quic_mpubbise@quicinc.com>
References: <20220720135113.15755-2-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166212222808.10242.13626602156198198987.kvalo@kernel.org>
Date:   Fri,  2 Sep 2022 12:37:10 +0000 (UTC)
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

> Enable threaded NAPI on WCN6750. Unlike traditional NAPI poll which
> runs in softirq context and on the core which scheduled the NAPI,
> threaded NAPI makes use of kernel threads which are under direct
> control of the scheduler and helps in balancing the NAPI processing
> load across multiple CPUs thereby improving throughput.
> 
> In the case of WCN6750, enabling threaded NAPI has improved
> 160 MHz RX throughput by nearly 400 Mbps. This should give similar
> gains for other ath11k devices as well, therefore enable threaded
> NAPI on all other devices.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>

Fails to apply and no base commit provided, so please rebase.

error: patch failed: drivers/net/wireless/ath/ath11k/core.c:111
error: drivers/net/wireless/ath/ath11k/core.c: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath11k/hw.h:205
error: drivers/net/wireless/ath/ath11k/hw.h: patch does not apply
stg import: Diff does not apply cleanly

3 patches set to Changes Requested.

12924009 [1/3] ath11k: Enable threaded NAPI on WCN6750
12924011 [2/3] ath11k: Add multi TX ring support for WCN6750
12924010 [3/3] ath11k: Increase TCL data ring size for WCN6750

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220720135113.15755-2-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

