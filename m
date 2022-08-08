Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A768A58C507
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Aug 2022 10:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbiHHImr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Aug 2022 04:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbiHHImo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Aug 2022 04:42:44 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66D462DB
        for <linux-wireless@vger.kernel.org>; Mon,  8 Aug 2022 01:42:43 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so8392396pjf.5
        for <linux-wireless@vger.kernel.org>; Mon, 08 Aug 2022 01:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/V5YRzrrngmrKnPlwjf2mgGczmcX1pFkUBvlD3ol0Bc=;
        b=GQnd9TY1YEzi5kl2Lpj5+BraYFv5K2KMYpqyeBGSJX6Ps2WZx6/vOZrvXXT6BdDe9N
         rPt38lus/dthOJHWQ/BqlCgrV9PUQAFLO0bjVkVy49GYKCeIg/ghmEoM7hG22+ZfvANO
         WwHAk1xRJtmZ+unsjz/xoUL1MbP1E10HzG/GWA/wno3uGH1NEDCQQwRxMSNJH+EgSgmY
         zFHHddStYltjqR+0+DbBy+SPTxX8WuILn6nyRLe2iwjiDwFoTk7tduaNHbnts9iKwAZ0
         emjGWfKkTHTGiJZBfHzBxOHiqtu/3BuVbk3xnA6OtC/lHnYDTtKDDRN4sH6QRVwyFwO8
         l5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/V5YRzrrngmrKnPlwjf2mgGczmcX1pFkUBvlD3ol0Bc=;
        b=CMPBe7OLCGMAl5xH96rseLZqdJldjrjKIanJqx1ep+jg0B+q2KEveI8DxR152fxXup
         eZtF0TDVVxAkwDUu0zJmxKpRL7Gv4hL9x3hfQO+Rvg05fdpRDFvCj0nOjTdLqnH+O6T+
         gubnl99eJntnu0O2WEwTH+hZRkGvwDIFlon3O3KOvBQvI+Agwl8hFL4mLC21m+eM7dDt
         MLV3DkxoguYCuuPyd7JC1OZUFOLvrMr1WeOmTB2FdsLB30P/DtRz/k5X1cw5H/ADZflI
         wUqJOaPwLkBtTIGjHwft5rPym2a8ZUJcqAxDwJwg8POC8k8gljldod8p6OcY634gGj9U
         e2qA==
X-Gm-Message-State: ACgBeo3DRqCiEXZprXUSGo/zE6qhZLgQm8vzteZUtwH6udc1w5bUIeQJ
        vN0U2yRTr63lttDc+AB4b2M=
X-Google-Smtp-Source: AA6agR44OLGo625i4Bej3GHWTf+RtfAVSgb5b0BWvS61bFpz6lApAKhjRNmeHHHnrCpuRus185/zPw==
X-Received: by 2002:a17:902:ecce:b0:16e:e6e9:69b9 with SMTP id a14-20020a170902ecce00b0016ee6e969b9mr17667827plh.139.1659948163208;
        Mon, 08 Aug 2022 01:42:43 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d40400b0016f1319d2aasm7984242ple.171.2022.08.08.01.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 01:42:42 -0700 (PDT)
Message-ID: <ff359bed-ddfa-9f18-e926-fad986b9918b@gmail.com>
Date:   Mon, 8 Aug 2022 10:42:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] brcmfmac: fix use-after-free bug
Content-Language: en-US
To:     Alexander Coffin <alex.coffin@matician.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
References: <20220802172823.1696680-1-alex.coffin@matician.com>
 <20220802172823.1696680-2-alex.coffin@matician.com>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <20220802172823.1696680-2-alex.coffin@matician.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/2/2022 7:28 PM, Alexander Coffin wrote:
 >

A commit message would have been nice...

> Signed-off-by: Alexander Coffin <alex.coffin@matician.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> index 87aef211b35f..12ee8b7163fd 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> @@ -296,6 +296,7 @@ static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *skb,
>   	struct brcmf_pub *drvr = ifp->drvr;
>   	struct ethhdr *eh;
>   	int head_delta;
> +	unsigned int tx_bytes = skb->len;
>   
>   	brcmf_dbg(DATA, "Enter, bsscfgidx=%d\n", ifp->bsscfgidx);
>   
> @@ -370,7 +371,7 @@ static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *skb,
>   		ndev->stats.tx_dropped++;
>   	} else {
>   		ndev->stats.tx_packets++;
> -		ndev->stats.tx_bytes += skb->len;
> +		ndev->stats.tx_bytes += tx_bytes;

Why would this be a use-after-free? We only get here when ret is zero. 
In that case the skb is not freed. If there would be a commit message 
with some error report that proofs there is a use-after-free I would 
look into this further, but now I just say NAK.

Regards,
Arend

>   	}
>   
>   	/* Return ok: we always eat the packet */
