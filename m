Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9106DD00D9
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 20:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfJHSu6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 14:50:58 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38200 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfJHSu6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 14:50:58 -0400
Received: by mail-ot1-f68.google.com with SMTP id e11so14966961otl.5
        for <linux-wireless@vger.kernel.org>; Tue, 08 Oct 2019 11:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4ojXyagueRpYxGulw3wDVpX2f6vxGjdaDyeBInEnQcA=;
        b=lDnYQqc4wkzEla06oo4AW7tir7aVOFZqEVwKnWjimDODuxDtSPWcUibW8cv9jZaJEA
         t3WzS/5jGUoQ+wwDl9yIggKaYji9fxJ+zn2GG/e8P/fqtjSRIJ6TsXl5WPSLBNTugnqa
         W4Qf4twMu11wPN6BHr86MkFqXSdfua69yOmYBZMZmd3yyhWFTeEaizfC/6pJbp8hJNYe
         B83ierWvZAF+pZ0auF24i4i09nZMjsp1OMQXeMvcP+KEhUKgQiQyU4P2TaAOLfYecx6U
         uJqqAG21JO1uqnfsWKvXLZcUoaWQmGrh36Z2NRwdDPRkPrXPUGjIn3ZagPXrO9SoV3o4
         ydMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ojXyagueRpYxGulw3wDVpX2f6vxGjdaDyeBInEnQcA=;
        b=o4zcB7YKSbfWYHOEhmkMvGwFscpbyNjB2l7nuIYPq52lX+NRO+E83TpfiIJr8OKO0Z
         575NxXnzyaaKo3u0g/sHK3fY0SaR11tHW90LqhfMGwTGLMuUx5i1eJB6QLWmccW3Cm99
         yJbH4HclTkqWYqJ13IofLWM91ymHUEFyACLuwYhP2Kp4636HjFiEx0sVI+4mATriuZUT
         /lAP2seYnjcXsPZbDah2i1iSVjXl/dPKTS1vhdMoyCWPrKz463pK/ZUyGNBi4rzT6/l+
         y3qMiELRc4u+AMUO+DHieIRjEPm9V43vbap/lo2TonThV+aCSIKd/lU9ZxnQCf92unz2
         d2vQ==
X-Gm-Message-State: APjAAAUm1saeIfKly7sOBevluwrrrgCQ13CJWqAKlvc9/fo2cmfx0A1k
        2F4JOELSI1sTm0aMvK3SR293KrAp
X-Google-Smtp-Source: APXvYqxEKPBsZamFhTyVrg0Texbi1t2OPyiwWuwvZnKtm2rmHnWpJau3Z72YgUo6OqtfjbFXzfzepQ==
X-Received: by 2002:a9d:3463:: with SMTP id v90mr27211682otb.29.1570560657292;
        Tue, 08 Oct 2019 11:50:57 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id a9sm5768341otc.75.2019.10.08.11.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 11:50:56 -0700 (PDT)
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
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <193168d4-6466-60a4-bc89-c4a44e84ac46@gmail.com>
Date:   Tue, 8 Oct 2019 13:50:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fbb287a82656dd3f89817590e86b23d6968a2822.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

>> But they shouldn't change due a mac address change?  I wonder if we can
>> further relax the requirements to allow mac change if
>> NL80211_SCAN_FLAG_RANDOM_ADDR was used?
> 
> No, at least with HW scan that would completely confuse the driver -
> since from the driver's POV we'd remove the interface it's currently
> managing the scan for.

So help me understand this better.  Just by virtue of copying the new 
mac into sdata->vif.addr we'd be confusing the driver such that it can't 
associate the ongoing scan request to the wdev it was started on?  Even 
when it has all this info?  I mean you have a single scan request on a 
phy, how hard can this be? :)

Note that some apps perform poor-man's scan address randomization by 
varying the mac (I assume prior to each nth scan).  So being able to 
change the mac while scanning might be a boon to them.  I personally 
don't think changing mac via rtnl to accomplish this is a great idea, 
but just tossing it out for you.

Regards,
-Denis
