Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D45C694FA5
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 23:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfHSVP2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 17:15:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42170 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbfHSVP2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 17:15:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id i30so1908713pfk.9
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2019 14:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OzHkxoZ9WMRl6BFgxy9w5C3HMi2V/wnG5Z2iZdgkePU=;
        b=g5ErnOe+SXbWe2q0nosSQKlksYnQHwxr+KYjRzN3IkSOtDeqHailZwlQTxYynCgti6
         cdflylVL/Wso998UkoaZycoeK8ndPEu+n/MV4YIDza8ZDhUfBH720CILv5ui3jdsY6RW
         b4tm2cx7W4qKffQwXy1clV6XydDMXu/aTKvIAQ6hw4jMPD9NX3ANVaGVM65/jK3y1lJJ
         BhgVRbpKq0fnCrx0x1b2ja+Esnyvq0UE6ZKbFFvS8QNCBoDmdmKy4ihVA1pmmAKgs1UH
         qckS5C4b68iYCwLzLobcDxpOUZ/uJgoJlsyhtnzZyfztmVk3sSWzj62OkB1KRccQxOmO
         mIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OzHkxoZ9WMRl6BFgxy9w5C3HMi2V/wnG5Z2iZdgkePU=;
        b=nUvXYKREFl5QtXfqM8WeKceG4j5vN4kHi2l3LedLmaakcLEy0lUkcUkMWOAPfD1hO5
         kfVnDiJLG0MKSAoz8M7zSUKeV1L0Yfjeq5vLJqQhenR2ImfKFA6mfvSC4I2tcvrc7rhD
         9WS9tcfPluXND4/cw5XzQ2/mJgbwB2NW7ARa6B2JTt4YQ1cN3qBg4zXr9HX2xpZI8lfb
         b63clstZnPetXLZOFfTVIwYrXDjFasGBvsXUArhNAYEYfrRyn+7uKOaAwktksiyY/UgR
         iC6MJ2L6oOIWo3C6Na8wZOzbpunJScac74uwXND6inY4l9LmDTPIfG7QO9suHwkcKMio
         7//A==
X-Gm-Message-State: APjAAAUUL+Vy0RHr3iwV9LG1aHbdbmsSzsKhdZWk0+rd4dr8qYyuJM1r
        S+30ZBJvWNsYVCMilozIinPhdW5MiZo=
X-Google-Smtp-Source: APXvYqzxTPVhp/f54VyWOhCr1pAE7MGkMpQrE624cOOvTrHwb7ijKkH1kBmNoyI8anuhiPFuI6Q/4Q==
X-Received: by 2002:a17:90a:9f4b:: with SMTP id q11mr22492300pjv.105.1566249327673;
        Mon, 19 Aug 2019 14:15:27 -0700 (PDT)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.googlemail.com with ESMTPSA id m9sm34594481pgr.24.2019.08.19.14.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 14:15:26 -0700 (PDT)
Message-ID: <c6b719d6279211bbf52443f327884d96ef63f2b2.camel@gmail.com>
Subject: Re: [RFC 0/1] Allow MAC change on up interface
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Mon, 19 Aug 2019 14:14:03 -0700
In-Reply-To: <4848c3a9d0b330fab4442436244387a2c127fa03.camel@sipsolutions.net>
References: <20190815185702.30937-1-prestwoj@gmail.com>
         (sfid-20190815_205833_978900_86B1E73D) <645af7dad899e8eb186b3fee0f8a8a151a408557.camel@sipsolutions.net>
         <394092a2f20697c9b055166a8254a5ef888551a5.camel@gmail.com>
         (sfid-20190819_175627_344053_E33FB9B0) <4848c3a9d0b330fab4442436244387a2c127fa03.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

Without reiterating what Denis said:

<snip>

> I don't, short of
> 
> 1) don't do that then
> 2) extend the network stack to have
> IFF_LIVE_BUT_NO_CARRIER_ADDR_CHANGE
>    or something like that

So you mean 2 is my only option... ;) I am fine with this.

> 
> TBH, I'm not really sure I see any point in this to start with, many
> devices will give the address to the firmware when the interface is
> brought up (even iwlwifi does - I'm not sure we'd want to take your
> patch for iwlwifi even if that works today, nothing says the firmware
> might not change its mind on that), and so it's quite likely only
> going
> to be supported in few devices.

The iwlwifi change was just an example. It ultimately would be up to
the maintainers of each driver to support this or not. Regardless,
doing the ground work for a driver/firmware to support this is more
valuable than continuing to neglect these quirks that make use of
nl80211 difficult/racy.

> 
> You've also not really explained what exactly is troubling you with
> changing the MAC address, you just mentioned some sort of "race
> condition"?

In order to change the MAC on a per-AP/SSID is to: ifdown, change MAC,
ifup via RTNL. The problem is that ifdown generates an RTNL link down
event and there is no way of knowing how this event was generated (by
you, hot-unplug, or some other issue in kernel?). Handling this without
a race is simply not possible. You sort of just have to pray none of
this happens (and its unlikely but it *could* happen).

Besides efficiency another obvious reason for this change is simply
ease of use. If the hardware supports doing this then why should
userspace have to jump through hoops to accomplish it?

> 
> Now, one thing I can imagine would be that you'd want to optimize
> 
>  * ifdown
>    - remove iface from fw/hw
>    - stop fw/hw
>  * change MAC
>  * ifup
>    - start fw/hw
>    - add iface to fw/hw
> to just
> 
>  * ifdown
>    - remove iface from fw/hw
>  * change MAC
>  * ifup
>    - add iface to fw/hw
> 
> i.e. not restart the firmware (which takes time) for all this, but
> that
> seems much easier to solve by e.g. having a combined operation for
> all
> of this that gets handled in mac80211, or more generally by having a
> "please keep the firmware running" token that you can hold while you
> do
> the operation?
> 
> 
> Your changes are also a bit strange - you modified the "connect" path
> and iwlwifi, but the connect path is not usually (other than with iw
> or
> even iwconfig) taken for iwlwifi? And if you modify auth/assoc paths,
> you get into even weirder problems - what if you use different
> addresses
> for auth and assoc? What if the assoc (or even connect) really was a
> *re*assoc, and thus must have the same MAC address? To me, the whole
> thing seems like more of a problem than a solution.

The connect path is just what we (IWD) use for almost all types of
connections that support it (apart from things like SAE/OWE/FT). Not
sure what you mean for "usually not taken for iwlwifi"? If you have an
iwlwifi card and you issue CMD_CONNECT thats the path it takes...

Thanks,
James

> 
> johannes
> 

