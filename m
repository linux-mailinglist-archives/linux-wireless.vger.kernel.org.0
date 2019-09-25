Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3B6BD7A8
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2019 07:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405153AbfIYFNx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Sep 2019 01:13:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39116 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388300AbfIYFNx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Sep 2019 01:13:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3A6646115D; Wed, 25 Sep 2019 05:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569388432;
        bh=uyezY+yPYzNZetQyZ4PtFeHdvxO2EXnjS44T11fWciQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=MaPkHcGfX7OfcwWqrJco4C9u4uuFo+J1WG5ru1CPadG0G4Wv54YErq+FFcvr7kYID
         xjyUTksotD4SklxrD4hobrfeT9ZpLB88g2YtXLqLrv924CqgOyGUy3037hOUfdMlNQ
         EU8bfshWrelpax7Iuv8veqe5BoIV3qvgMVeOLjoI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-136-106-186.rev.dnainternet.fi [37.136.106.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B219602E1;
        Wed, 25 Sep 2019 05:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569388431;
        bh=uyezY+yPYzNZetQyZ4PtFeHdvxO2EXnjS44T11fWciQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Nq7ekzud6M55tO4q9LBqpQX5NkzcRHUc+iT7PFkHgAlkvzkxf71Z4yXiU8h35k3b+
         /IGWames6cbaKE+oPl1HA5F5PlAGWD/ELgTRpElVMJ+TOV4F7dUp6UPfOoOlN5POWh
         TpTyqHMHWxV3Tah23eOlohhSzyVNXYt8t5YIKXBw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B219602E1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Dundi Raviteja <dundi@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] ath10k: Enable support for beacon interval per VAP
References: <1550579046-22649-1-git-send-email-dundi@codeaurora.org>
Date:   Wed, 25 Sep 2019 08:13:47 +0300
In-Reply-To: <1550579046-22649-1-git-send-email-dundi@codeaurora.org> (Dundi
        Raviteja's message of "Tue, 19 Feb 2019 17:54:06 +0530")
Message-ID: <87pnjp3qlw.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dundi Raviteja <dundi@codeaurora.org> writes:

> Enable support to configure different beacon interval per VAP.
>
> To support this feature, map different beacon interval service bit
> to wmi tlv service.
>
> Tested HW: WCN3990
> Tested FW: WLAN.HL.2.0-01188-QCAHLSWMTPLZ-1
>
> Signed-off-by: Dundi Raviteja <dundi@codeaurora.org>

[...]

> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -8232,6 +8232,30 @@ void ath10k_mac_destroy(struct ath10k *ar)
>  	},
>  };
>  
> +static struct
> +ieee80211_iface_combination ath10k_tlv_qcs_bcn_int_if_comb[] = {
> +	{
> +		.limits = ath10k_tlv_if_limit,
> +		.num_different_channels = 1,
> +		.max_interfaces = 4,
> +		.beacon_int_infra_match = true,
> +		.beacon_int_min_gcd = 1,
> +		.n_limits = ARRAY_SIZE(ath10k_tlv_if_limit),
> +	},
> +	{
> +		.limits = ath10k_tlv_qcs_if_limit,
> +		.num_different_channels = 2,
> +		.max_interfaces = 4,
> +		.n_limits = ARRAY_SIZE(ath10k_tlv_qcs_if_limit),
> +	},
> +	{
> +		.limits = ath10k_tlv_if_limit_ibss,
> +		.num_different_channels = 1,
> +		.max_interfaces = 2,
> +		.n_limits = ARRAY_SIZE(ath10k_tlv_if_limit_ibss),
> +	},
> +};
> +
>  static const struct ieee80211_iface_limit ath10k_10_4_if_limits[] = {
>  	{
>  		.max = 1,
> @@ -8642,6 +8666,15 @@ int ath10k_mac_register(struct ath10k *ar)
>  				ath10k_tlv_qcs_if_comb;
>  			ar->hw->wiphy->n_iface_combinations =
>  				ARRAY_SIZE(ath10k_tlv_qcs_if_comb);
> +
> +			if (test_bit
> +			    (WMI_SERVICE_VDEV_DIFFERENT_BEACON_INTERVAL_SUPPORT,
> +			    ar->wmi.svc_map)) {
> +				ar->hw->wiphy->iface_combinations =
> +						ath10k_tlv_qcs_bcn_int_if_comb;
> +				ar->hw->wiphy->n_iface_combinations =
> +				     ARRAY_SIZE(ath10k_tlv_qcs_bcn_int_if_comb);
> +			}

I don't like using WMI service flags to advertise different interface
combinations, it makes ath10k code convoluted. A much better approach is
to use WMI_SERVICE_IFACE_COMBINATION_SUPPORT:

ath10k:New interface to get interface combinations from FW

https://patchwork.kernel.org/patch/11027361/

-- 
Kalle Valo
