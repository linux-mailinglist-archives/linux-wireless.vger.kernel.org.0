Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABE01DBFE5
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 22:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgETUI1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 16:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgETUI0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 16:08:26 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898C6C061A0E
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2020 13:08:26 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id d191so4072200oib.12
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2020 13:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JTIq12nEFnaRPj0zVu/LWgxDphwDFMpWDi+VzEN9k/s=;
        b=YzE3j/Dj2wN8sl3oPrPAIEDWzaSL6wO7PmdGQW+k76HO/lY5rUsnmjAqoDVU06vtC/
         WYVW03G9wAB2gseeIvCAHaisaCNZw3btdvbuEY7FofZ5sbyH+Oi08AwYbhdJCp/OMd6d
         zrtOs4TUWSz/WQwkHe5BwzpUj0lhFLoy8n544zTbmRrnZ4821GjrEddmiY+2gT2Z/Io+
         XzAqBROZJ5JzBZPiwptN3/Xk7GOmzyFgYk1UG5BuKc74BOHCBidMM11hCAyD+hnUeaZU
         KiUyl3uEObb3F2LWvElYuCRocXw74zpBxxXU84rs1APitJobHT1KNquKJqrtSz+0t54E
         LE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JTIq12nEFnaRPj0zVu/LWgxDphwDFMpWDi+VzEN9k/s=;
        b=Z82Wpd2urYXhSGn6BljXKgGFvRmVewyt7toOez5kNrx1T5VhofEPHTIVfin2rspG7B
         8jNwFquK+pcpvVTopbFASEpN3HokJdu9rgdp6AWVQzlPMNGUHSATao01ERoJoK6+EQov
         3awMcLcOk6VMOCKZHwq42rl3rVgjq3/efTBVL+MNOroiDDoU67v3p972CDBzwSxzLqao
         SvKFPFd7mcRnwaZ6toHjE8rSU4+bxkJCSp49fjP0YDfmImx2i3aWbVt+qBQvm/SZePrz
         2guRKlqawhH3RKoY1qKrUyL9LOlWYJcAUykDdPcxxSPSotiKWTq0X8Ok1aEUo25GU8UA
         pYYg==
X-Gm-Message-State: AOAM531gYDHazdvgCoyWiWNpV2epgRiyUuHb2gqRojpe6WlvhAY2j7iP
        6p30KvmOllyw4pmq/aa1pKc=
X-Google-Smtp-Source: ABdhPJxLUV6QNOhqL7R+WuYc7JLCB4fDXoJiajHL9YxvTOsc6XGqmsZ/wgfgp0dQcCBgoA/kS6itfQ==
X-Received: by 2002:aca:3254:: with SMTP id y81mr4418574oiy.172.1590005305853;
        Wed, 20 May 2020 13:08:25 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id l26sm1043524oos.43.2020.05.20.13.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 13:08:25 -0700 (PDT)
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
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <263e247c-3bf9-6d42-996b-bc513efe4b71@lwfinger.net>
Date:   Wed, 20 May 2020 15:08:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CALjTZvaPi2FL-epk-Vd2wOLye2O0J8G5aZPsqzHXt2b7u=HyuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/20/20 5:55 AM, Rui Salvaterra wrote:
> On Wed, 20 May 2020 at 09:24, Rui Salvaterra <rsalvaterra@gmail.com> wrote:
>>
>> Hi, Larry,
>>
>> On Wed, 20 May 2020 at 01:16, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>>
>>> It is necessary to load the driver with option nohwcrypt set to 1. I expect that
>>> you probably did that, but I forgot to mention it.
>>
>> Yes, of course. I don't use modules, so I pass b43.nohwcrypt=1 in the
>> kernel command line. I confirmed in sysfs the nohwcrypt parameter is
>> correctly set to 1.
>>
>>> It would likely help if you can get verbose logs from wpa_supplicant.
>>
>> No problem! Attached is a wpa_supplicant -d log. Let me know if you
>> need extra verbosity.
>>
>> Thanks,
>> Rui
> 
> By the way, I just tested with WPA2 forcing MFP (pmf=3 in the Network
> Manager connection) and it also doesn't connect.

I found this line in the b43 logs:
nl80211: NL80211_CMD_SET_PMKSA failed: -95 (Operation not supported)

Could we also see the supplicant log for the RaLink driver that works?

Larry

