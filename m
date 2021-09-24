Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC80417642
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 15:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhIXNyP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 09:54:15 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:32120 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346366AbhIXNyO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 09:54:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632491561; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=pcTVrwUuMYYa1fd+/Gk31WRvxLa+fVnV7jCDUBlS3a0=; b=MotlSDdEp7+r+oc1kqIeXom8ImBL5ks12xLsbdpciIUWiF8C+GcmiBpxE5pKBfgNAHuGxmKa
 hvEpsudsoTF0+ykOQsNzm8a17aKgX32uOo/2ebGqumF1TS3+pwKBM53POR+2DKknp5mVtns5
 tnBdEo/5l+142CQSEe9YAQzy1ek=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 614dd829e0480a7d6fac6fec (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Sep 2021 13:52:41
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1850AC4338F; Fri, 24 Sep 2021 13:52:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D77EC4360D;
        Fri, 24 Sep 2021 13:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 7D77EC4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: Re: [PATCH 1/3] ath11k: add htt cmd to enable full monitor mode
References: <20210721171905.61838-1-jouni@codeaurora.org>
        <20210721171905.61838-2-jouni@codeaurora.org>
Date:   Fri, 24 Sep 2021 16:52:34 +0300
In-Reply-To: <20210721171905.61838-2-jouni@codeaurora.org> (Jouni Malinen's
        message of "Wed, 21 Jul 2021 20:19:03 +0300")
Message-ID: <87ilyqrsgt.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> writes:

> From: Anilkumar Kolli <akolli@codeaurora.org>
>
> Add a new hw_param full_monitor_mode to enable full monitor support for
> QCN9074. HTT_H2T_MSG_TYPE_RX_FULL_MONITOR_MODE cmd is sent to the
> firmware to enable the full monitor mode.
>
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/core.c  |  4 ++
>  drivers/net/wireless/ath/ath11k/dp.h    | 74 +++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/dp_tx.c | 48 ++++++++++++++++
>  drivers/net/wireless/ath/ath11k/dp_tx.h |  2 +
>  drivers/net/wireless/ath/ath11k/hw.h    |  1 +
>  5 files changed, 129 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 969bf1a590d9..3179495cb3c9 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -65,6 +65,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  					BIT(NL80211_IFTYPE_AP) |
>  					BIT(NL80211_IFTYPE_MESH_POINT),
>  		.supports_monitor = true,
> +		.full_monitor_mode = false,
>  		.supports_shadow_regs = false,
>  		.idle_ps = false,
>  		.cold_boot_calib = true,
> @@ -106,6 +107,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  					BIT(NL80211_IFTYPE_AP) |
>  					BIT(NL80211_IFTYPE_MESH_POINT),
>  		.supports_monitor = true,
> +		.full_monitor_mode = false,
>  		.supports_shadow_regs = false,
>  		.idle_ps = false,
>  		.cold_boot_calib = true,
> @@ -146,6 +148,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
>  					BIT(NL80211_IFTYPE_AP),
>  		.supports_monitor = false,
> +		.full_monitor_mode = false,
>  		.supports_shadow_regs = true,
>  		.idle_ps = true,
>  		.cold_boot_calib = false,
> @@ -184,6 +187,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  					BIT(NL80211_IFTYPE_AP) |
>  					BIT(NL80211_IFTYPE_MESH_POINT),
>  		.supports_monitor = true,
> +		.full_monitor_mode = true,
>  		.supports_shadow_regs = false,
>  		.idle_ps = false,
>  		.cold_boot_calib = false,

wcn6855 was not updated, I added that.

> --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
> @@ -1034,6 +1034,15 @@ int ath11k_dp_tx_htt_monitor_mode_ring_config(struct ath11k *ar, bool reset)
>  	struct htt_rx_ring_tlv_filter tlv_filter = {0};
>  	int ret = 0, ring_id = 0, i;
>  
> +	if (ab->hw_params.full_monitor_mode) {
> +		ret = ath11k_dp_tx_htt_rx_full_mon_setup(ab,
> +							 dp->mac_id, !reset);
> +		if (ret < 0) {
> +			ath11k_err(ab, "failed to setup full monitor %d\n", ret);

I changed this to:

		if (ret) {
			ath11k_warn(ab, "failed to setup full monitor: %d\n", ret);
			return ret;
		}

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
