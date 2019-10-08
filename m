Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFF51CFEF3
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 18:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfJHQdL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 12:33:11 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:45620 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfJHQdL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 12:33:11 -0400
Received: by mail-oi1-f178.google.com with SMTP id o205so15301498oib.12
        for <linux-wireless@vger.kernel.org>; Tue, 08 Oct 2019 09:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=V8JzW5ufWqfsvWt/2PHfMhHGNKpfScjLqSr/LltMya0=;
        b=eBQkQmko0ktT5ZcLSJgGdTD3HbsypIwe2a0Thu+HFYU82sPwNBIijrRU2pqlYueaFe
         +CXGoXUPUa6Aqahtpp6Z+PVaRGdBo9lZzy+WxC1JqnpIJ3en2sjvROTZmaT3umrhyd/v
         mY8ta2Itzp/RYNQB0ePqksqFuvxIrLOlTB8CLoGYAp/HEwgV4G0A70FgLX+SRRXj+y2n
         oklqcUmNVcO+hau7708k7lykAVgBdGEXAKsPkfKcqrRz0hwaXrjczB1r7pQMSNczSf2B
         ZIEr0FyKskY++HHB5gfrsMQkHv5aUniHlyIb66CfQcHnfTaNxl2ta+kIZV/5A0wSSln5
         eGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V8JzW5ufWqfsvWt/2PHfMhHGNKpfScjLqSr/LltMya0=;
        b=hysAV2ES+xSGGF9067YlLUOAxjSd+3CRaHK7pZDXUJn5lEYFa7k3zx0GZVt55dBsYE
         +YeUphwEaR6sHm05ME/Je2pJp+ARNZSpNJjFPqBeBck7YmqbIrGMogGbwcBc9Xz1YGRc
         yMte6RlXQDVPuR8wpWbvKiMRk4S7g4lLq3K7yFtkWmFwV4PBwPldnI5WcXRPE4YP7zQ1
         CoJYAWf7qA8FakD89p360LE+V1n7DayBLwoWIQEqMoV/yxsbqk/Y/NGYwyA8mZv0u7MJ
         2ujxvuDsjh1/f3eVs0AxT5+MRPZ1Cl/tSU4pddvvF3pMkBOxRaFAggsQgM3mbth4UWol
         3TNg==
X-Gm-Message-State: APjAAAWSIcIk3iyr/KN9jckQeZBC+TX/bSNhl68c2MLiHhiNm24zsHTq
        JUZN5fT1IfHUDRAMFSmToI2lbh/R
X-Google-Smtp-Source: APXvYqxuGibxthh/Oxz4VdiVH7b0AnInEQvWJWJwI7GE5NJ8QjKqhuWa2FjcnRtQEyh0IkjQ12CDPg==
X-Received: by 2002:aca:4d85:: with SMTP id a127mr4388546oib.154.1570552390459;
        Tue, 08 Oct 2019 09:33:10 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id l12sm5183770oii.48.2019.10.08.09.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 09:33:09 -0700 (PDT)
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
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <1bb5450b-bc4e-8c83-f99e-fc7e739b08f0@gmail.com>
Date:   Tue, 8 Oct 2019 11:23:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f02b81f6dac29da911f8793b952a9efb6a1fdb62.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

>> Indeed.  But that is not what you were suggesting earlier with just
>> checking local->scanning.  So if scan_req contains a wdev, then yes it
>> should be possible to compare the scan_req->wdev to the interface being
>> changed.
> 
> Well, yes, but only because I was incrementally going from James's
> patch, which was checking that only.

Well, something to improve.  Sometimes it is pretty hard to figure out 
what you mean.

> 
> Similar with the other local-> things being checked here, btw, though in
> some cases it might be harder to actually determine which wdev is doing
> something and which isn't.

Right

> 
>>> No, this typically cannot be fixed, and it doesn't really make sense.
>>> The NIC cannot possibly do two scans at a time since it has only a
>>> single radio resource :-)
>>
>> So why is the scan request not per phy then?  And should mac address
>> even affect the ongoing scan?  Can we simply change it with the scan
>> ongoing?
> 
> There are things that affect the scan from the interface, e.g.
> capability overrides, (extended) capabilities, the MAC address is used
> unless randomization is requested, etc.
> 

But they shouldn't change due a mac address change?  I wonder if we can 
further relax the requirements to allow mac change if 
NL80211_SCAN_FLAG_RANDOM_ADDR was used?

Regards,
-Denis
