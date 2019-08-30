Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCB0EA3B09
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 17:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfH3PxM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 11:53:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36642 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfH3PxM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 11:53:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id k18so7404197otr.3
        for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2019 08:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xllVYMulSRXP+3GHeI66uZ3ZqOC8IzBc/HynBTRO8eQ=;
        b=QfPOWPTd1LVbm3nUeIjtwxYFYB0xVSOANHg5utnAYkQ2hOvx3L1h8lSnwdDfC0gO7k
         sdGwxYmqeJjxblbcHyOjrXRIWBjwuAM3H1GYFDqD242yah7GLVzFZ58zGWL93cVs0vCz
         zGI7BRPAgKkgWA7gwz2ggLdg5SGTIpm+yvJXGP6O3mqWiaImIjzd3XkqhVY4mOxsL3qa
         ze+untzSOWu1RS6oi8N0TWF7Z4P1Cq5l0tZYFVTa3/RO18vnkpYfqFOhhSsttPmzlDOr
         OSs0+NKmMbVj6KMgOhZdvaOHU1BpBF901V4lZfnOjk/fsT6qKOBDsFbz1LOd52lF1cqL
         r8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xllVYMulSRXP+3GHeI66uZ3ZqOC8IzBc/HynBTRO8eQ=;
        b=imLmfMxMANA8Q/jyfmGlt2P7oU/KUsAk84BTuaZeevZ2e2BqFBjQ8eBC5/ktipP8/b
         xZCtO7+ji8YZ/72aK5BokDxbMvlpwnNUlFcUUOu5Q3THOFBWPnLlHNgXMrpsP9iW0vHz
         fiZSsz/2fGMNh4hb0GDUKF9XMxLDiVVROE2nxYayqCbUh9HPPAnye5hInUMVxrQIrd+g
         nWjzaeKyzWrjkzQLUobgAUe3rBmHLGUFck1JprZI1BRKbintZ/s//btCSOBylZO3fykw
         bJH/UEq5PETBumGkjnxCUuVEILS09Nr6fTnPInF1AfUzxjiMhs16vdCr8er6Hn9XPp2/
         jNcA==
X-Gm-Message-State: APjAAAUHTNs56YNpH3rmOm7wKFjPu/EMZO1HtshbddG8JAOIeZ64FVac
        ijDQ6gdJlEGCZg5CkmPxwAzKUyC8
X-Google-Smtp-Source: APXvYqzLyU1jXo9cVdp3Xu+G2vlzIHoem2KPF6ONOaanVb1XWA1Xd7sWwyPRqx3PgR1Q9reRyeNnKw==
X-Received: by 2002:a9d:2ae9:: with SMTP id e96mr11957505otb.89.1567180390989;
        Fri, 30 Aug 2019 08:53:10 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 20sm2149810oth.43.2019.08.30.08.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 08:53:10 -0700 (PDT)
Subject: Re: [RFCv2 4/4] nl80211: Send large new_wiphy events
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20190816192703.12445-1-denkenz@gmail.com>
 <20190816192703.12445-4-denkenz@gmail.com>
 <2eb256e8a7be09f35dc4f0f3b61e0363691f41f0.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <b8f6917e-b9af-fef5-f3a0-7d1c1c33f825@gmail.com>
Date:   Fri, 30 Aug 2019 10:53:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2eb256e8a7be09f35dc4f0f3b61e0363691f41f0.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 8/30/19 5:14 AM, Johannes Berg wrote:
> On Fri, 2019-08-16 at 14:27 -0500, Denis Kenzior wrote:
>> Send large NEW_WIPHY events on a new multicast group so that clients
>> that can accept larger messages do not need to round-trip to the kernel
>> and perform extra filtered wiphy dumps.
>>
>> A new multicast group is introduced and the large message is sent before
>> the legacy message.  This way clients that listen on both multicast
>> groups can ignore duplicate legacy messages if needed.
> 
> Since I just did the digging, it seems that this would affect (old)
> applications with libnl up to 3.2.22, unless they changed the default
> recvmsg() buffer size.
> 

Sorry, I'm not sure I understand.  Are you saying new clients would try 
to use old libnl and subscribe to this new multicast group for large 
messages?  Legacy clients shouldn't even see messages on this multicast 
group since they would never subscribe to it.

> I think this is a pretty decent approach, but I'm slightly worried about
> hitting the new limits (16k) eventually. It seems far off now, but who
> knows what kind of data we'll add. HE is (and likely will be) adding
> quite a bit since it has everything for each interface type - something
> drivers have for the most part not implemented yet. That trend will only
> continue, as complexity in the spec doesn't seem to be going down.
> 

Right, but the kernel will go up to 32k buffers if userspace read buffer 
is that large.  So I think we have quite some room to grow.  On the 
other hand, we probably should be vigilant that any new stuff added 
tries to minimize message sizes whenever possible.

> And I don't really want to see "config3" a couple of years down the
> road...
> 

Agreed.

> So can we at least mandate (document) that "config2" basically has no
> message limit, and you will use MSG_PEEK/handle MSG_TRUNC with it?
> 

Yes, I will take care of that in v3.

> That way, we can later bump the 8192 even beyond 16k if needed, and not
> run into problems.
> 
>> +       if (cmd == NL80211_CMD_NEW_WIPHY) {
>> +               state.large_message = true;
>> +               alloc_size = 8192UL;
>> +       } else
>> +               alloc_size = NLMSG_DEFAULT_SIZE;
>> +
> 
> nit: there should be braces on both branches
> 

will fix

>> +       if (nl80211_send_wiphy(rdev, cmd, msg, 0, 0, 0, &state) < 0) {
>> +               nlmsg_free(msg);
>> +               goto legacy;
>> +       }
> 
> I think that'd be worth a WARN_ON(), it should never happen that you
> actually run out of space, it means that the above wasn't big enough.
> 

Yep

> Now, on the previous patches I actually thought that you could set
> "state->split" (and you should) and not need "state->large_message" in
> order to indicate that the sub-functions are allowed to create larger
> data - just keep filling the SKBs as much as possible for the dump.
> 
> Here, it seems like we do need it. It might be possible to get away
> without it (by setting split here, and then having some special code to
> handle the case of it not getting to the end), but that doesn't seem
> worth it.
> 
>> @@ -14763,6 +14787,8 @@ void nl80211_notify_iface(struct cfg80211_registered_device *rdev,
>>                  return;
>>          }
>>   
>> +       genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
>> +                               NL80211_MCGRP_CONFIG2, GFP_KERNEL);
> 
> Hmm. That seems only needed if you don't want to listen on "config" at
> all, but in the patch description you explicitly said that you send it
> on "config2" *before* "config" for compatibility reasons (which makes
> sense) - so what is it?

Well it can be both, depending on whether large messages can fail or 
not.  So one use case might be that a client detects whether the config2 
multicast group exists.  If so, then it only subscribes to it and that's it.

Another use case might be (if userspace is worried about losing large 
messages) to subscribe to both groups.  If it receives the large 
message, it can ignore the one that comes on the legacy multicast group.

> 
> I'm having a hard time seeing anyone get away with only listening on
> config2 since that'd basically require very recent (as of now future)
> kernel. Are you planning this for a world where you can ditch support
> for kernel<5.4 (or so)?

No, but there's nothing stopping the client in making the choice at 
runtime depending on the genl family info it gets.  E.g. by peeking into 
CTRL_ATTR_MCAST_GROUPS.

Regards,
-Denis
