Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A960434F184
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Mar 2021 21:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbhC3TTd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Mar 2021 15:19:33 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:46404 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbhC3TTR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Mar 2021 15:19:17 -0400
Received: from [192.168.254.6] (unknown [50.34.172.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id B1A1513C2B0;
        Tue, 30 Mar 2021 12:19:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B1A1513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1617131956;
        bh=Vp4Toja8m/3uoXvkiN44tZkYFJEmp5cP+xZxQQXVFDQ=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=Xaaqpj4ND4wnAuT8wCyrGV8BLbRdhBJlIeOpOqFEeOEtmLoW3B67+kSpg0v0UCpjw
         MnJbHUsL9gcHxbhT3p6iO6okmfz94zTI8JCg8lA59UIOBRwvhcsHu10e9j/4R14f+d
         X4PH57PJg0PKFkuALxKs/1N1IKY5rIQv+RkhnQx8=
Subject: Re: mac80211 mlme connection probing woes (bisected)
From:   Ben Greear <greearb@candelatech.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>
References: <312fa32e-21f7-fcc0-fef4-55633db53f65@candelatech.com>
Organization: Candela Technologies
Message-ID: <af486fdb-5ac4-8d89-5d5e-554b828435bf@candelatech.com>
Date:   Tue, 30 Mar 2021 12:19:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <312fa32e-21f7-fcc0-fef4-55633db53f65@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/26/21 5:18 PM, Ben Greear wrote:
> I've been digging into a bug where our ath10k driver shows periodic
> throughput drops on regular intervals.  We've bisected this down to a patch
> where we disable the firmware connection monitor, and so ask mac80211 to
> do the connection monitor.
> 
> This works fine in 5.4 kernel, but in 5.11, it does not work well.
> 
> First, if anyone has an idea what change might have caused this,
> please let me know.  We will try with ath9k, assuming it uses
> the mac80211 connection monitor to see if it has the same issue.

Ok, it took a while, but I bisected to this:

commit 9abf4e49830d606f18a05111cfa96b8f0b724c7d (HEAD, refs/bisect/good-9abf4e49830d606f18a05111cfa96b8f0b724c7d)
Author: Felix Fietkau <nbd@nbd.name>
Date:   Tue Sep 8 14:36:56 2020 +0200

     mac80211: optimize station connection monitor

     Calling mod_timer for every rx/tx packet can be quite expensive.
     Instead of constantly updating the timer, we can simply let it run out
     and check the timestamp of the last ACK or rx packet to re-arm it.

     Signed-off-by: Felix Fietkau <nbd@nbd.name>
     Link: https://lore.kernel.org/r/20200908123702.88454-9-nbd@nbd.name
     Signed-off-by: Johannes Berg <johannes.berg@intel.com>

To do the bisect, I copied my ath10k-ct driver from the 5.4 kernel (well tested driver)
over whatever ath10k code was in the particular kernel commit I was testing.  I tweaked
the driver slightly to compile and work against stock kernel.

The failure case is that when in station mode, and transmitting UDP in upload direction
(with a few packets per second of download traffic too),
the traffic periodically goes to zero throughput every 30 seconds, and stays quiesced
for about 5 seconds, and then resumes.  The station stays connected.

In previous debugging, I noticed this only happens when my driver enables mac80211
connection monitoring.  In a different bisect attempt, my driver hit the issue when
changing how tx-descriptor count was configured, but I am not fully confident that
is a root cause, and changing things a bit made that problem go away.

The problem is not seen with ath9k, nor stock ath10k.  Stock ath10k uses in-firmware
connection monitoring.

Felix, if you have any ideas of likely failure points, please let me know.

Thanks,
Ben

