Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6A2F4DDE6
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2019 01:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfFTXvi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 19:51:38 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35202 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfFTXvh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 19:51:37 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so1620584ioo.2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2019 16:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WmIdzO++g1/wCok0wbpqBrilttEkSuaSVkaCP7OhK+o=;
        b=AYDPlcId15yG9cpMKfjE9PBjux50w9CJkTjGoeRvkxqDWf4cQ8JQnG7lfuq2NITy8B
         7pAfrtIDdmBH35K1/ghEWeUVedkjvGA9KWNX6AJTgopV9yVdTJOpekSFVj6x6R2doxwp
         TTh5b7xFo2i7iHeQ7/W58CnDBPGnQnug96AGXF07kIqjvcZATG2GZtIYrO55xuGvQk6N
         n8TntNFwmU+5Zm3ddW8piPvjM75V+sM1nwT0hUl/JhfYuQnJYwFkI8uBuwERM9Odpfvf
         RaWdb5Qwy/jFeMtmVF3mQqtd5o0PCB4QbLJzz3jXa17zwxJkNTX7UfR+Vq/o8QvVKa3O
         K1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WmIdzO++g1/wCok0wbpqBrilttEkSuaSVkaCP7OhK+o=;
        b=fyzhf6Yy20kOTrl5cBgf4CTl+m2nrqPenX70n3DRo99OptL6233WKG5AdgqCYdOdlk
         E9j6raevPW9FXGgo8klNJlkCG/sY2b1QdPmfY+662yxn1g41Gfx3YsThfg9MfAFivi0o
         3PazlzDW7nPAlA8kkEdF+BFVtRv3gMvVq2+sCd/u4U+GB475QQoxEFhsyn18+FdLPIXt
         X8T9NyU65OQTs0xMNBwzE1IDWztys9xmECMZ/oJHXKGgoZghtCnsQMASVFCM18CFs+hW
         hTF81D53TEOpTI70yY6gYs2YTXLkQQkRqOkd+AFHeRPsW0H/KrmDUy0zvx1AoFikTiAV
         i08A==
X-Gm-Message-State: APjAAAVCT7Fb9hHWPt5XqM+dRId545ep1/SD8TmgxwH6v1U4pnHA5Oe/
        +bqBO6ewqi6La+7GozQ+KKn3mvII
X-Google-Smtp-Source: APXvYqybfQefO3IkCkQNOm9aQAQTewf3m+3NHVF88WyqdTL2mcfFKBwEuOA8EI1bCXGL5F6Vt0PaQQ==
X-Received: by 2002:a5d:948f:: with SMTP id v15mr95679532ioj.93.1561074697097;
        Thu, 20 Jun 2019 16:51:37 -0700 (PDT)
Received: from new-host-2.home ([2605:a601:808:1001:37ba:4f0a:192f:f945])
        by smtp.googlemail.com with ESMTPSA id a8sm1301049ioh.29.2019.06.20.16.51.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 16:51:36 -0700 (PDT)
Subject: Re: [PATCH 3/3] nl80211: Include wiphy address setup in NEW_WIPHY
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <20190619223606.4575-1-denkenz@gmail.com>
 <20190619223606.4575-3-denkenz@gmail.com>
 <ec1ca95a5789f9001e89e603633b20316d687721.camel@sipsolutions.net>
 <7da9b924-78c7-ba72-fecc-a11700a34ff4@gmail.com>
 <44923833f1068e360b1f9534a9bbd37be41e4833.camel@sipsolutions.net>
 <427f488f-98f5-f888-f079-e2bbbb6eedf3@gmail.com>
 <144f36779085498bdc1b2f7ac0d0c267d431f51d.camel@sipsolutions.net>
 <cc4f1755ee5f27c72cbac344988bcb91a1a835f3.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <0b16aff6-7bd8-338f-2e52-f1011a914d2f@gmail.com>
Date:   Thu, 20 Jun 2019 18:51:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <cc4f1755ee5f27c72cbac344988bcb91a1a835f3.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 06/20/2019 03:21 PM, Johannes Berg wrote:
> On Thu, 2019-06-20 at 22:09 +0200, Johannes Berg wrote:
>>
>> Sure, but you don't really need to know *everything* about the events
>> right there ... you can already filter which ones you care about
>> (perhaps you know you never want to bind hwsim ones for example) and
>> then request data on those that you do need.
> 
> Btw, you can send a filter down when you do request the data, so you
> only get the data for the new wiphy you actually just discovered.

Yes, I know that.  I did help fix this ~3 years ago in commit 
b7fb44dacae04.  Nobody was using that prior, which really leads me to 
wonder what other userspace tools are doing for hotplug and how broken 
they are...

> 
> So realistically, vs. your suggestion of sending all of the data in
> multiple events, that just adds 2 messages (the request and the data you
> already had), which isn't nearly as bad as you paint it.

I never 'painted' the message overhead as 'bad'.  The performance 
overhead of this ping-pong is probably irrelevant in the grand scheme of 
things.  But I find the approach inelegant.

But really I'm more worried about race conditions that userspace has to 
deal with.  We already have the weird case of ATTR_GENERATION (which 
nobody actually uses btw).  And then we also need to dump both the 
wiphys and the interfaces separately, cross-reference them while dealing 
with the possibility of a wiphy or interface going away or being added 
at any point.   Then there's the fact that some drivers always add a 
default netdev, others that (possibly) don't and the possibility that 
the system was left in a weird state.

So from that standpoint it is far better to have the kernel generate 
atomic change events with all the info present than having userspace 
re-poll it when stuff might have changed in the meantime.

Going back to your 2 message point.  What about  sending the 'NEW_WIPHY' 
event with the info in labels 0-8.  And then another event type with the 
'rest' of the info.  And perhaps another feature bit to tell userspace 
to expect multiple events.  That would still end up being 2 messages and 
still be more efficient than the ping-pong you suggest.

Regards,
-Denis
