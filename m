Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A098E986F6
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 00:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfHUWEV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 18:04:21 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:52358 "EHLO
        3.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfHUWEV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 18:04:21 -0400
Received: from player788.ha.ovh.net (unknown [10.108.42.184])
        by mo2.mail-out.ovh.net (Postfix) with ESMTP id AA5381AA3C7
        for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2019 23:45:58 +0200 (CEST)
Received: from awhome.eu (p57B7E04C.dip0.t-ipconnect.de [87.183.224.76])
        (Authenticated sender: postmaster@awhome.eu)
        by player788.ha.ovh.net (Postfix) with ESMTPSA id 0914A8FB8FEA;
        Wed, 21 Aug 2019 21:45:55 +0000 (UTC)
Subject: Re: [linuxwifi] Intel Centrino Ultimate N 6300 regression
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1566423953;
        bh=uQ9QfbcZbrm3tEffITExqAoMKYqHYGgkn6zJJlepJao=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PYJajWbRcimavUxfeaPgX5Eqrel0HiZC279Lu4BpbgQFnJb3STorAlcNgJdmjP/le
         fQEfLNIrNqgcAVB9oEl+T1vLoaZfH59SIgLoIwqEG7IlFjBjWXx0bjabYhegxkAyVT
         j1MSWM8nqxXrcC7jXVlRpt+ozgWzayZyIMXs7Gos=
To:     Nigel Sollars <nsollars@gmail.com>,
        Luciano Coelho <luciano.coelho@intel.com>
Cc:     linuxwifi@intel.com, linux-wireless@vger.kernel.org
References: <CAG6aBkWDyGDtWX7X0t-FjynkYxpdhpZsAv4Ysw3dKf+iEu+mig@mail.gmail.com>
 <941b807b02962fadaf738942baf1621738872723.camel@intel.com>
 <CAG6aBkW09YFz4asHZkhWBUenBiT3dgb7iGXBCq8KkCM09QXjLg@mail.gmail.com>
From:   Alexander Wetzel <alexander@wetzel-home.de>
Message-ID: <4e63174a-34cc-cebf-4eb9-205f0d237574@wetzel-home.de>
Date:   Wed, 21 Aug 2019 23:45:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAG6aBkW09YFz4asHZkhWBUenBiT3dgb7iGXBCq8KkCM09QXjLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13516991332400045093
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudeggedgtdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>> So I have been trying to reach out in aim to get this driver fixed as its regressed now to a total non working state.
>>
>> The card can see access points, but thats about as good as it gets as trying to connect to any networks ( either 2.4 ot 5 Ghz ) results in the following,
>>
>>    wlp3s0: CTRL-EVENT-SCAN-FAILED ret=-22 retry=1
>>
>> ( alot of these ) which then resets connection status with a failed timeout.
>>
>> I am currently running FedoraCore 30 with the 5.2.5-200 kernel updated from 5.1.x yesterday. The firmware loaded is,
>>
>> loaded firmware version 9.221.4.1 build 25532 op_mode iwldvm
>>
>> Now with all that said, using a Linux Mint live boot from a usb device yeilds the card working fine at both 2.4 and 5ghz speeds, it connects within seconds. The kernal in this live boot is 4.15.x and uses the same firmware build as my FC install.

I'm also using a "Intel Corporation Centrino Ultimate-N 6300 (rev 3e)" 
card and it's working perfectly with 5.3.0-rc4-wt here.
(And with most wireless-testing kernels for the last years, too..)

Now there was one noteworthy bug in the last year we handled on the 
mailing list:
https://lore.kernel.org/linux-wireless/87k1rk1af5.fsf@kamboji.qca.qualcomm.com/

But then this was a null pointer and does not match to what you observe. 
(And that really should be fixed in any 5.2 kernel...)

I'm using a Gentoo ~amd64 system and wpa_supplicant more or less 
tracking git upstream and the wireless-testing kernels with the same 
firmware as you.

So whatever it is, it's not affecting me. I would suggest to try a 
vanilla 5.2 kernel and maybe also an updated wpa_supplicant version next...

Alexander
