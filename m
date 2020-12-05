Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB37B2CF92A
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Dec 2020 04:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgLEDT5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Dec 2020 22:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLEDT5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Dec 2020 22:19:57 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5827CC0613D1
        for <linux-wireless@vger.kernel.org>; Fri,  4 Dec 2020 19:19:17 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id q25so490714oij.10
        for <linux-wireless@vger.kernel.org>; Fri, 04 Dec 2020 19:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/6w/LCeQcZefYiYlmrx/2EwAJ7XYLkgxewwyOU2s6Hg=;
        b=gpzFfwu1yp93AlBoTJWqlP4K2PPLeNqHXa2MkF4maTRqqCtNsszxA8TpgeAxrtP2rE
         up/XrgZMdVQCglGsokL/pWcMvOwh594nYE5u18aPbjaNQSqQaSM5jo802Nv2yqyQJmd8
         ujNj510RqpppuAgU5P+tZ/4/FX1CswC3l8sZ4trfnemcfZCiazMp1+X3bb5JIJe67rZj
         bvejgDjl5bmqb0s83NlpFwOvrcq20QBjHc0x58yzuXg7QKywoyiqDFp1HwsznzHgP+Pa
         YqLMO1gHHjOfXwBU8pZD2dxN0/awF8dZqKFz2XB7CpBLiImzq0+klNBGePbsGwMpMrk+
         bwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/6w/LCeQcZefYiYlmrx/2EwAJ7XYLkgxewwyOU2s6Hg=;
        b=hJEctSBrcZkCGW76aTlzGlqd8TD5awABcBInAu/XnvulIhGTx66mW5VgrCCTXIDgxE
         j7hn3ClD5O8/FCzurQ2uBJdJZsKeDeYkxkyCsWyJV/BjocHjsOVDxNwYTHPq2siWDYwv
         XlFdQFAcZFIR5VrJtRlEspD5P+elKU1lk1NjHN+7cc/CmpIyvrUhFjrIczsNjv6+aE8J
         qmLLYK9JuDpKw9+IIYHIDZvETaGi2PtlbNjDJhTMJkm4jK45xxwvlMahIe9T9dXQAv8+
         k/A8P6i9Bpu9YdlendM+qlZlzdI9Qmz1MutDq8IDt3+WqYDuBdzusvK9norkJ7PgMz6d
         S/ug==
X-Gm-Message-State: AOAM5327UZkjXPUEg/p1Qk8b8rA3dg2rSvvqL2Ox1ipVnFvs96UIN/1p
        5juVsUInN+iyzEqoRbu0VbeJOD8Z+3U=
X-Google-Smtp-Source: ABdhPJxHq6RyaM65k/A6oIlIlemQoaEtdwhD8it5bxpk3I7dSw5PqeR3TwbYD3MXvj+0bPQe6HmCug==
X-Received: by 2002:a05:6808:18a:: with SMTP id w10mr5408785oic.146.1607138356573;
        Fri, 04 Dec 2020 19:19:16 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id v8sm1095360otp.10.2020.12.04.19.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 19:19:15 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Realtek RTL8723BE throttling network speed
To:     Pratyush Yadav <me@yadavpratyush.com>,
        linux-wireless@vger.kernel.org
Cc:     Ping-Ke Shih <pkshih@realtek.com>
References: <20201203113120.mdbhyiqn5zgf37li@yadavpratyush.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <a497f933-0809-1ab8-a064-1519142ceb05@lwfinger.net>
Date:   Fri, 4 Dec 2020 21:19:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201203113120.mdbhyiqn5zgf37li@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/3/20 5:31 AM, Pratyush Yadav wrote:
> Hi,
> 
> I have the Realtek RTL8723BE wireless network adapter on my laptop:
> 
>    $ lspci | grep -i wireless
>    08:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8723BE PCIe Wireless Network Adapter
> 
> running kernel version "5.9.10-arch1-1".
> 
> I am seeing some strange behavior on it for some time now. When I power
> on my router and connect to it, I get the full download speed for about
> an hour or so. After that the speed throttles to around 60-70 KB/s.
> Other devices connected to the router continue work at full speed.
> 
> If I power cycle the router, it again works at full speed for about an
> hour or two and then throttles back to around 60-70 KB/s.
> 
> Has anybody ever seen any problem like this? Any fixes for this? Or at
> least any pointers to where I can start looking in the driver source?
> 
> Any help would be appreciated because this is quite annoying having to
> restart the router every hour or so.

What router and software version?

Does unloading/reloading rtl8723be fix the problem without resetting the router?

I tried the rtl8723be connecting to a Netgear WNDR4500. The starting 
speedtest.net speeds of 45 Mbps down and 12 Mbps up were maintained for 10 
hours. The up speed is the maximum for my broadband connection. The interface 
had 2 disconnects for reason 3, but it reconnected automatically.

Larry
-



+
