Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8369B12863B
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2019 01:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfLUAzf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 19:55:35 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44869 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfLUAzf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 19:55:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id x7so5766700pgl.11
        for <linux-wireless@vger.kernel.org>; Fri, 20 Dec 2019 16:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BdaxFGwLgb3ce+3JHrcpofvonJrHt7G075X1rJRTfqI=;
        b=X4Pyb0kG9JhqiofSFpF4O5ug0nVfRFr17lP0LuuTKj6cvSVbroDqczfXHaygtk5ga7
         Ytx5jM1VjgoIx6RXWfTQON23VeL75R4+S4UUlAvTEjTvtEoMDDW+qBt8XgEllNsXJTbO
         y4BHJQns5ZhwPGIi/p83oMCFrpEsYk6bKfFoqR/InuQR+7o48qJyHRKFAs0fXtaZsqJE
         uakUemmPKvJBsKdfCv4TSiup7Atzj3s2BSCt8ec17sol3ZJ7pEm4dAgo9QPpWNHKKJxj
         RhMix6wKjxR7XH16O8p6p+pUygvr1lpiECRN+de31cWN3/69XUsBpn1+Cuic1dJEoMGd
         aDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BdaxFGwLgb3ce+3JHrcpofvonJrHt7G075X1rJRTfqI=;
        b=JoaKXqc3HhYg3uX2Du9NcaQJYgkgijQmqfxPXmT89vmJ9bA5JPuZfvpqlvlK3S0Xks
         +vEPMX2ClSNYeWFA2V+AV7ItdJ6gY+hZCmj20Zpyx0QbkWL664Ofh2vNqpLW6I2DeExW
         Wn2oXJqjpVLddJxJuXotUZoSJQUFg7NGSDfVKx4B4BJpLS4/rWEmSC3h2/B5wVRr5kII
         FSRhq+GsZPfPa4UqZyFoK4uGOaH1S9hSrdcmMwm4uc38W+Em8BwkqGxIWuW1XyPfZ02w
         LmpGsEwr2Dxiap3cf1omEPl9ew1/AIDvQ0nnijp9xoa2EaMr0Fq54nZPLCiQIdGe+qYK
         em9g==
X-Gm-Message-State: APjAAAWyFPVk6/MAipuGhw0D2zkr1wCh4pUsqOjTyyMJvfhIlcd519lA
        TUz9vnd6MZwyJaqQNPyYbhWYEIVV8zk2oQ==
X-Google-Smtp-Source: APXvYqyZ5b58i52oeWaiD+dp1ujiQyr9UneppuCJYxgIzSLDLp2DPb60Jd0BdDcJcm6MVhylPusQQw==
X-Received: by 2002:a63:360a:: with SMTP id d10mr17492475pga.366.1576889734748;
        Fri, 20 Dec 2019 16:55:34 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id c68sm14988644pfc.156.2019.12.20.16.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 16:55:34 -0800 (PST)
Subject: Re: iwlwifi warnings in 5.5-rc1
To:     Johannes Berg <johannes@sipsolutions.net>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
References: <ceb74ea2-6a1b-4cef-8749-db21a2ee4311@kernel.dk>
 <9727368004ceef03f72d259b0779c2cf401432e1.camel@sipsolutions.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bac02c88-6107-7517-0114-e9c369f5fb41@kernel.dk>
Date:   Fri, 20 Dec 2019 17:55:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <9727368004ceef03f72d259b0779c2cf401432e1.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/11/19 1:36 AM, Johannes Berg wrote:
> On Tue, 2019-12-10 at 13:46 -0700, Jens Axboe wrote:
>> Hi,
>>
>> Since the GRO issue got fixed, iwlwifi has worked fine for me.
>> However, on every boot, I get some warnings:
>>
>> ------------[ cut here ]------------
>> STA b4:75:0e:99:1f:e0 AC 2 txq pending airtime underflow: 4294967088, 208
> 
> Yeah, we've seen a few reports of this.
> 
> I guess I kinda feel responsible for this since I merged the AQL work,
> I'll take a look as soon as I can.

Still the case in -git, as of right now. Just following up on this to
ensure that a patch is merged to fix this up.

I'd be happy to test, if you need something tested.

-- 
Jens Axboe

