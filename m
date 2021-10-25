Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8F2439191
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 10:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhJYIkb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 04:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbhJYIka (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 04:40:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCDDC061745
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 01:38:08 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w15so7731593wra.3
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 01:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bpFddSXicr1FOM7E1DSDsDLO4EvvjPdgYo/SwAWZ4CI=;
        b=HsYo9mM67IAT2JW0UEFZJwI0o2A4VGquieEwA9MU26/6PzcXu+pfdzIxjmXObEvPQM
         te/aGKHmrZZ1hIsPeWSQVuJ45tHvnBA0b/Ndupp4xBwo8d50DyeSt5+QIXxABJk9hgaM
         uA+l55TIA1nSsjFyz5M8g49gwT60Yjgjpa+FLPb7cie+yLASxDe7asA/Gt9BKz/kF5yJ
         3Q0YnFI5kofNdNXdWkdtO4gqJRcFzhCDj67nJcU0Nne7JbQtUNGeTgbqHx1FYoiInGL/
         8cKRcpe+0vtnCwThoHAhACYi9XbDbRZC7/tJaly6sIhwKBCCYJbCVcyJJSYXYUAsa0vX
         PnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bpFddSXicr1FOM7E1DSDsDLO4EvvjPdgYo/SwAWZ4CI=;
        b=aoAu59CfHF/beUKu2T3F2KSXWo8cioHjrLiNY8fWirz7ZD1lwsrSP7Hy764/yEJpkC
         rzl6/XC0lcgvtV6FEeBK4uegLquW5JXx79oK+3XYvmsiXlzACHt4eJZHviqeHUcOzbh3
         kY5WyphrWeBP1BSyigJJt8lm2vjTrySVfbF50Camkgtt+9mjvDyGVi9uzQjPQo10zZpp
         bBzs/LswbfQCQjvEpSXMNl5NdmJxR6ykvFx+PVZB8Hr+TvJVyFv/8DuNGkz3MNNjy8bu
         U8YvtYJryHNpsB3QIQZh8xYBDt1i+FCYO6earoTZaMY2o1zoFnbU2++LhsplwbF+ImZ4
         JS0g==
X-Gm-Message-State: AOAM531nU67/i7IIapwYWTfa2PHG+gGEoaZfGfuo2gcUvLXLW7K96bfD
        u9ZL5+6Wo44j8MVhtT9/kpd52Q==
X-Google-Smtp-Source: ABdhPJwJQsTm18eA47qfr8YhUnx2IdC6QrR+dYrFLw0m0UG4HBjVqdt0CYvTKx1yHsWOdYvkCkOhRg==
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr21726178wrx.143.1635151086698;
        Mon, 25 Oct 2021 01:38:06 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id i6sm4602277wry.71.2021.10.25.01.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 01:38:06 -0700 (PDT)
Message-ID: <03845fc8-17a4-22b2-52fa-4fb013432a7a@linaro.org>
Date:   Mon, 25 Oct 2021 09:40:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] wcn36xx: Fix packet drop on resume
Content-Language: en-US
To:     Loic Poulain <loic.poulain@linaro.org>, kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
References: <1635150496-19290-1-git-send-email-loic.poulain@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1635150496-19290-1-git-send-email-loic.poulain@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 25/10/2021 09:28, Loic Poulain wrote:
> If the system is resumed because of an incoming packet, the wcn36xx RX
> interrupts is fired before actual resuming of the wireless/mac80211
> stack, causing any received packets to be simply dropped. E.g. a ping
> request causes a system resume, but is dropped and so never forwarded
> to the IP stack.
> 
> This change fixes that, disabling DMA interrupts on suspend to no pass
> packets until mac80211 is resumed and ready to handle them.
> 
> Note that it's not incompatible with RX irq wake.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>   drivers/net/wireless/ath/wcn36xx/main.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
> index a42eae6..a650b9e 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -1137,6 +1137,13 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
>   			goto out;
>   		ret = wcn36xx_smd_wlan_host_suspend_ind(wcn);
>   	}
> +
> +	/* Disable IRQ, we don't want to handle any packet before mac80211 is
> +	 * resumed and ready to receive packets.
> +	 */
> +	disable_irq(wcn->tx_irq);
> +	disable_irq(wcn->rx_irq);
> +
>   out:
>   	mutex_unlock(&wcn->conf_mutex);
>   	return ret;
> @@ -1159,6 +1166,10 @@ static int wcn36xx_resume(struct ieee80211_hw *hw)
>   		wcn36xx_smd_ipv6_ns_offload(wcn, vif, false);
>   		wcn36xx_smd_arp_offload(wcn, vif, false);
>   	}
> +
> +	enable_irq(wcn->tx_irq);
> +	enable_irq(wcn->rx_irq);
> +
>   	mutex_unlock(&wcn->conf_mutex);
>   
>   	return 0;
> 

LGTM

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
