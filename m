Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E6C5F9C7F
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 12:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiJJKQN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Oct 2022 06:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiJJKQL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Oct 2022 06:16:11 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAEB46DB7
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 03:16:10 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id l19so6854835qvu.4
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 03:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c0t8DWNdk01FeQs+z//YSSC//gxBgD7P1ALbry3MEZM=;
        b=GiQTIanFAXUFpf2sXsGbBZIswAO4oqjRbWaq6kc+8o0YjFXjHbY5dcTNGKCK+opDXz
         yM02bfWXYeFC9a0CxcNEls5X2Dv8vEG/EjAjtseg0DD9oRCv+MuwkH7HpRFYQ8FCjlfJ
         My7qeaTgg0tJ3wqhTGNmV7r5yBKrSCHry/R0TK2YPwi3VDvDGHfX6tcCjPfp4YdC+Tps
         40HX1kv2flqPK9OY4f2rx7YxvxvmNcF4M1LKNpBIrePAHzA2JdQMScJXuYrhE+OLK3Ls
         kSBdPb339m5Z/60XS6b0kM/OMVpSlUumbJO61D5q52xi0jUZukBFAGJ1blPU9/JbLk5w
         MNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0t8DWNdk01FeQs+z//YSSC//gxBgD7P1ALbry3MEZM=;
        b=2laKMKtBhmW8v5DUAhnCfoVZ7e/SRhfsSmFy2J02j6Rd5peFhf9V2zWyu1nSBvX69s
         fDgiMQYoVaBDxmkrX76Aas4/2bnGSt5aP48f+Tn66o9Vw5B3Vb6UIu5v3ZfDO/Qo5e/+
         0FdsMvFRoqs9pV5OmT6eutOKpobn45mhqF9cUBiDEEPNBJY5jCy7LBhKqf1nj1UjvMh3
         EmPLgB8pfY3xEK9vZVqDOTwigHb6vWS0aK1wUSjXGrw0OmLWk43bBbSA/oth+ylst967
         sI2Mpas1anGc+LEJwI+UN0dpZ6eadehJPYVnJWhV43AA+8it5T14lnlQDvSVuLpU14NS
         DvHg==
X-Gm-Message-State: ACrzQf0KXoEyn+sJoudxRJv1FvuBZVzreQ1PO1KxccWKeJEgBoLfuNxZ
        +/1iQ1nCbl1N+idxPVBLgFA=
X-Google-Smtp-Source: AMsMyM5ZnsrVkgDgNzRzv8LqLvCUCgPFP1L8Q3uf2NdTyUjdUp3LH3tUPr8/pdg3t5cfQMYW7JxASQ==
X-Received: by 2002:a05:6214:238b:b0:48a:f607:c4e0 with SMTP id fw11-20020a056214238b00b0048af607c4e0mr14025225qvb.44.1665396969340;
        Mon, 10 Oct 2022 03:16:09 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id br7-20020a05620a460700b006e9b3096482sm7951537qkb.64.2022.10.10.03.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 03:16:08 -0700 (PDT)
Message-ID: <449400ea-9751-e78b-fd90-0389aee39dbd@gmail.com>
Date:   Mon, 10 Oct 2022 12:16:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 4/4] brcmfmac: Fix authentication latency caused by
 OBSS stats survey
Content-Language: en-US
To:     Ian Lin <ian.lin@infineon.com>, linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        kvalo@kernel.org, Double.Lo@infineon.com
References: <20220929012527.4152-1-ian.lin@infineon.com>
 <20220929012527.4152-5-ian.lin@infineon.com>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <20220929012527.4152-5-ian.lin@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/29/2022 3:25 AM, Ian Lin wrote:
> From: Ramesh Rangavittal <ramesh.rangavittal@infineon.com>
> 
> Auto Channel Select feature of HostAP uses dump_survey to fetch
> OBSS statistics. When the device is in the middle of an authentication
> sequence or just at the end of authentication completion, running
> dump_survey would trigger a channel change. The channel change in-turn
> can cause packet loss, resulting in authentication delay. With this change,
> dump_survey won't be run when authentication or association is in progress,
> hence resolving the issue.

It does a bit more than that. It only allows survey when not connected. 
The description above suggests that it is possible when connection is 
completed, but the condition checked below is saying something else.

Regards,
Arend

> Signed-off-by: Ramesh Rangavittal <ramesh.rangavittal@infineon.com>
> Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
> Signed-off-by: Ian Lin <ian.lin@infineon.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index c13c4c559e6e..362d8fd0af4e 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -7697,6 +7697,12 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
>   
>   	brcmf_dbg(TRACE, "Enter: channel idx=%d\n", idx);
>   
> +	/* Do not run survey when VIF in CONNECTING / CONNECTED states */
> +	if ((test_bit(BRCMF_VIF_STATUS_CONNECTING, &ifp->vif->sme_state)) ||
> +	    (test_bit(BRCMF_VIF_STATUS_CONNECTED, &ifp->vif->sme_state))) {
> +		return -EBUSY;
> +	}
> +
>   	band = wiphy->bands[NL80211_BAND_2GHZ];
>   	if (band && idx >= band->n_channels) {
>   		idx -= band->n_channels;
