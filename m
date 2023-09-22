Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EE77AAEB4
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Sep 2023 11:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjIVJt2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Sep 2023 05:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjIVJt2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Sep 2023 05:49:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D188F
        for <linux-wireless@vger.kernel.org>; Fri, 22 Sep 2023 02:49:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D33C433CA;
        Fri, 22 Sep 2023 09:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695376162;
        bh=2PkDm1MBm9PwOayUT8B1AXo/8GTs8ZUrZ1gkVupKLIA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ERvDa4x+FiQk+KW9/bcKyjBekstgDIhGC9arW4HDX2iFt41YsW420PUWBTtuz1zV0
         gP6yBt615lK7gBy//cYNsdDRPMEZa5SDuJzWeh2m6T3XNaboGKNYZxI4Sd45LUKvms
         B0W9UkbKMPwB/5XNJ2BybnNUbAtTbt1K61STrDovmnBMJPsn1tiHPBNGeGlM80lmNS
         wkrJAT0o6dEoRnUdhbBHsrTORUnbDoeN40SK2FnpCQKBya4zPrCFTExKfFy/ulHHxW
         vzYrScQ+uRsBN4YNSnAuljw/Sw/q+MDH4Ux9Y2AbDBEaxobr1XqDpkn7KMn2zv/xH/
         dVAKf7LVG6G9A==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: ath11k: mac: fix struct
 ieee80211_sband_iftype_data handling
References: <20230921075440.1539515-1-kvalo@kernel.org>
Date:   Fri, 22 Sep 2023 12:49:19 +0300
In-Reply-To: <20230921075440.1539515-1-kvalo@kernel.org> (Kalle Valo's message
        of "Thu, 21 Sep 2023 10:54:40 +0300")
Message-ID: <87ediqa674.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> From: Kalle Valo <quic_kvalo@quicinc.com>
>
> Commit e8c1841278a7 ("wifi: cfg80211: annotate iftype_data pointer with
> sparse") added sparse checks for struct ieee80211_sband_iftype_data handling
> which immediately found an issue in ath11k:
>
> drivers/net/wireless/ath/ath11k/mac.c:7952:22: warning: incorrect type
> in argument 1 (different address spaces)
> drivers/net/wireless/ath/ath11k/mac.c:7952:22: expected struct
> ieee80211_sta_he_cap const *he_cap
> drivers/net/wireless/ath/ath11k/mac.c:7952:22: got struct
> ieee80211_sta_he_cap const [noderef] __iftype_data *
>
> The problem here is that we are accessing sband->iftype_data directly even
> though we should use for_each_sband_iftype_data(). Now we iterate over each
> item in the array and use the correct vif type which this vif is using.
>
> Tested-on: WCN6855 hw2.0 PCI
> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
>
> Reported-by: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

[...]

> @@ -7949,7 +7951,17 @@ ath11k_mac_bitrate_mask_get_single_nss(struct ath11k *ar,
>  			return false;
>  	}
>  
> -	he_mcs_map = le16_to_cpu(ath11k_mac_get_tx_mcs_map(&sband->iftype_data->he_cap));
> +	for_each_sband_iftype_data(sband, i, iftd) {
> +		if (iftd->types_mask & BIT(arvif->vif->type)) {
> +			iftype_data = iftd;
> +			break;
> +		}
> +	}
> +
> +	if (iftype_data == NULL)
> +		return false;
> +
> +	he_mcs_map = le16_to_cpu(ath11k_mac_get_tx_mcs_map(&iftype_data->he_cap));

Johannes pointed out that I should use ieee80211_get_he_iftype_cap_vif()
instead. I'll submit v2.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
