Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E4F43501F
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Oct 2021 18:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhJTQ2n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Oct 2021 12:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhJTQ2m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Oct 2021 12:28:42 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFD3C06161C
        for <linux-wireless@vger.kernel.org>; Wed, 20 Oct 2021 09:26:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o24so12813049wms.0
        for <linux-wireless@vger.kernel.org>; Wed, 20 Oct 2021 09:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3SQrn2nw1EiNhbPfAJK4wb6SICQN1Y4EQO0RwB7A/aQ=;
        b=PYqg2tKF+l7xBbLepJ7MkZxUbHdeOgtBzPTuq6Uy1rop5nYVP2Ap6nqn21onEqNH1w
         D2+BGSLnbldUPL0Zp8NvgKSNvj1gR3gvHGwSVz/JuTNshhg4PrVup+YCtXAO7Cr9tlNh
         MzNfaJE9eBjMKOjWie9wZYL6WgBH892Xtl6iQBv45IplmdIqP7VPWuA47rqVwjXOGa4v
         dqIkZCHJu6NeAOgOLXKZelSfjopE/hU9JTuDoyXeP5nI7WBFvuEWdZpglYiIg5rPKGus
         CUN8R65AG5HNXcti/V5KsPb7G6PxSUM8LkRhG/W2x40QkFC5EBUqFnXAXM66DRVKInqT
         lxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3SQrn2nw1EiNhbPfAJK4wb6SICQN1Y4EQO0RwB7A/aQ=;
        b=DzLlqn8vyOFtg1PMAb9C9XuleSidnx2izt2jKdiRKTZ1pGR2+qn6+K82I9q2FJlvES
         N6G8pfMFb2JN4/7ZVIa69IeF77I5/VdUFEfy4qlydbG+e0GvnJ7cpJW6uiPnW38Qom6v
         8smxgcqeP1DZO12cQ29DzcmMKz59O8CGqZoQMDV99mZXQZOoyu7YUlNQjyX7e0jZRzEl
         I+/u3DaHOkG6j8htbMQVL+sxrfMLvGNV1rzBfbI8N8brQhResQesYYl4O9WSyOzB+7/R
         VScTrhrBELXOIu0+4RtVtk9p5quheLgxt4/C6Fds+pD/H0Ib5ttzmftObMZNmj86ePB3
         brbw==
X-Gm-Message-State: AOAM531IhVaKlpgXuIrOl9jXpKHZkE2dQ857Bvj57DlK01k7DL8VSUU8
        LsXJgmBo813esNKwT9uy/4beLw==
X-Google-Smtp-Source: ABdhPJxcsqeUgYAImPE9yXLqv4iYdDU+eKZah8KkHX0W3OgMUj/OSgJJD+Pjk+MeSGOJ7+N0ym0sqw==
X-Received: by 2002:a7b:c114:: with SMTP id w20mr226490wmi.143.1634747186193;
        Wed, 20 Oct 2021 09:26:26 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id y5sm2325112wrq.85.2021.10.20.09.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 09:26:25 -0700 (PDT)
Message-ID: <574368d8-ebfa-7765-ea0d-def99b855719@linaro.org>
Date:   Wed, 20 Oct 2021 17:28:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 1/2] wcn36xx: Correct band/freq reporting on RX
Content-Language: en-US
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <1634554678-7993-1-git-send-email-loic.poulain@linaro.org>
 <d2128789-646f-1e02-0dd2-a9ac14b37cf7@linaro.org>
 <5a325d84-0d02-237b-a0a3-9eddd2e481de@linaro.org>
 <CAMZdPi8Mh+pN=xExhY1TFYJYTKCDJmVApNG3oOMFtF5nLu770A@mail.gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CAMZdPi8Mh+pN=xExhY1TFYJYTKCDJmVApNG3oOMFtF5nLu770A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 20/10/2021 14:54, Loic Poulain wrote:
> Hi Bryan, Kalle,
> 
> On Tue, 19 Oct 2021 at 02:26, Bryan O'Donoghue
> <bryan.odonoghue@linaro.org> wrote:
>>
>> On 18/10/2021 23:51, Bryan O'Donoghue wrote:
>>> On 18/10/2021 11:57, Loic Poulain wrote:
>>>>            ieee80211_is_probe_resp(hdr->frame_control))
>>>>            status.boottime_ns = ktime_get_boottime_ns();
>>>
>>> I think this is dangling in your tree, doesn't apply cleanly for me anyway
>>>
>>> Other than that
>>>
>>> Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>
>> Hmm.
>>
>> I'm told by a colleague with access to a router that has channel 144 - I
>> do not BTW - that 144 is not showing up with the firmware offload scan.
>>
>> We should probably hold off on applying for the time being :(
> 
> So the missing channel 144 is due to a different problem, and is now fixed
> in a subsequent patch:
>      wcn36xx: Channel list update before hardware scan
> 
> So I think we can go with this change :-).
> 
> Regards,
> Loic
> 

Cool, nice job
