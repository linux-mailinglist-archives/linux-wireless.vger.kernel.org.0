Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7CE6C80AD
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Mar 2023 16:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjCXPEE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Mar 2023 11:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjCXPEC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Mar 2023 11:04:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A620E187
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 08:04:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1963762B5B
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 15:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FB3C433D2;
        Fri, 24 Mar 2023 15:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679670240;
        bh=/I23K0OXPPkwe4qTbG0o7pOV7z8FIYzoQPT2ceT+BVc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=SzSJk5z4YzYZ3CE0dj+u5AejCQH0qD1LveYTn7RAmBheVRsZMgo02BK+RG1iqr9Ci
         SYJwRpEe7HSk3ld0IJJGN0z2YsBrWZXGz2Yt4ipUF4LIdCs07A5JuH8MM7TegsEtka
         GLYKvVYkS2GwE/FMHlJl2wUVelicV0Ok/AQSvzgRx8PzujvUyFqAsMYaIpLevuafjn
         HDeX5++1tzlVsqqNtCScYc1ypslorhEAu/LkHc/fsvVBOPfiHmX0IdiPDnSMg9qHhK
         76p/XZxmgO+oaOec1wCQOl3ttsn+4b/EPFX62FbGTb3p5pHAKdXKqeOZlmS2RAc7+p
         l6FPX+r5S7NHw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ganesh Babu Jothiram <quic_gjothira@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath11k: Configure the FTM responder role using firmware capability flag
References: <20230317072034.8217-1-quic_gjothira@quicinc.com>
Date:   Fri, 24 Mar 2023 17:03:56 +0200
In-Reply-To: <20230317072034.8217-1-quic_gjothira@quicinc.com> (Ganesh Babu
        Jothiram's message of "Fri, 17 Mar 2023 12:50:34 +0530")
Message-ID: <87sfduchsz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ganesh Babu Jothiram <quic_gjothira@quicinc.com> writes:

> Fine Time Measurement(FTM) is offloaded feature to firmware.
> Hence, the configuration of FTM responder role is done using
> firmware capability flag instead of hw param.
>
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Ganesh Babu Jothiram <quic_gjothira@quicinc.com>

[...]

> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -3538,7 +3538,7 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
>  
>  	if (changed & BSS_CHANGED_FTM_RESPONDER &&
>  	    arvif->ftm_responder != info->ftm_responder &&
> -	    ar->ab->hw_params.ftm_responder &&
> +	    (test_bit(WMI_TLV_SERVICE_RTT, ar->ab->wmi_ab.svc_map)) &&

Unnecessary parenthesis, I fixed that in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
