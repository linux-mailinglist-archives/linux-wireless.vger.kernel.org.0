Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE4E37B19D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 May 2021 00:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEKWaR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 18:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKWaQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 18:30:16 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F34C061574
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 15:29:08 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id j12so18577946ils.4
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 15:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iaRTLnhb0PbcUcr1RCmKbdmR48L0hhUEaISUvEmg3kI=;
        b=hWAKHKyf+HwjiZ+hI5V0fbeO8eiak4KLeR+rAk+GdY0KHRvYDqgoCPLEufYwQKVGks
         QypQjojwi9Kwn4kxjaxyt+7RETw6Qz5taXqBxWIg0/24u8s6lLTcgFNWnsP1cFOMxWbJ
         Ux105Qpbwa95ohQ4nkPVq5BMInEU920hDBFVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iaRTLnhb0PbcUcr1RCmKbdmR48L0hhUEaISUvEmg3kI=;
        b=NJbDTcd8GErOZc7PomJgB9dHlwH9M1nL28d34dMIeXw7bO6Drk714ByfZ9S7Kg3+Cz
         HvB455MG30t/J1X2Fvrqgq59aA7hSxy3xTxEg2QXFvuDrGlJbsRZjr+58sOGQ5amqZmO
         94icI3vCYYYwgk7vqR+xYgX8mowhD1depYdP0oU5DjOSZ3Ls9vv2Yyq4NFKEnAwxJ3Qt
         T49kEemMyDZMmlRXl7sQqVCaLfUNpZxHkGpL6HShE5w7zCpxbXgW0ELJT25Xs37WUvkE
         qRbGzpvyfrDABnowgxTQfX4XD2ic23eUMVrdGgLuCOAOn+jZWfcVTIlbkulB4o9S4n90
         8HgQ==
X-Gm-Message-State: AOAM530/eVXmDleb0L43k4yZdSrxBI8veckvHmVcVRjH6QVVumV3/XRm
        Z3Vo2aOXmy9WSfbEJra20IPkYg==
X-Google-Smtp-Source: ABdhPJwOu3q/UzjpFWDQ9/thPb8CGe+yhiDjLqpnEmKAXMIk2EAfeqAZxBEslRLQ9Tq2rx+4JNmFwA==
X-Received: by 2002:a92:901:: with SMTP id y1mr28411239ilg.118.1620772148304;
        Tue, 11 May 2021 15:29:08 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q5sm9827067ilv.19.2021.05.11.15.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 15:29:07 -0700 (PDT)
Subject: Re: [PATCH] net: mac80211: fix hard-coding of length check on
 skb->len in ieee80211_scan_rx()
To:     Du Cheng <ducheng2@gmail.com>,
        Thomas Pedersen <thomas@adapt-ip.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzbot+405843667e93b9790fc1@syzkaller.appspotmail.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210510041649.589754-1-ducheng2@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e52ff0a3-7b64-037d-7825-9cbbcafa21b6@linuxfoundation.org>
Date:   Tue, 11 May 2021 16:29:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210510041649.589754-1-ducheng2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/9/21 10:16 PM, Du Cheng wrote:
> Replace hard-coding with compile-time constants for header length
> check on skb->len. This skb->len will be checked again further down the
> callstack in cfg80211_inform_bss_frame_data() in net/wireless/scan.c
> (which has a proper length check with WARN_ON()). If the kernel is
> configure to panic_on_warn(), the insuffient check of skb->len in
> ieee80211_scan_rx() causes kernel crash in
> cfg80211_inform_bss_frame_data().
> 

Where is this WARN_ON? I didn't see it cfg80211_inform_bss_frame_data()

Please add more information on why the values of min_hdr_len in this
patch make sense for each of these cases.

> Bug reported by syzbot:
> https://syzkaller.appspot.com/bug?id=183869c2f25b1c8692e381d8fcd69771a99221cc
> 
> Reported-by: syzbot+405843667e93b9790fc1@syzkaller.appspotmail.com
> Signed-off-by: Du Cheng <ducheng2@gmail.com>
> ---
> 
> This patch has passed syzbot testing.
> 
>   net/mac80211/scan.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
> index d4cc9ac2d703..562eda13e802 100644
> --- a/net/mac80211/scan.c
> +++ b/net/mac80211/scan.c
> @@ -251,13 +251,21 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
>   	struct ieee80211_mgmt *mgmt = (void *)skb->data;
>   	struct ieee80211_bss *bss;
>   	struct ieee80211_channel *channel;
> +	size_t min_hdr_len = offsetof(struct ieee80211_mgmt, u.probe_resp.variable);
> +
> +	if (!ieee80211_is_probe_resp(mgmt->frame_control) &&
> +			!ieee80211_is_beacon(mgmt->frame_control) &&
> +			!ieee80211_is_s1g_beacon(mgmt->frame_control))
> +		return;
>  

Is the above check necessary? This doesn't look right. This skips
the ieee80211_is_s1g_beacon() all together.


    	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
> -		if (skb->len < 15)
> -			return;

Why not compare the header offset you expect here instead of 15 and
return?

> -	} else if (skb->len < 24 ||

Can you explain why it makes sense to remove < 24 check?

> -		 (!ieee80211_is_probe_resp(mgmt->frame_control) &&
> -		  !ieee80211_is_beacon(mgmt->frame_control)))
> +		if (ieee80211_is_s1g_short_beacon(mgmt->frame_control))
> +			min_hdr_len = offsetof(struct ieee80211_ext, u.s1g_short_beacon.variable);
> +		else
> +			min_hdr_len = offsetof(struct ieee80211_ext, u.s1g_beacon);
> +	}
> +
> +	if (skb->len < min_hdr_len)
>   		return;
>   
>   	sdata1 = rcu_dereference(local->scan_sdata);
> 

thanks,
-- Shuah
