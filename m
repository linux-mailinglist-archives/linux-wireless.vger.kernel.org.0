Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEC59157D
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2019 10:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfHRISF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Aug 2019 04:18:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35667 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfHRISF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Aug 2019 04:18:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id k2so5538072wrq.2;
        Sun, 18 Aug 2019 01:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3K2heShqXFvHIujD/jSq5A3T17t7gI6hW6s74lDnArU=;
        b=T94odbL8a+9RKtv1TAKGKnDEh3T8DWhCE/JM08UKWSxWAklklh4v25LwJWxqPwwdOT
         IsTppBhO1erCCNBSMz5BPM31J+LrsswsSA16Jf5jmJ4eevfV7aJ6VVlsW3/5fBgL0b+P
         eNN19FLdvSZwBppUAZQ0U3a6CHydMUghZUU6JHpb6EoYbab1OWXqBEUinpq8ZdzSw4mB
         Nab+qnEHiUqTLek9rCO9Gyjk5uLFXYEyfsuyJf2gA3q2h5IQd5oT612i0vxNmO8jnXis
         FN9EuJhOMdHjo4R7xWU6LbY2QNBfrQFcKv8asgJ2zSBeS6dd/18R4MzmyCgajRa2w/kk
         TMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3K2heShqXFvHIujD/jSq5A3T17t7gI6hW6s74lDnArU=;
        b=H+WIqiXNQqd56KMBcDfX15IqtcMvLAxN0U9CnT8mAsul7IRwp/UBhirhBSPeIKAa3J
         h/6DGAXeCa9uClopkCbuOaUeqFMWMQEdIbqFgHKInJIpGP/00uSvwiV4fs04Jl6mAL7L
         O91EEuqStJmUSONVDwJqBFETiNkyO+jtOlgt47DsNnqhA+Kwzird5DCGkiWINmKn+5di
         1K9M1PwaseIezBNC7ByUQhRuOKhOqySIHNOdDRw9Hc10ncaYBqYlo8XGNyB+5P4MCrvy
         doN/JXkmci5XfmxjHNrkH9jSX51ilhdoUf5BE6CwG6J6rlgfi2qYzbhPvr9Ss2P2Dg+T
         F5CQ==
X-Gm-Message-State: APjAAAV6KJri8SGQa8aKFhZ2Fa97yTEqUBrVV/87vuC/FcK/pTXxsgvL
        zid50eJVs/RbPsTPS/6Q2hXTdd8P
X-Google-Smtp-Source: APXvYqyohJYiGW+zR6av8QlVpXWZySF0SeXMCLMABQBULR2g8HTXBMf/AtVcq1m/meYNjj1TkMJBuw==
X-Received: by 2002:a5d:4b83:: with SMTP id b3mr20028180wrt.104.1566116282399;
        Sun, 18 Aug 2019 01:18:02 -0700 (PDT)
Received: from [192.168.1.20] (host86-151-115-73.range86-151.btcentralplus.com. [86.151.115.73])
        by smtp.googlemail.com with ESMTPSA id h2sm7729162wmb.28.2019.08.18.01.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2019 01:18:01 -0700 (PDT)
Subject: Re: PROBLEM: 5.3.0-rc* causes iwlwifi failure
To:     achirvasub@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <20190817214448.GB1070 () chirva-slack ! chirva-slack>
From:   Chris Clayton <chris2553@googlemail.com>
Message-ID: <fd102579-d83d-b86d-e165-8168c74a4bac@googlemail.com>
Date:   Sun, 18 Aug 2019 09:17:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190817214448.GB1070 () chirva-slack ! chirva-slack>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 17/08/2019 22:44, Stuart Little wrote:
> After some private coaching from Serge Belyshev on git-revert I can confirm that reverting that commit atop the current tree resolves the issue (the wifi card scans for and finds networks just fine, no dmesg errors reported, etc.).
> 

I've reported the "Microcode SW error detected" issue too, but, wrongly, only to LKML. I'll point that thread to this
one. I've also been experiencing my network stopping working after suspend resume, but haven't got round to reporting
that yet.

What was the git magic that you acquired to revert the patch, please?

> On Sat, Aug 17, 2019 at 11:59:59AM +0300, Serge Belyshev wrote:
>>
>>> I am on an Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz running Linux
>>> x86_64 (Slackware), with a custom-compiled 5.3.0-rc4 (.config
>>> attached).
>>>
>>> I am using the Intel wifi adapter on this machine:
>>>
>>> 02:00.0 Network controller: Intel Corporation Device 24fb (rev 10)
>>>
>>> with the iwlwifi driver. I am attaching the output to 'lspci -vv -s
>>> 02:00.0' as the file device-info.
>>>
>>> All 5.3.0-rc* versions I have tried (including rc4) cause multiple
>>> dmesg iwlwifi-related errors (dmesg attached). Examples:
>>>
>>> iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
>>> iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000
>>> iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND
>>>
>>
>> I have my logs filled with similar garbage throughout 5.3-rc*. Also
>> since 5.3-rcsomething not only it WARNS in dmesg about firmware failure,
>> but completely stops working after suspend/resume cycle.
>>
>> It looks like that:
>>
>> commit 4fd445a2c855bbcab81fbe06d110e78dbd974a5b
>> Author: Haim Dreyfuss <haim.dreyfuss@intel.com>
>> Date:   Thu May 2 11:45:02 2019 +0300
>>
>>     iwlwifi: mvm: Add log information about SAR status
>>     
>>     Inform users when SAR status is changing.
>>     
>>     Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
>>     Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>>
>>
>> is the culprit. (manually) reverting it on top of 5.3-rc4 makes
>> everything work again.
> 
