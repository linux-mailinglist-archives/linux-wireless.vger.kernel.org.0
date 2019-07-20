Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9D0C6F051
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2019 20:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfGTSVf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Jul 2019 14:21:35 -0400
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:59560 "EHLO
        1.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfGTSVf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Jul 2019 14:21:35 -0400
X-Greylist: delayed 6301 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Jul 2019 14:21:34 EDT
Received: from player696.ha.ovh.net (unknown [10.108.57.53])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id 7F23210CDA3
        for <linux-wireless@vger.kernel.org>; Sat, 20 Jul 2019 18:26:29 +0200 (CEST)
Received: from milecki.pl (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player696.ha.ovh.net (Postfix) with ESMTPSA id 7A56F8382E0F;
        Sat, 20 Jul 2019 16:26:25 +0000 (UTC)
Subject: Re: [PATCH] brcmfmac: change the order of things in brcmf_detach()
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Piotr Figiel <p.figiel@camlintechnologies.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <1556532561-24428-1-git-send-email-arend.vanspriel@broadcom.com>
 <20190430081142.GA27822@phoenix>
 <74b9f312-8c1a-daa8-6137-c664d37f06d1@broadcom.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Message-ID: <b0cacc7a-22b2-82dd-f2e0-154abf1c9f69@milecki.pl>
Date:   Sat, 20 Jul 2019 18:26:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <74b9f312-8c1a-daa8-6137-c664d37f06d1@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 4662632991080156721
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieelgddutdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 30.04.2019 12:10, Arend Van Spriel wrote:
> On 4/30/2019 10:11 AM, Piotr Figiel wrote:
>> Hi Arend,
>>
>> On Mon, Apr 29, 2019 at 12:09:21PM +0200, Arend van Spriel wrote:
>>> When brcmf_detach() from the bus layer upon rmmod we can no longer
>>> communicate. Hence we will set the bus state to DOWN and cleanup
>>> the event and protocol layer. The network interfaces need to be
>>> deleted before brcmf_cfg80211_detach() because the latter does the
>>> wiphy_unregister() which issues a warning if there are still network
>>> devices linked to the wiphy instance.
>>
>> This seems to already happen - brcmf_cfg80211_detach() is called after the
>> interfaces are removed.
> 
> Right. This was just to remind me why brcmf_cfg80211_detach() must be called after removing the interfaces.
> 
>>> This change solves a null pointer dereference issue which happened
>>> upon issueing rmmod while there are packets queued in bus protocol
>>> layer.
>>>
>>> Reported-by: Rafał Miłecki <rafal@milecki.pl>
>>> Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
>>> Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
>>> Reviewed-by: Franky Lin <franky.lin@broadcom.com>
>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>> ---
>>> Hi Piotr,
>>>
>>> While working on an issue with msgbuf protocol (used for PCIe devices)
>>> your change 5cdb0ef6144f ("brcmfmac: fix NULL pointer derefence during
>>> USB disconnect") conflicted. I suspect my reordering stuff in
>>> brcmf_detach() also fixes your issue so could you retest this patch,
>>> which basically reverts your change and applies my reordering, and see
>>> whether my suspicion can be confirmed.
>>
>> Does the issue reported by Rafał you are trying to solve with this patch occur
>> on current linux-next?
> 
> Looking at you patch I suspect it does, because brcmf_proto_msgbuf_detach() is invoked in brcmf_proto_detach_post_delif(). However, I could not reproduce it with or without the patch.
> 
> Rafał,
> 
> Do you know whether your reported issue, ie. calling brcmf_tx_finalize() after interfaces were removed, still exists in wireless-testing (or linux-next).

Sorry for a terribly late reply. It took me many attempts to crash a
firmware in a fully reproducible way.

I can say for sure this patch fixes crashes in brcmf_txfinalize() I saw
when unloading brcmfmac after a crash.
