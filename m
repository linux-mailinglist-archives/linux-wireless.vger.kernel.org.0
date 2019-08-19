Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9D794F77
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 22:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfHSU6U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 16:58:20 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:46240 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfHSU6U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 16:58:20 -0400
Received: by mail-ot1-f52.google.com with SMTP id z17so2983817otk.13
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2019 13:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hxPql9sb19a8QE3QCF0HOaJAx0zXs17fQuUoIj0wpO8=;
        b=ipKFTBt9N5CkQsg295S/7Jz0DcwbrCjj2PU61SVSP0ORFjPwmn1sRdEocSMMmxHClB
         JLm0mSdBdoH2Tzt73PpM2sMW0xHsEkGLzJ1Z0ktwNgW2NckRjJt1GIrMyeJcORUoilpZ
         ZXRqrIWiAEM/jmLDB0ivWSLt0ICzQBHcvPqocMwkmm1K7GAPGuqvl9fLioaLA9OnBNPn
         nvhYphCcOJFOjcBN+nzTmiS146BE0Gn4dHcgOUtG4n9vNkVc2Kb+l01iN186EjqC0T6i
         1nBT68H01r/QYJ6U5WXYP4XFplN4XWmWF6Tj+4kx+bHRRGtnE1P3qIKFHc8DAaIto2dF
         h6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hxPql9sb19a8QE3QCF0HOaJAx0zXs17fQuUoIj0wpO8=;
        b=Ha3+/K41fwvbvrqpdgEGq2ujYMu8Aw+Jb4XMp10GQutSMYtJVpx31zDA1p14e40Md0
         gk5w0xI/uZAxR6o5fOPE/mKBhV523bm7lMgDDWmTWGfT2Wyv26zDVY4KDoTKu4cJs92/
         P0Zf/N+58udiXgBgNeaGYaPmQ4EDlqa+bwHctPgSoB5exHhwt8+ke0WrtQ1wZ0q76Wku
         lG40JAGbrztNh+ojhkc/pqfNTMZSU8pKH0enrISnMEvjvt1HPtGPlGw5UY8vVCI5E8i2
         GzIJQtdv3YCyUe5UtAgA+2W7lgPJe6JjUkuiBr/57bHx/ePvsTM6yX/tBoVkxfOg1VlB
         24EA==
X-Gm-Message-State: APjAAAWncMpCquwte+mwr28Qj58+C7s/jPdhUSL4uaqulif4xl/5GZc5
        07hX1vp7CbOQ/tK1v0E8c9clReV4
X-Google-Smtp-Source: APXvYqxVEHaAx344nFeiFcqk1UKIwkSdUvEXeQq62KDSVkWA3Dv3eOnXelnLHSne/r0OAekZ6gW5ow==
X-Received: by 2002:a9d:7a94:: with SMTP id l20mr20268006otn.66.1566248298813;
        Mon, 19 Aug 2019 13:58:18 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id k6sm5702823otp.57.2019.08.19.13.58.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 13:58:18 -0700 (PDT)
Subject: Re: [RFC 0/1] Allow MAC change on up interface
To:     Johannes Berg <johannes@sipsolutions.net>,
        James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
References: <20190815185702.30937-1-prestwoj@gmail.com>
 <645af7dad899e8eb186b3fee0f8a8a151a408557.camel@sipsolutions.net>
 <394092a2f20697c9b055166a8254a5ef888551a5.camel@gmail.com>
 <4848c3a9d0b330fab4442436244387a2c127fa03.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <1d975fec-a480-f40b-ff98-90d0e4852758@gmail.com>
Date:   Mon, 19 Aug 2019 15:58:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4848c3a9d0b330fab4442436244387a2c127fa03.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

> TBH, I'm not really sure I see any point in this to start with, many
> devices will give the address to the firmware when the interface is
> brought up (even iwlwifi does - I'm not sure we'd want to take your
> patch for iwlwifi even if that works today, nothing says the firmware
> might not change its mind on that), and so it's quite likely only going
> to be supported in few devices.

Hmm... I sense a pattern of you not seeing a point in doing many 
things... Do you actually use the stuff you maintain?

> 
> You've also not really explained what exactly is troubling you with
> changing the MAC address, you just mentioned some sort of "race
> condition"?

Well, one possible use case might be, oh something like this:

https://source.android.com/devices/tech/connect/wifi-mac-randomization

> 
> Now, one thing I can imagine would be that you'd want to optimize
> 
>   * ifdown
>     - remove iface from fw/hw
>     - stop fw/hw
>   * change MAC
>   * ifup
>     - start fw/hw
>     - add iface to fw/hw
> 
> to just
> 
>   * ifdown
>     - remove iface from fw/hw
>   * change MAC
>   * ifup
>     - add iface to fw/hw
> 

That would be a part of it...

> i.e. not restart the firmware (which takes time) for all this, but that
> seems much easier to solve by e.g. having a combined operation for all
> of this that gets handled in mac80211, or more generally by having a
> "please keep the firmware running" token that you can hold while you do
> the operation?

And also maybe a bunch of other optimizations like not flushing scan 
results?

> 
> Your changes are also a bit strange - you modified the "connect" path
> and iwlwifi, but the connect path is not usually (other than with iw or
> even iwconfig) taken for iwlwifi? And if you modify auth/assoc paths,
> you get into even weirder problems - what if you use different addresses
> for auth and assoc? What if the assoc (or even connect) really was a
> *re*assoc, and thus must have the same MAC address? To me, the whole
> thing seems like more of a problem than a solution.
> 

Okay, so there are some obstacles.  But can you get over the whole 
"Don't hold it like this" part and actually offer up something constructive?

Regards,
-Denis
