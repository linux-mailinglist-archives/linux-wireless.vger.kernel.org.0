Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955A77BE6C
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 12:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbfGaKab (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 06:30:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33869 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387679AbfGaKaa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 06:30:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id b29so39840009lfq.1
        for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2019 03:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/2GVOHQtCp+RA8UaR5aWgC6YlYYaIG5dighBymtUXyw=;
        b=e5Xos3M3g75JkwLAQKiwNx02Ds3JbX4BZf2GVbUTCCAHX5Hk++qz3sb+1XYsNGWqNn
         1gqfquAISgT6Slw70Pdi7FH697Nn5AQKEp8/NamNACkTc5fNaAhej4noj/R3FsobhOvS
         n16818Yzn73NLdcSifiDlQ8kdXg2Ea2RnoqB3zP4mSniOGrnVXkYdd4BXbqFo+gacw8K
         3ftEFR2zj2K3UsUUi1vBRQyg8LzMJUkctW6bkFeWXgeKHtBFz9O0YSh7kmgCmpF/AJmK
         ALEHzBzm+as27hz+On+b8a3tyveDvaA6JjidGIqaKGL+cLVOwsdqGbhtGdcS9dxKWUMu
         v7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/2GVOHQtCp+RA8UaR5aWgC6YlYYaIG5dighBymtUXyw=;
        b=C9msNnPzWpNkjdMjQSDGXSGfR/WIJ7QkVh6sWtKRvXQYNy69NlrZS4ZVW+3+74h/R5
         EEhNLtkqZ1nJMMNjgmt7L7MoGxRWS/MZxOyF/7VeTkAhgjMcK1tojOTdrCdBJ1e2FoNx
         JDzFjZ/8Bf8L1zGh9QjgdbNHIfjZhTfzjrUb0BwS5BhpTZlFeS9j8uy3z7CQCUWnFD8q
         daKD2IjxD1DMmiw3osYa2pNTOkgjywrqJjdODu79jnzxsjG4kJrKl1D5iR8z6cIG7A8c
         8W/CjaTngPInOzznSxpoP0dxUoN2IlgH+u8p6TSeZGIdmlZXEo0lwXAl/+v0pA4joioA
         Q2jw==
X-Gm-Message-State: APjAAAUf/U6Uh4v9Yn70fJIN6uBAKlxPRf9143jRkwb/AhxgjzQ+v97s
        7gEpCiYflE8h8gjfrhVOQPeiM2z5xXg=
X-Google-Smtp-Source: APXvYqylLIkjMIh+Z3oYWiL54YNZX+63Daj9LzMk//LiEoPq2wPkjId0rvQvrOS34Z4Gr2fZhfLjoA==
X-Received: by 2002:ac2:4891:: with SMTP id x17mr59320272lfc.60.1564569028146;
        Wed, 31 Jul 2019 03:30:28 -0700 (PDT)
Received: from [192.168.100.6] ([109.252.54.73])
        by smtp.googlemail.com with ESMTPSA id h1sm11718704lfj.21.2019.07.31.03.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 03:30:27 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] nl80211: Limit certain commands to interface owner
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <20190701153317.27170-1-denkenz@gmail.com>
 <20190701153317.27170-2-denkenz@gmail.com>
 <bcb31ffae5b916d319bd25a34432026df61fc6f0.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <f0374da3-bc78-d0d9-8af7-64391d5bb702@gmail.com>
Date:   Wed, 31 Jul 2019 05:30:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bcb31ffae5b916d319bd25a34432026df61fc6f0.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannnes,

On 7/31/19 4:51 AM, Johannes Berg wrote:
> On Mon, 2019-07-01 at 10:33 -0500, Denis Kenzior wrote:
>> If the wdev object has been created (via NEW_INTERFACE) with
>> SOCKET_OWNER attribute set, then limit certain commands only to the
>> process that created that wdev.
>>
>> This can be used to make sure no other process on the system interferes
>> by sending unwanted scans, action frames or any other funny business.
>>
>> This patch introduces a new internal flag, and checks that flag in the
>> pre_doit hook.
> 
> So, looking at this ...
> 
> I can't say I'm convinced. You're tagging 35 out of about 106 commands,
> and even if a handful of those are new and were added after your patch,
> this doesn't really make sense.
> 
> NL80211_CMD_LEAVE_IBSS is tagged, but not NL80211_CMD_LEAVE_MESH?
> NL80211_CMD_NEW_STATION is tagged, but not NL80211_CMD_NEW_MPATH?
> NL80211_CMD_SET_KEY is tagged, but not NL80211_CMD_SET_PMK or
> NL80211_CMD_SET_PMKSA?
> NL80211_CMD_UPDATE_CONNECT_PARAMS is tagged, but not
> NL80211_CMD_UPDATE_OWE_INFO (though this could be patch crossing?)
> 
> NL80211_CMD_CONTROL_PORT_FRAME isn't tagged?

