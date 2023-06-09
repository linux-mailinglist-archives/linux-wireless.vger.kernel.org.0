Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCC3729BAA
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 15:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbjFINdQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 09:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjFINdP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 09:33:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EB42D48
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 06:33:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A941865674
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 13:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CB9C433EF;
        Fri,  9 Jun 2023 13:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686317594;
        bh=7BwFbeazrEVoJL4FmncCiczT3/uCanGLr7VBtUGZT1Y=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=dRtqaGI9SFaRhiwDihIPHXVkljRYdS4Ar+76dpUAejON5DOIgCHZDk38PWkBehEwg
         ++XEeO3J8ue/Tog6CiIrvngZv912JqPStruqF1C3JD3RQftV3/SQP1dU+OsxcAio8y
         XXeQklV9B7yERGR6rdSoKtz3iksnPOzejqCqxTIeXNCVxtm6QORmY0BtBRWboGnvbK
         q/sxosiGmNft2u22bkpaR89932ux9uZMw3Dr03U9zipV7JE3ZljZ3klTpSB6Z5cnRT
         hnRcw25lAkfso++29pnZpP5c1idLEMnxrnRBAKDYQLL34qlQxexqhzCF8J7A8FeduI
         hVHnBOwBe8mhw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: delete the timer rx_replenish_retry during
 rmmod
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1685355238-3282-1-git-send-email-quic_haric@quicinc.com>
References: <1685355238-3282-1-git-send-email-quic_haric@quicinc.com>
To:     Hari Chandrakanthan <quic_haric@quicinc.com>
Cc:     <quic_kvalo@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>,
        Hari Chandrakanthan <quic_haric@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168631759075.7235.15045413984427960673.kvalo@kernel.org>
Date:   Fri,  9 Jun 2023 13:33:12 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hari Chandrakanthan <quic_haric@quicinc.com> wrote:

> The rx_replenish_retry timer is initialized in ath12k_core_alloc() when ath12k
> module is loaded.  But rx_replenish_retry timer is not deleted anywhere in the
> code.  It is supposed to be deleted when ath12k module is removed/unloaded.
> 
> Delete the timer rx_replenish_retry in ath12k_core_free().
> 
> Found during code review.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-02903-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

e2d1f005d3fb wifi: ath12k: delete the timer rx_replenish_retry during rmmod

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1685355238-3282-1-git-send-email-quic_haric@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

