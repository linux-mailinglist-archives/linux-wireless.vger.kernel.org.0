Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D65A3FD00E
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Sep 2021 01:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238736AbhHaXxS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Aug 2021 19:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhHaXxR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Aug 2021 19:53:17 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7F0C061575
        for <linux-wireless@vger.kernel.org>; Tue, 31 Aug 2021 16:52:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g135so578272wme.5
        for <linux-wireless@vger.kernel.org>; Tue, 31 Aug 2021 16:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=95QP2BN90WZbAXtAhZTRyF6v3t06pc8PXKl5fp9d0dM=;
        b=IVSbAGcSJEIN3OmJUdsUYbjtvjF90ttFac5ujkqN6UKSJ1YfF8PEH022EPM08GR2lD
         14mR2Rf2fT7nDCeQSOHm6kHvyoRpmfayns0UcM1x4TTz6zsog9MK3lLAjU0K03ugQwtp
         mhQvpYkKkHxKMur2tmTpHxOXkPFRnEsQxsxaR/m3bysAozXxPmqiGr04dr0aXfTETQww
         Vh70jIEsYmj/RYgpbV3y6T9DfXFmrS/Mnw2cIJHlZMDMAaLRaRosC4F/uUrrjbnSCHMg
         5rTw2MB2oanv25TyOiDGOZZvt8Fx5GCNFu6D+vSh3rjJYc9HxireHymgPeQDFgf4LUHZ
         f20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=95QP2BN90WZbAXtAhZTRyF6v3t06pc8PXKl5fp9d0dM=;
        b=erVEz8I5j6oaBtCI6o0GagNATXwLIhjc1GwJnRTgkqro+jW6f+g/JzuNzgasMpYO/5
         GP6ydNFmD/HGcsnP6ThEPjYUytWOh7nUUQBi7ShIrEiF8KXrqUqVyetk0Tre7s8VF2kZ
         //9u6aZynjTCJE4sX/c8XsqJzyWB7yDcVqxglQM1VWbueZfSSkLgB0YvACLWvMKyDWzW
         bq15G/xtRFJ7+AXuGY3aCU6S7IxgRknHzLEuMkZPnHyFRGX5GU6Vjnp4/SdZQYbJDOZT
         ebXytKD3RVGNaH2kwVWHHhrw7Gau2OTtX+CDe3lajEUqEYavfMNqKk91VNfBcqsvPbeP
         FUiw==
X-Gm-Message-State: AOAM533P2LpEnQ9mIlnwXdqnBOhk3mICdpC4P6OKDOXe3dmi7ZqtXQC6
        NoLxkQhaiaEe2fcDq/eQ66utNKKkArJ7UIeq
X-Google-Smtp-Source: ABdhPJy61pHIYYgB9hFjnI9/nfugzyWJ1NlLcXyB5SkAf2+hwv7ilTTCgrCZFgT6JAXf7oxRbxCSmw==
X-Received: by 2002:a7b:cb53:: with SMTP id v19mr6575456wmj.127.1630453939837;
        Tue, 31 Aug 2021 16:52:19 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d9sm24169493wrb.36.2021.08.31.16.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 16:52:19 -0700 (PDT)
Subject: Re: [PATCH] Revert "wcn36xx: Enable firmware link monitoring"
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-wireless@vger.kernel.org, stable@vger.kernel.org,
        Benjamin Li <benl@squareup.com>
References: <1630343360-5942-1-git-send-email-loic.poulain@linaro.org>
 <878s0i3yfq.fsf@codeaurora.org>
 <40edf308-d12c-2116-0e5f-22cab413ea71@linaro.org>
Message-ID: <afb41aa0-c6a8-4663-3b05-c26046a2f5b1@linaro.org>
Date:   Wed, 1 Sep 2021 00:54:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <40edf308-d12c-2116-0e5f-22cab413ea71@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 01/09/2021 00:51, Bryan O'Donoghue wrote:
> On 31/08/2021 07:44, Kalle Valo wrote:
>> Loic Poulain <loic.poulain@linaro.org> writes:
>>
>>> This reverts commit wcn->hw, CONNECTION_MONITOR.
>>>
>>> The firmware keep-alive does not cause any event in case of error
>>> such as non acked. It's just a basic keep alive to prevent the AP
>>> to kick-off the station due to inactivity. So let mac80211 submit
>>> its own monitoring packet (probe/null) and disconnect on timeout.
>>>
>>> Note: We want to keep firmware keep alive to prevent kick-off
>>> when host is in suspend-to-mem (no mac80211 monitor packet).
>>> Ideally fw keep alive should be enabled in suspend path and disabled
>>> in resume path to prevent having both firmware and mac80211 submitting
>>> periodic null packets.
>>>
>>> This fixes non detected AP leaving issues in active mode (nothing
>>> monitors beacon or connection).
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 8def9ec46a5f ("wcn36xx: Enable firmware link monitoring")
>>> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
>>
>> I'll queue this to v5.15.
>>
> 
> Might want to hold off on that.
> 
> Its been reported by testing that wcn36xx_smd_delete_sta_context_ind() 
> actually _is_ firing.
> 
> But if you look at wcn36xx_smd_delete_sta_context_ind() it doesn't seem 
> to do ieee80211_connection_loss() like it presumably should.
> 
> I think the right fix here might be to call ieee80211_connection_loss() 
> in wcn36xx_smd_delete_sta_context_ind() if (wcn->hw & CONNECTION_MONITOR)
> 
> ---
> bod

In that case right now if (wcn->hw & CONNECTION_MONITOR) we'd presumably 
rely on a subsequent wcn36xx_smd_missed_beacon_ind() but...

its not clear that wcn36xx_smd_missed_beacon_ind() would fire subsequent 
to wcn36xx_smd_delete_sta_context_ind()

In fact, it would be pretty illogical if it did.

I think instead of revert - we want to just do better processing here in 
wcn36xx_smd_delete_sta_context_ind() alright.

---
bod
