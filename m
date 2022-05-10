Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95A352213A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 18:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347403AbiEJQeL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 May 2022 12:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347385AbiEJQeC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 May 2022 12:34:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599D12044CF
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 09:30:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7054B81E1B
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 16:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8753C385A6;
        Tue, 10 May 2022 16:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652200201;
        bh=JcqMRF2kIwrTJsoNWDWbv7L3FOOPJ3N11qWphHlZbvA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hvfbW6JG8xrDLPmd2BgNXEgFRpUHkTbO9DBrw+rNAaStoXJlf6+lQ/9G7DaV++I2V
         fFRHW65kD0+hn3woRv1tE5JWbNa0Wesw7nifDV7DsMzLM1eVDVIHxIV3IarbnNTR8p
         7rtP81SYqaxpIeiNcaHs0JYLAPX3iekLegc800eBVOPhFndmuT0xoB4b2IIHDM955o
         8de4rtWgniMkWTROUiFRY5WlNRAXUdgDsbPO8SHkmJ4r3GULuksdKCUcYJB0aP9b6m
         yOf4RXTOgJTX6357z1Argdrw5To5VVNrEr5zn5oLs4KcPswhaIracqhcf7D6L6jQwo
         L2HDMi90aFMEg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3] ath11k: Handle keepalive during WoWLAN suspend and resume
References: <20220506012540.1579604-1-quic_bqiang@quicinc.com>
Date:   Tue, 10 May 2022 19:29:56 +0300
In-Reply-To: <20220506012540.1579604-1-quic_bqiang@quicinc.com> (Baochen
        Qiang's message of "Fri, 6 May 2022 09:25:40 +0800")
Message-ID: <87wnet73ln.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> With WoWLAN enabled and after sleeping for a rather long time,
> we are seeing that with some APs, it is not able to wake up
> the STA though the correct wake up pattern has been configured.
> This is because the host doesn't send keepalive command to
> firmware, thus firmware will not send any packet to the AP and
> after a specific time the AP kicks out the STA.
>
> Fix this issue by enabling keepalive before going to suspend
> and disabling it after resume back.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

[...]

> --- a/drivers/net/wireless/ath/ath11k/wmi.h
> +++ b/drivers/net/wireless/ath/ath11k/wmi.h
> @@ -5907,6 +5907,45 @@ struct wmi_pdev_set_geo_table_cmd {
>  	u32 rsvd_len;
>  } __packed;
>  
> +struct wmi_sta_keepalive_cmd {
> +	u32 tlv_header;
> +	u32 vdev_id;
> +	u32 enabled;
> +	u32 method; /* WMI_STA_KEEPALIVE_METHOD_ */
> +	u32 interval; /* in seconds */
> +	/* NOTE: following this structure is the TLV for ARP Response:
> +	 * WMI_STA_KEEPALVE_ARP_RESPONSE arp_resp; <-- ARP response
> +	 */
> +} __packed;

I cleaned up the comments a bit.

> +enum wmi_sta_keepalive_method {
> +	WMI_STA_KEEPALIVE_METHOD_NULL_FRAME = 1, /* 802.11 NULL frame */
> +	WMI_STA_KEEPALIVE_METHOD_UNSOLICITED_ARP_RESPONSE = 2, /* ARP response */
> +	WMI_STA_KEEPALIVE_METHOD_ETHERNET_LOOPBACK = 3, /* ETHERNET LOOPBACK */
> +	WMI_STA_KEEPALIVE_METHOD_GRATUITOUS_ARP_REQUEST = 4, /* gratuitous ARP req */
> +	WMI_STA_KEEPALIVE_METHOD_MGMT_VENDOR_ACTION = 5, /* vendor action frame */
> +};

The comments are not really bringing any extra value from the actual
names so I just removed them.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
