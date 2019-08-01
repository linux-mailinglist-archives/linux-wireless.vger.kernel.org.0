Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A312D7E35D
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2019 21:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388671AbfHATgG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Aug 2019 15:36:06 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33294 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388668AbfHATgG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Aug 2019 15:36:06 -0400
Received: by mail-lf1-f68.google.com with SMTP id x3so51246855lfc.0
        for <linux-wireless@vger.kernel.org>; Thu, 01 Aug 2019 12:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=V3Ge8kEfBOhgHnghoea/vpqthEkQaA2OeSiJtSpZcBU=;
        b=HtkKgWkG37oSBA7NVQz1Y7KzkqjUnWRMn8GBTKCcUv8QvFCAzmr0hP6ATSTuTvtKb5
         OVwaTG8+eZGMta/7oqC6SJiKlKlU8DWxQX90NDuAh8TASo5Tgq1AGRtGyVsWPwwRC1a8
         CP48Zf815BwLv9I7Tz14Am1951qNyM9HWFD2ZqrSXjNYmM+uWJBY2lumee63KI5Db5kR
         w4WUrq5goSfMt+DwHF7ePVhKbWqHxToBzuMrBp9sWapgy4T/EkXuhYAN4jAhBWZ8wTA1
         bAiwYHabnfXedmeazT44O3YEnOsTQ8D7MKAsyaq95avbQkwXALe3mvQZHKZMBrW9Ptfu
         HUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V3Ge8kEfBOhgHnghoea/vpqthEkQaA2OeSiJtSpZcBU=;
        b=WGxSELisJbzM7bOnlgdsgY1GA8vXNnkT3UGZ61G5EQttb8pYOIeOohJDAry1FWU8XE
         USOuGkOTWKUsFGzykbbsT4w0oCEeMnn+JKiVP9ThdJ9QhGadF3+z8D5RSG5yf3Hs/eTC
         85xQvNFjqrrGwcBLg5FxDpcwoaXwKnTaOfB8bxM+25cgFONCP6+GEmWgi2aES1mehpm2
         tFX9fWtNp5PLJ/WWMcAvlRfGo8i4YKy2ZB92DttZ0UJ5X31HutJQC5aTy5r4Mh3DB7+l
         +JlRVe/L66gju0DaYB1csPn3GM8r68S4AeiIHyqmMEzyC6USwSczqdJFV9M91FEMZDb5
         u5dg==
X-Gm-Message-State: APjAAAVUcLvJLDANksQESMM9T4FwzGLc0G0fg0Hhnq1aalzuLAGE+VZV
        /x8T187euQyRAO2sPwev+jrV91z1
X-Google-Smtp-Source: APXvYqwq12X1zo2WBCLz2iOCtVL9KnLIhW32ESJ3BwDxVZ5zajjCsgZvy5R8bXiiZjTHvkt3uzJz1g==
X-Received: by 2002:ac2:4466:: with SMTP id y6mr17944447lfl.0.1564688163262;
        Thu, 01 Aug 2019 12:36:03 -0700 (PDT)
Received: from [192.168.100.6] ([109.252.54.73])
        by smtp.googlemail.com with ESMTPSA id k124sm12413295lfd.60.2019.08.01.12.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 12:36:02 -0700 (PDT)
Subject: Re: [RFCv1 2/2] nl80211: Don't split-dump for clients with large
 buffers
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20190801071455.4974-1-denkenz@gmail.com>
 <20190801071455.4974-2-denkenz@gmail.com>
 <fec97dd04fe0b91a2d0d046839344f62cd8e127a.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <4275ea18-86c5-62a9-014d-f1a1b9c72280@gmail.com>
Date:   Thu, 1 Aug 2019 14:36:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fec97dd04fe0b91a2d0d046839344f62cd8e127a.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 8/1/19 4:13 AM, Johannes Berg wrote:
> On Thu, 2019-08-01 at 02:14 -0500, Denis Kenzior wrote:
> 
>> +		/*
>> +		 * auto-detect support for large buffer sizes: af_netlink
>> +		 * will allocate skbufs larger than 4096 in cases where
>> +		 * it detects that the client receive buffer (given to
>> +		 * recvmsg) is bigger.  In such cases we can assume that
>> +		 * performing split dumps is wasteful since the client
>> +		 * can likely safely consume the entire un-split wiphy
>> +		 * message in one go without the extra message header
>> +		 * overhead.
>> +		 */
>> +		if (skb_tailroom(skb) > 4096) {
>> +			state->large_message = true;
>> +			state->split = false;
>> +		}
> 
> Hmm. That's kinda a neat idea, but I don't think it's a good idea. Have
> you checked how long the message is now?

