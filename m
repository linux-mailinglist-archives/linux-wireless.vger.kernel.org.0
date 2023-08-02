Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77D876CBF2
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 13:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjHBLog (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 07:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjHBLof (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 07:44:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394BB213D
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 04:44:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C259961939
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 11:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA57C433C8;
        Wed,  2 Aug 2023 11:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690976674;
        bh=gCzHrGsl2mzOFtgFir6MlbRDFwpswOAJQ2dRzzMSFkQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=VXp9XxDowNRdyq0bcXm5SET3I5X50WQl4W3PZExnvUrRb9sVY6s32N8Hc8TC3CB2I
         q/A+jkwLwfUtvF8UaSBHheaeKXvjd2VRTMW/DOJz6OYOxRlbjyFUDomL5m7fUMwLlz
         bz4iBpUGEneSGrABXTs3ICUZFp3T/Jt2AY2dJTFlJ1uYx3xI/EVqsXC40ggNzIvwwR
         0Cs3tBcjLa5Z7mpeNXhTuJf2yho/Cpt0E4Vn5BNz2ocCoo4UAdyeoro8j+k11NRDM+
         333r9X/BS6ZzdaSiKt4xZcqO27MdGj/od6bhDrGi4TjFBkPF/pz8WUQFJGt8jpCxyd
         9U0Rd3pDch+oQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 4/5] wifi: ath11k: update regulatory rules when
 interface added
References: <20230607094810.26707-1-quic_wgong@quicinc.com>
        <20230607094810.26707-5-quic_wgong@quicinc.com>
Date:   Wed, 02 Aug 2023 14:44:31 +0300
In-Reply-To: <20230607094810.26707-5-quic_wgong@quicinc.com> (Wen Gong's
        message of "Wed, 7 Jun 2023 05:48:09 -0400")
Message-ID: <87zg39vfc0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> When wlan boot up, WMI_REG_CHAN_LIST_CC_EXT_EVENTID is sent from
> firmware at an early stage, the interface mode is not decided at
> this point, then ath11k select reg rules of AP mode as default.
>
> After interface is created, it is exactly decided AP/station mode,
> then ath11k need to update reg rules to the exact one.
>
> Tested-on: WCN6855 hw2.0 PCI
> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

[...]

> --- a/drivers/net/wireless/ath/ath11k/hw.c
> +++ b/drivers/net/wireless/ath/ath11k/hw.c
> @@ -897,6 +897,12 @@ static u32 ath11k_hw_wcn6750_get_tcl_ring_selector(struct sk_buff *skb)
>  	return skb_get_hash(skb);
>  }
>  
> +bool ath11k_hw_supports_6g_cc_ext(struct ath11k *ar)
> +{
> +	return (test_bit(WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT,
> +			 ar->ab->wmi_ab.svc_map)) && ar->supports_6ghz;
> +}

This is more like a firmware feature, maybe move to mac.c?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
