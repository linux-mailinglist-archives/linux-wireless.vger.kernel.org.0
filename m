Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5390944CAA9
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Nov 2021 21:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhKJUfk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 15:35:40 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.48]:55646 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230230AbhKJUfk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 15:35:40 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.66.134])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 1BA671A007B
        for <linux-wireless@vger.kernel.org>; Wed, 10 Nov 2021 20:32:51 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id EEE5C68007E
        for <linux-wireless@vger.kernel.org>; Wed, 10 Nov 2021 20:32:50 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 6541D13C2B0
        for <linux-wireless@vger.kernel.org>; Wed, 10 Nov 2021 12:32:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6541D13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1636576370;
        bh=zPvpu4AoKbh0tlYEfUlhJG2XObzIPJEbgW8gdsXhywE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=OmxCZZEDQO25Ffz0lvP5lgJ4EsvYbPMVQdWdhK5M0PmIqhuKNTXKBgt/St8l2Esr5
         grIyg1hfVze2CYfnzRuVC1j7GrMC1YtSq0Ik9ukQmfEJo7S4IMc+c8a1YiXrUIlzKO
         z+aokIzkIJlZge73I7+FxbtX2JWrxQV+UAsjcQq0=
Subject: Re: [PATCH v3 2/2] mt76: mt7915: fix radar detector logic
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20210820203531.20706-1-greearb@candelatech.com>
 <20210820203531.20706-2-greearb@candelatech.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <950c52e2-8422-36f0-9024-55e45ef2672c@candelatech.com>
Date:   Wed, 10 Nov 2021 12:32:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20210820203531.20706-2-greearb@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1636576371-q2QZyQ1PgtQA
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/20/21 1:35 PM, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> Before this patch, if AP went from ch 100 to ch 36, the radar detector
> logic in the firmware was not being disabled.  This made the AP appear
> to be up, but no beacons were seen on air until module reload or
> reboot.
> 
> To reproduce this, I change hostapd.conf and restart hostapd.  Others
> on openwrt used their UI to make changes and problem was seen, but
> stil others changed channels in some other way and/or had some other
> difference and could *not* reproduce it.  So, something perhaps a
> bit subtle.
> 
> To fix the problem, stop depending on comparing dfs_state, store last
> freq/bandwidth to detect changes in that, and streamline code that
> checks to enable/disable radar detection.  And add in error checking
> and dev_dbg logic so one can see what is actually happening if need
> to debug this again.

Back when I was working on this, someone sent me an email or chat or something
about some other way to do this that was simpler and just relied on
mac80211 timers.  But, I cannot find that email for the life of me.

In case you are reading, please resend!  Evidently this 2/2 patch had
some regression for someone so it is not acceptable upstream in
current state...maybe the mac80211 option is best.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

