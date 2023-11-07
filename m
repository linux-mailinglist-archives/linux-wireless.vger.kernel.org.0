Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7DB7E3F1C
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Nov 2023 13:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbjKGMsF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Nov 2023 07:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbjKGMrt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Nov 2023 07:47:49 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE913A21C
        for <linux-wireless@vger.kernel.org>; Tue,  7 Nov 2023 04:33:47 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-66d0169cf43so36495226d6.3
        for <linux-wireless@vger.kernel.org>; Tue, 07 Nov 2023 04:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699360426; x=1699965226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OBeH66RqA4binssm1/YZiUv+TJC+gxK19gaHjgxqkzM=;
        b=dGnyNGgTW3kOJ+DiRfNYpdllnYsuxcc1mALjzmaFyQOYOEDyrBsaKtmEDHUHfGgTem
         2zpC4jwAt7sIeEKd3/kCrSIoiaO1WtDMWZlGP2rdt6r/BmJRGFdJ3tKAHSjLNJbccGgh
         A9cgnZzeiaz5f1dK5AiQksBlXSMVS6uDlwjQzw+ns9lrE4QizmvlwXUdioMdZf4/DoFv
         oJVzXBqCYsRQ2el0Z8xhgkD0F4nhROT79yMh0/wh8LlwAJxNOttlaHnMUm+2owRsWOch
         ewBWHUu720B0RN5zMN0VFqFjulhL76weasLkIbqCrJPcb/zPW2K+5Crui8j4mJ0QTS3x
         39mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699360426; x=1699965226;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OBeH66RqA4binssm1/YZiUv+TJC+gxK19gaHjgxqkzM=;
        b=Q4zgxNvu7fmpshcMsD0qHy+1uGhHcIruO8AkggIMbVt/vHvQu7dv5vtH1iRLqSqUN1
         r3O1lXzESyAt/2r8sVGGMchRSNWbMEVAkfaZeAAibJhUP06mkf/SBpXQk5QCvDP6zlQo
         5UYQBEEQIdpKlDukbhYjAsMB7pR/6yM32clr6yHh83aP0dd2dXYgE4Eji0jI+/TMhStc
         DSfXre7/duJJEGI7BOAOIPPcIx7jr6sM8G9hlXnjgaqqWHLNGq7gy8LdNw9hysf6Oqy5
         Dpd1sG5TH3YQ5xuj9OiqGZOyaDKGq3d6fmuaxfs9NfY1WPBMu1gi2whDT+Wkg1MKEda+
         O/SQ==
X-Gm-Message-State: AOJu0Yw+p2kq24moSFD3DnkNyKXJaLLBcxBT6t4r2k2e6VSg4UjBhzoI
        f6uTx0KK5OgEWyyQgLwYCKQ0b8R0Tlw=
X-Google-Smtp-Source: AGHT+IGxTpcW3HDGq7ZoXTKUwf3NXYiQ++fssfXabnLIu393CsWKFaMYyJo002ZL6ASGNrp/zbQkPA==
X-Received: by 2002:a05:6214:21cf:b0:66c:fc2d:80a3 with SMTP id d15-20020a05621421cf00b0066cfc2d80a3mr35210411qvh.33.1699360426283;
        Tue, 07 Nov 2023 04:33:46 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id e7-20020a0cf747000000b0066db33eeeb7sm4331901qvo.131.2023.11.07.04.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 04:33:46 -0800 (PST)
Message-ID: <93d905b4-3c64-470c-8a40-60b8547855a2@gmail.com>
Date:   Tue, 7 Nov 2023 04:33:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: add support to allow broadcast action from
 RX
Content-Language: en-US
To:     linux-wireless@vger.kernel.org
References: <20231017165306.118779-1-prestwoj@gmail.com>
Cc:     ath10k@lists.infradead.org, quic_jjohnson@quicinc.com
From:   James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20231017165306.118779-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Re-sending as its been a few weeks, thanks Jeff for adding the ath10k CC.

On 10/17/23 9:53 AM, James Prestwood wrote:
> Advertise support for multicast frame registration and update the RX
> filter with FIF_MCAST_ACTION to allow broadcast action frames to be
> received. Broadcast action frames are needed for the Device
> Provisioning Protocol (DPP) for Presence and PKEX Exchange requests.
> 
> Signed-off-by: James Prestwood <prestwoj@gmail.com>
> ---
>   drivers/net/wireless/ath/ath10k/mac.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> index 03e7bc5b6c0b..932ace5b900b 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -1249,7 +1249,7 @@ static bool ath10k_mac_monitor_vdev_is_needed(struct ath10k *ar)
>   	return ar->monitor ||
>   	       (!test_bit(ATH10K_FW_FEATURE_ALLOWS_MESH_BCAST,
>   			  ar->running_fw->fw_file.fw_features) &&
> -		(ar->filter_flags & FIF_OTHER_BSS)) ||
> +		(ar->filter_flags & (FIF_OTHER_BSS | FIF_MCAST_ACTION))) ||
>   	       test_bit(ATH10K_CAC_RUNNING, &ar->dev_flags);
>   }
>   
> @@ -6020,6 +6020,7 @@ static void ath10k_remove_interface(struct ieee80211_hw *hw,
>   	FIF_OTHER_BSS |				\
>   	FIF_BCN_PRBRESP_PROMISC |		\
>   	FIF_PROBE_REQ |				\
> +	FIF_MCAST_ACTION |			\
>   	FIF_FCSFAIL)
>   
>   static void ath10k_configure_filter(struct ieee80211_hw *hw,
> @@ -10121,6 +10122,8 @@ int ath10k_mac_register(struct ath10k *ar)
>   	wiphy_ext_feature_set(ar->hw->wiphy,
>   			      NL80211_EXT_FEATURE_SET_SCAN_DWELL);
>   	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_AQL);
> +	wiphy_ext_feature_set(ar->hw->wiphy,
> +			      NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS);
>   
>   	if (test_bit(WMI_SERVICE_TX_DATA_ACK_RSSI, ar->wmi.svc_map) ||
>   	    test_bit(WMI_SERVICE_HTT_MGMT_TX_COMP_VALID_FLAGS, ar->wmi.svc_map))
