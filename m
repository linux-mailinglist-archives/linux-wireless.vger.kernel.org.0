Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63C2076B78
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 16:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfGZOXI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 10:23:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45419 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfGZOXI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 10:23:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id x19so47523394eda.12
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jul 2019 07:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4tlpTADdY2fSxbXVBrVqoDJcw+VkjOYmmKX60sK+wlM=;
        b=KZuiMxVvu63gEskXS3jVd9ZUMB5LyFQuNV0IiTEN16rpvhTQWiStTHEIv9DamzmJ7W
         /Jw9GMmQhN+1LzXMvID3Y7uIFJIbNkEWi1Tp0NW6dIIg16i/xFfSl9ZE80cFcz3VL8K+
         gHszDPCDo2VaUm/xeCv0Db6vbs7X3RWIhVVqMPkgTxWFI54knuHfxeOxbxUtq84tefE3
         Bi4pVzDXLFduLcCfFqaY/ER/1MXqCHowQrcQveC+m8MNboRb5aa+aKZN4xglGSpOmym7
         GW/MBk6+6ju1atyPV9AP6Da1x43/H7Ei4ZzpGyez8HseX2uKnjK7lLZnmOOq/Jds128G
         9bzQ==
X-Gm-Message-State: APjAAAVj9yOaGkhVzZjWnKATZeFdL1F/ty4VMW1PWwJQpJuUlAyncqrp
        6TwBVSCDxlltcuV6x+Dlc2TrzMRRzn0=
X-Google-Smtp-Source: APXvYqzZQaPbH8vp59RwX7yJdsGdpkV2yMt2qvDfhJ+2PXjF+A0XoMWgJUg4zLygFYg+8/KiRBWGbA==
X-Received: by 2002:a17:906:2557:: with SMTP id j23mr72164151ejb.228.1564150986404;
        Fri, 26 Jul 2019 07:23:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id t2sm14370497eda.95.2019.07.26.07.23.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 07:23:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 900991800C5; Fri, 26 Jul 2019 16:23:04 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mac80211: reject zero MAC address in add station
In-Reply-To: <218afd33eda4410472c2a99624f81908cf535cb4.camel@sipsolutions.net>
References: <1563959770-21570-1-git-send-email-periyasa@codeaurora.org> <0cc7d0c578b60730e77ecd03e2df240dd1b393a0.camel@sipsolutions.net> <fd6e7a7e0746b861bbbd660bf54cc675@codeaurora.org> <218afd33eda4410472c2a99624f81908cf535cb4.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 26 Jul 2019 16:23:04 +0200
Message-ID: <87imroyiwn.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Fri, 2019-07-26 at 19:36 +0530, Karthikeyan Periyasamy wrote:
>> > > Don't allow using a zero MAC address as the station
>> > > MAC address. so validated the MAC address using
>> > > is_valid_ether_addr.
>> > 
>> > Theoretically, all zeroes might have been a valid address at some 
>> > point.
>> > I see no reason not to reject it, but I'd like to know why you ended up
>> > with this now??
>> > 
>> 
>> Its a Wireless fuzz testing tool (codenomicon) which sends out different 
>> types of frames to the AP. It actually tampers legitimate wireless 
>> frames (Probe, Auth, Assoc, Data etc..) and will send to the AP. I 
>> thought allowing a zero MAC address station is not a valid. so validated 
>> the given MAC address. Just for curious, which case all zero address is 
>> a valid MAC.
>
> Well, it isn't really, but the OUI 00:00:00 *is* in fact assigned (or
> was), and theoretically the vendor could assign it to a device.

Heh, now that we allow routing the 0.0.0.0/8 subnet, this means that the
following could be a perfectly sensible thing to do:

'ip neigh add 0.0.0.1/8 lladdr 00:00:00:00:00:01 dev wlan0'

One bit per address per network layer ought to be enough for everyone,
right? ;)

-Toke
