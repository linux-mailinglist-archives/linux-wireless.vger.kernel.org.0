Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06C2E6FEBE
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2019 13:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfGVLct (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jul 2019 07:32:49 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34362 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfGVLcs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jul 2019 07:32:48 -0400
Received: by mail-lf1-f65.google.com with SMTP id b29so19134158lfq.1
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2019 04:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2vUFlSitQcY1TFH2rfMTdF9oyL7Qbe3JTvU3Wn5QINY=;
        b=nt6TVOu4iAkKDFSGZPQNOeHTWI9r6RCO888UnInPTctKFQb4SPUKOb4hb3y+TW0tL5
         nWHI4ewXxHKJXGqakTPMiWpi1a1PCg7FO9kO1aFl4gDpSX9f/u1gsukBLKrTBtYZ+5B0
         UxYKeuFKPsBbWjDCQwOR/aT4aA6/LlZ3SBL69mZ9yI5IzenItpEHeCaDGNkRjM1JVjxJ
         x4b2pvjRfvnGFzB0Jb16NL8LCfr0oE9ycpUE317Yubk+KLzwEwgdiE8uiy+Jwgzv16de
         ySI8+TmDQJ2xT4UwIr0NYRKVHP/mL3FTBNXvhAPvnLfL0/2sBTS7AKQ3oZ8TUUzJLF8y
         l3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2vUFlSitQcY1TFH2rfMTdF9oyL7Qbe3JTvU3Wn5QINY=;
        b=YrSdsL3BYLGYs4nVLFzDuKbWT2owVbg9zOhvSRWhJxOTTRkDhdoN+u2JDENd3iQ8ww
         U3Cqhtwc8CsSL/2IhvgRivazKEW2Ien2J4/0pEun49DJFHoG8MqEYp9XiiwGBfuZ5wwP
         q7OtL+TGOG9FiUOnC3EMOyVxJ65UHHUpIvEcEYraK30y7X6kdQ2RRJEXENFOiZCwTyBw
         v3WGiJDWpH2GvXMshL58IqBkOIe9m7Ir95iTner23DhMxzelr+buXUuN+pO6CM6CbFFR
         RCERltoH+6XMNoLS2ItRWAE93ipHc2z3WEu6TI0tyLmMV39bVg47fpF2Gbjc50FCXFkH
         LGow==
X-Gm-Message-State: APjAAAWtYol7Th1Pnvdl9G4fHepTW1z6cVkc28mj24rynNwJX61JxWTl
        zMe+5yThkMIPgb7p4ytJnh7vD+Jp
X-Google-Smtp-Source: APXvYqwo0S8xoezJ36CM+SWM3l9ecf9GNQiKBykLF09+IZyKjv0FH7YdIY4/gjy1mRd0Yw5hIbhK0g==
X-Received: by 2002:a19:6e41:: with SMTP id q1mr21350131lfk.20.1563795166545;
        Mon, 22 Jul 2019 04:32:46 -0700 (PDT)
Received: from [192.168.100.6] ([109.252.54.73])
        by smtp.googlemail.com with ESMTPSA id s1sm7425675ljd.83.2019.07.22.04.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 04:32:45 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] nl80211: Limit certain commands to interface owner
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <20190701153317.27170-1-denkenz@gmail.com>
 <20190701153317.27170-2-denkenz@gmail.com>
 <d75d6f90-1691-57fa-ddb2-ece84f5d262f@broadcom.com>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <b81ed4a0-0b41-fff2-2bab-7219db2c9e35@gmail.com>
Date:   Mon, 22 Jul 2019 06:32:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d75d6f90-1691-57fa-ddb2-ece84f5d262f@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

On 7/18/19 3:24 AM, Arend Van Spriel wrote:
> On 7/1/2019 5:33 PM, Denis Kenzior wrote:
>> If the wdev object has been created (via NEW_INTERFACE) with
>> SOCKET_OWNER attribute set, then limit certain commands only to the
>> process that created that wdev.
>>
>> This can be used to make sure no other process on the system interferes
>> by sending unwanted scans, action frames or any other funny business.
>>
>> This patch introduces a new internal flag, and checks that flag in the
>> pre_doit hook.
>>
>> Signed-off-by: Denis Kenzior <denkenz@gmail.com>
>> ---
>>   net/wireless/nl80211.c | 80 ++++++++++++++++++++++++++++++++----------
>>   1 file changed, 61 insertions(+), 19 deletions(-)
>>
>> Changes in v3:
>>    - Fix minor locking mistake reported by kernel test robot
>>
>> Changes in v2:
>>    - None
>>
>> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
>> index ff760ba83449..ebf5eab1f9b2 100644
>> --- a/net/wireless/nl80211.c
>> +++ b/net/wireless/nl80211.c
> 
> [snip]
> 
>> -    return 0;
>> +    ret = 0;
> 
> I suggest to keep the return 0 here for success path and only do the 
> below for failure case (and obviously dropping '&& ret < 0'). Maybe 
> rename label 'done' to 'fail' as well.
> 

Sure, makes sense.  I've made the suggested changes for v4.

>> +done:
>> +    if (rtnl && ret < 0)
>> +        rtnl_unlock();
>> +
>> +    return ret;
>>   }
> 
> Regards,
> Arend

Regards,
-Denis
