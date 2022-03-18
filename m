Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398694DDD19
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Mar 2022 16:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbiCRPio (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Mar 2022 11:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237890AbiCRPin (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Mar 2022 11:38:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2770519ABC7
        for <linux-wireless@vger.kernel.org>; Fri, 18 Mar 2022 08:37:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8ACADB82474
        for <linux-wireless@vger.kernel.org>; Fri, 18 Mar 2022 15:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DB6C340E8;
        Fri, 18 Mar 2022 15:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647617841;
        bh=yG6GKN0QjG+NaDFavP6liDr4c6Co2c817z3BufnzAu0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=hQjEbL5jn4+4a7ZfA4/O4plDIYrr4+JgPAxWELCt1UYNegyWIzXghgKKdvqvQqSnP
         uLncILr7F2JZ5VDXLU+azFMUbi2mWL/Kj6ALG3hu/UW+l/cjLBf+TsznOXY4tPPfbk
         E6C9FV2sHAd2xBTNDSEyE3icLMppHC/+xXHzHqxbHBMU9KyKwu9FgyoM7H2pOn3PiJ
         wlGclaf8/a5+tggnYmRbanJpaMGSncl/+N4ttMEXZi9zxABJrAKU+RJbCTAe2f351V
         pbNo4tjaRCVisiWSGez/cbfQNcM/lW3Ib33ZSjIv/sBzhUK1XO3XpkULkFXh6IOEeG
         sVKeszvHXKRjw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/6] ath11k: Add basic WoW functionalities
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1644308006-22784-2-git-send-email-quic_cjhuang@quicinc.com>
References: <1644308006-22784-2-git-send-email-quic_cjhuang@quicinc.com>
To:     Carl Huang <quic_cjhuang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164761783674.655.6579747484395583481.kvalo@kernel.org>
Date:   Fri, 18 Mar 2022 15:37:20 +0000 (UTC)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <quic_cjhuang@quicinc.com> wrote:

> Implement basic WoW functionalities such as magic-packet, disconnect
> and pattern. The logic is very similar to ath10k.
> 
> When WoW is configured, ath11k_core_suspend and ath11k_core_resume
> are skipped as WoW configuration and hif suspend/resume are done in
> ath11k_wow_op_suspend() and ath11k_wow_op_resume().
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

6 patches applied to ath-next branch of ath.git, thanks.

ba9177fcef21 ath11k: Add basic WoW functionalities
fec4b898f369 ath11k: Add WoW net-detect functionality
c417b247ba04 ath11k: implement hardware data filter
90bf5c8d0f7e ath11k: purge rx pktlog when entering WoW
c3c36bfe998b ath11k: support ARP and NS offload
a16d9b50cfba ath11k: support GTK rekey offload

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1644308006-22784-2-git-send-email-quic_cjhuang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

