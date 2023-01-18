Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACA367149C
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 08:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjARHEu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 02:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjARHDo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 02:03:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1740866FA4
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 22:33:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B918616B6
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 06:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DEAC433EF;
        Wed, 18 Jan 2023 06:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674023598;
        bh=RwxYuosURc59hD10m17FwTIIVzMWVJAUePzyWZQet/I=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=izLqVWSOTToFPMXZnCqI/Ofl4R0SLw3T8xaFmbi7F7/lk4ycfvPhHLfgHZSuAol6s
         gebvr5/RaFAIXsRrgUFhzMHumlBwrkRQqh4z+kqL/m0ZvfTv02z39uN60JgQ1idw5a
         jWEVekZl5xmwI4T6tXj44kQsicYjZcVKroImkdlj+fP77YhD1d/DprxV4m5k7PdMkS
         tL0kowc2plnIxE1Nt20BLMoCVVpwsMRNuG+H3EWuBFsihy3Cs/RURKwAMwiKpEG+wm
         vSbZTXRZqlBq05AD+ufSLWw/9SWXysvBBUslXecHWUHqFwmiZRu/qETMy0jx4wCK8k
         QPosAAxhb3G+g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Abinaya Kalaiselvan <quic_akalaise@quicinc.com>
Subject: Re: [PATCH] wifi: ath11k: Add tx ack signal support for mgmt packets
References: <20221219053844.4084486-1-quic_mkenna@quicinc.com>
Date:   Wed, 18 Jan 2023 08:33:14 +0200
In-Reply-To: <20221219053844.4084486-1-quic_mkenna@quicinc.com> (Maharaja
        Kennadyrajan's message of "Mon, 19 Dec 2022 11:08:44 +0530")
Message-ID: <87fsc8xsgl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maharaja Kennadyrajan <quic_mkenna@quicinc.com> writes:

> From: Abinaya Kalaiselvan <quic_akalaise@quicinc.com>
>
> Add support to notify tx ack signal values for mgmt
> packets to userspace through NL interface.
>
> Advertise NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT flag
> to enable this feature and it will be used for data
> packets as well.
>
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Abinaya Kalaiselvan <quic_akalaise@quicinc.com>
> Signed-off-by: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>

[...]

> --- a/drivers/net/wireless/ath/ath11k/wmi.h
> +++ b/drivers/net/wireless/ath/ath11k/wmi.h
> @@ -2309,6 +2309,7 @@ struct wmi_init_cmd {
>  } __packed;
>  
>  #define WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64 BIT(5)
> +#define WMI_RSRC_CFG_FLAG1_ACK_RSSI BIT(18)
>  
>  struct wmi_resource_config {
>  	u32 tlv_header;
> @@ -4541,6 +4542,8 @@ struct wmi_mgmt_tx_compl_event {
>  	u32 desc_id;
>  	u32 status;
>  	u32 pdev_id;
> +	u32 ppdu_id;
> +	u32 ack_rssi;
>  } __packed;

Adding these two fields increases the minimum length for
WMI_TAG_MGMT_TX_COMPL_EVENT:

	[WMI_TAG_MGMT_TX_COMPL_EVENT]
		= { .min_len = sizeof(struct wmi_mgmt_tx_compl_event) },

If we have a firmware version which doesn't include ppdu_id and ack_rssi
in WMI_TAG_MGMT_TX_COMPL_EVENT ath11k will drop those events. Not sure
what to do.

Is it certain that all ath11k firmware versions have ppdu_id and
ack_rssi? Or should handle so in ath11k that ppdu_id and ack_rssi can be
optional in the event?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
