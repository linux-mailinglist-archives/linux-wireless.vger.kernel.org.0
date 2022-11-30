Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F2563D65F
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Nov 2022 14:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbiK3NMp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 08:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbiK3NMn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 08:12:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A866386
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 05:12:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D64361AC1
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 13:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22E3C433C1;
        Wed, 30 Nov 2022 13:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669813958;
        bh=ZWr9+FAS57bf6z+vP2CjDIujiiH62Huf8CkIkmu3W9M=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bAVcbl+z0vk5KRpXDEbnZDykL57W2UPuXXt+9HJyaS3rwqSDgBR4drbI/jAK4syur
         jcC43u3+C+RdOkE9JDHAhvylFEE9ty7KozKVMxZ2nIwBj76lMbSTGLshI5qzNPWbNR
         qVFKxPJkx7a0kEXzc7KeyDR6+C/BCb9qRlP8+uEI3iHtkXzqLtJIY6mqUXLYh/QPN7
         HvQEXM1SjACAg9t4qCgfOfO1KLadR/V694xONFe/DRnrLwpItGBpBSC5k42xX9BtJA
         m1jPzX3nA6yokZjNCKT674ZMtNK4wD+g5uJAgk7NBsKLY/PhBYMJMX8hQNYHQq0fgO
         IpG+ytCKZteZQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: ath11k vs ar_qrtr?
References: <20221130122807.GA31720@lst.de> <87o7so4nr2.fsf@kernel.org>
        <20221130125236.GA865@lst.de>
Date:   Wed, 30 Nov 2022 15:12:32 +0200
In-Reply-To: <20221130125236.GA865@lst.de> (Christoph Hellwig's message of
        "Wed, 30 Nov 2022 13:52:36 +0100")
Message-ID: <87k03c4mdb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

Christoph Hellwig <hch@lst.de> writes:

> On Wed, Nov 30, 2022 at 02:42:41PM +0200, Kalle Valo wrote:
>> Sorry, not following you here. Are you saying that "select QRTR" is not
>> enough and we should add something more?
>
> Yes, there is no runtime dependency right now. Something like using
> MODULE_SOFTDEP should solve this. Untested for now, but I can send a
> formal one after I make it past the initial installation:

Heh, I'm learning something new here. But I wonder why nobody else has
seen this?

If you submit a patch, please remember to CC linux-wireless so that our
patchwork sees it:

https://wireless.wiki.kernel.org/en/users/drivers/ath11k/submittingpatches

> diff --git a/drivers/net/wireless/ath/ath11k/core.c
> b/drivers/net/wireless/ath/ath11k/core.c
> index b99180bc81723b..72d043fc6b7c2c 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -1945,3 +1945,5 @@ EXPORT_SYMBOL(ath11k_core_alloc);
>  
>  MODULE_DESCRIPTION("Core module for Qualcomm Atheros 802.11ax wireless LAN cards.");
>  MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_SOFTDEP("pre: qrtr");
> +MODULE_SOFTDEP("pre: qrtr-mhi");

Would it be better to have these in one line?

MODULE_SOFTDEP("pre: qrtr qrtr-mhi");

At least the documentation seems to suggest that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
