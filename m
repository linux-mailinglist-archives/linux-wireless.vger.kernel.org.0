Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529D246EAF2
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 16:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhLIPUV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 10:20:21 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:34548 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhLIPUS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 10:20:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E8479CE261B
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 15:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB83C004DD;
        Thu,  9 Dec 2021 15:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639063002;
        bh=66Cgp3VacMsVX3GfgxZ8ibIa5IwzQamvqK+EV/QKVKg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bIGEiPZiqi7eUzq/8DllDHRC87cX7v+aUs3PNpbB0DPQyeksPi3yWExMW6BI8lANG
         KoFBSubCGbLZL4qTV3qzadm8uZwL1ylwxH8KslNPj8LCuGgQwJQI2tlIrGuC7e0Ipx
         pEN7x8aSBYls/sWh+63b4ZxiuKN8kGFOj6T2xBYI0BABBFpSj0kKSBSEF+/rGJhBvh
         X6BNNIBiR0DQuZwg1nqZR5yU2pUDWrnP2bamRbK8eUL+yLBKrtE2iSB+/R41/unnRe
         zDaElO4nPrjOFrpZFbLbEXZNlYLTFGBMAHOjEwgirtu9IGoAsxvORBtuSNH/4020sI
         YQc7okdowDhWw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 5/6] ath11k: support ARP and NS offload
References: <20211011193750.4891-1-cjhuang@codeaurora.org>
        <20211011193750.4891-6-cjhuang@codeaurora.org>
Date:   Thu, 09 Dec 2021 17:16:38 +0200
In-Reply-To: <20211011193750.4891-6-cjhuang@codeaurora.org> (Carl Huang's
        message of "Mon, 11 Oct 2021 15:37:49 -0400")
Message-ID: <87r1alzu3t.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <cjhuang@codeaurora.org> writes:

> Support ARP and NS offload in WoW state.
>
> Tested this way: put machineA with QCA6390 to WoW state,
> ping/ping6 machineA from another machineB, check sniffer to see
> any ARP response and Neighbour advertisement from machineA.

s/machineA/machine A/
s/machineB/machine B/

> @@ -672,8 +712,15 @@ int ath11k_wow_op_resume(struct ieee80211_hw *hw)
>  	}
>  
>  	ret = ath11k_wow_clear_hw_filter(ar);
> -	if (ret)
> +	if (ret) {
>  		ath11k_warn(ar->ab, "failed to clear hw filter: %d\n", ret);
> +		goto exit;
> +	}
> +
> +	ret = ath11k_wow_protocol_offload(ar, false);
> +	if (ret)
> +		ath11k_warn(ar->ab, "failed to clear wow protocol offload events: %d\n",
> +			    ret);
>  
>  exit:
>  	if (ret) {

For consistency please add goto exit for ath11k_wow_protocol_offload().

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
