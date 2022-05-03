Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E9E518820
	for <lists+linux-wireless@lfdr.de>; Tue,  3 May 2022 17:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbiECPVc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 May 2022 11:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbiECPVa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 May 2022 11:21:30 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95BE3A5F6
        for <linux-wireless@vger.kernel.org>; Tue,  3 May 2022 08:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651591077; x=1683127077;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BLQzsQAQEulbk5ygn5S9q0gNQ6kr1O2cVXrga4s4po8=;
  b=gKXUm0diKV0YyY4lv49hUaB6E7fPq/kUGDIBgkaZO/9+c/f+PImsPn2+
   0aMeQ+7FZ2s3dqyn6byA+dciuff/fQX6/We/s6bqAprzg5tbjwvu5pnPI
   JIdReSMm4COQZx7Ed3hIHaZJWUGUKBxbaKQ1fUKuMUeg/7QkntrZRbOrH
   8=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 May 2022 08:17:57 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 08:17:57 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 3 May 2022 08:17:57 -0700
Received: from [10.110.89.220] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 3 May 2022
 08:17:56 -0700
Message-ID: <f2f27831-03eb-3788-5855-649c0f33c785@quicinc.com>
Date:   Tue, 3 May 2022 08:17:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] ath11k: mac: fix too long line
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20220503060415.24499-1-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220503060415.24499-1-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/2/2022 11:04 PM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> checkpatch warns:
> 
> drivers/net/wireless/ath/ath11k/mac.c:7760: line length of 91 exceeds 90 columns
> 
> This was introduced by commit 046d2e7c50e3 ("mac80211: prepare sta handling for
> MLO support").
> 
> Compile tested only.
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath11k/mac.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index c76cac5d6849..32fb0142124d 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -7735,6 +7735,7 @@ ath11k_mac_validate_vht_he_fixed_rate_settings(struct ath11k *ar, enum nl80211_b
>   	bool he_fixed_rate = false, vht_fixed_rate = false;
>   	struct ath11k_peer *peer, *tmp;
>   	const u16 *vht_mcs_mask, *he_mcs_mask;
> +	struct ieee80211_link_sta *deflink;
>   	u8 vht_nss, he_nss;
>   	bool ret = true;
>   
> @@ -7757,13 +7758,16 @@ ath11k_mac_validate_vht_he_fixed_rate_settings(struct ath11k *ar, enum nl80211_b
>   	spin_lock_bh(&ar->ab->base_lock);
>   	list_for_each_entry_safe(peer, tmp, &ar->ab->peers, list) {
>   		if (peer->sta) {
> -			if (vht_fixed_rate && (!peer->sta->deflink.vht_cap.vht_supported ||
> -					       peer->sta->deflink.rx_nss < vht_nss)) {
> +			deflink = &peer->sta->deflink;


is there a reason to not declare deflink here?
then its scope of definition would equal the scope of usage


> +
> +			if (vht_fixed_rate && (!deflink->vht_cap.vht_supported ||
> +					       deflink->rx_nss < vht_nss)) {
>   				ret = false;
>   				goto out;
>   			}
> -			if (he_fixed_rate && (!peer->sta->deflink.he_cap.has_he ||
> -					      peer->sta->deflink.rx_nss < he_nss)) {
> +
> +			if (he_fixed_rate && (!deflink->he_cap.has_he ||
> +					      deflink->rx_nss < he_nss)) {
>   				ret = false;
>   				goto out;
>   			}
> 
> base-commit: f39af96d352dd4f36a4a43601ea90561e17e5ca6

