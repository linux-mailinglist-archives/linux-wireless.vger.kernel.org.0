Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A19A194F7D
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 23:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfHSVAD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 17:00:03 -0400
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:58092 "EHLO
        9.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfHSVAD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 17:00:03 -0400
Received: from player755.ha.ovh.net (unknown [10.108.42.75])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id 644151025AB
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2019 22:50:50 +0200 (CEST)
Received: from awhome.eu (p4FF9179D.dip0.t-ipconnect.de [79.249.23.157])
        (Authenticated sender: postmaster@awhome.eu)
        by player755.ha.ovh.net (Postfix) with ESMTPSA id E59C090B6EAD;
        Mon, 19 Aug 2019 20:50:46 +0000 (UTC)
Subject: Re: [PATCH] iwlwifi: Extended Key ID support for mvm and dvm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1566247846;
        bh=vWC3/wW/csnaR/+Rsx8WN7OJ+Enhk24DjISGYj98Oyc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HrMHO8hLorbZwlLDTY0N1NVsrzCfEi8YfSOo594+2MNZX8/mDR1fTCgMJJ8kCu0u9
         FO5dsGmJRL6gMaLImDlDRG+iB/gTy07mrmZDQXZf0L/zpoK+C0h8aA1mdi510xHXPk
         BMWz2yierKSGJrhw7hXr5dcvRO6m2VTuC+zLU960=
To:     Johannes Berg <johannes@sipsolutions.net>, luciano.coelho@intel.com
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
References: <20190819180540.2855-1-alexander@wetzel-home.de>
 <204c346ab9fc71865e4cb5f5c29ec33ca05050e2.camel@sipsolutions.net>
 <da471544-3370-8ba1-2265-d02ab09cdcee@wetzel-home.de>
 <52914e64663283eeff9445b8b1fb37986c15223d.camel@sipsolutions.net>
 <5bc077f7b2f017da7c027edd27a543910dd6ac32.camel@sipsolutions.net>
From:   Alexander Wetzel <alexander@wetzel-home.de>
Message-ID: <9e63e06d-48ef-e7aa-638a-b551a208665f@wetzel-home.de>
Date:   Mon, 19 Aug 2019 22:50:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5bc077f7b2f017da7c027edd27a543910dd6ac32.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 840484282674453704
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudefledgudehhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Am 19.08.19 um 22:09 schrieb Johannes Berg:
> On Mon, 2019-08-19 at 22:03 +0200, Johannes Berg wrote:
>>
>>> While less desirable we still could get that working: The mvm driver
>>> would have to detect the key borders and then tell the firmware to
>>> switch over to the other key. But we would have to make sure to not
>>> re-enable A-MPDU aggregation till the card really has switched.
> 
>> So probably you're right, and we'd have to disable A-MPDUs until we have
>> no outstanding old-key-retransmits, but that seems manageable.
> 
> Actually, we probably have to even delay the key switch until there are
> no more frames to retransmit, because the hardware is involved to some
> extent and it won't know about two keys or something... Not really sure
> how it all works though, off the top of my head.

This sounds like the card is not really able to handle two unicast key 
per STA, which would be a show stopper.
But not sure if I can believe that: After all the card is setting the 
correct keyid for the key and e.g. able to use keyid 1 for both send and 
receive, so it's not simply assuming unicast keys are always using keyid 0.

Honoring the keyid for that but then not be able to differentiate 
between the keyids for re-transmits is nothing I would have expected. So 
I still hope you are wrong here:-)

Alexander
