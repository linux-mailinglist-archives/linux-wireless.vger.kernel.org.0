Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A99474044
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Dec 2021 11:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhLNKTa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Dec 2021 05:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbhLNKT3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Dec 2021 05:19:29 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC58C06173F
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 02:19:29 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id n8so13219703plf.4
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 02:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9+mpZERBOVfw7BDmwfN5jn1RukuhFcqR1QOuIWL/IE=;
        b=JxAMdWA6XYXJINZEOoxRseFOQG7Q1zbpjV59y1udb0hr9rAjYAR7LoDwG8EvTM9t2d
         D46IONV/l2hKmA1PEh7PpR/gCOYZg/e+MQvzyD3LMktulYaZciDaGQtZ/kRRmxMtHPLz
         utaRfG8X1ojBFPCZVJ2nQuS16m2mAmx3nG2YMPX7binHxKh5ffNBGJwNa9vAwfSHTsXR
         MBQQJ5ohwavpyThMsJdd2Jt7CA5K905f9pv7Xt00uRWfrbRCKvYviVsA6Dl9ZFhZpitK
         AYB5kB+TwlMzAvIjaWSZjv43v+B9+hEB9QuEJwgn+nvxek3dSTq/uWZdZcpnBb279TJQ
         nnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9+mpZERBOVfw7BDmwfN5jn1RukuhFcqR1QOuIWL/IE=;
        b=ptuT+ZLRlGh2vP3MVPgfjKtngxbppPhZEdowRjX0/z8C3qsYUgO1o93Mlp8gD5FysH
         6pCH92NeUTFiDj0fyU+9oFaRnyqRqT3AtvZb4SqD40LMEThkMQrARZCWiiZSGCzeKoib
         L5hwedOzVqEUG2HsmmIadMGUcoVrWYtr05XLs5IC82SFltl4i7+GiNtwJxH0X/qOVc3b
         EM7Gc8HlewHWzqVf4slx6bnFsCNknhUzxVUiT8nG4Wx6zgA4Pu8tjzRoEeZ/95Vpksl+
         jx/+3++hAdK1Y/Oz04pSeHIZZQkrzrtSWjnYbTBKpq4j6PxKpThBX3UnCj/8x3wDimP2
         M+Lw==
X-Gm-Message-State: AOAM5332gR5GzXBLfvqxQJIMs0Cd9gnSkLnkaVITpJTwrjozBOctZed3
        hfyywlykG0FmPTBq0489McnSw5exf4UcxdvCRUqwx1Cbm0A4Zw==
X-Google-Smtp-Source: ABdhPJzl3Y58sHlHCffknr3LuxaOD8r6Jg/ya+rPmjBfsJ7EiHWBtchQvSBlGiqKX+n4PccX0FQTunl0MeN20Ow/E/M=
X-Received: by 2002:a17:90a:690d:: with SMTP id r13mr4717492pjj.40.1639477168226;
 Tue, 14 Dec 2021 02:19:28 -0800 (PST)
MIME-Version: 1.0
References: <20211213135127.1656258-1-bryan.odonoghue@linaro.org> <20211213135127.1656258-4-bryan.odonoghue@linaro.org>
In-Reply-To: <20211213135127.1656258-4-bryan.odonoghue@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 14 Dec 2021 11:31:02 +0100
Message-ID: <CAMZdPi82xqRGn+oZwVX5wgutEDO1qpufSra2oBW9S4pALHHAdw@mail.gmail.com>
Subject: Re: [PATCH 3/3] wcn36xx: Implement downstream compliant beacon filtering
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        benl@squareup.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 13 Dec 2021 at 14:49, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> Downstream facilitates the direct programming of beacon filter tables via
> SMD commands.
>
> The purpose of beacon filters is quote:
>
> /* When beacon filtering is enabled, firmware will
>  * analyze the selected beacons received during BMPS,
>  * and monitor any changes in the IEs as listed below.
>  * The format of the table is:
>  *    - EID
>  *    - Check for IE presence
>  *    - Byte offset
>  *    - Byte value
>  *    - Bit Mask
>  *    - Byte reference
>  */
>
> The default downstream firmware filter table looks something like this:
> tBeaconFilterIe gaBcnFilterTable[12] =
> {
>   { WLAN_EID_DS_PARAMS, 0u, { 0u, 0u, 0u, 0u } },
>   { WLAN_EID_ERP_INFO, 0u, { 0u, 0u, 248u, 0u } },
>   { WLAN_EID_EDCA_PARAM_SET, 0u, { 0u, 0u, 240u, 0u } },
>   { WLAN_EID_QOS_CAPA, 0u, { 0u, 0u, 240u, 0u } },
>   { WLAN_EID_CHANNEL_SWITCH, 1u, { 0u, 0u, 0u, 0u } },
>   { WLAN_EID_QUIET, 1u, { 0u, 0u, 0u, 0u } },
>   { WLAN_EID_HT_OPERATION, 0u, { 0u, 0u, 0u, 0u } },
>   { WLAN_EID_HT_OPERATION, 0u, { 1u, 0u, 248u, 0u } },
>   { WLAN_EID_HT_OPERATION, 0u, { 2u, 0u, 235u, 0u } },
>   { WLAN_EID_HT_OPERATION, 0u, { 5u, 0u, 253u, 0u } },
>   { WLAN_EID_PWR_CONSTRAINT, 0u, { 0u, 0u, 0u, 0u } },
>   { WLAN_EID_OPMODE_NOTIF, 0u, { 0u, 0u, 0u, 0u } }
> };
>
> Add in an equivalent filter set as present in the downstream Linux driver.
> For now omit the beacon filter "rem" command as downstream does not have an
> explicit call to that SMD command. The filter mask should only count when
> we are inside BMPS anyway.
>
> Replicating the downstream ability to program the filter table gives us
> scope to add and remove elements in future. For now though this patch
> makes the rote-copy of the downstream Linux beacon filter table, which we
> can tweak as desired from now on.
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/net/wireless/ath/wcn36xx/hal.h  |  16 ++++
>  drivers/net/wireless/ath/wcn36xx/main.c |   1 +
>  drivers/net/wireless/ath/wcn36xx/smd.c  | 104 ++++++++++++++++++++++++
>  drivers/net/wireless/ath/wcn36xx/smd.h  |   3 +
>  4 files changed, 124 insertions(+)
>
[...]
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
> index f59eb1119da88..a4510f144041f 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -934,6 +934,7 @@ static void wcn36xx_bss_info_changed(struct ieee80211_hw *hw,
>                          * place where AID is available.
>                          */
>                         wcn36xx_smd_config_sta(wcn, vif, sta);
> +                       wcn36xx_smd_add_beacon_filter(wcn, vif);

Shouldn't this be configured only if the vif type is NL80211_IFTYPE_STATION?

Regards,
Loic
