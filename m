Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93B4260AAC
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 08:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgIHGQA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 02:16:00 -0400
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:34022
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728775AbgIHGQA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 02:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599545759;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=VMiemkVD8yJlEdrlW9L4KQe/m0sUPmu/eZlwgIzkXDM=;
        b=OlvEcjHv79vMi243YAl8yq/AEvNilxC8NEM02AIYyKltlmcvIGozlyOcccDpKXF2
        e/O9mzWL06t3FJNtuuwSf6zS7PWFs0yBcCVKB3dOWXKwaFqSKe4HHO2MrLm26npOJ9r
        QXie8A8IsmngCkXCN8iO82RW2/RAzMoNMaGR0GGA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599545759;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=VMiemkVD8yJlEdrlW9L4KQe/m0sUPmu/eZlwgIzkXDM=;
        b=PlZK/zo8OiL5cXzbAwz0oU7gwOkBw+XnhEK66v8ntSK3IKdhFqGnV2duWSWPBOGf
        Um2TJ0Mb2gHLCqEoninn9UvxMeRAHZXrB2CFUYTDRvnlSriXAsGc2TOON7XEFDA+ZyM
        BF8uLC4nMqQfH+e+cwdVaW4O06ZycuN2dB1/5QoM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3AA1C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH V5 5/5] ath11k: add support for BSS coloring
References: <20200826055650.1101224-1-john@phrozen.org>
        <20200826055650.1101224-5-john@phrozen.org>
Date:   Tue, 8 Sep 2020 06:15:59 +0000
In-Reply-To: <20200826055650.1101224-5-john@phrozen.org> (John Crispin's
        message of "Wed, 26 Aug 2020 07:56:50 +0200")
Message-ID: <010101746c5b561b-0d2e710d-262e-46d9-b08f-d11e9546c438-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.08-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> writes:

> Whenever the MAC detects a color collision or any of its associated station
> detects one the FW will send out an event. Add the code to parse and handle
> this event. and pass the data up to mac80211.
>
> The FW does not provide an offload feature such as the one used for CSA. The
> color change process is hence triggered via the beacon offload tx completion events
> sent out by the FW.
>
> Signed-off-by: John Crispin <john@phrozen.org>

Tested-on tag missing.

I wonder if QCA6390 supports this and are there any regressions, do you
know?

> @@ -2076,6 +2092,24 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
>  			if (ret)
>  				ath11k_warn(ar->ab, "failed to set bss color collision on vdev %i: %d\n",
>  					    arvif->vdev_id,  ret);
> +
> +			param_id = WMI_VDEV_PARAM_BSS_COLOR;
> +			if (info->he_bss_color.enabled)
> +				param_value = info->he_bss_color.color <<
> +						IEEE80211_HE_OPERATION_BSS_COLOR_OFFSET;
> +			else
> +				param_value = IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED;
> +
> +			ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
> +							    param_id,
> +							    param_value);
> +			if (ret)
> +				ath11k_warn(ar->ab,
> +					    "failed to set bss color param on vdev %i: %d\n",
> +					    arvif->vdev_id,  ret);
> +
> +			ath11k_info(ar->ab, "bss color param 0x%x set on vdev %i\n",
> +				    param_value, arvif->vdev_id);

Shouldn't this be a debug message?

> @@ -6083,6 +6117,7 @@ static int __ath11k_mac_register(struct ath11k *ar)
>  
>  	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
>  	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_STA_TX_PWR);
> +	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_BSS_COLOR);

So my QCA6390 question above is should we enable this for all hardware
or just for IPQ8074? If the latter, we should add a boolean to
hw_params. Or does the firmware advertise if it supports this feature?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
