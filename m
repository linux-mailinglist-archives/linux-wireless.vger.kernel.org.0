Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E21AE66AFC
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 12:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfGLKk6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 06:40:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35250 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfGLKk6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 06:40:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so9474472wrm.2
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jul 2019 03:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DGpIfdSf9fCzn18KxW6W4HSwsVhHteMT5Lklieujtm0=;
        b=O9iaSNIInxFUfC6sjvL1GNZ1/9oYlIzbWVEzIarcOZk/zO7Y6zH1mwxJT5aZ2unymM
         c0Hr6NJsJF9c9TFDL6Ck9t0BFuQl2UlEYdwkpf8t8RR7bMKyUq+Lhh7/6g6RURvG+NiX
         UE0Mutwwj9ZboYYiL8tg90t1ChcCZhgsBU34Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DGpIfdSf9fCzn18KxW6W4HSwsVhHteMT5Lklieujtm0=;
        b=UdBy4xeCpMLCG1BgQQEhWFoG9okzmjvr949qDC+b5IVQCC05dru83gqKtF9obFx+ai
         xvzooI9i0mC6kyRrr2YpGtzlOm+4Z2smE4cvlk7IZl2WA/tETGE1wCYHGOjbMzKx2p28
         M+kwN1cALLPdN1fJYeA17IpmTDyPU9jKCoaHT7STak5ebPWd8tbNncapnW8XTO5bXWrH
         vn5AFMLYJPxGeIgchn8GcWkzLVuw9X6fSszaMRXhjNBR/aj3dNEIIU4n74B79mxdluML
         7xLlYc0HGz3Ag3DAlST6drGroZ5wWeeOnR1Q/6qayf4cadU5AgPRnVaShqCyMf9l0Hjy
         cAlw==
X-Gm-Message-State: APjAAAWn/9mTdMU+w7il8qv41x+cYTypk/4pQ1siWhC7N2oTucr7epy6
        2gzqkIr1zJQ8Oa52K6CTKKpGn/0eMgX6yA==
X-Google-Smtp-Source: APXvYqyjKGGtm9wy1HDOMR6mnV12bTXjq17gt6aZceP8EwVCSJvVcUioV3RD7nKHFJ0siUnn4u6ylQ==
X-Received: by 2002:adf:f286:: with SMTP id k6mr766280wro.320.1562928055306;
        Fri, 12 Jul 2019 03:40:55 -0700 (PDT)
Received: from [10.176.68.244] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id s63sm7739588wme.17.2019.07.12.03.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 03:40:54 -0700 (PDT)
Subject: Re: [RFC 0/8] nl80211: add 6GHz band support
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Jouni Malinen <j@w1.fi>,
        Tova Mussai <tova.mussai@intel.com>
References: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
 <df53f969297fea1f3c8101cd2c1571a957985d2a.camel@sipsolutions.net>
 <16aeb2310e8.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <9ba78df6-18a3-5c1c-6c57-3fa71531b460@broadcom.com>
 <48a43287e65e1d24082dea2cc32ca14998acb8d1.camel@sipsolutions.net>
 <8ca6ef2e-b41b-da40-b29a-77666d440495@broadcom.com>
 <a6e317539fbd53ad5e2fd62ce3544260a3f74e77.camel@sipsolutions.net>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <d22d5159-60d3-5926-5b3f-bdc3ff07af82@broadcom.com>
Date:   Fri, 12 Jul 2019 12:40:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a6e317539fbd53ad5e2fd62ce3544260a3f74e77.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/12/2019 11:30 AM, Johannes Berg wrote:
> On Thu, 2019-07-11 at 13:30 +0200, Arend Van Spriel wrote:
>>
>> I assume user-space does not necessarily need the band, but hostapd
>> needs to be aware that it is operating in 6GHz to setup the correct
>> (information) elements in the beacon. Obviously the operating classes
>> can be used there, but I don't think there is any issue with nl80211
>> exposing a 6G band.
> 
> Yeah, I don't really see any *issue* with it, in many places we don't
> really even care about the band enum.
> 
> In a sense, *most* of the places that consider the channel don't
> actually care about the band, the channel num/freq conversion helpers
> are a bit of the odd ones out in that regard. In the chandef, for
> example, we don't have the band.
> 
> Really the original use for the band enum was mostly around the
> advertising if capabilities. As you pointed out, 6GHz actually *does*
> have different capabilities, though it's not clear to me what exactly
> the behaviour differences are. Scanning is a big area, of course.

For starters a 6G STA has to add "HE extended capabilities" element. 
This contains capabilities that are taken from HT/VHT. Reason being that 
there is following requirement (clause 26.17.2.1):

"""
A 6 GHz HE STA shall not transmit an HT Capabilities element, VHT 
Capabilities element, HT Operation
element, VHT Operation element or an HE Operation element that contains 
a VHT Operation Information
field.
"""

The inclusion of the "HE extended capabilities" element is determined by 
the dot116GOptionImplemented option. (band[6G] != NULL) provides that 
condition although there are other ways to solve that I guess :-p
Come to think of it. Does mac80211 need that. Guess IEs are provided by 
user-space, right?

> When we discussed splitting up or not the band, I think what we mostly
> considered was the channel num/freq conversion helpers, and Jouni
> pointed out that really what we should be doing for those isn't to
> consider the band but the operating class instead.
> 
> So I'm starting to think that perhaps the decision we came to in Prague
> was a little hasty, without considering the full impact?
> 
> I do completely agree that we should have knowledge about the operating
> classes in the kernel eventually, and probably we will need to have it
> here if we need to parse reduced neighbor reports etc. OTOH, we have
> already ieee80211_operating_class_to_band(), and that seems sufficient,
> though probably we should consider a combined helper that takes
> opclass/chan# instead of having to call two functions?
> 
> However, from a feature advertisement point of view, we might very well
> consider 6 GHz to be a separate nl80211 band, in particular if there
> *are* indeed differences around what rates are permitted? Which is
> really the only place where we care. Or maybe, thinking about this more,
> if there could be devices that have different capabilities in 6 GHz than
> in 5 GHz, in the sense of HT/VHT/HE capabilities?

Regarding rates the answer seem to be in clause 26.17.2.1 as well:

"""
A STA shall not transmit an HT PPDU in the 6 GHz band. A STA shall not 
transmit a VHT PPDU in the
6 GHz band. A STA shall not transmit a DSSS, HR/DSSS, or ERP-OFDM PPDU 
in the 6 GHz band.
"""

I may be wrong but that seems to say only HE rates are allowed.

> Can somebody do the legwork and really go look at the spec to figure out
> what the differences are? I'm not even sure now legacy rates are
> permitted or not - you (Arend) seemed to imply they're not, and Igor
> said only for beacons ...

Regarding beacons the rate requirement is in clause 26.15.6, which 
basically states that beacons have to be transmitted with HE rate where 
NSS equals 1.

> I tend to think that this would be the deciding factor. For example, if
> we do end up sending a probe request on 6 GHz, would we include a
> different supported rates element than on 5 GHz? Or might there even be
> devices that have different PHY paths and thus possibly different
> capabilities for 5 and 6 GHz, essentially requiring a new place (a new
> band enumerator) to store those capabilities, so we don't have to try to
> figure out the difference in code later?
> 
> I'm almost tempted to say that given all these possibilities we should
> in fact add a new value to the band enum, worst case we just duplicate
> some data, but if there do end up being differences we can handle them
> much more gracefully than if we put everything into 5 GHz.
> 
> Jouni, what do you think?

Regards,
Arend
