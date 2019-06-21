Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE034EDA7
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2019 19:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfFUROC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jun 2019 13:14:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41959 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFUROC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jun 2019 13:14:02 -0400
Received: by mail-io1-f68.google.com with SMTP id w25so34099ioc.8
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2019 10:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ts6bDWGram+dVfsUFCHCTCLS3nqJnHBiIMFNifP063M=;
        b=bMd2oW/4Xf416oCSmZ5iG2bphyyMHe+FyDaIi0IGclqbBGQ4AkcguMQROXDWyitk+e
         rBrLhSDxq8WWuVIen9sEC3UE56BCAYNwVSBC8a4Ttr8nTrzi383IA9oLLYpRZzow1uFU
         6kSQ8H7KsSbT6OoPoJ/jW4HxGXd5qdMwt8QfP5Y+UoIWiJ7M301NRI+8GLjAy6UVGF2K
         IKQRKKrZMxuMuAAVexKBbABU2uKz0cLRCtjXLNMWgKpAiXKyCZV1oH+BLAOFZ7QwKMhO
         cPcls5TX9JtofHlywjofnYSsaP5BVO7wOLUT0wFw+brP7tXVALK9tQtJSsAQJmGA+Ap/
         4xEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ts6bDWGram+dVfsUFCHCTCLS3nqJnHBiIMFNifP063M=;
        b=CM3rUtUXKTGwgWyPTKZjlWbrQF/dQyx4gX3WxkkitMv5L93UMrcOMXbNib2TujG85s
         +aysYCARBrvN97syVJsyv0SxMJgVkF92JJ8elFszlBPi357FOjvALfZYgMEeLQ9n4Kgk
         /3fXA9YHfNz4n+5NQ996K+9zPCyf0UHxUqwaSUdpQruB9V1bZsuewpme/u4nukR0rDyR
         +PWp8v9H77ptouXVyMgz3ROTpUo1d/k73t27Zgj25zKBHQ1mNH90HqoH0Bg72jk0QQHO
         l7Zaqm9S0t2/EiM8O1SEI+b9WXsP3pWVZXK5LHFXJWSKi8UfSkKGkzZkSWyOWIR1wNmx
         Dy2g==
X-Gm-Message-State: APjAAAU2++p1jB7jIrte5TJnRH9qx55WWELd5lOYvGTyIV2/AzAvDpZ/
        J1sOTiqSCVRsjX5nrSIzFtSvChrS
X-Google-Smtp-Source: APXvYqykZi1IqDQ/3yqjD9Zm0wlNXjALspMSBJu8DQ2LO4MIIDnoJHdQFdyTFd3rIv7aexMwh+rjrg==
X-Received: by 2002:a5e:9314:: with SMTP id k20mr14645024iom.235.1561137242964;
        Fri, 21 Jun 2019 10:14:02 -0700 (PDT)
Received: from new-host-2.home ([2605:a601:808:1001:37ba:4f0a:192f:f945])
        by smtp.googlemail.com with ESMTPSA id l2sm2550807ioh.20.2019.06.21.10.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 10:14:02 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] nl80211: Limit certain commands to interface owner
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <20190620220749.10071-1-denkenz@gmail.com>
 <20190620220749.10071-2-denkenz@gmail.com>
 <11852f40-67e5-9122-7d82-077bdd0b014a@broadcom.com>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <af810765-ba1a-c7ae-abe5-35eef72eb8ce@gmail.com>
Date:   Fri, 21 Jun 2019 12:14:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <11852f40-67e5-9122-7d82-077bdd0b014a@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

On 06/21/2019 03:09 AM, Arend Van Spriel wrote:
> On 6/21/2019 12:07 AM, Denis Kenzior wrote:
>> If the wdev object has been created (via NEW_INTERFACE) with
>> SOCKET_OWNER attribute set, then limit certain commands only to the
>> process that created that wdev.
>>
>> This can be used to make sure no other process on the system interferes
>> by sending unwanted scans, action frames or any other funny business.
> 
> The flag is a good addition opposed to having handlers deal with it. 
> However, earlier motivation for SOCKET_OWNER use was about netlink 
> multicast being unreliable, which I can agree to. However, avoiding 

???  I can't agree to that as I have no idea what you're talking about 
:)  Explain?  SOCKET_OWNER was introduced mainly to bring down links / 
scans / whatever in case the initiating process died.  As a side effect 
it also helped in the beginning when users ran iwd + wpa_s 
simultaneously (by accident) and all sorts of fun ensued.  We then 
re-used SOCKET_OWNER for running EAPoL over NL80211.  But 'multicast 
unreliability' was never an issue that I recall?

> "funny business" is a different thing. Our testing infrastructure is 
> doing all kind of funny business. Guess we will need to refrain from 

So you're going behind the managing daemon's back and messing with the 
kernel state...  I guess the question is why?  But really, if wpa_s 
wants to tolerate that, that is their problem :)  iwd doesn't want to, 
nor do we want to deal with the various race conditions and corner cases 
associated with that.  Life is hard as it is ;)

> using any user-space wireless tools that use the SOCKET_OWNER attribute, 
> but how do we know? Somehow I suspect iwd is one to avoid ;-) I have yet 

I guess you will be avoiding wpa_s since that one uses SOCKET_OWNER too ;)

> to give iwd a spin, but this SOCKET_OWNER strategy kept me from it. 
> Maybe iwd could have a developer option which disables the use of the 
> SOCKET_OWNER attribute.

Okay?  Not sure what you're trying to say here?  I'd interpret this as 
"You guys suck.  I'm taking my ball and going home?" but I hope this 
isn't what you're saying?

Regards,
-Denis
