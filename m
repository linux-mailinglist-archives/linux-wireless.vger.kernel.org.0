Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6671DC0AA
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 22:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgETU4U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 16:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgETU4T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 16:56:19 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67BEC061A0E
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2020 13:56:19 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id u190so964509ooa.10
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2020 13:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z5984Y6a+qDCOEn0z7BxJFP/LZWybUR8jBVn+MZPqzU=;
        b=bx5Dek8bIuSdHGgRSOJMqztYvhd7IYJEdLijM0NZy3OscNjvkmgg5mJB6ILcyu2F7h
         wqa5iMI6wqAJtDacHoWSONy9OmeLRinwvM6HoOgUwB7t94IOOu4VIxDfFdlwvlOSvFcs
         OziZiPBQDcv+dLEizyAoZJHOzQC9nOTg34bzVyhnQBfwHPizENTTCm/pOqu2/Bxa/weP
         xXX8IerAaVNDOw/xJIatxpNZk9SlnDeBnqyXj/QoGI6P/nek3ah2g7ttJZl4PLyvjvY3
         UAZncG1LHFr6Akm1HjC9y41X9lq01kY5g0+IIpoH7ByOzO76BAFGr9ploN80KEzj18q8
         ZtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z5984Y6a+qDCOEn0z7BxJFP/LZWybUR8jBVn+MZPqzU=;
        b=OkBoDAgZ6nvr/lqKU09JqtjZUcbA+VyPiMN7JopigFSQLS4In5EOGkTXObP/O90d6/
         UtqojJ/kqhXTtEOIdmJIdmiT0aTuKDya3z7SlZXZDNJC4GMd27Db1BNGdKwxmG5Ye5wC
         XQHX6dlt47p0nDz1ZPIHwzudboyJlUMyN/+dT2JcFVU/H4XZBAkuCYT0HUvrC78oMMdG
         JYQ+GhstwLNXtnh1pDbnKCmFVunq6qEgxuiUFgxpx2hLn7YvcUCklH/ufLw1jo8Eoric
         ixWc2O3flE5kQHliaBcfLA1rszCpHngusd/FbkGQMS8oZeS+cqUz6RxgHHSleO/ci8yI
         WO9Q==
X-Gm-Message-State: AOAM533gLn8ZroC+85duaMmMC5QCzyYWUsUWNmNz/+Axsr7W1KnInwPp
        rYejiUJhx3oCZRzFo0dMjIo=
X-Google-Smtp-Source: ABdhPJxG01/Dr6KTDEEXmLD1kP1QzYtrY4GCTFkON1SZKwqJJrkgW+5HLgZbtzyUi7v+IK5hmqKGTQ==
X-Received: by 2002:a4a:94eb:: with SMTP id l40mr4965781ooi.30.1590008179073;
        Wed, 20 May 2020 13:56:19 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id f5sm666682oig.32.2020.05.20.13.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 13:56:18 -0700 (PDT)
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
 <3483242e-c2ad-ec83-0c2c-ce952bc9b638@lwfinger.net>
 <CALjTZvatxQ2BvUeZGcTFijBf1PiLizJuDdENxg2b=tPQL_NAzQ@mail.gmail.com>
 <CALjTZvYSJOx0xeMVkN6dHcGTdgW9O9NVbgXPKK4d6-31VX+0JQ@mail.gmail.com>
 <29f5e3de-a32c-6292-9197-19dcc57fa6a3@lwfinger.net>
 <CALjTZvaroTrgK9=W8uTwq9YcYayfuEU31BUc0qNYJr+08hevfg@mail.gmail.com>
 <CALjTZvaPi2FL-epk-Vd2wOLye2O0J8G5aZPsqzHXt2b7u=HyuQ@mail.gmail.com>
 <263e247c-3bf9-6d42-996b-bc513efe4b71@lwfinger.net>
 <CALjTZvauK0Hh+aoabcDX9kkQZ4zN2ZjPnB+aq7YrJ9+-4ihiAg@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <87fffd5d-242a-7195-c4cc-80260dbd53c5@lwfinger.net>
Date:   Wed, 20 May 2020 15:56:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CALjTZvauK0Hh+aoabcDX9kkQZ4zN2ZjPnB+aq7YrJ9+-4ihiAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/20/20 3:28 PM, Rui Salvaterra wrote:
> On Wed, 20 May 2020 at 21:08, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>
>> I found this line in the b43 logs:
>> nl80211: NL80211_CMD_SET_PMKSA failed: -95 (Operation not supported)
>>
>> Could we also see the supplicant log for the RaLink driver that works?
> 
> Sure thing, here you go! This one's much shorter, since the connection
> was successful.

A quick difference - this one supports 3 additional ciphers:

vedder wpa_supplicant[376]: nl80211: Supported cipher 00-0f-ac:13
vedder wpa_supplicant[376]: nl80211: Supported cipher 00-0f-ac:11
vedder wpa_supplicant[376]: nl80211: Supported cipher 00-0f-ac:12

The one with :13 is for  BIP-CMAC-256, :11 is BIP-GMAC-128, and :12 is 
BIP-GMAC-256. I did not find a reference that says that these are needed for 
WPA3, but I am suspicious.

Thus far, I have not found where the driver tells nl80211 what should be supported.

Perhaps, we were calling ieee80211_hw_set() in the wrong place. Try

diff --git a/drivers/net/wireless/broadcom/b43/main.c 
b/drivers/net/wireless/broadcom/b43/main.c
index 39da1a4c30ac..211d6126734f 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -5569,7 +5569,10 @@ static struct b43_wl *b43_wireless_init(struct 
b43_bus_dev *dev)
         /* fill hw info */
         ieee80211_hw_set(hw, RX_INCLUDES_FCS);
         ieee80211_hw_set(hw, SIGNAL_DBM);
-
+       if (modparam_nohwcrypt) {
+               printk(KERN_INFO "b43: Setting MFP_CAPABLE\n");
+               ieee80211_hw_set(hw, MFP_CAPABLE);
+       }
         hw->wiphy->interface_modes =
                 BIT(NL80211_IFTYPE_AP) |
                 BIT(NL80211_IFTYPE_MESH_POINT) |

In addition, check that the printk message is seen in dmesg.

Larry

