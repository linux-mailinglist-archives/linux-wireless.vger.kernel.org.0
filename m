Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D531B76CBF4
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 13:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjHBLpt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 07:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbjHBLps (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 07:45:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B316226A1
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 04:45:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 523FC6193C
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 11:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19DFC433C7;
        Wed,  2 Aug 2023 11:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690976745;
        bh=zwoKG3lx3jesoWIM65Zml8EW8Hft2kRROiIGMP7TCKs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YR9WmRRwYB3w+kXXEB0NwMed/Q9l1QF6KxLe8+Jc3GC31rsCeu35OGfprLGtoQg8O
         9k7hsNstZgCi5AdFiAPd0Nd5ptrHI/zadBnV/0MxNHZSRmjOxDyfHX8LYgBkcD429n
         OMskULJz0rFqqP4Lhyp7HSutYKQo5ii3PaQKy+er1bQqNaCHrrPo2+s42IUSk3Jba/
         lJoh0UzC8N5HfDF/ChVsT9xN8JkOVmw3yM9zCmclvcmRApBVIVVgFzxYoCA7eEtkA4
         UriD/OpjUudKHWGnUWk3QO03APkwJ9K+BD3WtXHCZCYMkYNmz2+YojfTu1Vbk2jlK4
         pFL4BeqtKCePQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] wifi: ath11k: add support to select 6 GHz
 Regulatory type
References: <20230607094810.26707-1-quic_wgong@quicinc.com>
        <20230607094810.26707-2-quic_wgong@quicinc.com>
Date:   Wed, 02 Aug 2023 14:45:43 +0300
In-Reply-To: <20230607094810.26707-2-quic_wgong@quicinc.com> (Wen Gong's
        message of "Wed, 7 Jun 2023 05:48:06 -0400")
Message-ID: <87v8dxvfa0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> There are 3 types of regulatory rules for AP mode and 6 type for
> station mode. Add wmi_vdev_type and ieee80211_ap_reg_power to
> select the exact reg rules.
>
> Tested-on: WCN6855 hw2.0 PCI
> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

[...]

> --- a/drivers/net/wireless/ath/ath11k/reg.c
> +++ b/drivers/net/wireless/ath/ath11k/reg.c
> @@ -607,25 +607,64 @@ ath11k_reg_update_weather_radar_band(struct ath11k_base *ab,
>  	*rule_idx = i;
>  }
>  
> +enum wmi_reg_6ghz_ap_type
> +ath11k_ieee80211_ap_pwr_type_convert(enum ieee80211_ap_reg_power power_type)
> +{
> +	switch (power_type) {
> +	case IEEE80211_REG_LPI_AP:
> +		return WMI_REG_INDOOR_AP;
> +	case IEEE80211_REG_SP_AP:
> +		return WMI_REG_STANDARD_POWER_AP;
> +	case IEEE80211_REG_VLP_AP:
> +		return WMI_REG_VERY_LOW_POWER_AP;
> +	default:
> +		return WMI_REG_MAX_AP_TYPE;
> +	}

Rename to something like ath11k_reg_ap_pwr_convert()? And this can be a
static function, I don't see it used outside of reg.c.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
