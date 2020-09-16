Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4A926BB2D
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Sep 2020 05:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgIPD4w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Sep 2020 23:56:52 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:29385 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgIPD4v (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Sep 2020 23:56:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600228609; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=zhAWbSljlJgUnLLmClLio7hKzg7MfXDGtftCum5hJo8=;
 b=RfqnrjbSukfv9reEDEgzPTL+IihgbSLlnYZ8lQNn8RqMDVtrsye0FFHa89rA4DQln9GATm+w
 rimnfcr8rn+MyqImmA/zc8HdiadCI3UrH5TkbTKaiq0ebpJ+DLASky2hSY9z+njXLnA19Phk
 55TNzzQGHs2H8nzhNgPosY0dzZU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f618d019f3347551f7f36e2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Sep 2020 03:56:49
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6DAECC433F0; Wed, 16 Sep 2020 03:56:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BF171C433C8;
        Wed, 16 Sep 2020 03:56:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 16 Sep 2020 11:56:47 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH v5 2/8] ath11k: add support for 6GHz radio in driver
In-Reply-To: <20200603001724.12161-3-pradeepc@codeaurora.org>
References: <20200603001724.12161-1-pradeepc@codeaurora.org>
 <20200603001724.12161-3-pradeepc@codeaurora.org>
Message-ID: <98d81c8fab17ee4ed32aa8dee8dd7736@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-06-03 08:17, Pradeep Kumar Chitrapu wrote:
> This patch adds 6GHz band support and mac80211 registration for
> the 6G phy radio.
> 
> Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
> ---
> v5:
>  - do not add ht/vht caps in 6ghz band.
> v3:
>  - update 6GHz starting frequency as defined in IEEE P802.11ax/D6.1
> 
>  drivers/net/wireless/ath/ath11k/core.h |  6 +-
>  drivers/net/wireless/ath/ath11k/mac.c  | 93 +++++++++++++++++++++-----
>  drivers/net/wireless/ath/ath11k/wmi.c  | 16 ++++-
>  3 files changed, 94 insertions(+), 21 deletions(-)
> 
[...]
> diff --git a/drivers/net/wireless/ath/ath11k/wmi.c
> b/drivers/net/wireless/ath/ath11k/wmi.c
> index c2a972377687..291fb274134f 100644
> --- a/drivers/net/wireless/ath/ath11k/wmi.c
> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
> @@ -368,6 +368,17 @@ ath11k_pull_mac_phy_cap_svc_ready_ext(struct
> ath11k_pdev_wmi *wmi_handle,
>  	memcpy(&cap_band->he_ppet, &mac_phy_caps->he_ppet5g,
>  	       sizeof(struct ath11k_ppe_threshold));
> 
> +	cap_band = &pdev_cap->band[NL80211_BAND_6GHZ];
> +	cap_band->max_bw_supported = mac_phy_caps->max_bw_supported_5g;
> +	cap_band->ht_cap_info = mac_phy_caps->ht_cap_info_5g;
> +	cap_band->he_cap_info[0] = mac_phy_caps->he_cap_info_5g;
> +	cap_band->he_cap_info[1] = mac_phy_caps->he_cap_info_5g_ext;
> +	cap_band->he_mcs = mac_phy_caps->he_supp_mcs_5g;
> +	memcpy(cap_band->he_cap_phy_info, &mac_phy_caps->he_cap_phy_info_5g,
> +	       sizeof(u32) * PSOC_HOST_MAX_PHY_SIZE);
> +	memcpy(&cap_band->he_ppet, &mac_phy_caps->he_ppet5g,
> +	       sizeof(struct ath11k_ppe_threshold));
> +
>  	return 0;
>  }
> 
I want to move this under below check(if (mac_phy_caps->supported_bands 
& WMI_HOST_WLAN_5G_CAP) ),
becuase single_pdev 
introduced(https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/drivers/net/wireless/ath/ath11k?id=5f859bc02c7bc7a4094bfba0b4ed145edd7661f2)

Is it will distrub your original logic?
[...]
