Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84A65A9CCD
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Sep 2022 18:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbiIAQOZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Sep 2022 12:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbiIAQOY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Sep 2022 12:14:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF20E66128
        for <linux-wireless@vger.kernel.org>; Thu,  1 Sep 2022 09:14:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C165B827EE
        for <linux-wireless@vger.kernel.org>; Thu,  1 Sep 2022 16:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262E3C433D6;
        Thu,  1 Sep 2022 16:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662048861;
        bh=pbRiEW810/z4dMLbhfR754FG3Xc43pwbUMTg9W2eMeI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=KTH0ucWUHEiRmOowLLad/Rg8IYx+vSsFPJOxRUz0QZBFv9AAPKTeStcNa9jSiER9w
         EYNoT4/83cyiWWX361FLCOcJjQhYvAgBd+mHig5GCMiQQzudNY3M4efPHkUH8+IjUh
         eP6PBABji2QuChpoTvaq6qMwcHZFZrjykxt4VBFTCT7a4yUsPOEsv9A5isS2NfO6l/
         YOFzucf8LGQpxtBgHDpyn29xoBX1YfzhmDDJRTY43mmR46/wVdlHGVphLAIDHonFPJ
         iqAdEhWqcyUBMP50biH/eWOcxZFuNSDLPjoEYeAsYelKuLA00sxhnQlIanYLDtbhJR
         0w7ixY9jhEciQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath11k: Fix incorrect QMI message ID mappings
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220720134909.15626-2-quic_mpubbise@quicinc.com>
References: <20220720134909.15626-2-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166204885791.15293.566980702953762498.kvalo@kernel.org>
Date:   Thu,  1 Sep 2022 16:14:19 +0000 (UTC)
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

> QMI message IDs for some of the QMI messages were incorrectly
> defined in the original implementation. These have to be corrected
> to enable cold boot support on WCN6750. These corrections are
> applicable for all chipsets and will not impact them. Refactor the
> code accordingly.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

b3ca32308e46 wifi: ath11k: Fix incorrect QMI message ID mappings
6fe62a8cec51 wifi: ath11k: Add cold boot calibration support on WCN6750

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220720134909.15626-2-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

