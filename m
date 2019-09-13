Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8837FB27FD
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Sep 2019 00:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390540AbfIMWEv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 18:04:51 -0400
Received: from 2.mo1.mail-out.ovh.net ([178.32.119.250]:34624 "EHLO
        2.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389867AbfIMWEv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 18:04:51 -0400
X-Greylist: delayed 2403 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Sep 2019 18:04:50 EDT
Received: from player158.ha.ovh.net (unknown [10.108.42.83])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id ECF9F18F557
        for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2019 22:48:21 +0200 (CEST)
Received: from awhome.eu (p57B7E67F.dip0.t-ipconnect.de [87.183.230.127])
        (Authenticated sender: postmaster@awhome.eu)
        by player158.ha.ovh.net (Postfix) with ESMTPSA id 18D539B283E7;
        Fri, 13 Sep 2019 20:48:15 +0000 (UTC)
Subject: Re: [PATCH 04/11] wil6210: fix PTK re-key race
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1568407693;
        bh=C/MTRKucCQexrI44T2Nu91LyY+09ypq/BewO4fLc6ds=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VtRTV5cQt5QosVKvoBQIpHDTBH+0b3lY+f5TkSj97mUbWypygB7gC4m0jUu1cKSwj
         6G/DMenw0Cb8fDQD+mNcwoeeLgjPGPGn3FjEQanzWKNzdxhA5DDndhONLi1U25SKQl
         eDloSXeuAWMEjjj2z3nHjJyNcrSNXm7lyDyiTXgo=
To:     Denis Kenzior <denkenz@gmail.com>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>
Cc:     Ahmad Masri <amasri@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
References: <1567931575-27984-5-git-send-email-merez@codeaurora.org>
 <20190910132315.D7AC7602F2@smtp.codeaurora.org>
 <7b636313-fa4a-5ee4-935a-ba2ed5dde1e5@wetzel-home.de>
 <2c6bc637-62c2-020c-ab83-d2e1677d96b2@gmail.com>
 <5716f475-856e-7fd2-637b-67927f4f78bc@wetzel-home.de>
 <74c0e328-320c-0999-836e-1bfb0fa224ff@broadcom.com>
 <13f699ef-16c2-3ba7-79a0-0934f5e39368@gmail.com>
From:   Alexander Wetzel <alexander@wetzel-home.de>
Message-ID: <46f1141c-929c-9686-017d-fe4305d9c922@wetzel-home.de>
Date:   Fri, 13 Sep 2019 22:48:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <13f699ef-16c2-3ba7-79a0-0934f5e39368@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 41939774643313792
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtdejgdduheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 13.09.19 um 16:33 schrieb Denis Kenzior:
> Hi Arend, Alexander,
> 
>> Basically, we now have two bypass methods dealing with the 
>> same/similar issue:
>>
>> 1) bypass the QDISC.
>> 2) bypass network stack entirely with CONTROL_PORT.
> 
> It also raises the question in my mind as to why we have two ways of 
> doing the same thing?  From the discussion so far it also sounds like 
> each requires somewhat different / special handling in the driver. 
> Wouldn't it make sense to deprecate one and encourage drivers to 
> implement the other?
> 

My understanding is, that any control port frame must bypass any queues 
and just send out the frame directly, correct? Any packets send via it 
is directly jumping to the very front and is immediately send out.
And that the intend of it is to replace the "old" path.

So the best way forward here would be to

1) implement the patch here to work around the problem without 
control_port or the theoretical QDISC bypass
2) start implementing control port for the future.

correct?


> CONTROL_PORT was added specifically to take care of the re-keying races 
> and can be extended with additional attributes over time, as needed 
> (perhaps for extended key id, etc).  Also note that in our testing 
> CONTROL_PORT is _way_ faster than PAE socket...
> 

Extended Key ID is pretty robust when rekeying and the driver/card only 
has to take care to not mix KeyIDs within one A-MPDU. It's no problem 
encrypting eapol#4 with the new key. You can even encrypt it at the 
initial connect and it will work. Basically all races the "classical" 
rekey has to work around go away.

For "normal" rekeys it's working pretty well with ath9k and iwlwifi even 
without control_port and just learned some weeks ago that QDISC could 
still cause issues...

Alexander



