Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8356F0A3D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 18:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243777AbjD0Quj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 12:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243673AbjD0Qui (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 12:50:38 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E43E53
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 09:50:36 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5069097bac7so15428223a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682614235; x=1685206235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJ3N2R4NErV9IbxSWkGHrt42b2KYNikkh42LE+ov5uw=;
        b=GIYAYz5dlIXKYSrTDdRB/9pdxUpewHSvnzMTaRPiau1MggNQ0lnEsE1AKM2ziLlrsk
         rhiMQSYjpnf/mdS3+zTwhnsL+85XlnWja9ERN0kqRFvdfEjJs9CgboADIPlG2F0ROgQ1
         a5QyjHKLfKJvd+JWsFF4NkWY3zEqzL16X6E2Tk38X4CbQp9eUSGK5WAVzjgPyDtyklSA
         yGOmP8FVqgeZ+tUtQvOmZviRJHMkih7lMPePU87GwsOdOnuRZdlpcGPFIw+V7rT/e/5T
         PftJibRmWbMGytyvWYutK3wm31+pDR5Tf8rtFBHHTnLoiwcwz9+QzGVJR14rdrjy/sm3
         FDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682614235; x=1685206235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJ3N2R4NErV9IbxSWkGHrt42b2KYNikkh42LE+ov5uw=;
        b=bnheZ6fTCooroA/cIKpZuRVvVTf+HwvliycWKQMB8bb4wjp60BCH0LUP07PNlfGOO/
         hOAyt2m++oLLQHxFAq67Ek6Befq9K6SjVzE0IlRLJj3gpz6f08lHQLLA6t17xTto2GsC
         LaUnh5RtlbxGtQ/CSylfX3PQKBRWTGk8FdMRnJrdMdE/D8uHw90fjtRkmbRNyQQr/aBo
         wCj8f6TiV84pLi2HOaJtNYnjlKm219EYKfwLQ5QjkF1W3QWc4YiktZUEMrStMvi3bkq2
         8AeU1gOkCh18Qv7w3t6lOpinNiOhHOUXQcXmThDNE3xhMhzhNDvwowXJrRIGUIRlExwQ
         1Oqw==
X-Gm-Message-State: AC+VfDz23g/wcYsHtzlfeBpPHfFLsAe2r4DxR+s95ct36EnRIcGbrrPO
        6PGu63bhYSN8qbsAgdYx+XY=
X-Google-Smtp-Source: ACHHUZ4bOy5VaHEHWThjYWwnPS04ob+b7DYR7xqPIS4REbSv3kTXuW350X/ZLvj4qDDsKXWMQl8aSg==
X-Received: by 2002:aa7:d659:0:b0:506:75bb:22a3 with SMTP id v25-20020aa7d659000000b0050675bb22a3mr1811039edr.9.1682614235277;
        Thu, 27 Apr 2023 09:50:35 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id z15-20020aa7cf8f000000b005067d6b06efsm8041490edx.17.2023.04.27.09.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 09:50:34 -0700 (PDT)
Message-ID: <ca4645cc-70c0-6c2a-993f-2e1d277eefb4@gmail.com>
Date:   Thu, 27 Apr 2023 09:50:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Automatically adding OCI in mac80211
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     ilan.peer@intel.com
References: <432703ce83ac979ba06e2b85d6dc500f246c6a76.camel@gmail.com>
 <199f2ac280a1e1a195add45290411a9c1dc519fc.camel@sipsolutions.net>
 <cba322cbf992067e843114ab53da610978768d64.camel@gmail.com>
 <33e23355cd8cfcf2296bba1272df814af32b003f.camel@gmail.com>
 <38649e92c619dc2f1482aba08c977d1611064e05.camel@sipsolutions.net>
From:   James Prestwood <prestwoj@gmail.com>
In-Reply-To: <38649e92c619dc2f1482aba08c977d1611064e05.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 4/24/23 10:15 AM, Johannes Berg wrote:
> Hi James,
> 
> Sorry - going through old email that might still need attention, clearly
> dropped the ball on this ...
> 
> On the other hand, now we have all the MLO code in the tree :)

No problem, I had completely forgotten about this as well. Moved on to 
other things :)

> 
>> So thinking about it more I think we have two options:
>>
>> 1. Improve CMD_ASSOCIATE to be non-destructive on failure and allow the
>> API to accept a channel definition directly i.e. enough info for
>> nl80211_parse_chandef() to work. Then use this chandef rather than
>> derive its own. If this fails (e.g. due to a downgrade) return an error
>> and userspace could downgrade the width itself and try again. What I'm
>> thinking here is not modifying any values in sdata, link, ifmgd etc.
>> until the channel switch returns successfully.
> 
> That seems rather complex too, to be honest.

yeah I started down this path and quickly got in over my head.

> 
>> 2. Build the OCI element all in the kernel. As far as figuring out the
>> operating class I'm happy to contribute that (IWD already does this).
> 
> That might be easier, though I guess it needs to have an opt-in from
> userspace to solve this issue.

Yeah, probably some flag attribute would be needed. At the moment I've 
got other priorities but I'll keep this in mind.

Thanks for getting back to me though.
- James

> 
>> And I'm not sure what you mean about it not working with MLO, I don't
>> know much about it.
> 
> I don't know how OCV works with MLO in the first place, but I guess it'd
> have to be per link?
> 
> So I guess it would work, just have to be done for each link.
> 
>> Also I do think there would be some value doing (1) in general as far
>> as it being non-destructive. ieee80211_mgd_assoc() starts modifying
>> state almost immediately making any failure (even -EBUSY) result in a
>> disconnect AFAICT. This seems kinda bad...
> 
> Well, there could be some plausible reordering here, but a lot of hw/fw
> fundamentally cannot try to make a new connection while maintaining an
> old one, so in general you can't really fix that completely.
> 
> johannes
