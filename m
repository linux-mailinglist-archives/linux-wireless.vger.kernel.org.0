Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A614B5909
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 18:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiBNRp7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 12:45:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiBNRp7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 12:45:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396AC65439
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 09:45:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8298B81195
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 17:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775E0C340E9;
        Mon, 14 Feb 2022 17:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644860748;
        bh=JOBmuLpYMO9AGh+G2jtHoYb6XFhfIGc6Qj+i753pEGg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ivJdt0ZZiwQbjYsBtB6FlyUwfNUmMfbLG7tk72s6lqp5mROYpk/0E7T0ewKbyvugn
         t4H7gpgO0emUdXw2MRlrgD3RWa9kzg9e4n/tl63+cTqD84id+xixDfqI9HkbmHpLEE
         3NkS/r3ImBZYyDAblm+qk6elKDL+PGOSRakalfKrAvFJVGxUdCqjRb5r9p7LDmfTqL
         sWhN3RPwSP2Q+hzHqsW/UAl6TEa3u9iOkA4rLYiV8/KYuOtamYi4JKi0FK+Qc+xiTs
         E4VxpRUcNZMAaeaFhP35f3JeLPqDgO2d0t58lNODDQXeFJINJ2ZduRGWq5su6niAm+
         N917D4zEG/7uw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix uninitialized rate_idx in
 ath11k_dp_tx_update_txcompl()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220209060816.423-1-quic_wgong@quicinc.com>
References: <20220209060816.423-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164486073463.4355.2988755414965557803.kvalo@kernel.org>
Date:   Mon, 14 Feb 2022 17:45:47 +0000 (UTC)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> The rate_idx which passed to ath11k_debugfs_sta_add_tx_stats() by
> ath11k_dp_tx_update_txcompl() is not initialized, add initialization
> for it.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03003-QCAHSPSWPL_V1_V2_SILICONZ_LITE-2
> 
> Fixes: 1b8bb94c0612 ("ath11k: report tx bitrate for iw wlan station dump")
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

8c4c567fa291 ath11k: fix uninitialized rate_idx in ath11k_dp_tx_update_txcompl()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220209060816.423-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

