Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FEF4E33E1
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Mar 2022 00:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiCUXA2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 19:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbiCUW7Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 18:59:16 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A632DD69
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 15:47:05 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id p15so32766518ejc.7
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 15:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=B3k8XeIehCebVGnYu+X4/M90KsONe0lm83sqt9IZNVE=;
        b=Xl/Vdd9aQ1md8c05zqF8ZFmtLUu6VrldOsAc0MNNRGBOKIKLwyAfL2zv5lSGUBMZfC
         MMI+NAEDuCCx0w3c8Z0b+c86tFwmULMTp8PPbzkvsaWeePfx+q1CdS/pRuDSyU3y2k+Q
         eVb15/PtFbKxPKXt4xdr9Z2F2XpKleCGUl/Xp7gd6FtRhS9GvL7UyxKUqAN0i7/vsNck
         yCRojuFiXFNKD9LrhEzoAqWyFQZczpFv4v/qqLn5rvItB5r5gWQkzoCEztzVLuO5iby9
         ddDFFvQi64CIF64/xmXNiqBZCpZDhI0Xe4qOinNCSrIuCpG70xuCOVIsCMEoVoVNdOsg
         qBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B3k8XeIehCebVGnYu+X4/M90KsONe0lm83sqt9IZNVE=;
        b=aGvF54Ks3ZDEUu0gSkbCzufAtA9h1rYMAqcS3wjnm+6eDe6NCGyX7c/fdPwqUZcLoM
         OqlMG3AGo9i6IGVbtBkyU+wEzcsIqI45K5LE6KONF/ikaOE1IZwLKicYG3OS/M26eW3g
         SdiH39JD+Y5XybVb07SZVztPKEOjlN5KReKPNL+56qyUp03fkADJv30vuWpg77aMGPFp
         lsxz28mxSHN+Qd+MAJwi1wrRZjl/eMG+d2XUq5Vs3P86nFxczmZgCKdfExXgncCYv4sU
         s4fvsiQrHEp45Sl5ysMq8wH+ovW85u9EOve3T58qRWSPFEVGO/vp0iwxadVzUT0WqNLq
         PDYQ==
X-Gm-Message-State: AOAM531/6O/bGg93XaWNF2JbNU+BRuRPN8oSJ0SbIZ0U9+VTwF992arp
        NuRWyW8RX/wloEoeJC483c0VcumeDnbPlQ==
X-Google-Smtp-Source: ABdhPJwVqxIIp8FANWfiQvGEsha5ArRtocfdS9cm7cudMsEddR7vde9sS+98VhnWg3uzkmzzLpNEEA==
X-Received: by 2002:a17:907:1b25:b0:6da:8206:fc56 with SMTP id mp37-20020a1709071b2500b006da8206fc56mr22423558ejc.81.1647902823804;
        Mon, 21 Mar 2022 15:47:03 -0700 (PDT)
Received: from ?IPV6:2a02:1811:cc83:eef0:7bf1:a0f8:a9aa:ac98? (ptr-dtfv0pmq82wc9dcpm6w.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:7bf1:a0f8:a9aa:ac98])
        by smtp.gmail.com with ESMTPSA id qk9-20020a1709077f8900b006dfbc4b9b83sm4348181ejc.163.2022.03.21.15.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 15:47:03 -0700 (PDT)
Message-ID: <dedd1b4c-4d72-ac36-865e-f02614dfe3da@gmail.com>
Date:   Mon, 21 Mar 2022 23:47:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH RFT] mwifiex: add mutex lock for call in
 mwifiex_dfs_chan_sw_work_queue
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-wireless@vger.kernel.org,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@kernel.org>
References: <20220319224751.72241-1-dossche.niels@gmail.com>
 <YjjdcG5NmzLOmjEu@google.com>
From:   Niels Dossche <dossche.niels@gmail.com>
In-Reply-To: <YjjdcG5NmzLOmjEu@google.com>
Content-Type: text/plain; charset=UTF-8
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

On 21/03/2022 21:17, Brian Norris wrote:
> On Sat, Mar 19, 2022 at 11:47:52PM +0100, Niels Dossche wrote:
>> --- a/drivers/net/wireless/marvell/mwifiex/11h.c
>> +++ b/drivers/net/wireless/marvell/mwifiex/11h.c
>> @@ -285,6 +285,7 @@ void mwifiex_dfs_chan_sw_work_queue(struct work_struct *work)
>>  	struct mwifiex_private *priv =
>>  			container_of(delayed_work, struct mwifiex_private,
>>  				     dfs_chan_sw_work);
>> +	struct net_device *netdev;
>>  
>>  	bss_cfg = &priv->bss_cfg;
>>  	if (!bss_cfg->beacon_period) {
>> @@ -301,7 +302,11 @@ void mwifiex_dfs_chan_sw_work_queue(struct work_struct *work)
>>  		return;
>>  	}
>>  
>> +	netdev = priv->netdev;
>> +
>>  	mwifiex_dbg(priv->adapter, MSG,
>>  		    "indicating channel switch completion to kernel\n");
>> -	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef);
>> +	mutex_lock(&netdev->ieee80211_ptr->mtx);
> 
> A more appropriate route to this object might be priv->wdev.mtx. But
> otherwise, I think this makes sense, and matches what
> ath6kl_cfg80211_ch_switch_notify() and qtnf_event_handle_freq_change()
> do. With the suggested change:

Thanks for the review, will change that and send a v2.

> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> 
> Thanks.
> 
>> +	cfg80211_ch_switch_notify(netdev, &priv->dfs_chandef);
>> +	mutex_unlock(&netdev->ieee80211_ptr->mtx);
>>  }
>> -- 
>> 2.35.1
>>
