Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417CE46F182
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 18:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242726AbhLIRZD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 12:25:03 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:47376 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbhLIRZD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 12:25:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5B860CE276F
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 17:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E04C004DD;
        Thu,  9 Dec 2021 17:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639070486;
        bh=yHZ3BWinJ0pAFz+/sk9jf+axKOu0yEghOAFBuX78R4A=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nIvkR7yeOTEiN0/vFE/won6NhuwOo+MnpZaK++HBLw09zgu2cbgCrmjz1BQFzKGpm
         tUhErojDFchJ16eYLHhVX03C1ZkkFOYJUXI/17JqcQTeXhPCIVuVkkmTsA3ZzWy/PN
         nZ8Ib8vQ5sy9M5NNiALCLdMCc2uThSRNwx0Y0wGwchU833eDM8TXaSpKL93dydsvRl
         6MBYdVH7BqIhlVL4lmahZ23w3WlLAeXt8QJVQJavEb/NEyfLpETgP1uWXxCtsd80gX
         bclLceF12mPA61tDC5fbAo8TkVhHrFnApwm5TW1ebt/cDp4yZlMrsifGfG0kzWyqC/
         o4hD4pufmTl+g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 02/15] ath11k: Add support to parse new wmi event for 6 GHz regulatory
References: <20211026111913.7346-1-quic_wgong@quicinc.com>
        <20211026111913.7346-3-quic_wgong@quicinc.com>
Date:   Thu, 09 Dec 2021 19:21:20 +0200
In-Reply-To: <20211026111913.7346-3-quic_wgong@quicinc.com> (Wen Gong's
        message of "Tue, 26 Oct 2021 07:19:00 -0400")
Message-ID: <87bl1pwv73.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> In order to support different power levels of 6 GHz AP and client, new
> wmi event for regulatory was added in firmware(WMI_REG_CHAN_LIST_CC_EXT_EVENTID)
> to provide new parameters required for 6 GHz regulatory rules.
>
> firmware advertises its capability of handling new event in wmi service ready
> event. Based on that, host needs to set host_service_flags in wmi init
> command to indicate that host supports processing of new wmi event.
> Based on advertised host capability, firmware decides to send old event
> (WMI_REG_CHAN_LIST_CC_EVENTID) or new event(WMI_REG_CHAN_LIST_CC_EXT_EVENTID).
>
> Add support for parsing 2.4 GHz/5 GHz/6 GHz reg rules and other parameters from
> WMI_REG_CHAN_LIST_CC_EXT_EVENTID, to populate the channel lists.
> Since 6 GHz requires additional power value fields(PSD info), update
> reg rule parsing function.
>
> Signed-off-by: Lavanya Suresh <quic_lavaks@quicinc.com>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

[...]

> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -230,6 +230,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.supports_suspend = true,
>  		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
>  		.fix_l1ss = false,
> +		.support_ext_cc = true,
>  	},
>  };

Please add all the false cases as well. I'm trying to keep all hardware
entries have all fields specified.

> diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
> index 67b843a92344..a65f7d00eea2 100644
> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -966,4 +966,10 @@ static inline const char *ath11k_bus_str(enum ath11k_bus bus)
>  	return "unknown";
>  }
>  
> +static inline bool ath11k_support_cc_ext(struct ath11k_base *ab)
> +{
> +	return ab->hw_params.support_ext_cc &&
> +	       test_bit(WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT, ab->wmi_ab.svc_map);
> +}

Add core:

ath11k_core_supports_cc_ext()

Or maybe it would be more intuitive to have this in hw.h?

ath11k_hw_supports_cc_ext()

> diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
> index b17c37e9eda7..86fd9dc82983 100644
> --- a/drivers/net/wireless/ath/ath11k/hw.h
> +++ b/drivers/net/wireless/ath/ath11k/hw.h
> @@ -164,6 +164,7 @@ struct ath11k_hw_params {
>  	bool supports_suspend;
>  	u32 hal_desc_sz;
>  	bool fix_l1ss;
> +	bool support_ext_cc;

supports_ext_cc

But in ath11k_core_supports_cc_ext() you cc before ext, maybe it should
be the same here as well? Something like:

supports_cc_ext

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
