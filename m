Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA5AE4F062
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2019 23:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfFUVQG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jun 2019 17:16:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38020 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfFUVQF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jun 2019 17:16:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so7814851wmj.3
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2019 14:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BVVs07OmK9YR7IOR/B+T3LtKYvR/qxKoFTYvv8pP2dk=;
        b=I3gG1ZmAGKiE8Q/S5gZYwDl7J7fJJ6C1WhRagYWJSZbEj7RPs2DbpvvIfb43d1vcE0
         i1vnUDh5YjZ9n1paixH7TsbGqv0Nwi5514gc2TXrFoq0RPFDWZzEU5umonFUiXb+xE4i
         pGlT/tZLpERpTAjeKWJk6dqXEejUCsWDogu0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BVVs07OmK9YR7IOR/B+T3LtKYvR/qxKoFTYvv8pP2dk=;
        b=LACucIiVwB3ElUB2+yiOaz/EbQF06w4+MSjgcHwOcskSrc8tXgIMva1+NA6KsHCv0s
         PvMRfNHpHErkyy7fQXJA50T4rp0zkQc52H3J9ekkjgTn+5DdcSkoSj+naDv2kkPtjafn
         RiXQp9suQNvw+wvIRRwZDv2fCfKpDubf/2Z2G1+wyjY5W+OokpG6/E0U5Aj3zHpXpgf4
         D2FLY390C37CZ930tklFtM/lOo8AGwzEpyQ3uXRq7dyRF5KVFVtX1vUXlcNrJj8cTjr2
         jN1XpxBfxrI0QVYDbtxME0F0+6Tc5BKD57UNWR4sURAIZc40IC3eHCwuCjQp/Bslx4JJ
         zbIQ==
X-Gm-Message-State: APjAAAUc5X8HznACIbv4TOWqQZKJwsWVLj7aUxsgPEpx8F0/yQLjk2Vh
        STnWI/gf6n5cJWdm8M4uOx6wt79KfYa8ZirFo6Z2X+nJdAgOFrPfogIfeQeYQmcwqtfxo2R7kRv
        oMk885VF37jzqIHgcHjRYNbrPAfYUUD0fcLNqw7I0690WO3ewClHl02NHeJp+I7kUrP/VQ8FurZ
        xjDZOvwUGxJokkuw==
X-Google-Smtp-Source: APXvYqyRM3zC6y88SGRq81wrKP+WHQfT2OuIpTfWztjGwBuYbWUQoWKHO208i/DAQtgBU6OVxHNXFQ==
X-Received: by 2002:a1c:c305:: with SMTP id t5mr5135500wmf.163.1561151763260;
        Fri, 21 Jun 2019 14:16:03 -0700 (PDT)
Received: from [10.230.40.234] ([192.19.215.250])
        by smtp.gmail.com with ESMTPSA id h84sm3610001wmf.43.2019.06.21.14.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 14:16:02 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] nl80211: Limit certain commands to interface owner
To:     Denis Kenzior <denkenz@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <20190620220749.10071-1-denkenz@gmail.com>
 <20190620220749.10071-2-denkenz@gmail.com>
 <11852f40-67e5-9122-7d82-077bdd0b014a@broadcom.com>
 <af810765-ba1a-c7ae-abe5-35eef72eb8ce@gmail.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <b1ae8df6-c8a7-e453-aad3-e31bb2e3bd60@broadcom.com>
Date:   Fri, 21 Jun 2019 23:16:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <af810765-ba1a-c7ae-abe5-35eef72eb8ce@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/21/2019 7:14 PM, Denis Kenzior wrote:
> Hi Arend,
> 
> On 06/21/2019 03:09 AM, Arend Van Spriel wrote:
>> On 6/21/2019 12:07 AM, Denis Kenzior wrote:
>>> If the wdev object has been created (via NEW_INTERFACE) with
>>> SOCKET_OWNER attribute set, then limit certain commands only to the
>>> process that created that wdev.
>>>
>>> This can be used to make sure no other process on the system interferes
>>> by sending unwanted scans, action frames or any other funny business.
>>
>> The flag is a good addition opposed to having handlers deal with it. 
>> However, earlier motivation for SOCKET_OWNER use was about netlink 
>> multicast being unreliable, which I can agree to. However, avoiding 
> 
> ???  I can't agree to that as I have no idea what you're talking about 
> :)  Explain?  SOCKET_OWNER was introduced mainly to bring down links / 
> scans / whatever in case the initiating process died.  As a side effect 
> it also helped in the beginning when users ran iwd + wpa_s 
> simultaneously (by accident) and all sorts of fun ensued.  We then 
> re-used SOCKET_OWNER for running EAPoL over NL80211.  But 'multicast 
> unreliability' was never an issue that I recall?

hmm. I tried searching in memory... of my email client but to no avail. 
I somehow recalled that netlink multicast was not guaranteed to be 
delivered/seen by all listeners.

>> "funny business" is a different thing. Our testing infrastructure is 
>> doing all kind of funny business. Guess we will need to refrain from 
> 
> So you're going behind the managing daemon's back and messing with the 
> kernel state...  I guess the question is why?  But really, if wpa_s 
> wants to tolerate that, that is their problem :)  iwd doesn't want to, 
> nor do we want to deal with the various race conditions and corner cases 
> associated with that.  Life is hard as it is ;)

That's just it, right. This is what Marcel calls the real environment, 
but is it. The nl80211 is a kernel API and should that mean that there 
must be a managing daemon locking down APIs for other user-space tools 
to use. If I want a user-space app to show a radar screen with 
surrounding APs using scanning and FTM nl80211 commands it seems now it 
has to create a new interface and hope the resources are there for it to 
succeed. Where is my freedom in that? If I am using such an app don't 
you think I don't accept it could impact the managing daemon.

>> using any user-space wireless tools that use the SOCKET_OWNER 
>> attribute, but how do we know? Somehow I suspect iwd is one to avoid 
>> ;-) I have yet 
> 
> I guess you will be avoiding wpa_s since that one uses SOCKET_OWNER too ;)

Probably. One of my concerns was about NL80211_CMD_CONNECT event, but 
checking nl80211_send_connect_result() it seems to just send it to the 
mlme multicast group regardless SOCKET_OWNER use.

>> to give iwd a spin, but this SOCKET_OWNER strategy kept me from it. 
>> Maybe iwd could have a developer option which disables the use of the 
>> SOCKET_OWNER attribute.
> 
> Okay?  Not sure what you're trying to say here?  I'd interpret this as 
> "You guys suck.  I'm taking my ball and going home?" but I hope this 
> isn't what you're saying?

Not saying that. Just saying that the "real environment" is in the eye 
of the beholder and it would be nice if there was a way to opt out, but 
Marcel seems strongly opposed to it. So there seems no point in 
scratching that itch and come up with a patch.

Regards,
Arend
