Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D894F0D44
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Apr 2022 02:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242059AbiDDAaU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Apr 2022 20:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbiDDAaU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Apr 2022 20:30:20 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E005390
        for <linux-wireless@vger.kernel.org>; Sun,  3 Apr 2022 17:28:24 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so8854937fac.11
        for <linux-wireless@vger.kernel.org>; Sun, 03 Apr 2022 17:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rDG8m800sceK7uGKVaGei8LKjT7Z6p9kfSL3gXOXsz8=;
        b=IiJZ4XEQcpBuHmVAw6T4650hsr227dKIEWqNyOLu4A9cIJ1hAwFCQc5Ez5k6HkQypF
         hX5J0H27U27dvrny8E/+30ldmwNHCtQhVcJMB0l1ww1M/5OHs9GSqVjZ+sHTnvubRxnY
         dVcEjlQ17KlCKQMRb/HXi6hbtref4oxE4XaocF83cNMCgoSYWkNobYV2eCYrMv2uhPR3
         zkse4u6xSyFMHQkgG/DkRa+RVXwBJd7jt2ZOimPwQOsgV9a5rbel9DqcvYfGyKRl5JrX
         hhf7zRedFkuaWVFWVjrB3iiRicELmYOJ3fY3N2QkOLhnfeVpYg8qY4eZrwZavAaOokUz
         9Wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rDG8m800sceK7uGKVaGei8LKjT7Z6p9kfSL3gXOXsz8=;
        b=E7KWHaRT4xvpBQb5vN6tsHfTZKCHA20jdxtPqGkjtCpy7rxJfi34tbaVfH1XOj59Fn
         dno0/9aOMh9epHe2jljYmffkVzPlhp+qevxW2ku7oIUEOarTeL797tjYJ7DGI8WINSYR
         JhEt8lmSAcHfunXOpbjMRuoXgC/+kyZvEMBadytdPSPo0+RrE3WkQExhWrYadH1z7oQX
         xRikxAOv78qEsganQBlWHphXN4ewGJHFrON0YBS6nrXGl+7FabUDopg+Z0kYBw5wRPox
         H0WImr5XIaucG02i3ACC/YAKH2KvOk+PO9ijBvtvh+7Ctqptbg2+Q96bdTTXZZ78Vx6t
         jUVw==
X-Gm-Message-State: AOAM533aCFnwUvs/6sP+SJbNejRJeYSMxQiqxTa/JwIgWZDqNQERE1Yd
        dCHg1nXczu7bzIFOFuFalcjfcAgZ9kk=
X-Google-Smtp-Source: ABdhPJzuoPDmtjsxr+2kdpTPK99phTddaDd78hzVV8AlKojSvol6QGPyr1aEdoEqHP7BWwcogkfDMQ==
X-Received: by 2002:a05:6870:17a1:b0:da:b3f:2b79 with SMTP id r33-20020a05687017a100b000da0b3f2b79mr9673620oae.280.1649032103902;
        Sun, 03 Apr 2022 17:28:23 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::1004? (2603-8090-2005-39b3-0000-0000-0000-1004.res6.spectrum.com. [2603:8090:2005:39b3::1004])
        by smtp.gmail.com with ESMTPSA id o17-20020a9d5c11000000b005b2611a13edsm3970251otk.61.2022.04.03.17.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 17:28:23 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <57ff87e5-2012-1253-c98a-10bc9ad54441@lwfinger.net>
Date:   Sun, 3 Apr 2022 19:28:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] wireless: Change Kconfig to select WEXT_PRIV
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
References: <20220403181431.21811-1-Larry.Finger@lwfinger.net>
 <3e30cdabeb1d1a33f16a41d86f8b660a996a0d0e.camel@sipsolutions.net>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <3e30cdabeb1d1a33f16a41d86f8b660a996a0d0e.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/3/22 14:20, Johannes Berg wrote:
> On Sun, 2022-04-03 at 13:14 -0500, Larry Finger wrote:
>> File net/wireless/Kconfig contains two blind configuration variables,
>> namely WEXT_PRIV and WEXT_SPY. If those variables are already in the
>> configuration file, they will be retained, but there is no way to
>> set them if they are missing other than to manually edit .config.
>> They should be enabled if either WIRELESS_EXT or CFG80211_WEXT are set
>> in the same manner as WEXT_CORE and WEXT_PROC.
>>
>> Personally, the setting of WEXT_SPY is not important; however, openSUSE
>> and Ubuntu both enable it in their default kernels. Other distros have
>> not been checked, but it is likely that they also enable that setting.
>>
> 
> They're intentionally this way though - they're only selected by the
> (few) drivers that need them.
> 
> Yeah, out of tree drivers lose out, but we don't really care?

Unfortunately, I do. At least I now know enough to turn those two on before they 
cause me any problems. Until yesterday, my configuration files were OK. I'm not 
sure what happened.

@Kalle - please drop this patch.

Larry