I only have hwsim and a ath9k to test with.  The hwsim comes out to be 
4448 bytes with an updated version of my patch.  ath9k is smaller.  V1 
did not address some extra gotcha code which didn't include some 
attributes in the unsplit case.  As far as I can tell all the attributes 
are now identical with v2.

Note that the overhead for split dumps is actually quite big.  The same 
info using split-dumps is 7724 bytes.  So there would definitely be an 
advantage in not using such fragmentation if not needed...

> 
> Since we *did* in fact hit the previous limit, and have added a *lot* of
> things since then (this was years ago, after all), I wouldn't be
> surprised if we're reasonably close to the new limit you propose even
> now already.

It seems not?

> 
> Also, keep in mind that there are some devices that just have an
> *enormous* amount of channels, and that's only going to increase (right
> now with 6/7 GHz, etc.)

The 2.4 & 5 Ghz bands account for about 2k.  So even if we add another 
band, we're likely still within an 8k buffer.  And really the kernel 
recommends a 16k buffer to be used as a minimum...

Also, the way nl80211 encodes channel information is really quite 
wasteful.  Not sure if anything can be done about it now, but the flags 
really, really, really add up.  So there is significant savings to be 
had here...

> 
> So in general, given all the variable things we have here, all this
> buffer size estimation doesn't seem very robust to me. You could have
> any number of variable things in a message:
>   * channel list - which we alleviated somewhat by having a separate
>     channel dump, so not all data is included here (which I guess you'll
>     complain about next :P)

Not sure I follow?  I don't see a separate channel dump?  Can you point 
me in the right direction?

>   * nl80211_send_mgmt_stypes() things are also a bit variable, and we
>     keep adding interface types etc., and some devices may support lots
>     of frames (there's an upper bound, but it's not that small)
>   * interface combinations - only getting more complex with more complex
>     devices and more concurrency use cases
>   * vendor commands have no real limit
>   * I'm sure measurement use cases will only increases
>   * and generally of course we keep adding to everything
> 
> 
> Also, I don't really buy the *need* for this since you're just removing
> a few kernel/user roundtrips here when new devices are discovered, a
> rare event. The parsing isn't really any more complicated for the
> userspace side.
> 

roundtrips to the kernel introduce races.  The less potential for a 
race, the less code we have to write and the less buggy it is.  Pretty 
simple...

> 
> Regarding the other patch, I think most of the above also applies there.
> I can sort of see how you think it's *nice* to have all the data right
> there, but I really don't see why you're so hung up about having to
> request the full information ... And I really don't want to see this hit
> the wall again in the future, in some weird scenarios with devices that
> have lots of <any of the above information>.
> 

See above...

> 
>> It should be safe to assume that any users of these new unsolicited
>> NEW_WIPHY events are non-legacy clients, which can use a
>> larger receive buffer for netlink messages.  Since older, legacy clients
>> did not utilize NEW_WIPHY events (they did not exist), it is assumed
>> that even if the client receives such a message (even if truncated), no
>> harm would result and backwards-compatibility would be kept.
> 
> Interesting idea, but no, in general you cannot assume that. Older
> clients might have added support for NEW_WIPHY without fixing the split
> dumps first ...

The two commits are over a year apart, but okay, fair enough.  Then 
again, you sort of hinted that nobody used this anyhow.

But regardless, if this mythical legacy/broken client is truly a 
concern, we can introduce a NEW_WIPHY_BIG or something.

> 
> Also, you mention in the code that messages are truncated, but I'm
> pretty sure they're just dropped, not truncated.

Dropped by who though? The kernel still copies the data into the 
usersace buffer, and sets the MSG_TRUNC flag.  Userspace will most 
likely drop it, yes.  But anyway, this is academic.

> 
> And finally, I also see no reason to send out many KB of data for what
> might in the end (e.g. in iw) just be a debug message.
> 

iw is not the real world though.  I mean seriously, who cares about what 
iw sees or doesn't?  We're sending 2x the data due to fragmentation 
overhead right now.

> 
> But really I think the thing that kills this proposal is the fact that
> it reintroduces a message size limit (even if higher now) that we're
> somewhat likely to hit in the future.
> 

I'd like to see some actual numbers that we're close to this message 
size limit?

Regards,
-Denis
