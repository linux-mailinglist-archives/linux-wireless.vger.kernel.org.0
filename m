Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457FF6B774F
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 13:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjCMMRN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 08:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCMMRM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 08:17:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD875291F
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 05:17:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2840F611DB
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 12:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A4BC4339B;
        Mon, 13 Mar 2023 12:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678709830;
        bh=5SV13aq5tJjlhLGlfb0uLtr95GJYuPICvzYb8uVfPSs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=PVRsjOPYcUvXrPVS3gD6bsJsoyE0Flnzoz6LQalM+NWm9VuzGD0c9A2vUIAegPWxk
         Zip9CzAbzUSJskQOER1441H5JdnVMOFGkD779ec5ppdL27R+spj4hu2LdyjFILtgHG
         U6w1LQU6ECAXBMGoZWmhcxqko5dtCuewkSceGAYJo9HRn5jX8/aSWMXQ51UWIN4KrS
         NqRlIwzRMWB1Wm3za661iHu2jR60RTN7HfvYCOUTGpxb/S/HOKaD5+KsJPWUqrtG9t
         quWw2Q/kUU4YMeGusGUjLZiCEPRL/SHD2BcFI/LA8l+BcJ/o+pWj9pRCklkMfFocCt
         Ebsa4k0dAk8Bg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Govindaraj Saminathan <quic_gsaminat@quicinc.com>,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Subject: Re: [PATCH 1/2] wifi: ath11k: factory test mode support
References: <20230213130854.2473-1-quic_rajkbhag@quicinc.com>
        <20230213130854.2473-2-quic_rajkbhag@quicinc.com>
Date:   Mon, 13 Mar 2023 14:17:05 +0200
In-Reply-To: <20230213130854.2473-2-quic_rajkbhag@quicinc.com> (Raj Kumar
        Bhagat's message of "Mon, 13 Feb 2023 18:38:53 +0530")
Message-ID: <87ilf4onge.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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

Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> writes:

> From: Govindaraj Saminathan <quic_gsaminat@quicinc.com>
>
> Add support to process factory test mode commands(FTM) for calibration.
> By default firmware start with NORMAL mode and to process the FTM commands
> firmware needs to be restarted in FTM mode using module parameter ftm_mode.
> The pre-request is all the radios should be down before starting the test.
>
> When start command ATH11K_TM_CMD_TESTMODE_START is received, ar state
> is set to Test Mode. If the FTM command or event length is greater
> than 256 bytes, it will be broken down into multiple segments and
> encoded with TLV header if it is segmented commands, else it is sent
> to firmware as it is.
>
> On receiving UTF event from firmware, if it is segmented event, the driver
> will wait until it receives all the segments and notify the complete
> data to user application. In case the segmented sequence are missed or
> lost from the firmware, driver will skip the already received partial data.
>
> In case of unsegmented UTF event from firmware, driver notifies the
> data to the user application as it comes. Applications handles
> the data further.
>
> Command to boot in ftm mode
> insmod ath11k ftm_mode=1
>
> Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Govindaraj Saminathan <quic_gsaminat@quicinc.com>
> Co-developed-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

[...]

> -bool ath11k_tm_event_wmi(struct ath11k *ar, u32 cmd_id, struct sk_buff *skb)

Please do removal of this ath11k_tm_event_wmi() in a separate patch,
then it's easier to read this patch.

>  static int ath11k_tm_cmd_get_version(struct ath11k *ar, struct nlattr *tb[])
>  {
>  	struct sk_buff *skb;
> -	int ret;
>  
>  	ath11k_dbg(ar->ab, ATH11K_DBG_TESTMODE,
>  		   "testmode cmd get version_major %d version_minor %d\n",
> @@ -98,21 +205,50 @@ static int ath11k_tm_cmd_get_version(struct ath11k *ar, struct nlattr *tb[])
>  	if (!skb)
>  		return -ENOMEM;
>  
> -	ret = nla_put_u32(skb, ATH11K_TM_ATTR_VERSION_MAJOR,
> -			  ATH11K_TESTMODE_VERSION_MAJOR);
> -	if (ret) {
> +	if (nla_put_u32(skb, ATH11K_TM_ATTR_VERSION_MAJOR,
> +			ATH11K_TESTMODE_VERSION_MAJOR) ||
> +	    nla_put_u32(skb, ATH11K_TM_ATTR_VERSION_MINOR,
> +			ATH11K_TESTMODE_VERSION_MINOR)) {
>  		kfree_skb(skb);
> -		return ret;
> +		return -ENOBUFS;
>  	}
>  
> -	ret = nla_put_u32(skb, ATH11K_TM_ATTR_VERSION_MINOR,
> -			  ATH11K_TESTMODE_VERSION_MINOR);
> -	if (ret) {
> -		kfree_skb(skb);
> -		return ret;
> +	return cfg80211_testmode_reply(skb);
> +}

Please also do the changes in ath11k_tm_cmd_get_version() in a separate
patch.

> @@ -47,4 +49,21 @@ enum ath11k_tm_cmd {
>  	 * ATH11K_TM_ATTR_DATA.
>  	 */
>  	ATH11K_TM_CMD_WMI = 1,
> +
> +	/* Boots the UTF firmware, the netdev interface must be down at the
> +	 * time.
> +	 */
> +	ATH11K_TM_CMD_TESTMODE_START = 2,
> +
> +	/* Shuts down the UTF firmware and puts the driver back into OFF
> +	 * state.
> +	 */
> +	ATH11K_TM_CMD_TESTMODE_STOP = 3,

The documentation for for the STOP command is misleading, now ath11k
just ignores that command. So is there any point even to have the
command if it doesn't do anything?

> @@ -8096,6 +8128,12 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
>  	case WMI_PDEV_CSA_SWITCH_COUNT_STATUS_EVENTID:
>  		ath11k_wmi_pdev_csa_switch_count_status_event(ab, skb);
>  		break;
> +	case WMI_PDEV_UTF_EVENTID:
> +		if (test_bit(ATH11K_FLAG_FTM_SEGMENTED, &ab->dev_flags))
> +			ath11k_wmi_tm_event_segmented(ab, id, skb);
> +		else
> +			ath11k_tm_wmi_event_unsegmented(ab, id, skb);
> +		break;

I didn't investigate this in detail, but I find the flag a bit
problematic as it alters the behaviour ATH11K_FLAG_FTM_SEGMENTED and the
behaviour difference it's not documented at all in enum ath11k_tm_cmd.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
