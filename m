Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73B8412BEE
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 13:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfECLBa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 07:01:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48582 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfECLBa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 07:01:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6309460E7A; Fri,  3 May 2019 11:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556881289;
        bh=KvQF9ucCFXh4SBqBgoTHtXk3eNkiuWkSDh/j4nC0a3I=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AzlpNkvAGa6fO6f2OM1IrO/21DwAO3s1kIoUA5wiXXO8+jDVNzIehraPBmMDb0mjZ
         G8MbDj+jsDUDrL3JCIgVdqwQ+Lx4RqLYoWOt0QfrjOFt33vfCICxudnUCQArPIe/op
         oAM8KxE4eMvvbwgqe/rdJpIJX8sBItj5TTYHVZQQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5E00160E57;
        Fri,  3 May 2019 11:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556881289;
        bh=KvQF9ucCFXh4SBqBgoTHtXk3eNkiuWkSDh/j4nC0a3I=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AzlpNkvAGa6fO6f2OM1IrO/21DwAO3s1kIoUA5wiXXO8+jDVNzIehraPBmMDb0mjZ
         G8MbDj+jsDUDrL3JCIgVdqwQ+Lx4RqLYoWOt0QfrjOFt33vfCICxudnUCQArPIe/op
         oAM8KxE4eMvvbwgqe/rdJpIJX8sBItj5TTYHVZQQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E00160E57
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 6/6] rtw88: more descriptions about LPS
References: <1556879502-16211-1-git-send-email-yhchuang@realtek.com>
        <1556879502-16211-7-git-send-email-yhchuang@realtek.com>
Date:   Fri, 03 May 2019 14:01:25 +0300
In-Reply-To: <1556879502-16211-7-git-send-email-yhchuang@realtek.com>
        (yhchuang@realtek.com's message of "Fri, 3 May 2019 18:31:42 +0800")
Message-ID: <87zho3kdiy.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> The LPS represents Leisure Power Save. When enabled, firmware will be in
> charge of turning radio off between beacons. Also firmware should turn
> on the radio when beacon is coming, and the data queued should be
> transmitted in TBTT period.
>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/main.c
> b/drivers/net/wireless/realtek/rtw88/main.c
> index f447361..6953013 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -20,7 +20,7 @@ EXPORT_SYMBOL(rtw_debug_mask);
>  module_param_named(support_lps, rtw_fw_support_lps, bool, 0644);
>  module_param_named(debug_mask, rtw_debug_mask, uint, 0644);
>  
> -MODULE_PARM_DESC(support_lps, "Set Y to enable LPS support");
> +MODULE_PARM_DESC(support_lps, "Set Y to enable Leisure Power Save
> support, turn radio off between beacons");

I think it would help to add:

", to turn radio off between beacons"

-- 
Kalle Valo
