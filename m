Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92E3214D0A0
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2020 19:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgA2SmI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Jan 2020 13:42:08 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:52174 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgA2SmI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Jan 2020 13:42:08 -0500
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 74F03137586;
        Wed, 29 Jan 2020 10:42:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 74F03137586
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1580323327;
        bh=QsUirO+HnCbE2ORNTWB+j3sWg0WNbWy59Q80E3HxW5A=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=U2DOhJ37B4J2UK7DEC4s2B9pHvgXbhwq2z1TGHf3ki37Rgjm4qhIz3n/YnldewzMP
         rlExHxDlj4FAS8UUz2qEpz+JOysvT955JJkB8YHS1I394F39CQWYpG9pLv+wN1GVe3
         +yFQJgAa8jrgh7Hp6egJfvuHk8D+++3QDEvW8qFA=
Subject: Re: Strange performance issue when using two devices at once
To:     Marlon Smith <marlon.smith10@gmail.com>,
        linux-wireless@vger.kernel.org
References: <1580323191.26012.48.camel@gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <2e80a485-892d-3b29-19c7-38a9caa14f4b@candelatech.com>
Date:   Wed, 29 Jan 2020 10:42:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1580323191.26012.48.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/29/20 10:39 AM, Marlon Smith wrote:
> Hi everyone,
> 
> I have two RT5370 devices connected to the same access point. Both
> devices are very slow, but the instant I disconnect one device, the
> other speeds up by a factor of 10.

Out of curiosity, are both of the RT5370 used on the same client device?

Did you check that they have unique MAC addresses?

Thanks,
Ben

> 
> The really strange part is that one device will perform slowly even if
> the other device is basically idle! I've confirmed this with a packet
> sniffer.
> 
> I've been trying to do some debugging, and I've found that when both
> devices are connected to the access point, they report a large number
> of duplicate frames. I added some debug output
> in ieee80211_rx_h_check_dup() to confirm that this only happens while
> both devices are connected. The packet sniffer also shows a large
> number of retries while this is occurring.
> 
> Using backports 5.3-rc4 for this, but also tested on 4.14-rc2.
> 
> I did post about this previously on this mailing list (RT5370
> performance issues), but I thought I'd post again with this new
> information and more descriptive title. I'm a little bit stuck on this
> for a while now, so any ideas are much appreciated.
> 
> Thanks!
> 
> Marlon
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

