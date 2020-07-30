Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937692338AF
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 21:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgG3TKw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 15:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730411AbgG3TKw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 15:10:52 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051B0C061574
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 12:10:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t14so2004450wmi.3
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CscVsMNnpDg2b000DHJpFBIh3agH1Nhvyq9uWgvASwg=;
        b=0tZ/E4YxOxlM9Ibk6lZot3+gIOoUaOCDlJh1QLcOYi89b1Ufn3Bk+Ea5wJ1ESWWu2B
         S+GJztXLe35iM/wbTdLRETB0zkdZ35lTJnqOQlmjoMNxWi4iJlNhN2/I0+gLnGlNOb2f
         +upWW6lwucQdarNNWtffU3ynbkiXqtrrVDgetgotxFsm0Ycj0A0G3gPj9/3sGMXBquxy
         2YhHrb+I8QSOrUgYT7ikQKOU6XhNaax5XoDG8SMh6FYj5Kz3Q0RM0XBnfx6NuC04wFmh
         F/2xClUMh66f4bLypajQK8aGMSyKr90DiIDoCzmv682l3pOq1lmMgpnzikverGms4y3X
         Mg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CscVsMNnpDg2b000DHJpFBIh3agH1Nhvyq9uWgvASwg=;
        b=luN8m90XD8wr/Eq/AxkarzqU3TpXydp98C4eR8aHvzpGINMXMP9EECX3N4dFiK1FAq
         fACOZDia83l3pnKZQG9Es1FSSk5akXUEhQVryKVkkHEjIU8nzGh+lEt/hIr62Vzg0K/m
         iMOijIIbtf8sUY1dC0pPDtTNvTxsf68ikFjIYtvzWB8Bfcr8DH3Lg+qp6cEX4r/zxxHN
         iQn7+Wm5tmuzyXPSVzlXvj9MX2FsLHEGXI8Hpyq/sijcC4pIOc1arOUIVaOtg+XBHP3J
         IHuEbOctGjfhW5By0IP4pbJDHyYJP+e6G7oYXIi+WdGGwhuRXyfDTIqhQ/2Km+ucjofE
         nrZw==
X-Gm-Message-State: AOAM533jhatsA2NxOGu2+2Pf7WI0CxmpKxundK2YOwPTCBDJC/VF2FPW
        tQlRIWTSkW5Pb3n556gH1DUvfIuuUZg=
X-Google-Smtp-Source: ABdhPJwk35VEzk0JD4jBkNHJ9qz9KDvAJuPYD/ydsRSAc2A6rWn3cKAUbERRbl5DHBQi7Aio8WnmHg==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr538501wmb.113.1596136250537;
        Thu, 30 Jul 2020 12:10:50 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id l11sm9589533wme.11.2020.07.30.12.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 12:10:49 -0700 (PDT)
Subject: Re: [PATCH] wcn36xx: Set operational channel to 0 on disassociation
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        kvalo@codeaurora.org, loic.poulain@linaro.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20200730110947.57979-1-bryan.odonoghue@linaro.org>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <3a77d3dd-9ac5-6733-f4bb-76fda257f095@nexus-software.ie>
Date:   Thu, 30 Jul 2020 20:11:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730110947.57979-1-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 30/07/2020 12:09, Bryan O'Donoghue wrote:
> After a disassociated event we need to make sure we reset the operational
> channel so that subsequent channel scans will not exclude the channel we
> were using.
> 
> Doing a software scan on a wcn3680 showed that if we disassociated from an
> AP we would never see it re-appear in a scan - unless we shifted the AP to
> a different channel.
> 
> Setting the operational channel to zero on disassociation ensures that this
> situation will not arise in the wild.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   drivers/net/wireless/ath/wcn36xx/main.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
> index fb8978a3c11e..4681d085b683 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -908,6 +908,7 @@ static void wcn36xx_bss_info_changed(struct ieee80211_hw *hw,
>   						bss_conf->bssid,
>   						vif->addr,
>   						WCN36XX_HAL_LINK_IDLE_STATE);
> +			wcn36xx_smd_switch_channel(wcn, vif, 0);
>   		}
>   	}
>   
> 

Hmm.

This one failed for me too.. eventually.

wcn36xx: ERROR hal_switch_channel=0 response failed err=6.

Looks like channel 0 as a safety channel will not always be accepted by 
the firmware.

I think the right fix is to set the working channel to any _valid_ 
channel in our set other than the current channel.

That way the software scan will still run but, the firmware should also 
still be happy to switch to the channel we have set.

Anyway - ignore this patch for now

---
bod



