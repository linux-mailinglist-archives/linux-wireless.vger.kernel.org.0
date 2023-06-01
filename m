Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCB67199A5
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 12:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjFAK01 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 06:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjFAK0H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 06:26:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697E026B3
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 03:24:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED345615D7
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 10:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC90C433EF;
        Thu,  1 Jun 2023 10:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685615013;
        bh=nT3VqUSHcgSuYegNgg5ujoQ1kd3Z2W22ZLPHr9mqYyY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kdB1r85nkRPJsTa3J5/llQdYEbqQFQ6ex4utYBKDrVleZSsr2zJROuYenv6ggZ0GG
         S2PlPMeSK45xF7JmpvC6E/zCtPEIsMxSXb/6YZhFfElXrm5jOuOFwRxiSPQQdMTinz
         xBkKwY4SMjlgtVvS18XkrXBTa/76nCfmhi7Qsub8IVUcziywB6WobpduQ9LQ64cqXM
         pTjAiiXrjIKqob6NKiPdkhSpcNY9ke39pK3Pb94lgaS1Lm3V/3pAhlgImBYoQm7ae/
         VEC9zfNQOTbcW5OA+VSgUH5P4WVi55NlW0UsvhlaILXKdQfxj8L3f0Mxlc7D57r1Rm
         t3eCqS0Jwew5w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Govindaraj Saminathan <quic_gsaminat@quicinc.com>,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>
Subject: Re: [PATCH v4 3/4] wifi: ath11k: factory test mode support
References: <20230517135934.16408-1-quic_rajkbhag@quicinc.com>
        <20230517135934.16408-4-quic_rajkbhag@quicinc.com>
Date:   Thu, 01 Jun 2023 13:23:29 +0300
In-Reply-To: <20230517135934.16408-4-quic_rajkbhag@quicinc.com> (Raj Kumar
        Bhagat's message of "Wed, 17 May 2023 19:29:33 +0530")
Message-ID: <87cz2fjxb2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
> Command to boot in ftm mode:
>
> insmod ath11k ftm_mode=1
>
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Govindaraj Saminathan <quic_gsaminat@quicinc.com>
> Co-developed-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

[...]

> --- a/drivers/net/wireless/ath/ath11k/testmode.h
> +++ b/drivers/net/wireless/ath/ath11k/testmode.h
> @@ -8,11 +8,16 @@
>  
>  #ifdef CONFIG_NL80211_TESTMODE
>  
> +void ath11k_tm_wmi_event(struct ath11k_base *ab, u32 cmd_id, struct sk_buff *skb);
>  int ath11k_tm_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>  		  void *data, int len);
>  
>  #else
>  
> +void ath11k_tm_wmi_event(struct ath11k_base *ab, u32 cmd_id, struct sk_buff *skb)
> +{
> +}
> +

This introduced an warning and to fix it I changed it to static inline function.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
