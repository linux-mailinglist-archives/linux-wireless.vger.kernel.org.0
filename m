Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCF353EC6E
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jun 2022 19:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239596AbiFFOKy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jun 2022 10:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239592AbiFFOKx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jun 2022 10:10:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFE3275C4
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jun 2022 07:10:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FB3DB819FC
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jun 2022 14:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DF1C385A9;
        Mon,  6 Jun 2022 14:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654524649;
        bh=8VhyjTxv1+dQL+DkFd0bU0FBPuJ2fWCYDX8POlXeams=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=l7GPPyhCik3JLk3asyZHqAKEqcHy5v3TC4CqaZTmsQOOKblTrfNkDHJ93LyLcVAJX
         XPAeIh2QuHYPkK5bNPNLF6NnGz4CnV/F2JVPd6kJeQGKL3khnzZ7y2V00m7sSRiDN8
         5iECrRS3Gmx7Xpje+xb94CTQqLLYhYuzRaF5DdwsCfOHkfoUkmuY9Ym81MzTs0XOWZ
         +FruGqansw6stu2sR9spHReUk0EmbklGvcaPmuvGMHCMwdkOCMp0udH6IN1wU3J4rP
         /Fp6ZfiQDTkBnRlHBu3p3HqIasql6Dm5fTeH06CMxZR3vuvtUuMaKkZGtQMN0P+qOj
         wOhIJ37zvXVww==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fix LDPC config in set_bitrate_mask hook
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220602124142.29909-1-quic_mpubbise@quicinc.com>
References: <20220602124142.29909-1-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165452464285.15301.12888477923740045977.kvalo@kernel.org>
Date:   Mon,  6 Jun 2022 14:10:48 +0000 (UTC)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> wrote:

> Currently ar->ht_cap_info is not set anywhere in the code, this could
> result in LDPC config computed wrongly in the set_bitrate_mask() hook
> and eventually sending wrong config to the target. Fix this by checking
> the LDPC support from the band HT capabilities of the radio instead.
> 
> Furthermore, it looks like firmwares running on the ath11k hardware
> do not set WMI_HT_CAP_LDPC for advertising the TX LDPC capability,
> WMI_HT_CAP_TX_LDPC is set instead and this should be checked for
> getting hardware's TX LDPC support. This is true for QCA6390, WCN6855
> & WCN6750 hardware.
> 
> Also, remove unused variables ht_cap_info & vht_cap_info from
> struct ath11k{}.
> 
> Found this during code review.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

4c1fc4f60a53 ath11k: Fix LDPC config in set_bitrate_mask hook

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220602124142.29909-1-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

