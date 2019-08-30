Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB433A3CAF
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 18:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfH3QzR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 12:55:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36526 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfH3QzR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 12:55:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id k18so7586889otr.3
        for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2019 09:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hOWPt9D3wtZLYl74Bh3Q8GcQxuAnKB6MXNeOglOBCSo=;
        b=AG6yQwrLQKbqxCSLEj3F9Am3Mecy25wgYeO+RjDTBQ1Hg4ejIi5bVNcZqEIkpHAW7L
         1RUttkEFuItN4iFIDED2Ow/4ejzNPbBlQLY53j0PU3roTgTUdRijEtE+f5EtYZh1kQif
         SfZWblKTZoAF62FhCe7WVfN2n1HSeV7FlzGLW+RcqlnH3QuDqBkRp4M5c4ArZDBNIX/c
         CPjrfZT7V74YSQBJu5U2SccP0+mUhGFy9+LrLVFUHK7pe0WqpASe+KDqHk5ybI/B+uMF
         AYNN4ZSq3lE/XgSMaPjDEn3UIQB9B1F58BBkWTUzXoZvWnNAoyO63J7pcieustHF6Z0X
         ioGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hOWPt9D3wtZLYl74Bh3Q8GcQxuAnKB6MXNeOglOBCSo=;
        b=Pr9TBmaqWANWDttzoHCJ/GkO1jAgrN+REr9Sn+XnUpz/8FwFvwYLm3XcrMeGWaS0M9
         6mjjY4xEs5Rgna3Y+J1Gts3Tw3O25X6ZULp35u04e6Q/eDEpn1kWGYpvW3kiPhXntjDK
         /ehHd3uLHojEstMbodLufRopwCB7n4I7bNdMorFkW5QzIF427nG3bSIdJ3YxvX7weTas
         9gH1tt2yB3EE1q5/fzOxaGQ1JgMPAzOdTwTmh2r5WAGNyUMkVHU8duMmF/iGtmUq3+vI
         awPifuDzUmZYL1wusEpyqg/JK4oVRKfYPpcKwTHP26hgRjwzKgjRAc4b56cZ4zKEBwry
         3oCA==
X-Gm-Message-State: APjAAAXJG0VxRcxE/Uy9cauAWRLeOfkKiJ+5vQ2jjnpmle+kjLdM4yGF
        FNeuiGfrQ7lnVLfhy+9r/yukNB8d
X-Google-Smtp-Source: APXvYqzs/EEFzfODXa2CaTIRqOjXJSSwxPy6e2SYpVR9jZaW9FKj6CA9kbr01q2f8w1H0xNlg6EQ/g==
X-Received: by 2002:a05:6830:1b65:: with SMTP id d5mr13280647ote.278.1567184116053;
        Fri, 30 Aug 2019 09:55:16 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id z85sm1161811oia.42.2019.08.30.09.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 09:55:15 -0700 (PDT)
Subject: Re: [PATCH 1/2] nl80211: Add NL80211_EXT_FEATURE_LIVE_IFTYPE_CHANGE
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20190826162637.7535-1-denkenz@gmail.com>
 <f5986ccd8ecdcc08d5c3e0d65f8bddef8b0af021.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <73e78b3e-f36a-aa29-a818-e0e1f0598b2f@gmail.com>
Date:   Fri, 30 Aug 2019 11:55:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f5986ccd8ecdcc08d5c3e0d65f8bddef8b0af021.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 8/30/19 5:19 AM, Johannes Berg wrote:
> On Mon, 2019-08-26 at 11:26 -0500, Denis Kenzior wrote:
>>
>> + *	Prior to Kernel 5.4, userspace applications should implement the
>> + *	following behavior:
> 
> I'm not sure mentioning the kernel version here does us any good? I
> mean, you really need to implement that behaviour regardless of kernel
> version, if NL80211_EXT_FEATURE_LIVE_IFTYPE_CHANGE isn't set.
> 

Agreed.  I guess I just view nl80211.h as a sort of combination between 
a uapi file and an actual manpage.  And manpages do mention which kernel 
version a certain feature/flag/whatever was added.  Such info can be 
useful in many ways, e.g. figuring out which kernel version might be 
required for a certain piece of hardware, etc.

Another point where this might be useful is if the kernel starts 
enforcing certain behavior that it didn't before.  E.g. I mentioned this 
in the purge thread that a lot of mode change failure cases could be 
caught if the kernel checked this flag prior to doing anything.

I really leave this up to you if this is something you think is a good 
idea or not.

>> + * @NL80211_EXT_FEATURE_LIVE_IFTYPE_CHANGE: This device supports switching
>> + * 	the IFTYPE of an interface without having to bring the device DOWN
>> + * 	first via RTNL.  Exact semantics of this feature is driver
>> + * 	implementation dependent.
> 
> That's not really nice.

Sorry.  This came from some doc changes I have pending.  I think I wrote 
this after looking at some fullmac drivers and how they handle mode 
changes and the wording reflects the exasperation I felt at the time.

Do you want to suggest some alternate wording?  I think it is worth it 
to have some fair warning in the docs stating that prior to version so 
and so the semantics are completely driver dependent.

> 
>> For mac80211, the following restrictions
>> + * 	apply:
>> + * 		- Only devices currently in IFTYPE AP, P2P_GO, P2P_CLIENT,
>> + * 		  STATION, ADHOC and OCB can be switched.
>> + * 		- The target IFTYPE must be one of: AP, P2P_GO, P2P_CLIENT,
>> + * 		  STATION, ADHOC or OCB.
>> + * 	Other drivers are expected to follow similar restrictions.
> 
> Maybe we should instead have a "bitmask of interface types that can be
> switched while live" or something like that?
> 

I'm fine with that, but this would only apply to newer kernels, no? 
Don't we at least want to attempt to state what the rules are for older 
ones?

An alternative might be to simply state what the restrictions are and 
just enforce those at the cfg80211 level.

Regards,
-Denis
