Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65D52114EF7
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2019 11:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfLFKWc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Dec 2019 05:22:32 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:39280 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfLFKWc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Dec 2019 05:22:32 -0500
Received: by mail-wr1-f46.google.com with SMTP id y11so7136970wrt.6
        for <linux-wireless@vger.kernel.org>; Fri, 06 Dec 2019 02:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncentric-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=skOAPnOWl3oT4FLd3L7s3uUOBfrTM7GiceHUAqMGxxo=;
        b=j7c2pU9URI9Ex9AiqPbGP/ExC83/hxdjHRIX5QUV9CObuJGPDVgzyn7roii88Fs2yJ
         aJy4BX8c3vcKcBX2DNAI6OkqcKQqQW+VD+sKQomSGz9id++iA5QQ7b/xnvwG2wszanDi
         I7Wip0Funwei6dPICIL1L0E9nY3LpyHpa3Ojg/eJ6moLOFyObndkUH6DXyUjeRWcS7Ik
         a7eOYiIleQfw4Rofsv4tiCYtnkXudBWRYw7rFtjSdK/lwqroGoRLL2ELvGj86Wrk6N5V
         NmXf1deNeHGZJsMMV/O9/WaxGiCVmDuunWCqt0TfhpUnPfamwJacoQlluFk4y736hu8y
         Kisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=skOAPnOWl3oT4FLd3L7s3uUOBfrTM7GiceHUAqMGxxo=;
        b=oLAiWefotRBWFFxm2gx50z+wqNLj8K+RGMbHck0yE9EZ7p/SEnoqM/+eXjeo85JhOi
         63Ep3MPavxJSayR1or0892Jtyg6k6Z/rWaKCCq8vGiVpnh9DMe3NMq9hXFoX2lmqjffa
         x9r0/b8L7zlubVYY947rykMDHbYv7MtNhz3lgkoESlJ9VSJX/9CqXyJ3BenoI15w8ScX
         WSci0/xERxbgKTdnf2MM2N797IZyu+Ecff2n5qgCUcUOA6/MXLPs9+i6AffGO64J2wz5
         yHzJjbFA1VTwoSRan4xp/i61h+bzkZNkrpGWZ2bmshIlB6GopZJjf49wPcubWSr0+DWd
         1c5Q==
X-Gm-Message-State: APjAAAUPAyHu5TkhziUvFH7WCB90Fx8sKsygzKKuJMf8K/Fog94mDmfP
        8YTbdhJcUFD7VsU4N9xrtZSi4KnOPIw=
X-Google-Smtp-Source: APXvYqyb8K5dKXhMBLK+WvPo5nhutMQ5JbO/7iEuaBGU5in3fFnRDQ0HxABUXllYjqYilB6KCp2OYg==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr15302545wrt.367.1575627749305;
        Fri, 06 Dec 2019 02:22:29 -0800 (PST)
Received: from [192.168.3.176] (d515300d8.static.telenet.be. [81.83.0.216])
        by smtp.gmail.com with ESMTPSA id z189sm3084599wmc.2.2019.12.06.02.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 02:22:28 -0800 (PST)
Subject: Re: debugging TXQs being empty
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kan Yan <kyan@google.com>
Cc:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <bbc516f28782175b27ac5e19dcdeac13cd6ee76a.camel@sipsolutions.net>
 <fd23a26dea59128ede8c1c4d02fb2f3514ffb5e9.camel@sipsolutions.net>
 <CA+iem5tjTpO_2MKL_pEu7enTa-8=g5vY3=2WJKjg9f=JA2eCEw@mail.gmail.com>
 <9b89b3b294295063aec045b9e863a44ad20b8782.camel@sipsolutions.net>
 <bf0cced86a1466285f74eb845e73fbaea1dff1c0.camel@sipsolutions.net>
From:   Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <a4895e13-5d18-f151-e558-a3be1ed065ce@ncentric.com>
Date:   Fri, 6 Dec 2019 11:22:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <bf0cced86a1466285f74eb845e73fbaea1dff1c0.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 06.12.19 10:12, Johannes Berg wrote:
> On Fri, 2019-12-06 at 09:41 +0100, Johannes Berg wrote:
>> Maybe somehow TSO is interacting badly with the TXQs and the tracking
>> here, since TSO makes the traffic *very* bursty? A 64k packet in the
>> driver will typically expand to 9 or 10 A-MSDUs I think?
> No, that all seems well. Without TSO (with the trivial mac80211 patch to
> let me turn it off with ethtool) I get about 890Mbps, so about 5% less.
> That's not actually *that* bad, I guess due to software A-MSDU in
> mac80211, but it's not really the right direction :)
If you try this test again while setting coverage class higher (20000m 
or so), you *will* notice the difference a *lot* more (>50%) :-)
Even when the actual devices are only a few meters apart.
>
> Changing wmem_max/tcp_mem to outrageous values also didn't really make
> any difference.
>
> I guess it's time to see if I can poke into the TCP stack to figure out
> what's going on...
>
> johannes
>
