Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21D146ECE5
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 17:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240887AbhLIQU1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 11:20:27 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57632 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240808AbhLIQUV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 11:20:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D74D6CE26DC
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 16:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492DAC341C3;
        Thu,  9 Dec 2021 16:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639066605;
        bh=vIafIP6C3RpogBuFFp1t3jgJ2dzSziVrRC/XH3biL8c=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GcfEwhKmiTJvQQ5Y0fKoT15Y9A1t0xqh1GG/ENdGwU9mE6DeNp2c1AKkVoGzrikw9
         4cMeyUhadDPh8QmpDaiqHmAjLbend0c40d/M7yyi2CaRd5oj/0sqxITMoJty6SbTol
         ZdIVG3uoflGskKwkMcdMFqm81zmMXPaDQMd9LhZHxh9/6lteI7DadFvnTESmNpC6pR
         iKQx5XXfomA+zjCwPWXKnl8Rfdkz1o0mRZsarR1Uf4XIvJWIPlmsxt5ywVRpMWqc4s
         HOdEWEcjuxosrmqJhy1rAQNDiZ3Qm4zMbRNl7ylVTiRS0Vkt3XAqrIf6YyZIoJZ8uW
         OtFl7RxGn+OlA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 01/15] ath11k: add support for extended wmi service bit
References: <20211026111913.7346-1-quic_wgong@quicinc.com>
        <20211026111913.7346-2-quic_wgong@quicinc.com>
Date:   Thu, 09 Dec 2021 18:16:41 +0200
In-Reply-To: <20211026111913.7346-2-quic_wgong@quicinc.com> (Wen Gong's
        message of "Tue, 26 Oct 2021 07:18:59 -0400")
Message-ID: <87fsr1wy6u.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> The max wmi service bit is 256 in ath11k, Extend it
> for more wmi service bit.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

[...]

> --- a/drivers/net/wireless/ath/ath11k/wmi.h
> +++ b/drivers/net/wireless/ath/ath11k/wmi.h
> @@ -2059,7 +2059,9 @@ enum wmi_tlv_service {
>  	WMI_TLV_SERVICE_EXT2_MSG = 220,
>  	WMI_TLV_SERVICE_SRG_SRP_SPATIAL_REUSE_SUPPORT = 249,
>  
> -	WMI_MAX_EXT_SERVICE
> +	WMI_MAX_EXT_SERVICE = 256,
> +
> +	WMI_MAX_EXT2_SERVICE
>  };
>  
>  enum {
> @@ -5066,7 +5068,7 @@ struct ath11k_wmi_base {
>  
>  	struct completion service_ready;
>  	struct completion unified_ready;
> -	DECLARE_BITMAP(svc_map, WMI_MAX_EXT_SERVICE);
> +	DECLARE_BITMAP(svc_map, WMI_MAX_EXT2_SERVICE);

I don't get this, why do we need two MAX enums? Please explain in the
commit log.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
