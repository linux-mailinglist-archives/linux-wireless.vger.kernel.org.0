Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A296A53EB8A
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jun 2022 19:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239393AbiFFOJj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jun 2022 10:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238043AbiFFOJi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jun 2022 10:09:38 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4092228F
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jun 2022 07:09:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 23024CE1B8F
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jun 2022 14:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A01C385A9;
        Mon,  6 Jun 2022 14:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654524573;
        bh=xOo5DWzZui20CIsgcscdrFQMIfcx26XVOfbAkUjR34E=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=PQ/yd1lQZR0tpO0Xk/XlcK8k7gHS7aNH5dEm/oZbAt62gSM4j8L64a4c2rJtL0hPn
         aKb/SekUi6YWQ8h7CJYHr2wCEbw6BUmIA9nrtyVg7miGquM0+T4Fpjy0KTeR4fZQpT
         K2O9qA4DZFhYqpGdoPgVmAL0EhdxD74VKk8vhanMFi3dVSWQCK5qBM6SaCrTSZep3Y
         y1khFUFfQM8MewFGRq+OwSk1ixhpiYjkFfs/cywYC/EO6YzOk7yfnCaWqk0VdBjdRu
         vT1D3yHS4ZRBcJWQBS9QCc4sncDUQ23+qoqjeu+b07q18TlCm8JITxauUxPjQlILTp
         H2jg8V667WOEg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Avoid REO CMD failed prints during firmware
 recovery
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220602122929.18896-1-quic_mpubbise@quicinc.com>
References: <20220602122929.18896-1-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165452456971.15301.3255857087699251778.kvalo@kernel.org>
Date:   Mon,  6 Jun 2022 14:09:32 +0000 (UTC)
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

> Currently when firmware recovery is in progress, we do not queue REO
> commands to the firmware, instead -ESHUTDOWN will be returned to the
> caller leading to a failure print on the console. The REO command in
> the problem scenario is sent for all tids of a peer in which case we
> will have 16 failure prints on the console for a single peer. For an
> AP usecase, this count would be even higher in a worst case scenario.
> Since these commands are bound to fail during firmware recovery, it
> is better to avoid printing these failures and thereby avoid message
> flooding on the console.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> 
> Fixes: 8ee8d38ca472 ("ath11k: Fix crash during firmware recovery on reo cmd ring access")
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

0ab52b2bd7be ath11k: Avoid REO CMD failed prints during firmware recovery

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220602122929.18896-1-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

