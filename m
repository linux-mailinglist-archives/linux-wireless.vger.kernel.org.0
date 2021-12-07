Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D677F46C115
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 17:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238821AbhLGQ70 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 11:59:26 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:37212 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbhLGQ70 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 11:59:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CAA8BCE1C64
        for <linux-wireless@vger.kernel.org>; Tue,  7 Dec 2021 16:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E1CC341C3;
        Tue,  7 Dec 2021 16:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638896152;
        bh=9wwvZs+yVczrOqKsz4pGQrP1UKcx4uLoOGbsJoo8H2M=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nphsx6Rd66rCNlNGdY6Dp8ERYk2ICqU46OAl6F5yIA+xN3Cl9+fIX9AeAtqMAshAi
         lvYfYhC/qmypiJUwE2QPpRLpctqMYHq7Psygdx3PGPLt/o+lp0pUDf70QAxpJIbPzV
         y7vbiT2IXaXTrA8JYpFulTEFMPsk8q5WMAXETD9Jpi6XrtUDEZOox6luwIjyg5U1KT
         AsfR+16jrxtfexkKLPaPvQxtCnWkv9F2H7nndbopwSryDxUxDsQkaaV0ozMr3rp5ir
         Y2DIBaRb9usDvYsoqru/h+N2HbVYcsXMTJcn0uJmJcW6HL/4NlSO5w5sMfpEL4fEF1
         JQVnkA0sjjHcQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCHv2 2/2] ath11k: add spectral/CFR buffer validation support
References: <1637312901-10279-1-git-send-email-quic_vnaralas@quicinc.com>
        <1637312901-10279-2-git-send-email-quic_vnaralas@quicinc.com>
Date:   Tue, 07 Dec 2021 18:55:46 +0200
In-Reply-To: <1637312901-10279-2-git-send-email-quic_vnaralas@quicinc.com>
        (Venkateswara Naralasetty's message of "Fri, 19 Nov 2021 14:38:21
        +0530")
Message-ID: <87y24wmk19.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Venkateswara Naralasetty <quic_vnaralas@quicinc.com> writes:

> Currently there is no validation on the spectral/CFR report
> over the db ring buffers from the hardware. Improper/incomplete
> DMA by the target can result in invalid data received by host.
> Due to this we may populate incorrect data to user space.
>
> This buffer validation support fix this issues by filling some
> magic value in the buffer during buffer replenish and check for
> the magic value in the buffer received by the target. If host
> detect magic value in the received buffer it will drop the buffer.
>
> Tested-on: IPQ8074 WLAN.HK.2.4.0.1-01467-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> ---
> v2:
>  * Rebased on TOT
>
>  drivers/net/wireless/ath/ath11k/dbring.c   | 32 ++++++++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/dbring.h   |  1 +
>  drivers/net/wireless/ath/ath11k/spectral.c | 10 ++++++++++
>  3 files changed, 43 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath11k/dbring.c b/drivers/net/wireless/ath/ath11k/dbring.c
> index 31cf7ac..5c07442 100644
> --- a/drivers/net/wireless/ath/ath11k/dbring.c
> +++ b/drivers/net/wireless/ath/ath11k/dbring.c
> @@ -6,6 +6,37 @@
>  #include "core.h"
>  #include "debug.h"
>  
> +#define ATH11K_DB_MAGIC_VALUE 0xdeadbeaf
> +
> +int ath11k_dbring_validate_buffer(struct ath11k *ar, void *buffer, u32 size)
> +{
> +	u32 *temp;
> +	int idx;
> +
> +	size = size >> 2;
> +
> +	for (idx = 0, temp = buffer; idx < size; idx++, temp++) {
> +		if (*temp == ATH11K_DB_MAGIC_VALUE) {
> +			ath11k_warn(ar->ab, "found magic value in the buffer\n");

I moved the warning message to the callers to make it easier to identify
where the corruption is happening and also added the word "dropping" to
make the message clearer for the user.

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6c90df4c7aca225c4c486f31ca956ae6c08abe59

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
