Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001CC46EC22
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 16:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbhLIPu4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 10:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240347AbhLIPuv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 10:50:51 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1ECC0617A2
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 07:47:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 531EECE268F
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 15:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AC9C341C7;
        Thu,  9 Dec 2021 15:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639064834;
        bh=YNOFaTpt1tvJv+y9fCTCvs/wMNi4pGUJVNtcNP24z30=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ryzWtrETFjq9LQ3PNVEnbp8XaS5CRAw39D3ZeapzuMta1z31qwWdbVLP6KXMF9e3i
         4LcJftgZflGxEFjIQ3PZaTA/sPeEB0oDMO/TvUEtp0HsmHkmkNzIRHgZ9cIBRnQ15v
         EZ9m/MYxZmLoXvnLuWbtjxdw0WAYPA769HTEhz9tIEML6YPuXSqL01otlbJnvVhHCv
         dE6hZGRs19O5b7w52kfynZUWPHUAGle12i+H5UTH95pU/EqHD3H8WuDWVl2Ui2NNa+
         dsAWt4myfeK49e/xYAtrM8g8Q9LMsaKYJTp6qtCFJHyI6SoNhDL8VSiOTz6rPFOW8h
         T+FUw9+zbFE9A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/6] ath11k: implement hw data filter
References: <20211011193750.4891-1-cjhuang@codeaurora.org>
        <20211011193750.4891-4-cjhuang@codeaurora.org>
Date:   Thu, 09 Dec 2021 17:47:10 +0200
In-Reply-To: <20211011193750.4891-4-cjhuang@codeaurora.org> (Carl Huang's
        message of "Mon, 11 Oct 2021 15:37:47 -0400")
Message-ID: <87mtl9zsox.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <cjhuang@codeaurora.org> writes:

> Host needs to set hw data filter before entering WoW to
> let firmware drop needless bc/mc frames to avoid frequent wakeup.
> Host clears hw data filter when leaving WoW.
>
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>

[...]

> @@ -598,8 +647,14 @@ int ath11k_wow_op_resume(struct ieee80211_hw *hw)
>  	}
>  
>  	ret = ath11k_wow_nlo_cleanup(ar);
> -	if (ret)
> +	if (ret) {
>  		ath11k_warn(ar->ab, "failed to cleanup nlo: %d\n", ret);
> +		goto exit;
> +	}
> +
> +	ret = ath11k_wow_clear_hw_filter(ar);
> +	if (ret)
> +		ath11k_warn(ar->ab, "failed to clear hw filter: %d\n", ret);
>  
>  exit:
>  	if (ret) {

For consistency please add goto exit for ath11k_wow_clear_hw_filter().

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
