Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA68F5E5A55
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 06:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiIVEpA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 00:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIVEo7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 00:44:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4B279A45
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 21:44:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BF6E60E1F
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 04:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17514C433C1;
        Thu, 22 Sep 2022 04:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663821897;
        bh=gbR3u/t/kC/SjT45zLt6naquQjBqychc082YTNWqfXQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bshQxVsuciVWgMQN3v5H10YUeEax9waliNOGLIds9qDuu+O6My+bIX8TLBRa4Qzwk
         58p9kdZQ/UqP/w2aEGEUzc93OHoswv7PA2JsUnpJ1cn1b7tR8I8t2l6k+u5qPqmgml
         wiEywMVzpZOzpeSwrzPiJd50tNpuv43ZL7Xdflvt5/xZxQ595yMNlSa5TI4p7gfAij
         s0vxn3sV6485rzfYi/btbRHW9/fj4vclSRfQ5wf7BTyKheSlr+6daZFus5DkezWdXk
         2Q25Cwmack495mwwOIqqeNqbaVkQngkncGvjoFbRi1BM8fG+yt89uorYdcM4Warqdz
         xbfj8hEGoxxGA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ian Lin <ian.lin@infineon.com>
Cc:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <Double.Lo@infineon.com>
Subject: Re: [PATCH 4/5] brcmfmac: Update SSID of hidden AP while informing its bss to cfg80211 layer
References: <20220914033620.12742-1-ian.lin@infineon.com>
        <20220914033620.12742-5-ian.lin@infineon.com>
Date:   Thu, 22 Sep 2022 07:44:53 +0300
In-Reply-To: <20220914033620.12742-5-ian.lin@infineon.com> (Ian Lin's message
        of "Tue, 13 Sep 2022 22:36:19 -0500")
Message-ID: <87tu506mre.fsf@kernel.org>
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

Ian Lin <ian.lin@infineon.com> writes:

> From: Syed Rafiuddeen <syed.rafiuddeen@cypress.com>
>
> cfg80211 layer on DUT STA is disconnecting ongoing connection attempt after
> receiving association response, because cfg80211 layer does not have valid
> AP bss information. On association response event, brcmfmac communicates
> the AP bss information to cfg80211 layer, but SSID seem to be empty in AP
> bss information, and cfg80211 layer prints kernel warning and then
> disconnects the ongoing connection attempt.
>
> SSID is empty in SSID IE, but 'bi->SSID' contains a valid SSID, so
> updating the SSID for hidden AP while informing its bss information
> to cfg80211 layer.
>
> Signed-off-by: Syed Rafiuddeen <syed.rafiuddeen@infineon.com>

Syed's email address in From does not match with s-o-b.

> @@ -3032,6 +3033,12 @@ static s32 brcmf_inform_single_bss(struct brcmf_cfg80211_info *cfg,
>  	notify_ielen = le32_to_cpu(bi->ie_length);
>  	bss_data.signal = (s16)le16_to_cpu(bi->RSSI) * 100;
>  
> +	ssid = brcmf_parse_tlvs(notify_ie, notify_ielen, WLAN_EID_SSID);
> +	if (ssid && ssid->data[0] == '\0' && ssid->len == bi->SSID_len) {
> +		/* Update SSID for hidden AP */
> +		memcpy((u8 *)ssid->data, bi->SSID, bi->SSID_len);
> +	}

memcpy() takes a void pointer so the cast is not needed.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
