Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB1A64CEA1
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 18:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbiLNRKy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 12:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237412AbiLNRKx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 12:10:53 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785292251C
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 09:10:51 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id db10-20020a0568306b0a00b0066d43e80118so2136209otb.1
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 09:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6eQ6Qrqi9BIjGXip7wtyWRdabskueU9xxtAb9jeYdUY=;
        b=HZ+zMYzTl7pW5fn3k2q/gvMN/ESTv8ctbJ8wXQRV1TcKNOltWox5008+Fmu7vnmNvd
         CsueWQTPodCterpV3wJBJjvXVaYcpHFvLywk/yr7zj1+34YplSixFVfu9JshWVxWbzlX
         7/EfXjJF/sjN4rQSikbe2zarb6wUeDysdWAKYiYGekrvjKjrQG9uempBn1m1zhPZHks/
         Pay+BnGglVkHb4efEbEC+NMk7yT9txz8c0v2RVBMK1fTud/MhAzSrqNERRtujYtpepua
         IBMzflbRvan2dejoiOdleh4+tku19/mij9quA7oEK8LhLYp8NEtn9gCNB8mBfR/m72MX
         ++Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eQ6Qrqi9BIjGXip7wtyWRdabskueU9xxtAb9jeYdUY=;
        b=bscl5KKM+XFonZd+2p985scBXEyl/JzE6i8kNMXhtUSGyAX6LjTqqRRXtGGUjkdi7J
         7XV3sQFLksFz0ZK09ydRPJlKZG0HIaRSuHfEN7tgXmg2Z/tIYBBtnMTe6+FGJODrzIkC
         kSKqctaKt09kvcH77AE9tt3foqLhpv6Nkd/vDazsPc473P78T/iPfexP9bddH7q5i4WZ
         tH3ivrRxgJGYpGwHZ546kYNzEKlVaDj/uRJ+VN8DSl2gq0aY0Arbk/iVN064ocqfuJY1
         Jg34MTpqrl0G7B3KZe9Pas/xHZxQLrLQx0huNdWisQirss/UXXRXIpaxxw/sN/U0JD4C
         YdUQ==
X-Gm-Message-State: ANoB5pmhbhDEPr4CLi6uxPqZl/4eBDF+Oei8ILrdvUg6NLFn9Iz5kuZc
        I16NpY2FTLGsGpm79ofo/ruih/ed45g=
X-Google-Smtp-Source: AA0mqf5BOY03q+ddAskZlDiFn43wRjyv4HHLvwBcrnMlzhUa827qaHM1x9vQkIrpSGsNBGgLOTjg+g==
X-Received: by 2002:a05:6830:3685:b0:661:dfeb:ea33 with SMTP id bk5-20020a056830368500b00661dfebea33mr13649517otb.24.1671037851245;
        Wed, 14 Dec 2022 09:10:51 -0800 (PST)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id r9-20020a05683001c900b0066e67925addsm2617128ota.26.2022.12.14.09.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 09:10:51 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <90ce8fa8-a000-34fb-4a3e-381b3464f45a@lwfinger.net>
Date:   Wed, 14 Dec 2022 11:10:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: Realtek 8852BE support
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Charles Piekarski <contact@charlespiekarski.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <a2a454c5-3940-52d0-77b7-e5f8376720ae@charlespiekarski.com>
 <1f878b2ec793443f96685773c6599591@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <1f878b2ec793443f96685773c6599591@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/13/22 18:47, Ping-Ke Shih wrote:
> 
>> -----Original Message-----
>> From: Charles Piekarski <contact@charlespiekarski.com>
>> Sent: Monday, December 12, 2022 7:11 PM
>> To: linux-wireless@vger.kernel.org
>> Subject: Realtek 8852BE support
>>
>> Dear Sir or Madam,
>>
>> I would like to kindly ask for information if Realtek 8852BE Wi-Fi 6
>> module is supported or will be supported by the Linux kernel.
>> Regrettably, the module does not work under Ubuntu 22.04.1 and 22.10, at
>> least out of the box, and I was unable to find any useful information to
>> get it working in a safe way (with Secure Boot enabled).
>>
> 
> 8852BE got merged into kernel 6.2 that will release about 3 months later.

Charles,

You can get that driver by doing a 'git clone 
https://github.com/lwfinger/rtw89.git' and building it following the 
instructions in file README.md from that repo. If you are using Ubuntu, pay 
particular attention to the last paragraph as the distro has not included the 
firmware for RTW8852BE, even though that firmware has been in the official 
linux-firmware repo since October.

Larry

