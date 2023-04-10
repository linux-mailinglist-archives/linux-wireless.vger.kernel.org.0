Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2806DCDAA
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 00:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjDJWt4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Apr 2023 18:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDJWtz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Apr 2023 18:49:55 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97B01BF1
        for <linux-wireless@vger.kernel.org>; Mon, 10 Apr 2023 15:49:53 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 20so7797365plk.10
        for <linux-wireless@vger.kernel.org>; Mon, 10 Apr 2023 15:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681166993;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3t1KjkhsY3dbdLV5/spto0CqC4ciHSRy5efznb6cZIk=;
        b=U5ro2patfTVnv5SQByLVLDDtIlIKa9HszDeiDpQfXiR0k7yXSe3cri3l+P6CBfnaK5
         sUe365p7rlrb09ZJJa2GeyocAU9/7GypqZfyVo6pzmjcR/oeFsWO5gX6tF1IGrc36afR
         VPC91H34V4jFZbkevq6slzrWdzl1qkjdGXyF/QVe1sFpKOwVCs96tevc23G+jOujHI6+
         bqwtEFOEUGu+BiTzvWLM9u87yrSQFicVo6b7QZhzbhyKHCxRmNqNwdENrb2iD5BVCr47
         +mjaH3UrE0NDm491i7HY1rpPl8tvIocKU0oqO+U933FvbMoDyBF2YMBc6cVaBl4oOWRk
         QTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681166993;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3t1KjkhsY3dbdLV5/spto0CqC4ciHSRy5efznb6cZIk=;
        b=Ajvb8mQb8lJfwUPL4OB+eVzNHaCd3ehtHj2exrEqDP2cilstSF+mw3zQGofQrqgNvZ
         b/FIv+v6SKFXKdF0RmY+ZifhqKst34vcSSaQI5ERelUxlJbX0KekLxdaSSfeRbD+9vIX
         lyt1jfBNFGsn4f/OlCv/LDh5MRHr61IfJdcg0xHdPMlZ3/TqRx+dqyLvMeorUjrLIdTw
         TYW0PrPnWrsjB5qQfT/ycmT5wT3/mug1p/x+Ia5A/t1OmW0LkQ/t/MsSHasG8kIo9mL3
         zpm4nFt4DfiCNZI57/ww0N4WmxgTP6CABqMukCvk3d1XQbeS4PG+2can/nMKMBSfBlIK
         X2NA==
X-Gm-Message-State: AAQBX9c4Jos1k6cHOHilpGvu+ZhFGtRJchFtUJBRlaEotF25h2RlxHDA
        nCV5albEGUs0aZO6A1t7FNxnEKZheSPs3Q==
X-Google-Smtp-Source: AKy350YKzNX6vVoS1GRGbcg+6AtYovQynU9kkmnSVjl2Gr/EYaG/H/y7szLQ0EN6wbebdMH+EktGbg==
X-Received: by 2002:a17:90b:3a8f:b0:23f:9925:6f8b with SMTP id om15-20020a17090b3a8f00b0023f99256f8bmr15186041pjb.17.1681166993263;
        Mon, 10 Apr 2023 15:49:53 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id y8-20020a655b48000000b0051366c88476sm7432409pgr.30.2023.04.10.15.49.52
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 15:49:52 -0700 (PDT)
Message-ID: <9b4b6d3e-8840-f37a-52ec-6ea391fa67db@gmail.com>
Date:   Mon, 10 Apr 2023 15:49:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: CMD_REMAIN_ON_CHANNEL vs CMD_FRAME (offchannel)
Content-Language: en-US
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
References: <6d3869e9-6d8f-f7cf-2fe9-b8188a02d086@gmail.com>
In-Reply-To: <6d3869e9-6d8f-f7cf-2fe9-b8188a02d086@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/7/23 11:47 AM, James Prestwood wrote:
> Hi,
> 
> I'm having an issue with CMD_REMAIN_ON_CHANNEL taking a full second to 
> become ready versus CMD_FRAME (offchannel_ok=1) which is quite fast. 
> Under the hood it looks like both commands call 
> ieee80211_start_roc_work() so its curious why one would take so long. 
> I'm running this in UML so I shouldn't be hitting scheduling problems 
> (at least that's how I understand UML).
> 
> This happens during the DPP auth exchange, I can include a full log if 
> desired, but this is the sequence:
> 
> - Start ROC on 2417mhz
> - Wait for ROC event indicating we are offchannel
> - Receive DPP presence announcement from enrollee
> - Send DPP auth request, request enrollee switches to 2412mhz
> - Send Cancel ROC (and wait for confirmation)
> 
> - Start ROC on 2412mhz
> - Oddly, receive the enrollees auth response before ROC event. So the 
> driver _did_ switch channels.
> - ROC event comes about a second later, and enrollee has timed out
> 
> So the driver is in fact going offchannel to 2412 and even receiving a 
> frame. But for whatever reason it doesn't send the ROC event for a full 
> second. Any idea why the ROC event is so delayed here?

After a lot of kernel prints I think I know whats going on, but still 
somewhat confused.

It appears that sending a frame then immediately canceling the ROC 
request is the issue. The kernel seems to be queuing the CMD_FRAME 
rather than adding it to the ROC request (is this expected?). To 
simplify the above sequence without DPP specifics:

ROC on 2417mhz
...
Send frame on 2417mhz (queued)
Cancel ROC request.
ROC request on 2412mhz (queued)

At this point the kernel waits for the first (canceled) ROC to complete, 
then processes the frame request (which requires going offchannel 
again). THEN its able to handle the second ROC request.

Anyways, maybe ROC is the wrong way to be doing this? It was convenient 
because its much easier to set some ultimate timeout then fire off 
frames as needed in that duration in addition to listening for presence 
announcements... But maybe ROC is just very limited in what can be done? 
and using CMD_FRAME + a duration is the only way the kernel can support 
this nicely?

Thanks,
James


> 
> Thanks,
> James
