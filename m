Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D36746EA48
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 15:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbhLIOwE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 09:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbhLIOwB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 09:52:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAC4C061746
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 06:48:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3430EB824B5
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 14:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3942AC341C7;
        Thu,  9 Dec 2021 14:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639061305;
        bh=A830pBYznpcvdIJBYdEboK0dA2NmQ+lMyN/PmKYowRI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LruwVv0MnhKuFcnA8ZQIjBNUmwCX6wlTw3EZfPE3qV/Sszrs7A6wXN/NyY4Wgr9o9
         d6v7dxMKvFFlAwZ6BsN4Lok/sbWfYt4QLaBX3q+nbJxMkSxCXpzCAsGQCQDwC0WS4W
         V4TJ0sJwLJ2uop85oYno40OU9Nh4QNwRJix5SQQpFs8ofIVJ7TDUpD+5JanzlR7r+y
         SUN7ulcF6XmCElTgob0ZbirUhlJjHguE6UDWea1ql+CWAQC14ngp2D1du9hg1Vh9Mr
         jLVkovH3TV8i8psaInxfnZlB9L6L6wnTL4QWWVeW1NAnUcJyeru3+tqxqvIxQ9LzFB
         ksuFxaCUbtU8Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/6] ath11k: Add basic WoW functionalities
References: <20211011193750.4891-1-cjhuang@codeaurora.org>
        <20211011193750.4891-2-cjhuang@codeaurora.org>
Date:   Thu, 09 Dec 2021 16:48:18 +0200
In-Reply-To: <20211011193750.4891-2-cjhuang@codeaurora.org> (Carl Huang's
        message of "Mon, 11 Oct 2021 15:37:45 -0400")
Message-ID: <87czm525sd.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <cjhuang@codeaurora.org> writes:

> Implement basic WoW functionalities such as magic-packet, disconnect
> and pattern. The logic is very similar to ath10k.
>
> When WoW is configured, ath11k_core_suspend and ath11k_core_resume
> are skipped as WoW configuration and hif suspend/resume are done in
> ath11k_wow_op_suspend() and ath11k_wow_op_resume().
>
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>

[...]

>  int ath11k_core_suspend(struct ath11k_base *ab)
>  {
>  	int ret;
> +	struct ath11k *ar;
>  
>  	if (!ab->hw_params.supports_suspend)
>  		return -EOPNOTSUPP;
>  
> +	/* so far single_pdev_only chips have supports_suspend as true
> +	 * and only the first pdev is valid.
> +	 */
> +	ar = ab->pdevs[0].ar;

I'm a bit worried about this assumption, it might change in the future.
What about a helper like this to add a test for it:

static inline struct ath11k_pdev *ath11k_core_get_single_pdev()
{
        WARN_ON(!ab->hw_params.single_pdev_only);

        return ab->pdevs[0];
}

>  int ath11k_core_resume(struct ath11k_base *ab)
>  {
>  	int ret;
> +	struct ath11k *ar;
>  
>  	if (!ab->hw_params.supports_suspend)
>  		return -EOPNOTSUPP;
>  
> +	/* so far signle_pdev_only chips have supports_suspend as true
> +	 * and only the first pdev is valid.
> +	 */
> +	ar = ab->pdevs[0].ar;
> +	if (!ar || ar->state != ATH11K_STATE_OFF)
> +		return 0;

The same helper could be used here.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
