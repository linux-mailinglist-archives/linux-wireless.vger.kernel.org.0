Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AB11FF69A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2020 17:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbgFRP0x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jun 2020 11:26:53 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:57866 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgFRP0w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jun 2020 11:26:52 -0400
Received: from [192.168.254.4] (unknown [50.34.202.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 9751213C2B4;
        Thu, 18 Jun 2020 08:26:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9751213C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1592494012;
        bh=DZaRzfO/rybgitUzzWdWjM+GhqQDjvU0Jix7PYAobCs=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=JeAhkmbeOnjMBkEXzXGWdZQfN4pMCOsOYUTP0mRuhBxoN365uFysix9WVvqAtlILM
         DtTdh7lNgRqOQ2/Mhb3BrOLXW29WjGOQrRCoOgFI49mlJweal8vvRQvgAm9JHxRIl5
         DDPbgNetnW3WGF+xFELr5UDz0j9AUdHPFKLgQEvM=
Subject: Re: [PATCH] mac80211: Send deauth to STA's upon AP stop
To:     Johannes Berg <johannes@sipsolutions.net>,
        Shay Bar <Shay.Bar@celeno.com>
References: <20200618093609.16514-1-shay.bar@celeno.com>
 <d57c8bf64d6ea2e3f7355c2f7ca9b376db7fe21c.camel@sipsolutions.net>
 <AM0P192MB04682E48D814F5F6CAFBF9CAE79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
 <2a7b33ace030fdeda96e60b2abd6c70a11f426e0.camel@sipsolutions.net>
 <AM0P192MB0468CA3DA7C8EC62366AC04AE79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
 <54236bdd708c53ec2f2a776bb3badcd77c7fecc6.camel@sipsolutions.net>
 <AM0P192MB046896A59F91F976EE7AB287E79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
 <6da8757ac90a4d34ed1bdc7c84b40aac06c01af9.camel@sipsolutions.net>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <f0b038b4-fbd8-0b9b-2c2e-6337f0d408ea@candelatech.com>
Date:   Thu, 18 Jun 2020 08:26:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <6da8757ac90a4d34ed1bdc7c84b40aac06c01af9.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 06/18/2020 07:48 AM, Johannes Berg wrote:
> On Thu, 2020-06-18 at 14:45 +0000, Shay Bar wrote:
>>> So... why would you ever do that? :)
>>> johannes
>>
>> :)
>> Is it illegal to do "ifconfig <if> down" or kill hostapd
>> while STA's are still associated?
>> There are some vendors/users that are doing that.
>
> It's not really *illegal* per se, but it would be weird if both did it
> ... But I do tend to think that if you're using hostapd or such to
> control it, you shouldn't do another out-of-band control.
>
>> Regarding Ben's proposal of using 11k/v, I couldn’t find such
>> "going down" single frame in the standard (although sounds trivial)
>
> Broadcast deauth :)

Or use k/v to tell STA that AP is going down immediately and here is (null, likely)
list of APs to associate with instead?

Another thing I notice:  In order to keep things from blocking for long periods (3+ seconds)
with rtnl held, I ended up doing a force flush in ath10k-ct, so at least when using that
driver, sending frames and then immediately doing flush will likely not put much on air.

I have hoped to one day add tx-completion call-backs handling to mac80211 instead of just calling a flush
for these types of station-down communication where flush is to be called shortly.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
