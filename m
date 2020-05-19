Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5A41D951E
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2020 13:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgESLTE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 May 2020 07:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgESLTD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 May 2020 07:19:03 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB1BC061A0C
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2020 04:19:03 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id v12so15391360wrp.12
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2020 04:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mjrDzCIFAxmXpLzgXwqUYBX9SMKqcgEOkc3B4Wb64uI=;
        b=TscaO9qMABIKLm7hdEoXHVzWB/fFHOb1GO/vYI8XzA4Ycno7hRsQF/xVJkEopXNe28
         uRRukulugUClNTiruo5HA+FR1HxZPVLOJeV2o8uVLTYwNe6v29MWR6FFX74lNbOFH424
         vj0K/5GQbbnMPRSo1X7pechRsjDdO4899hN74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mjrDzCIFAxmXpLzgXwqUYBX9SMKqcgEOkc3B4Wb64uI=;
        b=eyM5tzo4Mhh7YtzveATZ+tR1MAXxpWCvxIQOj8SwqroktlAZQ5xDXLBp9LbJOPKF21
         MhqKw2qbkevLPYOroP4gZZPp3YURPJm4Ugy2BmbVqviG9EKApdAeLmjeN/j/GGZte6sf
         asBx0Hsv1H3pxHXkGjP+H0jXM/sgxfv8LW0CMlbBdBgfpNRbQRhgLGgnREUUthNnrFXY
         N6w7n0EU9gBc/GRDZL3noGAnKYqSqNz+6uBd/TwO+T2SO6iXYF2YnEsgoztwBdVjRuxn
         FPMtb/+8+pjciGWHZiUbzVYSw6bJAqQ8fcyczm2VqEHVOw+X/auIM/mPxJpa9xmOsAwi
         hz3w==
X-Gm-Message-State: AOAM532eTv5hadEfWVU707nmJp1Eqhq8Y8XZgxHIZSWaJKMSpTkSll1a
        VLq78B+F9tYvv8FkYPHyyaJwCA==
X-Google-Smtp-Source: ABdhPJwASe2S5ryodn3z1FiFkrtvfTuBV33kkUYcn4X7i8hbp80U/BH/zhXF3nzFJwxIpUtnz/Zw3w==
X-Received: by 2002:a5d:4747:: with SMTP id o7mr24745389wrs.11.1589887141902;
        Tue, 19 May 2020 04:19:01 -0700 (PDT)
Received: from [10.230.34.187] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id s11sm20119755wrp.79.2020.05.19.04.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 04:19:01 -0700 (PDT)
Subject: Re: [PATCH 3/4] brcmfmac: set net carrier on via test tool for AP
 mode
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Kurt Lee <kurt.lee@cypress.com>
References: <20200519110951.88998-1-chi-hsien.lin@cypress.com>
 <20200519110951.88998-4-chi-hsien.lin@cypress.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <77e05853-447c-76e2-9d71-a95397c36ff0@broadcom.com>
Date:   Tue, 19 May 2020 13:18:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519110951.88998-4-chi-hsien.lin@cypress.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/19/2020 1:09 PM, Chi-Hsien Lin wrote:
> From: Kurt Lee <kurt.lee@cypress.com>
> 
> In manufacturing line, test tool may be used to enable SoftAP. Such
> SoftAP can't pass traffic because netif carrier is off by default. To
> allow such use case, let brcmfmac parse ioctl cmd, and then set iftype
> to ap mode and report netif_carrier_on to upper layer.
> 
> Signed-off-by: Kurt Lee <kurt.lee@cypress.com>
> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
> ---
>   .../net/wireless/broadcom/brcm80211/brcmfmac/vendor.c    | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c
> index d07e7c7355d9..5edf5ac1167a 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c
> @@ -64,6 +64,15 @@ static int brcmf_cfg80211_vndr_cmds_dcmd_handler(struct wiphy *wiphy,
>                  *(char *)(dcmd_buf + len)  = '\0';
>          }
> 
> +       if (cmdhdr->cmd == BRCMF_C_SET_AP) {
> +               if (*(int *)(dcmd_buf) == 1) {
> +                       ifp->vif->wdev.iftype = NL80211_IFTYPE_AP;
> +                       brcmf_net_setcarrier(ifp, true);
> +               } else {
> +                       ifp->vif->wdev.iftype = NL80211_IFTYPE_STATION;
> +               }
> +       }
> +

I prefer to keep this code path as flat as possible so I prefer no 
monitoring of firmware commands issued by user-space. Maybe another 
approach would be to set the carrier on a firmware event?

Regards,
Arend
