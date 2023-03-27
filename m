Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081AE6CAF1B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 21:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjC0TsF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 15:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjC0TsE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 15:48:04 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9E710E4
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 12:48:03 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-17997ccf711so10521651fac.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 12:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679946483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HTABSKb02gyXoedBDE30vJvdYSyyupbjz6oX1mRFN+U=;
        b=KVP4NncOik8UBeQcFBGiPt9KegCXUgsyFQdKAHfl1SrvSxVc130Hi2UVjQ8kJ/VTP2
         O8MO1dx0EIKISbdSG0hC8/pxLOofyGkq3fzBYyDieFnFYIj3I1JzEMBDVpUxeaJyl8w/
         9T8Y4qr5NLfpTPa6u4oxKkN0hCCoSX/sArrRKAAlMYjZYGzgq/4qDYLlPCIe1vBOXtSP
         aGnXCFr9ue2e3dg6y0x3ieYb/zuqTUWj9Pynwi2oLgs3vZyBQ+dD0MSoEmmALwS4bBk9
         tcAkXZo5rg0IX9zHjlCwB3noVcXTb3VEXZgxo5pa04DAjy3QcAqA+vEDg3dmc6aejrUj
         Nm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679946483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTABSKb02gyXoedBDE30vJvdYSyyupbjz6oX1mRFN+U=;
        b=0Nzb9EDLd/7KFnAyCrpiawOCP2a+w7dm0dUQpC3vFr11Yu05r5JhrNysNEXDtoSQxh
         /tzGtE6oVJoAeKzP/qCJkRKNb8tcdtoI+86YH4NitbIVSIPV1sGBmQ4ApORwI7Jkh4Xz
         iuJnM2vcVb0yQ5+XqeDf5pISEbGB0KimTKgal4CvQeYlplPUsDocTQCQeoCMl6ut4Pvh
         47WLORoJwQEYeuUG9HLdPtPzuYY3icrL0yFhCsuA2kKK5OVS7S73fkptocLtse0C5lDY
         /C7JsCDrNf1F3zXAOZLdJJQ5DvR4ZWz9tT7hqseDsLX9gZIh3Oi3T509o8Qqyklqbb9X
         yzwQ==
X-Gm-Message-State: AO0yUKW7xrs08F6TfGCEHAFcSvp5dAVxNCLmT3JA3jPDqJ5koQPrfAn1
        6JCcstSE2NlAwEU9jULI6Cj+l/TQJzU=
X-Google-Smtp-Source: AK7set//e2YyEUs2MpQgrke2oEXAWfL6Rymgx4BbsvN27UlsB04lP2HMVaSYMj1/n3EOEFNkr93BIQ==
X-Received: by 2002:a05:6870:40c1:b0:177:a9ae:d73 with SMTP id l1-20020a05687040c100b00177a9ae0d73mr8683512oal.42.1679946483120;
        Mon, 27 Mar 2023 12:48:03 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id xs12-20020a056871accc00b0017b0e3a5af0sm9727308oab.24.2023.03.27.12.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 12:48:02 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <9429bd51-3202-68ef-ea8b-ab1a89519eb5@lwfinger.net>
Date:   Mon, 27 Mar 2023 14:48:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: TP-Link
To:     Any One <mohammed_kalanawi@hotmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <BYAPR17MB2597C578BC6938CD18239EAE8C859@BYAPR17MB2597.namprd17.prod.outlook.com>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <BYAPR17MB2597C578BC6938CD18239EAE8C859@BYAPR17MB2597.namprd17.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/25/23 16:05, Any One wrote:
> Hi, support-team
> 
> I have a question about the TP-Link
> Its about that I have runned all the commands
> I see the wlan0 and wlan1mon on my screen
> When I type ifconfig
> But when I run the airodump-ng (Blackscreen) ???
> 
> Is it about the WiFi-Adapter
> Because I know that I installed the wireless adapter
> But still see (Blackscreen !) ???
> 
> I hope to solve this issue Fast!
> 
> Kind Regards,
> Mohammed Kalanawi
> 
> Verstuurd vanaf mijn iPhone

You are not getting any responses because your post was incomplete. TP-Link has 
built many wifi devices with chips from different vendors, thus they have very 
different drivers. Until you specify the USB ID for your device, no one will be 
able to know what driver you are using.

One additional thing is that most drivers will handle WLAN and monitor modes, 
but few will support packet injection. That mode has too many nefarious uses. I, 
for one, have little interest in promoting activities aimed at subverting 
someone's wifi security. If you really want to do that kind of thing, then I 
suggest you consult the Aircrack sites to find a device/driver combination that 
does what you want.

Larry

