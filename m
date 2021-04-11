Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A9B35B6B7
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 21:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbhDKTSA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 15:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbhDKTR7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 15:17:59 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A14C061574
        for <linux-wireless@vger.kernel.org>; Sun, 11 Apr 2021 12:17:43 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id i20-20020a4a8d940000b02901bc71746525so2584070ook.2
        for <linux-wireless@vger.kernel.org>; Sun, 11 Apr 2021 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ujtwZum6t/B7+ADOEeY3bpFOQO96Qy+Pp7zIv3gRRGw=;
        b=PyF/01wjlLtuYEQV/F6ix5BQeXUPoCWSRvfNVGM/+djYQ7rz+Kp/hX7hkPX0lp+uKG
         RHtFOWFbARGyPWeYPY7KXE8ocntXhcxuccvHnOygOcYNCcs+RSlM02zgqMEQyhQ7IuYP
         JVddGdgbGl+ni/f7/SJ0W82wNLowUbAoOjebSYSENeIvWi7uZH4wxLUifx3pY+Gjfzmq
         d6egIvih2ZLvwO7wAI5SrvsDBgXaePUF17m4///uttgw2seRsGJxa5PI05sae/JPnEZt
         e1NFCFA8d4PUcvNGTlvhh2U26jZEDqQiv5zAwkHwbLz++twAB8uZM2Wl0Pl2uPNiG9tJ
         spsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ujtwZum6t/B7+ADOEeY3bpFOQO96Qy+Pp7zIv3gRRGw=;
        b=WttwiuvAbBG3BHxK3EI6vQo2DHfGh1VGdd0goQRtWZRPdGE3ft2bQJNkEhDqWP1byM
         1YruN0kpFNpt3oDSPHBIwOgcHbSnU8Qyy8ZmsUpiNNxXqrwXqYDthTIQkQSNtUDXfhVl
         Wiy2jQmmLOos/rmLIyzt1+O+lnz++eL9Q7SDnpnZb1xbgi4m6InEWpV2Kt+Ag4j9pnPR
         Nm6lIKoVYGzfLyHzM0HPMxUu9shQks7Kps9cFNJ3Uv6jbomhb1PkgQ4qW8QBunW9mfpH
         drynGIJpfUB+apyHHUCqGGk7crJMtR9T3k36mh8G+8R/ZE0sXrcmnt0nhzWlcugGE9PU
         sa8g==
X-Gm-Message-State: AOAM533dxS4TRrFWiWZoOOn0LCSiDWY/tXnUDkeQ+pCnl+QKOQvKTt2W
        LBVEnccOxRf9m2qP48vA2vLIApfRpOQ=
X-Google-Smtp-Source: ABdhPJyy0aJtqDAI/TuKzdAinARn+p52e5sqVdtXmr/bU7B1yVrASQGgjOvamt4zmlwzXL0AFO01+g==
X-Received: by 2002:a4a:b389:: with SMTP id p9mr20050575ooo.71.1618168662092;
        Sun, 11 Apr 2021 12:17:42 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id o6sm2217515otj.81.2021.04.11.12.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Apr 2021 12:17:41 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Memory leak in ieee80211_rx_napi()
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Pkshih <pkshih@realtek.com>
References: <ad9bee4f-ef24-1fe0-5e63-e2e840ac0449@lwfinger.net>
 <82a7c6c9bcbe923906276e8aa26a9a783598a0d7.camel@sipsolutions.net>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <32687519-1c0e-1e6c-dbc3-1e9fd027fc8a@lwfinger.net>
Date:   Sun, 11 Apr 2021 14:17:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
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

Hi Johannes,

There were two bugs in rtw88. The first, suggested by PK, was that the sequence 
between start/stop of NAPI and the enable/disable of interrupts were reversed. 
The second bug was in NAPI polling as you suggested. The poll routine was 
calling napi_schedule() rather than napi_reschedule().

With these two changes, my RTL8822CE handled 12 hours of flood ping with my 
router without leaking a single buffer.

Thanks for your help,

Larry
