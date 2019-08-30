Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2A5A3C0F
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 18:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfH3QdB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 12:33:01 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46461 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbfH3QdB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 12:33:01 -0400
Received: by mail-ot1-f67.google.com with SMTP id z17so7446632otk.13
        for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2019 09:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=gScIWUZsqIWeQ/Jj6Me/x1jSg8AxJSb+7yOkWd1JZtI=;
        b=gziIcTeSVZY5w77wQevunRwAilLgMjgmmQVQpb94FCy7D/nWZak2Sf4rcb2DALGFmG
         zrz7w/YTCHWNI6rExn3p6HA9zK07ZkEKPBuFFHs3JtaJ+snNH45Ix3z9zt8C/UwAiUDp
         sgNspowCWuwG0a3//ZBT00GeywYAm6ATRE2yJwv2uNrwF9AYYIDbjcMBHOA23Vbt/C7b
         nMmuZOYCn1Zc38z0GXxqrW3jnPgZFPL0yK6c2kIyoE0tmU35e0cqjevC4/ZUVhmnz6iC
         bmn5u6zfAEqH30kdcr2Fpj/DGFm+Gd/fZ9Asvkd9n4+c2YPCAgPV3Vw/wi5tdDoF+FWj
         97+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gScIWUZsqIWeQ/Jj6Me/x1jSg8AxJSb+7yOkWd1JZtI=;
        b=tMjH++7pFnh9y+7OUCooMQZ9UMDaMEmO0SdKL3E2WtqA7qIPVh1U591zfELUn568QG
         NYUz77UO/EX/UpXw/Hreyfy3k2MUDVjy6TjvZ7XZsawNZ7YBHxNI3hNga+l4Cd/bPSOt
         kCeNY7VzSPPxwYWsTQwuTHpPjMCKaQ4rVjbNJnVdn18oxB0IDGkxySZK/wRPVO+n1qEk
         nzP1qELkXCBrEKAJ5ld8iVXLitnzwbMWyd8L+Jw437Kum9O4u53pAbGRX4ugqapRfvJC
         QUOUSArjBKg8nafVrZbOvrAkQ3LAVMaT/nsmrG8FdpoRctRXzI2AT7fkEoBC6B18IBF9
         CgLg==
X-Gm-Message-State: APjAAAVRmXnENUT3XNMZS38MaVWUhn35X8VR45b8NGiQiRjxcLpOuvkX
        eVPaHva4QST5+4O3llDSmuXWRTOe
X-Google-Smtp-Source: APXvYqw2/khTofMbLcCMNuI0FvbcijApkkiP3HMQkmMkRt2wxFFq36WIQ76Lq/wdupIvQXtXRQsbpQ==
X-Received: by 2002:a05:6830:144b:: with SMTP id w11mr13170183otp.185.1567182780164;
        Fri, 30 Aug 2019 09:33:00 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t18sm2067030otk.73.2019.08.30.09.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 09:32:58 -0700 (PDT)
Subject: Re: [RFCv2 1/4] nl80211: Fix broken non-split wiphy dumps
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20190816192703.12445-1-denkenz@gmail.com>
 <f7c98da178677cbb0cad3568f4ea4ab85171edd8.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <5fc07547-80fe-99ee-a83d-5fabe3c92a1b@gmail.com>
Date:   Fri, 30 Aug 2019 11:32:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f7c98da178677cbb0cad3568f4ea4ab85171edd8.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 8/30/19 4:03 AM, Johannes Berg wrote:
> On Fri, 2019-08-16 at 14:27 -0500, Denis Kenzior wrote:
>> If a (legacy) client requested a wiphy dump but did not provide the
>> NL80211_ATTR_SPLIT_WIPHY_DUMP attribute, the dump was supposed to be
>> composed of purely non-split NEW_WIPHY messages, with 1 wiphy per
>> message.  At least this was the intent after commit:
>> 3713b4e364ef ("nl80211: allow splitting wiphy information in dumps")
>>
>> However, in reality the non-split dumps were broken very shortly after.
>> Perhaps around commit:
>> fe1abafd942f ("nl80211: re-add channel width and extended capa advertising")
> 
> Fun. I guess we updated all userspace quickly enough to not actually
> have any issues there. As far as I remember, nobody ever complained, so
> I guess people just updated their userspace.
> 
> Given that it's been 6+ years, maybe we're better off just removing the
> whole non-split thing then, instead of fixing it. Seems even less likely
> now that somebody would run a 6+yo supplicant (from before its commit
> c30a4ab045ce ("nl80211: Fix mode settings with split wiphy dump")).
> 

That would be my vote, given that we're probably one of a handful of 
people in this world that understand that code path.

But...  How would we handle non-dump versions of GET_WIPHY?  To this day 
I have dhcpcd issuing fun stuff like:

< Request: Get Wiphy (0x01) len 8 [ack] 
0.374832
     Interface Index: 59 (0x0000003b)

> OTOH, this is a simple fix, would removing the non-split mode result in
> any appreciable cleanups? Perhaps not, and we'd have to insert something
> instead to reject non-split and log a warning, or whatnot.
> 

Getting rid of the legacy non-split case would simplify things.  We 
could also be a-lot smarter about how we split up the messages in order 
to utilize buffer space more efficiently.  I think you cover this in 
your other replies, but I haven't processed those yet.

Regards,
-Denis
