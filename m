Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8073A9697C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 21:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbfHTTaj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 15:30:39 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:37761 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbfHTTai (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 15:30:38 -0400
Received: by mail-ot1-f49.google.com with SMTP id f17so6144144otq.4
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2019 12:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LTwQroJaNM945xGtDUu5hmcDOKm5C/RugUMNbzlwxac=;
        b=Z+CK2U/eyIzQC67NqKtGeyjza7w9bSI7jcfGzINotmI6HQ09Q+YV/HYlb+I94HTbLu
         JovqWqTuvWoA6EuWAoeobCIVdYv5+6dtPOF+E4YXJc+s/g5y0+j2h4SrpK59yNLqLh+N
         8FhHKi59iOuZpQmK+MycHSLucMqN/v4tful9dV6TekNSZR0rQ0RMDlY9zGX3QG/BQP36
         zKfySLaF1D4A2fb0DiAs1iMEbfBPlaPqAWqmEfoSrTdUMYXZ/4/ZUadh1GFNGZKSojsn
         cOpRSgx+3HY8mgQwMvdVCkHAiFTOMu8FiVpzl1DXVLkkDBlNglkEPp75LyIgdvATNTda
         txMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LTwQroJaNM945xGtDUu5hmcDOKm5C/RugUMNbzlwxac=;
        b=ZV8CxMKQ1X8LrWkpjwTM0BtFqBxpRAf/lRsFYtfasovSCo6ENv37JPiUzTHysGg2Th
         3YVB48AW2RQWECweDgIMaKoTHLPxB7w7jKVR+0J+hFSvhf7WlVASq6i0Bj773553xbjW
         4p4xKaeUTeqMkIWeqJArnR6wlaoXGF9Cy8uHi3MezDRx5xh5CYaTIssjRGofTUKCz2u1
         i3bS5tHuTtOMIVpcsiKYokkAB7Die3hheW3jFBgRcjFxiCdHS5Mprd+nlJuv+RS0IrdD
         86Y5wBGOCSZyjboT/iXkt1HWLKVL9KBw3VQg0SCMrRILJmgJo6/yziSeJ66W3z6nnYXV
         oTqQ==
X-Gm-Message-State: APjAAAX/ofNULvZA7z2lz8MZhfAguLVk5jXqEN1BKCeptFIGDpVNYqG6
        1JfA5mglkExi8fQHBTVozY0=
X-Google-Smtp-Source: APXvYqz+DPGlE6zuaDnUC+caF+0u6su04BS3972vEXaDkcMVUKzNU55cL0r28UVUj/3ga6wNHZWTvw==
X-Received: by 2002:a05:6830:13c5:: with SMTP id e5mr24327565otq.68.1566329438224;
        Tue, 20 Aug 2019 12:30:38 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id b19sm5303690oie.34.2019.08.20.12.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 12:30:37 -0700 (PDT)
Subject: Re: [RFC 0/1] Allow MAC change on up interface
To:     Johannes Berg <johannes@sipsolutions.net>,
        James Prestwood <prestwoj@gmail.com>
References: <20190815185702.30937-1-prestwoj@gmail.com>
 <645af7dad899e8eb186b3fee0f8a8a151a408557.camel@sipsolutions.net>
 <394092a2f20697c9b055166a8254a5ef888551a5.camel@gmail.com>
 <4848c3a9d0b330fab4442436244387a2c127fa03.camel@sipsolutions.net>
 <c6b719d6279211bbf52443f327884d96ef63f2b2.camel@gmail.com>
 <6835732fcc59ba8dbbcda4abc6e17dad499a7d8d.camel@sipsolutions.net>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Dan Williams <dcbw@redhat.com>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <b115e933-a357-9904-e831-dea7df1b46b9@gmail.com>
Date:   Tue, 20 Aug 2019 14:22:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6835732fcc59ba8dbbcda4abc6e17dad499a7d8d.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

So keeping things purely technical now :)

> I thought so, but I had another thought later. It might be possible to
> set LIVE_ADDR_CHANGE, but then block it in mac80211 when the interface
> is already connected (or beaconing, or whatever, using the MAC address
> in some way - even while scanning, remain-on-channel is active, etc.)
> 

Here's what we would like to see:

- The ability for userspace to add a 'Local Mac Address to use' 
attribute on CMD_CONNECT and CMD_AUTHENTICATE.
- It doesn't seem useful to add this to CMD_ASSOCIATE at the moment, as 
for new connections you'd always go either through CMD_AUTHENTICATE, 
CMD_ASSOCIATE sequence or use CMD_CONNECT.  This should take care of 
some (most) of your objections about specifying different addresses for 
authenticate/associate.  Feel free to correct me here.
- For Fast Transitions, Re-associations, roaming, etc userspace would 
simply omit the 'Local Mac Address to use' attribute and the currently 
set address would be used.
- Optionally (and I'm thinking of tools like NM here), add the ability 
to set the mac address via RTNL while the device is UP but has no 
carrier, and things like scanning, offchannel, etc are not in progress. 
Though really I don't see how NM could guarantee this without bringing 
the device down first, so I'll let NM guys chime in to see if this is a 
good idea.
- We definitely do not want to to mess with the device state otherwise. 
E.g. no firmware downloading, powering the adapter down, etc.  That just 
takes too much time.

The goal here is to keep things as fast as possible.  The randomization 
feature is basically standard on every modern OS.  So users expect it to 
be used on every connection.  Slowing down the connection time by up to 
3 seconds just isn't acceptable.

So tell us what you would like to see.  A new 
IFF_NO_CARRIER_ADDRESS_CHANGE or whether it is possible to use 
IFF_LIVE_ADDR_CHANGE with some additional restrictions.

> I still think you'd have to bake it into the mac80211<->driver API
> somehow, because we normally "add_interface()" with the MAC address, and
> nothing says that the driver cannot ignore the MAC address from that
> point on. The fact that iwlwifi just copies it into every new MAC_CTXT
> command and the firmware actually accepts the update seems rather
> accidental and therefore fragile to rely on.
> 

Since you seem to have a clear(er?) idea here, can you elaborate or 
possibly provide the driver interface changes you want to see?

Regards,
-Denis
