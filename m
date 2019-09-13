Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73D08B194D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 10:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfIMIEU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 04:04:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39192 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbfIMIEU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 04:04:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so963568wrj.6
        for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2019 01:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CVLOJNb7El0igHmrh3tBdAo10j+jnxTZfqyunXS365s=;
        b=MaL19SMd1atFg4F1J424287A6o+UK8W8stnoT2WDnt1HPjEVmpidhmOcM8/wTSQvio
         HXj79ZYjRGi/sq6+y01AKj4X0mx1x+edg11R7TZX+xJ5d9YQv4GQ8C67Xqrgd7bhSQ9O
         GWd99cR84UmS2GUsQlaA60ExoYycZvv1twKWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CVLOJNb7El0igHmrh3tBdAo10j+jnxTZfqyunXS365s=;
        b=czQcbYejMmH/Ne+sWikS8wDF5pPQpwx34FQICQKwj9DQ3YwBTc2xMFDFYZ0y9wo8VV
         Q23ZLVK5oXDmvr8Crm5uMgfl1ohZUAsjC29066fPhGFmeXoBMf1RGeAwMBjdbwbVBqCu
         htEKTT56ziLdB3iUSRZYEEPjIfCgOjqAk1zDFbrw1hrytD4MfDIGzNlljfNvTpQwTNP5
         BhXiNFameRNbr0rOaZEsjgNBL8oe0TkMyNdtM4eQa03042AGVsMa9Zar9Oiwy0MfgYYW
         VcwOzMnGiZv+cFT5UTkIc8XKV+hsRoKrUCrBnYtZkdWuYeFtq9EuvEG6LoH8Cu/Apq4J
         AL5A==
X-Gm-Message-State: APjAAAX5O+MlevYBOyUDtkIKxmL9XBHM1Z1/AIbkxDMB0Jqx/NIVVJ4j
        uOTkJ/QXaAPcfebh76lXkzy3IQ==
X-Google-Smtp-Source: APXvYqyP1gYfdrq/96DSgzD22Mlx5hB/OIcluf1iTaDV4ifm2TggYzaIdNDX5MLWad325kZyZCujjw==
X-Received: by 2002:a5d:500f:: with SMTP id e15mr23035404wrt.300.1568361857001;
        Fri, 13 Sep 2019 01:04:17 -0700 (PDT)
Received: from [10.230.40.234] ([192.19.215.250])
        by smtp.gmail.com with ESMTPSA id g185sm4125786wme.10.2019.09.13.01.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 01:04:16 -0700 (PDT)
Subject: Re: [PATCH 04/11] wil6210: fix PTK re-key race
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        Denis Kenzior <denkenz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>
Cc:     Ahmad Masri <amasri@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
References: <1567931575-27984-5-git-send-email-merez@codeaurora.org>
 <20190910132315.D7AC7602F2@smtp.codeaurora.org>
 <7b636313-fa4a-5ee4-935a-ba2ed5dde1e5@wetzel-home.de>
 <2c6bc637-62c2-020c-ab83-d2e1677d96b2@gmail.com>
 <5716f475-856e-7fd2-637b-67927f4f78bc@wetzel-home.de>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <74c0e328-320c-0999-836e-1bfb0fa224ff@broadcom.com>
Date:   Fri, 13 Sep 2019 10:04:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5716f475-856e-7fd2-637b-67927f4f78bc@wetzel-home.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 9/12/2019 11:04 PM, Alexander Wetzel wrote:
> Hi Denis,
> 
>>> I don't know anything about the driver here but in mac80211 the idea 
>>> to avoid the race is to simply flush the queues prior deleting the 
>>> outgoing key.
>>
>> Maybe a silly question, but what does flushing the queue mean in this 
>> context?  Is it waiting for all the packets to be sent or dropping 
>> them on the floor?
>>
> 
> It's stopping them to make sure nothing can be added and then sends out 
> all MPDUs in the queues.
> 
>>>
>>> Now wpa_supplicant is not yet bypassing qdisks, but adding the socket 
>>> parameter PACKET_QDISC_BYPASS is basically a one-liner in 
>>> wpa_supplicant and should allow a generic way for drivers to avoid 
>>> the race with a simple queue flush...
>>
>> Can you expand on this actually?  What would the sequence of events be?
>>
> 
> 1) wpa_supplicant hands over eapol #4 to the kernel.
>     When bypassing the QDISC the frame is directly added to a driver
>     queue or directly send out. When the send call returns the driver
>     has eapol 4 either in the queuem already send it or the send command
>     has failed.
> 
> 2) wpa_supplicant deletes the old key (NL80211_CMD_DEL_KEY)
> 
> 3) The driver stops all hw queues and sends out all MPDUs queued up to
>     that time
> 
> 4) Driver makes sure no traffic can be send with no/wrong key or PN to
>     STA
> 
> 5) the driver really removes the key from the HW/installs the new and
>     resumes normal operation
> 
> I've just posted my hostpad patch to use PACKET_QDISC_BYPASS for eapol 
> frames; It's probably too optimistic and need more code to retry a 
> transmit to compensate for the missing QDISC buffers.
> 
>> Also, how would this be made to work with CONTROL_PORT over NL80211 ?
>>
> 
> Control port is an optional feature drivers can provide. wpa_supplicant 
> should just use it when available or fall back to the "traditional" path 
> when not. Now the driver don't has to flush all queues when using 
> control port, as long as it makes sure the control port frame will be 
> send out prior to deleting the key.
> 
> But then the driver must know that eapol frames will really be handed 
> over via control port; So I guess flushing all queues is still the 
> simpler solution. So I guess it will change next to nothing...

Well, in the steps you describe (maybe its just how you describe it) it 
relies on how the driver is handling it all. I mean step 4) seems more 
the goal of the whole approach.

Basically, we now have two bypass methods dealing with the same/similar 
issue:

1) bypass the QDISC.
2) bypass network stack entirely with CONTROL_PORT.

How does option 1) work for drivers that skip the QDISC for all traffic 
and rely on mac80211 to schedule the packets? Guess mac80211 can control 
that, right?

Regards,
Arend
