Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E0246E3B9
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 09:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhLIIL2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 03:11:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38146 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhLIIL2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 03:11:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3CF6B8235C;
        Thu,  9 Dec 2021 08:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F405C004DD;
        Thu,  9 Dec 2021 08:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639037272;
        bh=9HSmsfMKHpF4f9eGjC4cv2s5/K0HxC/q6EHNgjltL8Q=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ITjPp9Fg5dys06q+H+NFzfGozFrNxZhZLI42km2lwKFIKTuhD0YkAoDh+CUAeXZ84
         YfQqSl8/MlO2R4GXcVL5aqUBKh6m/A9flq1U54IWaBQgIGvrm75rAtbXnPD5Lc90IL
         uhA+X91cnviVUV/TDKQ5v/H8FAo9RGVW8cli+ih34W2OYkUjtM2XaQHDOEkKolj7F/
         hpt8cATVojYZgYuoFFND9EC+U7bqN/Ogwg5h9JPBhbzQKaCeEn6tviWtMaPGTHeR7P
         zmpD/ztqluUyYDBJf9o4KvYk8UVZvpZHF1dgnazMtlf2FRKMO595T84tTEjgesaA0r
         NvFI9lTlK6Z5g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v7 2/2] ath11k: Use reserved host DDR addresses from DT for PCI devices
References: <1638789319-2950-1-git-send-email-akolli@codeaurora.org>
        <1638789319-2950-2-git-send-email-akolli@codeaurora.org>
Date:   Thu, 09 Dec 2021 10:07:49 +0200
In-Reply-To: <1638789319-2950-2-git-send-email-akolli@codeaurora.org>
        (Anilkumar Kolli's message of "Mon, 6 Dec 2021 16:45:19 +0530")
Message-ID: <87tufi42wa.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> writes:

> Host DDR memory (contiguous 45 MB in mode-0 or 15 MB in mode-2)
> is reserved through DT entries for firmware usage. Send the base
> address from DT entries.
> If DT entry is available, PCI device will work with
> fixed_mem_region else host allocates multiple segments.
>
> IPQ8074 on HK10 board supports multiple PCI devices.
> IPQ8074 + QCN9074 is tested with this patch.
>
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01838-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>

[...]

> @@ -349,8 +372,15 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
>  	if (!test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
>  		mhi_ctrl->irq_flags = IRQF_SHARED | IRQF_NOBALANCING;
>  
> -	mhi_ctrl->iova_start = 0;
> -	mhi_ctrl->iova_stop = 0xffffffff;
> +	if ((test_bit(ATH11K_FLAG_FIXED_MEM_RGN, &ab->dev_flags))) {

Unnecessary parenthesis, I fixed it in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
