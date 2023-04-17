Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C1D6E44F0
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 12:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjDQKQJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 06:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjDQKQG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 06:16:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F110BE4A
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 03:15:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED06062114
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 10:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C2AC433D2;
        Mon, 17 Apr 2023 10:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681726442;
        bh=SJ8Cjrcif9Zvy5yUgdgzzrInVemuGtS1n7KSjHiLBSs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Jz/8dNNN4qiIFAvn9NdY5cvBhSERTyXR6xVXHIqAqXaya52hUcod9ticnARpPscmH
         q2Tpxwh8KemQ73AtgtRwovcfck20bLNDsRbM65KPBqr2t66kQY64iuE8AraqnHqYjI
         DVwb2I26Ozyyh3kUdRJ5uDa/Lvs35kUShpj+pEMg0+LU7j9FmXhA5RNEbi8IZfCqBM
         B6q6TBiumu7YWf/2p0EpVxn63PNyjAqlyDN9vPuA/ynhq5i/bWAYBok9w4GhVQgY0N
         soSbRGGEEjBbJSKvWG7BbWyWs6VbtvZlRIeIgKhgwxeVdzeRFF8NGqSoDyN0xqGgsr
         YM7ctWpTym/cw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: Disable Spectral scan upon removing
 interface
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230328071150.29645-1-quic_tamizhr@quicinc.com>
References: <20230328071150.29645-1-quic_tamizhr@quicinc.com>
To:     Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168172643941.9486.9756032017777540721.kvalo@kernel.org>
Date:   Mon, 17 Apr 2023 10:14:01 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tamizh Chelvam Raja <quic_tamizhr@quicinc.com> wrote:

> Host might receive spectral events during interface
> down sequence and this might create below errors.
> 
> failed to handle dma buf release event -22
> failed to handle dma buf release event -22
> 
> Fix this by disabling spectral config during remove interface.
> 
> Tested-on: IPQ5018 hw1.0 AHB WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

5c690db63b45 wifi: ath11k: Disable Spectral scan upon removing interface

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230328071150.29645-1-quic_tamizhr@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

