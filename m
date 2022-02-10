Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC074B182C
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 23:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343576AbiBJW3Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 17:29:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242917AbiBJW3Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 17:29:25 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8659F10AA
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 14:29:25 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id d18-20020a9d51d2000000b005a09728a8c2so4799383oth.3
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 14:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/DB+7B0RJdPFWjNfIQMbWHz/JZyg5dCXeBYTpbBq6LU=;
        b=ES+GM8PmSq3apGXHTXfAZoqBRDptgkv81xnT1xGOHrlDmeUAmvGari1/J2DSNJBcYd
         K8pMXtvOttxwY7nObj7/YMP+OFsuFZWEp6bpj4CsKK4AHYXrN47rnk1413YKWNVe5fct
         2VTCyC0AflOJGgtzRhxA/5tCTblXv5ooNwwtx6U7ReJJzGUSE43fPABKsHTadn+AWwrY
         OHy+3q7abhqhEpBoBZJaWCQHS93TU3CH8ySvl6fjCfDz7lp5G9KveLsu4b23kKOQPelc
         J0CXDE16b8JblAqAgRedJmbOz7PBHXl0BCrpWD2WLhWZPHENrdtVicXd2pMjju7eNMAf
         bKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/DB+7B0RJdPFWjNfIQMbWHz/JZyg5dCXeBYTpbBq6LU=;
        b=IHA70Xvm2I0mQHPuTvcOXz2OVBqVAWIcBfkxsOnDFUlWo872nFiBFiIWDuwax37ujr
         ho1sjJrxNorSdxBg7/DmWj4pgRelQYwnoPjNC03gZezmtr6ljsRPcS2oZmPS51aMVpVD
         Piu3DMTeWve7LOkRWfUJZ5n4ijDAGlV0RiySLogxtGodCCwe7TgyudNXVnSWm5yzLWpj
         1dHzc3KVq8ZP50OrwvGLrVdVnF5U8SaSLg4E5spIAVsx3I5OnpltsNb1SHziVK11Nog9
         Vw0WssiNcHJzmkQZS5KkcFwWrDH/KtNHMO/L+M1nLfrfM/2iYSGTm+IlbqpblMTsnXX4
         CSwQ==
X-Gm-Message-State: AOAM533Vnm55vyGU0ZimLOKnTKUzCKMfEx+1dy+7CPnhcn0bGvY3qrcR
        LVlH9J9M+zvKWgkX2MNI1ZdXkhDKVcI=
X-Google-Smtp-Source: ABdhPJy5zh1TH9pD+AD8FBi1KyYeYGvF4AKSaWIaIk7ykfGEJwPlKYjw4SRiNO1CyY9cOxQ7Yl0Q4w==
X-Received: by 2002:a9d:4f0a:: with SMTP id d10mr3585369otl.292.1644532164906;
        Thu, 10 Feb 2022 14:29:24 -0800 (PST)
Received: from [192.168.1.104] (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id a15sm8743667oil.13.2022.02.10.14.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 14:29:24 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <f2985911-19ae-dd3b-6c23-93de0c188c0e@lwfinger.net>
Date:   Thu, 10 Feb 2022 16:29:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Possible bug in cfg80211
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Maxim Klimenko Sergievich <klimenkomaximsergievich@gmail.com>,
        linux-wireless@vger.kernel.org
References: <CAEqd1ZZucLqJMEktzmnCKzwXXkswzqJNf_yr2HZV20LcWtiR6A@mail.gmail.com>
 <ba50e373-59d8-d544-e7f9-3fe2a3336056@lwfinger.net>
 <bcbeaeb1c331a5570e6ab6e03a6ce2875b43f750.camel@sipsolutions.net>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <bcbeaeb1c331a5570e6ab6e03a6ce2875b43f750.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/10/22 14:10, Johannes Berg wrote:
> On Thu, 2022-02-10 at 12:54 -0600, Larry Finger wrote:
>>
>> I am most concerned about that bss_entries_limit=1 option for cfg80211. Do you
>> still get the warnings logged if you eliminate that one?
> 
> Yeah that's probably the reason ...
> 
> I guess we should ignore it if it's too low to make any sense.
> 
>> I also have a question for Johannes, et al. Should the "if (WARN_ON(!oldest))"
>> in net/wireless/scan.c be a WARN_ON_ONCE()? It does not seem worthwhile to spam
>> the logs. It is clear that once this happens, it will happen again and again.
>>
> 
> Indeed, that seems reasonable. Want to send a patch?

Yes, I will send a patch. I was able to duplicate the OP's warning with 
"bss_entries_limit=1 and I will be able to test for that warning.

Larry

