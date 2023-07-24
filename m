Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46DA75FEB3
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 20:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjGXSDK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 14:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjGXSDH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 14:03:07 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2594993
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 11:03:06 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1bb5db14abdso947864fac.0
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 11:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690221785; x=1690826585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=L9EMIHUm5nfLkLEqANloZqutmVTeNZ5m+rmy53s5B7Q=;
        b=pJs7qhHhEIdBUH6TE15dBmCQy1Xj0CAyfquGTKmzcXVo/e8l1ruZbaFFZOxqTEOfk7
         3z0g8viWuJFMhkp+Xx2nm3vxJpgjT+53fArT6g5lwTrpWNOjJyW/j9JtSeNJVERrxl1r
         2A3A8hJhkpOqCZoiytPdbJgvJjpNuk1s8i94rpK6GUbuji4Msp0WKMUEfiyX4LONoDs1
         hZQPik2D0Slum9B5sYDH0TgAO4rghwIi4kcTyxdclErQSYhlUQuN7gjGJnQMBLVHQ1io
         WYVpj+VZH2cDpYiidq2aQMkx7IZand5C+fXtSEOAc4+/IZVYMtLSWtZnYL7jCek/iDyn
         AOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690221785; x=1690826585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L9EMIHUm5nfLkLEqANloZqutmVTeNZ5m+rmy53s5B7Q=;
        b=cwaFKHZYVThn6S4HkjL76D5r4St/CSmaTgxA2qAXEGvNWulu7Dh30/Jg5qyv4mTgcA
         EiJPVMG4QWPkUWOmjmKbXQSyQMCnBKpmz++iGb6lnpXxd+j1nzFjTagJ2yfG7XtafOvD
         5PKqweRvPt6hnsF2J0ZwjRRLdFFZ948mQmZVOl5S4OnsKPqth2obC//xjjUSz9Ri9p34
         M4qBTv1Tvz9lEprXOhrGtCPByRC4GYBPPm2B3Q38mbs++WCDZcKsGLLDxC36pUn5g1tY
         PiIkaFfPrql2rOFzqFe+IF7G21+TzD0a/RuOoUwNucm/A3UrfNKey+qgc0xtbjqRWOYP
         jLTQ==
X-Gm-Message-State: ABy/qLYtuKZ/PqhfFVTHLpag2yct/38k9IqtAMmj08A0aWKZckxqZUKf
        bJpekMbGZpkojS9W8iByzEw=
X-Google-Smtp-Source: APBJJlF2hhQDC/n7Yw2uyySM+20YEIySF5G3v8LL5Mn+pFIcvieokVKlmW8QUF9adYBjCTA6ZnkEzA==
X-Received: by 2002:a05:6870:5ba2:b0:1ba:a410:4c53 with SMTP id em34-20020a0568705ba200b001baa4104c53mr7288191oab.10.1690221785339;
        Mon, 24 Jul 2023 11:03:05 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id dt27-20020a0568705a9b00b001bb58a346b8sm1901825oab.18.2023.07.24.11.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 11:03:04 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <4bd1d468-d512-65b8-7e03-8cf879ce24af@lwfinger.net>
Date:   Mon, 24 Jul 2023 13:03:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 8/9] MAINTAINERS: wifi: mark b43 as orphan
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
References: <20230724104547.3061709-1-kvalo@kernel.org>
 <20230724104547.3061709-9-kvalo@kernel.org>
 <14cfb9d7-089d-607a-9062-eb9e268ffd67@lwfinger.net>
 <87zg3l19lz.fsf@kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <87zg3l19lz.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/24/23 12:51, Kalle Valo wrote:
> Larry Finger <Larry.Finger@lwfinger.net> writes:
>> Kalle,
>>
>> Michael Buesch and I have been unofficial maintainers of this driver
>> for years, but your change makes sense.
> 
> I would be more than happy to add you and/or Michael as b43 maintainers!
> But I don't want to force anyone, it's not exactly a fun role :) Just
> let me know what you prefer.
> 

Given my advanced age, I have been busy trying to get rid of responsibilities, 
not take on new ones. I think making the driver an orphan is OK. As long as I am 
capable, I will continue to address any bugs that turn up.

Larry

