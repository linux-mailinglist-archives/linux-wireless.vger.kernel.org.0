Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586B153EA8D
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jun 2022 19:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbiFFOI6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jun 2022 10:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238043AbiFFOI4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jun 2022 10:08:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86591CF
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jun 2022 07:08:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6895FB819F8
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jun 2022 14:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D62DC385A9;
        Mon,  6 Jun 2022 14:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654524533;
        bh=D0nfxgkU1zrBljYHyZkn5gGyrYOdvPSzjiXG5oFDjTk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OaWnneUjkvytyScrO84+4eZ5Fx7jyuBNFOuMR2Ch2X3w+ooU9iorATsgwcicz96PI
         6DyEBusDL1M+Z5TDZ97ss0CzcbMBeJWjpPKCCcgTfxRFDhYcNCzUusvAhhuh0LXnCT
         tWHb8ogLckN6aWaHfeHo5jPVzFPurTbHcVB1UT9C9ivg92u9UHb7ue4o5f+hNOkCVy
         aAgf7YREEwz59vhgzzofwd+tlh6+laAogXC3AIGnyHWnilAy1WN7ra44FmZowSdGbm
         82BnxAiBbswSTY0eqCFAYpTjgKaZOPOxZEvsDTZkz5jQTLinrOBvZRbWmrARE3vykR
         6dflpyGyNfilQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fix incorrect debug_mask mappings
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220602115621.15339-1-quic_mpubbise@quicinc.com>
References: <20220602115621.15339-1-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165452452992.15301.3587479774647912453.kvalo@kernel.org>
Date:   Mon,  6 Jun 2022 14:08:51 +0000 (UTC)
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

> Currently a couple of debug_mask entries are mapped to the same value,
> this could enable unintended driver logging. If enabling DP_TX logs was
> the intention, then this could also enable PCI logs flooding the dmesg
> buffer or vice versa. Fix this by correctly assigning the debug masks.
> 
> Found during code review.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> 
> Fixes: aa2092a9bab3f ("ath11k: add raw mode and software crypto support")
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

9331f7d3c54a ath11k: Fix incorrect debug_mask mappings

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220602115621.15339-1-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

