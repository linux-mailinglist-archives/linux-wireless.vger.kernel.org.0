Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16ED47A8337
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 15:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjITNX0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 09:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjITNXZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 09:23:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC4AA9
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 06:23:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186B1C433C8;
        Wed, 20 Sep 2023 13:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695216199;
        bh=2Et11YtI8kBzyLko0A2MfjzkF+6hxxDNxXxX0g0Jl8U=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Ss+Tkz3brJULw9FCZUQKqAVU1bZUmIQwcTwz4OWfH34VkeBVKeLhkD4oWKx/Wi5Ls
         fV3pQTEPTWElBbIpv2Qdzb46X4t+0/UYjbX9AIx9F0RYLQ2aK9juSSLVJBdPzB4OYE
         +nnsazloGFtngv/0VazOi9uALgY5xrlwKviBQB5Wvqnxk8bnD9iPxQMDlWLNSLLUjA
         pqJcRz4LDSexgY/it52oJm7B+oHSfcYsG9hOZ6zKbCTrortk2+DgvpiO20uzzibuZo
         NKawn6d6io7WKg2Pgnb2pbWOU69tgCuPfKofqIyamSpe9HbyyOmvdJdSzNmuQIBp3D
         BmOpBkZwqJpgQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCH 1/6] [v3] wifi: ath10k: cleanup CE ring initialization
References: <997f4b09-7087-4788-aa2a-ef835ce6ebb3@quicinc.com>
        <20230824055117.42309-1-dmantipov@yandex.ru>
Date:   Wed, 20 Sep 2023 16:23:16 +0300
In-Reply-To: <20230824055117.42309-1-dmantipov@yandex.ru> (Dmitry Antipov's
        message of "Thu, 24 Aug 2023 08:51:06 +0300")
Message-ID: <874jjpashn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Commit 25d0dbcbd5c7 ("ath10k: split ce initialization and allocation")
> changes 'ath10k_ce_init_src_ring()' and 'ath10k_ce_init_dest_ring()'
> so these functions can't return -ENOMEM but always returns 0. This way
> both of them may be converted to 'void', and 'ath10k_ce_init_pipe()'
> may be simplified accordingly.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v3: split to smaller units per Jeff's suggestion
> v2: change 'ath10k_ce_alloc_rri()' to return -ENOMEM in case
> of 'dma_alloc_coherent()' failure and fix error handling in
> 'ath10k_snoc_hif_power_up()'

[...]

> -static int ath10k_ce_init_src_ring(struct ath10k *ar,
> -				   unsigned int ce_id,
> -				   const struct ce_attr *attr)
> +static void ath10k_ce_init_src_ring(struct ath10k *ar,
> +				    unsigned int ce_id,
> +				    const struct ce_attr *attr)

I have on purpose avoided to use void functions in ath10k/ath11k/ath12k.
The problem is that if some of the functions return void and some of the
functions return int it's much harder to review the code. If most/all of
the functions return the same error value type as int it makes a lot
easier to read the code.

Is there a benefit from function returning void? Why do this in the
first place?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
