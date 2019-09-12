Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6832DB15F8
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2019 23:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfILVnk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Sep 2019 17:43:40 -0400
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:44536 "EHLO
        3.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfILVnk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Sep 2019 17:43:40 -0400
Received: from player794.ha.ovh.net (unknown [10.109.143.225])
        by mo69.mail-out.ovh.net (Postfix) with ESMTP id 42646689FC
        for <linux-wireless@vger.kernel.org>; Thu, 12 Sep 2019 23:04:21 +0200 (CEST)
Received: from awhome.eu (p57B7E67F.dip0.t-ipconnect.de [87.183.230.127])
        (Authenticated sender: postmaster@awhome.eu)
        by player794.ha.ovh.net (Postfix) with ESMTPSA id 91CBF9B99616;
        Thu, 12 Sep 2019 21:04:15 +0000 (UTC)
Subject: Re: [PATCH 04/11] wil6210: fix PTK re-key race
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1568322254;
        bh=FOyxQjhLSfcQDlFh1gXPHOywjt7O5lVYGBW0LO6uJjY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ldE9yQVjCWbkOk8WOoSgs32XrNjQkCrE3TkAHzEvRD9DM/Plx5c+wWvhWtGD7XABh
         gkRC58zVZBXvY2RFpXTdfcqcTSI5mBxapqvx7vVvz/oj9SdjP8ztes29gX4TRmLRCt
         JeGtxbHG9C8sLx0ExW4lKZ36KgRdQItscNwUjt8Y=
To:     Denis Kenzior <denkenz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>
Cc:     Ahmad Masri <amasri@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
References: <1567931575-27984-5-git-send-email-merez@codeaurora.org>
 <20190910132315.D7AC7602F2@smtp.codeaurora.org>
 <7b636313-fa4a-5ee4-935a-ba2ed5dde1e5@wetzel-home.de>
 <2c6bc637-62c2-020c-ab83-d2e1677d96b2@gmail.com>
From:   Alexander Wetzel <alexander@wetzel-home.de>
Message-ID: <5716f475-856e-7fd2-637b-67927f4f78bc@wetzel-home.de>
Date:   Thu, 12 Sep 2019 23:04:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <2c6bc637-62c2-020c-ab83-d2e1677d96b2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12886205910649412728
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtdehgdduheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Denis,

>> I don't know anything about the driver here but in mac80211 the idea 
>> to avoid the race is to simply flush the queues prior deleting the 
>> outgoing key.
> 
> Maybe a silly question, but what does flushing the queue mean in this 
> context?  Is it waiting for all the packets to be sent or dropping them 
> on the floor?
> 

It's stopping them to make sure nothing can be added and then sends out 
all MPDUs in the queues.

>>
>> Now wpa_supplicant is not yet bypassing qdisks, but adding the socket 
>> parameter PACKET_QDISC_BYPASS is basically a one-liner in 
>> wpa_supplicant and should allow a generic way for drivers to avoid the 
>> race with a simple queue flush...
> 
> Can you expand on this actually?  What would the sequence of events be?
> 

1) wpa_supplicant hands over eapol #4 to the kernel.
    When bypassing the QDISC the frame is directly added to a driver
    queue or directly send out. When the send call returns the driver
    has eapol 4 either in the queuem already send it or the send command
    has failed.

2) wpa_supplicant deletes the old key (NL80211_CMD_DEL_KEY)

3) The driver stops all hw queues and sends out all MPDUs queued up to
    that time

4) Driver makes sure no traffic can be send with no/wrong key or PN to
    STA

5) the driver really removes the key from the HW/installs the new and
    resumes normal operation

I've just posted my hostpad patch to use PACKET_QDISC_BYPASS for eapol 
frames; It's probably too optimistic and need more code to retry a 
transmit to compensate for the missing QDISC buffers.

> Also, how would this be made to work with CONTROL_PORT over NL80211 ?
> 

Control port is an optional feature drivers can provide. wpa_supplicant 
should just use it when available or fall back to the "traditional" path 
when not. Now the driver don't has to flush all queues when using 
control port, as long as it makes sure the control port frame will be 
send out prior to deleting the key.

But then the driver must know that eapol frames will really be handed 
over via control port; So I guess flushing all queues is still the 
simpler solution. So I guess it will change next to nothing...

Alexander

