Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B05CFE75
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 18:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfJHQDj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 12:03:39 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39043 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfJHQDi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 12:03:38 -0400
Received: by mail-ot1-f66.google.com with SMTP id s22so14461097otr.6
        for <linux-wireless@vger.kernel.org>; Tue, 08 Oct 2019 09:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Q5G4fEvx6aGYpXTyfozkr/6mvrwbDErJ8bUUTfZwUuo=;
        b=Vvy0vpp+sDss/mwbOASNCud2/viMOSVR6UNWPiuvf7+YKcZHIsabqE1MguO6SF5MJ/
         p37CGoMpVknerd58okJjhQmqAsTU38faS4VTTaJp0AI3/Mxv8OKox4cuPv0MEHf5bjj9
         R9e8yLtz2jLLg70Bsf4XE4mEeoBkdLEt8HYhAGfo7lQBN3WVwLCwy2Fe+bClyERVMoSO
         RAWZXyzDAggy+eeAttCv7HVMhSdn8p/cOzwllPE1yivevV/SkyaBo4o0bhWWbwXEf1Py
         2NvlzolD+qMDJLeMm6Gw1enjog0toV6/TQxhotQzkYhouYR9a62TCGkt73BC3GlWdj0B
         N4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q5G4fEvx6aGYpXTyfozkr/6mvrwbDErJ8bUUTfZwUuo=;
        b=oO/qbgzHpJostBvZ5CmlSZ2VkvNbXOu2jLnuiQBomce2XBrzUanZON7P0x5YpLwNF1
         Y9KORGprM9GJXoCtwDDjZUGzjLZMykN/k5WJMaMBDZK+1SvVM1+Wu2J1STLBZUW8hjp9
         FcjuFOkefnRBA8bsHM5n/bVyQhaPJ08Qz0v79weZuLDAGAcd8ROl1+w29mM1TPK+bHz3
         B1UHR0J45PGhqZxwnmALrjmFf7BBygUXiOSsUGqnhmWyKIsdCv1KCf77Qmnkl64bJg6n
         yocicBJ5PnWFvUKb3tt+HZHLnLUy5dxX7IyCu+xfP56o+Mpq6MfgIV1tJSWozimJ1/HJ
         HAdQ==
X-Gm-Message-State: APjAAAWmODEBCwGSiOHjFiENRcT4ZVWPC/0DveyPoENa8KAIjlA6Yqvv
        wdstar4lzpPTsOPGRkLPMzW38F+X
X-Google-Smtp-Source: APXvYqyZargK9Ghlp4L9eMY7QWrejEhtx+WmCdTFrwamSH2Jv7FsQFOAdSiPLa7ObZtT0rBkbs1eIg==
X-Received: by 2002:a05:6830:1619:: with SMTP id g25mr26962621otr.238.1570550617748;
        Tue, 08 Oct 2019 09:03:37 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id n186sm5791341oih.58.2019.10.08.09.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 09:03:37 -0700 (PDT)
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
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <864267ec-9158-940d-6e0e-db84a395888e@gmail.com>
Date:   Tue, 8 Oct 2019 10:53:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6530a6b06176790c5a6949d6ffccf37b506975bd.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 10/8/19 10:52 AM, Johannes Berg wrote:
> Hi,
> 
>>> You could have two interfaces, one which is scanning right now, right?
>>> And then theoretically you don't care about the other one - it *should*
>>> be OK to remove/re-add (with new MAC address) the one that *isn't*
>>> scanning, right?
>>
>> Actually, I don't think you can?  Unless I'm missing something?  All the
>> scan state is stored on struct ieee80211_local, so if that struct is
>> allocated per phy as you point out below, then what you suggest is
>> currently not possible?
> 
> ?
> 
> The scan_req struct contains a reference to which interface is scanning,
> so it should very well be possible to have
> 
> phy0:
>   wlan0: IFF_UP & scanning
>   wlan1: IFF_UP & change MAC address all the time
> 
> just like it's possible to change the MAC address when wlan1 *isn't*
> IFF_UP even if wlan0 is scanning, right?
> 

Indeed.  But that is not what you were suggesting earlier with just 
checking local->scanning.  So if scan_req contains a wdev, then yes it 
should be possible to compare the scan_req->wdev to the interface being 
changed.

>>> But we don't have that granularity here for anything - you're just
>>> checking "sdata->local->something", and by going from sdata to local
>>> you've now checked the whole NIC, not just a single interface on that
>>> NIC.
>>
>> Right.  But that seems to be a limitation of mac80211 actually.  We
>> can't run two scans concurrently on different interfaces.  This is
>> rather unintuitive given that scan requests require an ifindex/wdev.
>>
>> Can this be changed / fixed in mac80211 actually?  I would expect that
>> if a card supports p2p and station simultaneously, then it can scan / go
>> offchannel on two interfaces simultaneously? Or not?  What can iwlwifi
>> do for example?
> 
> No, this typically cannot be fixed, and it doesn't really make sense.
> The NIC cannot possibly do two scans at a time since it has only a
> single radio resource :-)

So why is the scan request not per phy then?  And should mac address 
even affect the ongoing scan?  Can we simply change it with the scan 
ongoing?

> 
>> Given the above, I'm not sure I see anything wrong?  The switch/case can
>> probably be gotten rid of, but it actually makes things clear that only
>> station/p2p_device and adhoc are handled specially.
> 
> I just don't think they *should* be handled specially.
> 

Fair enough.

> Given your code now, you can have
> 
> phy0:
>   wlan0: STATION, IFF_UP & something is doing remain-on-channel
>   wlan1: STATION, IFF_UP
> 
> --> cannot change wlan1 MAC address
> 
> phy0:
>   wlan0: STATION, IFF_UP & something is doing remain-on-channel
> 
> wlan1: AP, IFF_UP
> 
> --> *can* change wlan1 MAC address
> 
> This doesn't really make much sense?
> 

Agreed.

Regards,
-Denis
