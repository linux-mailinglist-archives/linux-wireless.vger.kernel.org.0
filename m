Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DB0706351
	for <lists+linux-wireless@lfdr.de>; Wed, 17 May 2023 10:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjEQIuk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 May 2023 04:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjEQIui (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 May 2023 04:50:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C65A1BC3
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 01:50:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDE30643F7
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 08:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13742C433D2;
        Wed, 17 May 2023 08:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684313436;
        bh=6rgrwlaZHojy/RgltgvP3Z7GNEA6aZa/h9uZUuiicpI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=G9WdNhzmNu4MvZ9/FL2lrLu6C/uM6VzFwj0BrXOtJqcT/iQzl+Hg6m3rWtPp7Alg8
         PMsh5QXpA1ZdvSdXUAcaVYrPT78F95PUhJp8Fm4VHXDm+2vxXUJStyuKQqZJHTbFXa
         giw6HtyMvSY6vqm/ZrQZOt8PXH+cc9ENmD27BS5elZYdqhCl1foiGxxpv/8Cmih6CY
         My85DJx2i1ekp8wYuMz/pUI+lHe2459WPMky6jnpMokYD8gRXnO6MB7WCmEZCE4u+X
         EcDVGfIx4woInDsCULAmnUkEd5Lw65w/+UZR04YYUN9XF3pXWvZZumO/ka6BnRNz5+
         xqLvzgXdhCR/Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Cc:     ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <quic_ppranees@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: Add support to parse new WMI event for 6 GHz regulatory
References: <20230502142018.20301-1-quic_rgnanase@quicinc.com>
Date:   Wed, 17 May 2023 11:50:30 +0300
In-Reply-To: <20230502142018.20301-1-quic_rgnanase@quicinc.com> (Ramya
        Gnanasekar's message of "Tue, 2 May 2023 19:50:18 +0530")
Message-ID: <875y8rmje1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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

Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:

> From: P Praneesh <quic_ppranees@quicinc.com>
>
> In order to support different power levels of 6 GHz AP and client,
> new WMI event for regulatory (WMI_REG_CHAN_LIST_CC_EXT_EVENTID) has been
> added in firmware to provide new parameters required for 6 GHz regulatory rules.
>
> Firmware advertises its capability of handling new event in WMI service ready
> event. Based on that, host needs to set host_service_flags in WMI init command
> to indicate that host supports processing of this WMI event.
> Based on advertised host capability, firmware sends event (WMI_REG_CHAN_LIST_CC_EXT_EVENTID).
> This new event contains 2G/5G/6G reg rules with additional power value
> fields for 6GHz and regd is built accordingly.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-02903-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>

I made some changes in the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=a483b258992f80c657ed3175293a15cac4acd25d

> @@ -3403,6 +3403,10 @@ int ath12k_wmi_cmd_init(struct ath12k_base *ab)
>  	struct ath12k_wmi_base *wmi_sc = &ab->wmi_ab;
>  	struct ath12k_wmi_init_cmd_arg arg = {};
>  
> +	if (test_bit(WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT,
> +		     ab->wmi_ab.svc_map))
> +		arg.res_cfg.is_reg_cc_ext_event_supported = 1;

is_reg_cc_ext_event_supported is bool so I changed this to true.

> +static int ath12k_wmi_tlv_services_parser(struct ath12k_base *ab,
> +					  u16 tag, u16 len,
> +					  const void *ptr,
> +					  void *data)
>  {
> -	const void **tb;
>  	const struct wmi_service_available_event *ev;
> -	int ret;
> +	u32 *wmi_ext2_service_bitmap;
>  	int i, j;
> +	u16 expected_len;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
> -	if (IS_ERR(tb)) {
> -		ret = PTR_ERR(tb);
> -		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> -		return;
> +	expected_len = WMI_SERVICE_SEGMENT_BM_SIZE32 * sizeof(u32);
> +	if (len < expected_len) {
> +		ath12k_warn(ab, "invalid len %d for the tag 0x%x\n",
> +			    len, tag);
> +		return -EINVAL;
>  	}

I changed the warning to be more descriptive.

> -	ev = tb[WMI_TAG_SERVICE_AVAILABLE_EVENT];
> -	if (!ev) {
> -		ath12k_warn(ab, "failed to fetch svc available ev");
> -		kfree(tb);
> -		return;
> -	}
> +	switch (tag) {
> +	case WMI_TAG_SERVICE_AVAILABLE_EVENT:
> +		ev = (struct wmi_service_available_event *)ptr;
> +		for (i = 0, j = WMI_MAX_SERVICE;
> +		     i < WMI_SERVICE_SEGMENT_BM_SIZE32 && j < WMI_MAX_EXT_SERVICE;
> +		     i++) {
> +			do {
> +				if (le32_to_cpu(ev->wmi_service_segment_bitmap[i]) &
> +				    BIT(j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32))
> +					set_bit(j, ab->wmi_ab.svc_map);
> +			} while (++j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32);
> +		}
>  
> -	/* TODO: Use wmi_service_segment_offset information to get the service
> -	 * especially when more services are advertised in multiple service
> -	 * available events.
> -	 */
> -	for (i = 0, j = WMI_MAX_SERVICE;
> -	     i < WMI_SERVICE_SEGMENT_BM_SIZE32 && j < WMI_MAX_EXT_SERVICE;
> -	     i++) {
> -		do {
> -			if (le32_to_cpu(ev->wmi_service_segment_bitmap[i]) &
> -			    BIT(j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32))
> -				set_bit(j, ab->wmi_ab.svc_map);
> -		} while (++j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32);
> +		ath12k_dbg(ab, ATH12K_DBG_WMI,
> +			   "wmi_ext_service_bitmap 0:0x%x, 1:0x%x, 2:0x%x, 3:0x%x",
> +			   ev->wmi_service_segment_bitmap[0],
> +			   ev->wmi_service_segment_bitmap[1],
> +			   ev->wmi_service_segment_bitmap[2],
> +			   ev->wmi_service_segment_bitmap[3]);

I changed the debug messages to the recommended style.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
