Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E722935A853
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 23:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbhDIV0I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 17:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbhDIV0I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 17:26:08 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1D3C061762
        for <linux-wireless@vger.kernel.org>; Fri,  9 Apr 2021 14:25:54 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so1932934otf.12
        for <linux-wireless@vger.kernel.org>; Fri, 09 Apr 2021 14:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aNCSu2xYlKsIMXHj6gIb1amoqadpvhhoarITcQ+V4ac=;
        b=Uw2sgbpaDjcB36KLJ0VO+vSNpMt1XCz60hKyL6bAgudD/YxYnLsGf8yYzPATQnghuC
         WtyJHHS0Brruv1uHPjDyJuZ6D9fWGbB7fFiXLCs/4Zm1cIasjvgRp9QwGmqqZoJKOWB5
         jKqVqMvLwa97cNHX+auRgHtHP8P2SpCgiWUcFTNvuiF63lIaxy9VYb9/vO2NMYO0vBai
         LL79fv/N7+KPHom2Wrza5UFMMGLoTbCApeRPHWEh8H50kqBq1yxwImm3kKriUwJ+rdXs
         U7UGEdUySMaSLuMpzRU5UYZUuvx7u3jn2QcYHcSgMmYL/mw6QFZYx1+Cy4RBt//FcJay
         kZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aNCSu2xYlKsIMXHj6gIb1amoqadpvhhoarITcQ+V4ac=;
        b=UId7SOzU+SOCo2WN20zdz7xJxDlS4Wr1QtvlccuCHG0f3ym6AvugaThEWpHIogOXxi
         traup8PQpNCx512b5+Ooc5TRv/3ovDrFVOIabfu686VHM4SdbNZBnHzpmX/N9xhaVke9
         IRMbdA6v9PFRSxP/EM5W8BpIyGLbLMfRHRntUxCZkv76F3gkCLFVxA1SQYBxin9CrefG
         gblHT8Llkti6cbLYRF6ypauuPEGrhQlMbsdbGDOH7d2aKkeGkJy8LjkzSOIEVkkjMfRw
         m+AcAVPQEdNH1eIY0xaCB/7l8C1ckZpEeJicnZMOe/NrMeV8G5dM2VRLFOVhvVZ3LSuP
         f7ng==
X-Gm-Message-State: AOAM5301qkLZnZlaSRa8bYUy1GCisby+nX4TlzOviExmKGP1/SgRLkUM
        zP+fyYOQilSN858b+xR0ciKAHikeNSQ=
X-Google-Smtp-Source: ABdhPJzKzk+6C53o2ZEvp1TscUovtKn1EEa4bOUftwBwtHWd9Hv+PFm+MBUdm4zCbTOBsSuXliUE1A==
X-Received: by 2002:a05:6830:109:: with SMTP id i9mr13833106otp.47.1618003554302;
        Fri, 09 Apr 2021 14:25:54 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id u126sm280064oig.4.2021.04.09.14.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 14:25:53 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Memory leak in ieee80211_rx_napi()
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Pkshih <pkshih@realtek.com>
References: <ad9bee4f-ef24-1fe0-5e63-e2e840ac0449@lwfinger.net>
 <82a7c6c9bcbe923906276e8aa26a9a783598a0d7.camel@sipsolutions.net>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <a5bc42af-3b76-8e31-4538-e81b3a33b4f2@lwfinger.net>
Date:   Fri, 9 Apr 2021 16:25:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <82a7c6c9bcbe923906276e8aa26a9a783598a0d7.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/9/21 2:31 PM, Johannes Berg wrote:
> Hi Larry,
> 
>> What setting or lack of, would cause ieee80211_rx_napi() to leak the skb that it
>> is given? The documentation states that once this call is made, mac80211 owns
>> this buffer. Does this mean that it will also be freed?
> 
> Eventually, yes. But it might go onto a NAPI GRO list, etc. Perhaps it
> might even look like it's leaked if it's on such a list if you didn't
> implement NAPI properly as polling, but just call ieee80211_rx_napi()
> with a non-NULL napi struct pointer.
> 
> That said, of course there might be bugs in mac80211 where it actually
> leaks the skb.
> 
> How are you determining that it's being leaked?
> 
> johannes
> 

I use kmemleak. They are real leaks as they persist after the rtw drivers are 
unloaded.

The call is ieee80211_rx_napi(rtwdev->hw, NULL, new, napi); I added a test for 
napi == NULL. None failed.

Is it possible that the NULL for struct ieee80211_sta would screw it up? I see 
that most of the Intel drivers use a non-NULL argument.

Would a "Network controller [0280]: Intel Corporation Wireless 7260 [8086:08b1] 
(rev 73)" use napi? If so, iwlmvm does not leak anything. I do not have any 
other devices that use napi.

Larry



