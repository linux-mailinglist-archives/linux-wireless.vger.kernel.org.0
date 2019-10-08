Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2794DD028B
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 22:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbfJHU4B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 16:56:01 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39913 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbfJHU4A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 16:56:00 -0400
Received: by mail-oi1-f193.google.com with SMTP id w144so16061693oia.6
        for <linux-wireless@vger.kernel.org>; Tue, 08 Oct 2019 13:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yCyVhjClXNjq0YQsKGkIC8fBv7zTeXfGYpTR/X/NJOw=;
        b=DNaHBaGGja++PJFx1ICQDovPst/jYbNFfC14YiyjFaBEvyeEgz5BJol3O/gzA4dQx8
         B4naJbVxTOYSRTM88dWIcWysw3r2X5+CJrpWrqM1DWMWVkTwd2zklDHkbFcal6rFkED1
         OERDWwLkCqxWMWaK6GlyRDjzBpgUfvN1zdEaje2WOzUuohEFbmCxwuhh+0EGajPFDfY8
         VYnS/CLtE+wc6cYQ5zao3jKI5VdQPGreYMSEuvnE3sU4bJyb4kZoDkoQtLI79nC4A2kb
         Vm2vRWiLl7xZBTzIiRhItku54sgSfMmjQAviCLdnCHKI/WtUWwTKld3gBLP9Fa52PKQL
         eXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yCyVhjClXNjq0YQsKGkIC8fBv7zTeXfGYpTR/X/NJOw=;
        b=JPasWP7DPZrQ6Fv6O/z2nfY7dg2ABW2wJD3ooxYx/VY1kAf3usiqYcFZPXtNrJpiJU
         HP2agHeyK+CT+0l8zt762WlaKQKNxe8xu+Gs9SzE4zmqr1elWOKypHqPYtSUWk3hcYa/
         78Magc1q00VpXHKQ07M0wO2YPKtsGzICfH+66i//rcTdzOaKr/Rl4rHvcVox9afkG9LV
         c6I7GJ0hq32WTEWWnrFg9Eyg7t0wF9SHB5wRd6AL8ZR9VctM2LHAHpbX1cEkliA0oP/o
         LH8x2IIlxMhSO8upSmC9UZWLwpJI4yjSTm95z0tcstHZuLDi7YCnT+bNMcMbQRZ9lxvx
         bz+g==
X-Gm-Message-State: APjAAAULhwOll57M0GiKY9uyhZuZEU90qZGs3xOOc9852Svk0L1F9Xw5
        /TgmF/hS/29OOmEZZuu9d8rzShzJ
X-Google-Smtp-Source: APXvYqz5Kupsufgbz2AcCODlYzp/2aSWdKR6FSTc6aV/6ZZMAv62BjgkqI8cyluwSFshZP0MM5IdhA==
X-Received: by 2002:aca:f1c1:: with SMTP id p184mr5219872oih.43.1570568159925;
        Tue, 08 Oct 2019 13:55:59 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id o23sm5884620ote.67.2019.10.08.13.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 13:55:58 -0700 (PDT)
Subject: Re: [PATCH 2/2] mac80211: Support LIVE_ADDRESS_CHANGE feature
To:     Johannes Berg <johannes@sipsolutions.net>,
        James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
References: <20190913195908.7871-1-prestwoj@gmail.com>
 <20190913195908.7871-2-prestwoj@gmail.com>
 <c6835b5c5d2a97fa82b0fb21f7b7f0056aa42e1b.camel@sipsolutions.net>
 <90ae00044bc0834d87d3f9fb75ce63dce4cfadd5.camel@gmail.com>
 <0b57c1288016310050ccd6233dda886fc4a89b02.camel@gmail.com>
 <f468a8d573ddf401d2084b76eb625fef5950f265.camel@sipsolutions.net>
 <6fa34e4c-5c81-4875-da29-cada1a078e2c@gmail.com>
 <6530a6b06176790c5a6949d6ffccf37b506975bd.camel@sipsolutions.net>
 <864267ec-9158-940d-6e0e-db84a395888e@gmail.com>
 <f02b81f6dac29da911f8793b952a9efb6a1fdb62.camel@sipsolutions.net>
 <1bb5450b-bc4e-8c83-f99e-fc7e739b08f0@gmail.com>
 <fbb287a82656dd3f89817590e86b23d6968a2822.camel@sipsolutions.net>
 <193168d4-6466-60a4-bc89-c4a44e84ac46@gmail.com>
 <9c49ec27489333d7f27831de19e9d1c9cd65eeee.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <cc2cee76-2a83-17ad-0e7a-ba71075e1497@gmail.com>
Date:   Tue, 8 Oct 2019 15:55:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9c49ec27489333d7f27831de19e9d1c9cd65eeee.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 10/8/19 3:16 PM, Johannes Berg wrote:
> On Tue, 2019-10-08 at 13:50 -0500, Denis Kenzior wrote:
>> Hi Johannes,
>>
>>>> But they shouldn't change due a mac address change?  I wonder if we can
>>>> further relax the requirements to allow mac change if
>>>> NL80211_SCAN_FLAG_RANDOM_ADDR was used?
>>>
>>> No, at least with HW scan that would completely confuse the driver -
>>> since from the driver's POV we'd remove the interface it's currently
>>> managing the scan for.
>>
>> So help me understand this better.
> 
> include/net/mac80211.h:
> 
>         int (*hw_scan)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>                        struct ieee80211_scan_request *req);
> 
> How is it difficult to understand that with an API like that, it might
> not be a good idea to remove the vif from the driver while it's
> scanning?

Right, so you're talking in the context of this implementation which 
performs a remove/add interface.  You're right about that.

But I was asking more in general terms.  If all we're doing is scanning, 
can we just change the mac?  Anyway, not important.  Maybe I bring this 
up once this set is accepted.

Regards,
-Denis
