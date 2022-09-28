Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7AB5ED4F3
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 08:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiI1Gi5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 02:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiI1Giz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 02:38:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DA01EB1B4
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 23:38:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65550B81E8F
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 06:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913D9C433D6;
        Wed, 28 Sep 2022 06:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664347132;
        bh=Qgf+blPwJYlrxXJyxXiV64PqP2SbQ6LU2lqwySqs5h8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ea1L2EtxxaKtvBN2vKvlD5/f0PrHNza8idjp3jOYXi2lXLmgfQpTDHckRlDug/D49
         Xhj7Jgy0AwEjKUJtDFMOQGC8LmFQmfRBEE4C1U7pGZzWRyOb7q7HAm+C/egzm3Hy4O
         WRY7u5CjDWq6yE1eO5TtY1QinvuzZd8PpiPfIByGBhJhhtZaixMYjmXUQlbwMBVOGO
         9Z0bPaJdY1jSdoo+iNpcBhRFP9DbPe9f2ubZ0njWYB3TFzxYGYaeYNN+Rj52WG9oXD
         A7Z2GA2tzO0dDFejpmF1w9ajj8hNEQB36boyWUamvAZomEYvvnY4OX86N2NWVkFkrf
         ObcCXZvOt65+A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ian Lin <ian.lin@infineon.com>
Cc:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <Double.Lo@infineon.com>
Subject: Re: [PATCH v3 4/5] brcmfmac: Update SSID of hidden AP while informing its bss to cfg80211 layer
References: <20220927034138.20463-1-ian.lin@infineon.com>
        <20220927034138.20463-5-ian.lin@infineon.com>
Date:   Wed, 28 Sep 2022 09:38:48 +0300
In-Reply-To: <20220927034138.20463-5-ian.lin@infineon.com> (Ian Lin's message
        of "Mon, 26 Sep 2022 22:41:37 -0500")
Message-ID: <874jwsrojr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> Signed-off-by: Syed Rafiuddeen <syed.rafiuddeen@cypress.com>
> Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
> Signed-off-by: Ian Lin <ian.lin@infineon.com>
> ---
>  .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c   | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index 6c37da42e61b..3560afe0ccfe 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -3003,6 +3003,7 @@ static s32 brcmf_inform_single_bss(struct brcmf_cfg80211_info *cfg,
>  	u8 *notify_ie;
>  	size_t notify_ielen;
>  	struct cfg80211_inform_bss bss_data = {};
> +	struct brcmf_tlv *ssid;
>  
>  	if (le32_to_cpu(bi->length) > WL_BSS_INFO_MAX) {
>  		bphy_err(drvr, "Bss info is larger than buffer. Discarding\n");
> @@ -3032,6 +3033,13 @@ static s32 brcmf_inform_single_bss(struct brcmf_cfg80211_info *cfg,
>  	notify_ielen = le32_to_cpu(bi->ie_length);
>  	bss_data.signal = (s16)le16_to_cpu(bi->RSSI) * 100;
>  
> +	ssid = (struct brcmf_tlv *)
> +		brcmf_parse_tlvs(notify_ie, notify_ielen, WLAN_EID_SSID);

This still casts away the const. For some reason brcmf_parse_tlvs()
takes a const buffer:

static const struct brcmf_tlv *brcmf_parse_tlvs(const void *buf, int buflen, uint key)

I'm not familiar with brcmfmac internal so I don't know why it does
that, but that means the buffer cannot be modified. If you need to
modify the ssid should you make a copy of it?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
