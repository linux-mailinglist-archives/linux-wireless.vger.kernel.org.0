Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9A7D4F0CD
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jun 2019 00:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfFUWdF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jun 2019 18:33:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43594 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfFUWdF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jun 2019 18:33:05 -0400
Received: by mail-io1-f68.google.com with SMTP id k20so444507ios.10
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2019 15:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2P8WntbU+d4kIfNMxSUlPWkDA2n6aG/yNKd3O7NqDaA=;
        b=o7+tpQDsfmDyu4Hj1Q7PFX6qwy6m5eD9vLAlF3X/9EL6IaslgfgM4vJ9BNSf2A6a6j
         8i5A7qO2Zw2qNdzQaRozfQd3dDg/ih8VUgZ57b3ODje72pKEspX+4a3beePWK2NbKwF7
         d0TsvgmVoEZNy0lWlwad5cBhYy9/z2XDdcq+eoJuIwAxNPKlPzXREW4lQ9mOj923ZK/M
         1sTFwED/Wo4NF4DxQoMgAKlu4MQwwy/kd9phZxat9Sf9wHR+WWzXDrQ8ItW0YFhHwuBI
         9wF/jxBAejfRC39Shok/kXQrA7Vum5xJhYfPuJaJUxzjVb6vgbrhJtdPIhv3/Db2zK+v
         Mlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2P8WntbU+d4kIfNMxSUlPWkDA2n6aG/yNKd3O7NqDaA=;
        b=oOKZgJSceyrVxh4cZNoSpwTtqamISUktUj0SMpj9fzYkgOg0auP2Y8dcts5pTGLRkO
         YPRymH8x0QW1rlTZLOLgOdVGN3evGFz1lILn23ziU2yJ+OR9aWUZhp/eijqQ93fhjsAZ
         s+r96KZihz5Zi+XYWV+wdMTjJz6w8/TVK9PJ6t80qeMs9bWCeNB4FgUMiSk/k64vjM+k
         Xv95tLToLCJl/aUGMT2MhKbhXkBcC3KCAM9AtHoXvzBUZiMf8pQ0Tt5oLk58g1e8RyMJ
         Nf13N506BLTdjTL9gDmKUV2/ju5vskjUNfvbY6BXzFDVIPGBImM7tA22gP7kDqT4vMtO
         bBDw==
X-Gm-Message-State: APjAAAXaoYpV37b+9EJYtf4YCp3WvxCZI1yBMef7MXBN0bs9T1PbWlpg
        lnR68TXl+6wnX9Pv3NXSNmV6jc9v
X-Google-Smtp-Source: APXvYqyfvHlkMAzZnbrXIwPzwbK73TzAJDcpPkko5+8OjNSKdXKTiXXj85Dy8a7K9NQkcx/XzSZprg==
X-Received: by 2002:a02:85ef:: with SMTP id d102mr29238409jai.63.1561156384665;
        Fri, 21 Jun 2019 15:33:04 -0700 (PDT)
Received: from new-host-2.home ([2605:a601:808:1001:37ba:4f0a:192f:f945])
        by smtp.googlemail.com with ESMTPSA id c2sm3358135iok.53.2019.06.21.15.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 15:33:04 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] nl80211: Limit certain commands to interface owner
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <20190620220749.10071-1-denkenz@gmail.com>
 <20190620220749.10071-2-denkenz@gmail.com>
 <11852f40-67e5-9122-7d82-077bdd0b014a@broadcom.com>
 <af810765-ba1a-c7ae-abe5-35eef72eb8ce@gmail.com>
 <b1ae8df6-c8a7-e453-aad3-e31bb2e3bd60@broadcom.com>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <68b4e059-71ba-1b3e-3764-5d28280fe11e@gmail.com>
Date:   Fri, 21 Jun 2019 17:33:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <b1ae8df6-c8a7-e453-aad3-e31bb2e3bd60@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

>>> "funny business" is a different thing. Our testing infrastructure is 
>>> doing all kind of funny business. Guess we will need to refrain from 
>>
>> So you're going behind the managing daemon's back and messing with the 
>> kernel state...  I guess the question is why?  But really, if wpa_s 
>> wants to tolerate that, that is their problem :)  iwd doesn't want to, 
>> nor do we want to deal with the various race conditions and corner 
>> cases associated with that.  Life is hard as it is ;)
> 
> That's just it, right. This is what Marcel calls the real environment, 
> but is it. The nl80211 is a kernel API and should that mean that there 
> must be a managing daemon locking down APIs for other user-space tools 
> to use. If I want a user-space app to show a radar screen with 
> surrounding APs using scanning and FTM nl80211 commands it seems now it 
> has to create a new interface and hope the resources are there for it to 
> succeed. Where is my freedom in that? If I am using such an app don't 
> you think I don't accept it could impact the managing daemon.

I get it.  But on the flip side, should the managing daemon accept you 
messing with it? I mean there is a definite associated cost here, 
whether it is stuff crashing, having to account for extra corner cases 
and race conditions, giving out erroneous results, etc.

As Marcel pointed out, the proper solution is to do this via some 
diagnostic interface on the managing daemon, so it can properly manage 
such requests to not interfere with whatever else is going on.

By the way, the above would be generally useful to many people, so if 
you have some code lying around... ;)

>>> to give iwd a spin, but this SOCKET_OWNER strategy kept me from it. 
>>> Maybe iwd could have a developer option which disables the use of the 
>>> SOCKET_OWNER attribute.
>>
>> Okay?  Not sure what you're trying to say here?  I'd interpret this as 
>> "You guys suck.  I'm taking my ball and going home?" but I hope this 
>> isn't what you're saying?
> 
> Not saying that. Just saying that the "real environment" is in the eye 
> of the beholder and it would be nice if there was a way to opt out, but 
> Marcel seems strongly opposed to it. So there seems no point in 
> scratching that itch and come up with a patch.
> 

I guess the question is, what do you want this for?  If you want this 
for pure manual testing and accept the consequence of the managing 
daemon crashing, giving erroneous results or being otherwise confused? 
If you're fine with the above, I don't see a problem with such a patch.

Regards,
-Denis
