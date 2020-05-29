Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED3F1E7C33
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 13:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgE2Lqk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 07:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgE2Lqk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 07:46:40 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27975C03E969
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2020 04:46:40 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f7so1768076ejq.6
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2020 04:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=0iVivS8i9Q+ttgxYMhIlTUf7VGPcp6pJZcCKZpFDfxE=;
        b=FJYboE6bQZ6CDu95MkZMm13fuxIYeQJM5aU/ayWAZDAvGunD87uwwL50pCeIfHTYQf
         pT6ez0T8sTb5ackNrRUrWL3SBfSPCQJjyZOWu1ccCQxulNhYy9f9JzAUOYpn4U7JMSNd
         v7TspqjOAff2MbnemxjuSZRwxjKIoPIkI3EkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=0iVivS8i9Q+ttgxYMhIlTUf7VGPcp6pJZcCKZpFDfxE=;
        b=dD61dk76sB1pgaOb9TWvP6D7bCM08AiFnDBYF0MzAzzQajB35u7eLwjG1eLso3c8F5
         eME62AEcmeMrmVmP6DKd3nlLIoZcG5g3NxbYo5yEpujMYfjvx6wgVvC414uGMwEOod9P
         FvpF2V61zZMGnZ7uRbhGiTWEhixmfKQIfqd33arym9cszp17/jRJBGULb5at/muua63B
         PEnf8T152FW/VC31GAEzMrxoH6C2ANNMeI2kdNXfctYo+YCczb+ApTDxIW9b5ja9R5Zt
         n7Xn+VM83BSvoQR2XwGH4v9l/wTPkooRCnnSPS3kK2WAuHmA2V6uDv81yoDuT+eqJ+R5
         3XUw==
X-Gm-Message-State: AOAM532dVSiKIdplUK/VyP667Gy1m3f+DuVTVVIIX6d+fovs+Ka7bcip
        XWmhkP2EiE41K+hRjl9TqdYyGEwpqUmBXzNS
X-Google-Smtp-Source: ABdhPJwj/z9MNyx/oVv5Ri7eQlAujQMOWFZ/YP/ptbHJXM0Mg2QN4EZ7CRahyHUax/yXPxBVDLMVEw==
X-Received: by 2002:a17:906:2e50:: with SMTP id r16mr7083854eji.305.1590752798783;
        Fri, 29 May 2020 04:46:38 -0700 (PDT)
Received: from [192.168.178.38] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id cf7sm6604653edb.17.2020.05.29.04.46.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 04:46:37 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless" <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Jouni Malinen <j@w1.fi>
Date:   Fri, 29 May 2020 13:46:36 +0200
Message-ID: <17260415d60.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <19c8ea7e8b0f78036cda9ecf55484755582cf6bb.camel@sipsolutions.net>
References: <1590744414-55473-1-git-send-email-arend.vanspriel@broadcom.com>
 <edf07cdd-ad15-4012-3afd-d8b961a80b69@broadcom.com>
 (sfid-20200529_114146_502376_6F982EE1)
 <19c8ea7e8b0f78036cda9ecf55484755582cf6bb.camel@sipsolutions.net>
User-Agent: AquaMail/1.24.0-1585 (build: 102400006)
Subject: Re: [PATCH V2] cfg80211: adapt to new channelization of the 6GHz band
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On May 29, 2020 11:53:30 AM Johannes Berg <johannes@sipsolutions.net> wrote:

> On Fri, 2020-05-29 at 11:41 +0200, Arend Van Spriel wrote:
>> It also fixes a missing MHZ_TO_KHZ() macro for 6GHz channels while at it.
>
> Yeah, I actually saw and fixed that earlier, but whatever. I can fix up
> any issues.
>
>> case NL80211_BAND_6GHZ:
>> - /* see 802.11ax D4.1 27.3.22.2 */
>> + /* see 802.11ax D6.1 27.3.23.2 */
>> + if (chan == 2)
>> + return MHZ_TO_KHZ(5935);
>> if (chan <= 253)
>> - return 5940 + chan * 5;
>> + return MHZ_TO_KHZ(5950 + chan * 5);
>
> So this can return 5950+5*253 == 7215
>
>> @@ -119,11 +121,14 @@ int ieee80211_freq_khz_to_channel(u32 freq)
>
>> else if (freq <= 45000) /* DMG band lower limit */
>> - /* see 802.11ax D4.1 27.3.22.2 */
>> - return (freq - 5940) / 5;
>> + /* see 802.11ax D6.1 27.3.23.2 */
>> + return (freq - 5950) / 5;
>
> and here you have no real upper bound, which is fine
>
>> @@ -1662,6 +1667,40 @@ bool ieee80211_chandef_to_operating_class(struct
>
>> + /* 6GHz, channels 1..233 */
>> + if (freq == 5935) {
>> + if (chandef->width != NL80211_CHAN_WIDTH_20)
>> + return false;
>> +
>> + *op_class = 136;
>> + return true;
>> + } else if (freq > 5935 && freq <= 7115) {
>
> but here both the comment and the code say 7115? Should that be 1..253
> and 7215, respectively?
>
> I can fix, no need to resend.

The 802.11 spec specifies the 1..253 range. The FCC has proposed the U-NII 
bands 5 to 8 for the 6G band. U-NII-8 ends at 7125 so the highest 20MHz 
center freq is 7115, ie. channel 233. Have to admit that mixing the two in 
this patch can be confusing. I leave it at your discretion how to fix it. I 
can also resend if necessary.

Regards,
Arend