So for some of these I was planning to submit a patch to check that the 
request comes from the SOCKET_OWNER for the connection itself.  E.g. it 
makes no sense to accept CONTROL_PORT_FRAME from a process that didn't 
issue the CMD_CONNECT.  Same applies for some of the offload commands. 
But I can include these in this list as well if you prefer.

For others, it was pure ignorance as to what the commands do.  E.g. we 
haven't looked into Mesh at all.  So if you want to suggest which 
commands should be included, I'm happy to add these.

> 
> NL80211_CMD_SET_QOS_MAP isn't tagged?
> 
> It almost feels like you just did a "git grep NL80211_CMD_" on your
> code, and then dropped the flag on everything you were using.
> 
> And honestly, I think you need a better justification than just
> "unwanted scans, action frames or any other funny business".
> 

We have a limited resource that we are managing in userspace.  We can't 
just have any random process coming in and messing with that resource. 
So either the userspace daemon should do it or the kernel.  Right now it 
is just pure chaos...

And really, in the end, how is this different from SOCKET_OWNER for 
CMD_CONNECT?  It is optional in the end, so if you don't want to use it, 
don't?

> Also, how's this not just a workaround for some very specific setup
> issue you were seeing, where people trying out iwd didn't remove wpa_s
> properly (*)? I'm really not convinced that this buys us anything except
> in very limited development scenarios - and those are typically the
> exact scenarios where you _want_ to be able to do things like that (and
> honestly, I'd be pretty pissed off if I couldn't do an "iw wlan0 scan"
> just because some tool decided it wanted to have control over things).

I understand where you're coming from, but you're just one user who can 
disable this behavior anyway if you really cared.  For 99.9% of the 
users this is never going to be a problem.  And I'd rather cater to the 
99%...

> 
> (*) also, that would just happen to work for you now with iwd winning
> because you claim ownership and wpa_s doesn't, you'd still get the same
> complaints "iwd doesn't work" if/when wpa_s *does* start to claim
> ownership and you get locked out with a patch like this, so I don't feel
> you'd actually win much even in this case.
> 

This is in no way the motivation for this.  wpa_s or iwd winning is a 
distro/user configuration problem.  I don't care about that now. 
Besides, this was mostly taken care of by the SOCKET_OWNER set on 
CMD_CONNECT...

> 
> I'm trying to come up with places where we do something similar, defend
> one application running as root against another ... but can't really?
> Think about VPN - we don't stop anying from removing or adding IP
> addresses that the VPN application didn't intend to use, yet that can
> obviously break your connection. You could even run dhcp on it, even if
> for (most) VPN protocols that's rather useless.

File locking would be one example.  Systemd can and does all kinds of 
fun stuff (e.g. locking a process out from twiddling rfkill).  LSM 
modules can do just about everything.  I think there are plenty of examples.

But really, a lot of this works just because various processes play 
'nice' and stay out of each other's way.  Also, as you point out, most 
things aren't done because they don't make sense.

But with nl80211 this isn't the case.  Many processes would be tempted 
to start an operation or get some info out of nl80211 directly.  So this 
patch tries to narrow down what they can use, e.g. informational-only 
commands are fine.  Anything that can affect state is not fine.

> 
> Overall, I'm not really convinced. The design is rather unclear
> (randomly sprinkling magic dust on ~35% of commands), and it's also not
> really clear to me what this is intended to actually achieve.
> 

You may want to refer to the thread between Arend & Marcel (started by 
an earlier version of this patchset).

I really don't see how giving the userspace management daemon (which by 
definition has exclusive control) a way from locking out a random 
process from starting a potentially disruptive operation is 
'unconvincing.'  As a developer you will hate this of course, and that 
is to be expected.  But look at it from a user POV.

Regards,
-Denis
