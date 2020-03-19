Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74D9718AEA7
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2020 09:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgCSIsg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Mar 2020 04:48:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54254 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgCSIsO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Mar 2020 04:48:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id 25so1039448wmk.3
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2020 01:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IYDx/ptJGnszzUSU/93/OXR/JSdyr1OCrDuqjWjepG4=;
        b=V9pWedQYvc2k7hjphAEHXozN3NuyMbd+eVZu5SD9BfwJpkD77qUWodVimzg9WuBUz+
         iBcCnCR11OevH+wbWB/3rgfpVC6l77ViGEO9TCygNwEGNERoFblEwWwHHWbc73fpoYJu
         oi2GmYpJpedds7VF9FtuN95CxdwW4ugKECRYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IYDx/ptJGnszzUSU/93/OXR/JSdyr1OCrDuqjWjepG4=;
        b=iW6KoDZdeYiTY6AoAkZOtaU43C9Q+wwSDIU7iPbpxR3rEbXYWgK/jezMp3JGkcXewG
         /3POOAItrcPzQ9LJpG6gPiiBTbPkF+Ur6UE5/bXlMKSj8Q6K/udJh2gMgWOvMNLbRelC
         JyOVyvwVtxJVAUlz0qDpo6AZ/0a7hE1f7d6Dx3Sqrzh4y7qFaSAhXDXvVboR3kPwlPuy
         MO8IsDSTQoep05vJ8L+Vm0OwzQJw1w5DJty168WWPvkCTU6qN/4q6jVrSKzrxL6u4nbG
         c2xI/LOyOOjg8ujPWFd0JNG8akTgJGYxgSyby9oK0EKY9LlxmTMwSF2GC7ooDEelDSdN
         ysjw==
X-Gm-Message-State: ANhLgQ2Pf2KnXXSopFsT0DTaBIuZMksn4bQorKciTaKbTeyZFcBfTS29
        MoF6GaJXwqusOTDdAS4DAkpzIA==
X-Google-Smtp-Source: ADFU+vvruVI0emy4HXrV7ex9XnC0hxYwqMNLeJ/cKSvgBRHAq6F3VtrztdileURLjTlC1HIHea5S6A==
X-Received: by 2002:a7b:ca41:: with SMTP id m1mr2250238wml.127.1584607692222;
        Thu, 19 Mar 2020 01:48:12 -0700 (PDT)
Received: from [10.230.41.113] ([192.19.215.251])
        by smtp.gmail.com with ESMTPSA id x17sm2178076wmi.28.2020.03.19.01.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 01:48:11 -0700 (PDT)
Subject: Re: [PATCH 1/3] brcmfmac: support AP isolate
To:     Wright Feng <wright.feng@cypress.com>, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@codeaurora.org,
        chi-hsien.lin@cypress.com
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
References: <1584604406-15452-1-git-send-email-wright.feng@cypress.com>
 <1584604406-15452-2-git-send-email-wright.feng@cypress.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <32bb2e43-76f5-5c41-af20-3cec1baa7bd8@broadcom.com>
Date:   Thu, 19 Mar 2020 09:48:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584604406-15452-2-git-send-email-wright.feng@cypress.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/19/2020 8:53 AM, Wright Feng wrote:
> Hostap daemon has a parameter "ap_isolate" which is used to prevent
> low-level bridging of frames between associated stations in the BSS.
> For driver side, we add cfg80211 ops method change_bss to support
> setting AP isolate from user space.
> 
> Signed-off-by: Wright Feng <wright.feng@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
> ---
>   .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index a2328d3..eb49900 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c

[...]

> @@ -5421,6 +5441,7 @@ static struct cfg80211_ops brcmf_cfg80211_ops = {
>   	.update_connect_params = brcmf_cfg80211_update_conn_params,
>   	.set_pmk = brcmf_cfg80211_set_pmk,
>   	.del_pmk = brcmf_cfg80211_del_pmk,
> +	.change_bss = brcmf_cfg80211_change_bss,

maybe only add this when firmware support "ap_isolate"?

Regards,
Arend
