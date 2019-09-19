Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77CD1B808B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 20:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391260AbfISSD3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 14:03:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40192 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391245AbfISSD2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 14:03:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so2805845pfb.7
        for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2019 11:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FA0E4Xd1CxRoSy79h+C7G59jiUefZolA8vrNTdNN3WE=;
        b=QlvCe6C3s9Gkpi4E8pUbehQGVbcnFvQOu0RB6GI4xvf6YfpIMv7E4SAPwrm+cazZrv
         erobVzn69aaA11K2D0g/XfyNNeqNt07ZTS4zpbIgXwDfcrG5E/n5j4bWOwApuqWHucA2
         x5/3YG4OYttEN6GOvDPZR0PLilsvKiKfSsih8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FA0E4Xd1CxRoSy79h+C7G59jiUefZolA8vrNTdNN3WE=;
        b=ZY+KKgmlxgbAUpZfs/CR/RjMa0o2d1LOgFTOAryEiuA2/jc2US4dzwXQMGjsQ/hCcv
         KS2WJD0mkEPK5NgBPkoYW3P7Q910EswyN9TLmgXuyxRCRnUHCeP70MEHPncyWSxPO2Ar
         pm1kE0zOF3gKXTwQdxZCPM9fhgE3hwSL8Z49g8vRuu9OFTkmIbY8OPzVB++woH26Bjeq
         m7Wv0W6h1QtYkl/GMKTrLEmy59HhrZHJM2B3ZQgb7akMNsvoGtCRtqn8XfWTRdy90TEy
         5hKUYYRG6oqVWAnJx/Yy7Xm6lrN3b0PQt+lsr1SI5iKWTNB9q7BdFwvIdWverq3/Fm/W
         H57w==
X-Gm-Message-State: APjAAAUCjooTxWuN5HSscvM7L+MDlWyEU90Rf61fQXs4ytqZ2+UC7lbY
        5rBm8XhCmu5XHUdwqWCpdmpQ1ev+2Fo=
X-Google-Smtp-Source: APXvYqzcie3HQAduAjI1S9tPW+WWCEXJ2wp/wDJWHll/2lI5z0jD0Ao34khCRKDh5pmU8cuQYrlahQ==
X-Received: by 2002:a17:90a:cf0c:: with SMTP id h12mr4951489pju.110.1568916206762;
        Thu, 19 Sep 2019 11:03:26 -0700 (PDT)
Received: from [10.0.2.15] (eero.static.monkeybrains.net. [199.116.72.162])
        by smtp.gmail.com with ESMTPSA id w21sm6019533pgj.36.2019.09.19.11.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 11:03:26 -0700 (PDT)
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit
 (AQL) on packet dequeue
From:   Peter Oh <peter.oh@eero.com>
To:     Ben Greear <greearb@candelatech.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
 <156889576869.191202.510507546538322707.stgit@alrua-x1>
 <f21b10fd-02ae-af59-8e2f-88f654627ab3@eero.com>
 <879913e9-4254-1381-07f6-d860fb0b8de0@candelatech.com>
 <f9b224a0-305f-9715-f627-7a5fae0988d3@eero.com>
Message-ID: <df105ac6-833b-4a22-9ecc-484513a2eb9c@eero.com>
Date:   Thu, 19 Sep 2019 11:03:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f9b224a0-305f-9715-f627-7a5fae0988d3@eero.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 9/19/19 10:54 AM, Peter Oh wrote:
>
> On 9/19/19 10:46 AM, Ben Greear wrote:
>> On 9/19/19 10:44 AM, Peter Oh wrote:
>>> On 9/19/19 5:22 AM, Toke Høiland-Jørgensen wrote:
>>>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>>>>
>>>> This patch ports that idea over to mac80211. The basic idea is simple
>>>> enough: Whenever we dequeue a packet from the TXQs and send it to the
>>>> driver, we estimate its airtime usage, based on the last recorded 
>>>> TX rate
>>>> of the station that packet is destined for.
>>>
>>> The way to decide the last recorded TX rate could be vary among 
>>> drivers. In terms of ath10k driver and FW, they use 4 PPDUs to 
>>> update the Tx rate. Isn't it too small sampling number to be used 
>>> for AQL?
>>
>> Probably it is not exactly the last 4 either, since the report comes 
>> back indirectly and not
>> synchronized with the tx path?
>>
The point of my question is "the last recorded Tx rate is derived from 
small number of PPDUs and if it's OK to use it for AQL calculation or not".

Thanks,

Peter

