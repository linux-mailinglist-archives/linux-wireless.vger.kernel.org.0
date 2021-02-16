Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCF931D2C1
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Feb 2021 23:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhBPWmG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Feb 2021 17:42:06 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:37272 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229927AbhBPWmF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Feb 2021 17:42:05 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613515301; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=0YLpehCcwqH+i7w9iHB1W1poqAYgJCfaz7LTVz2vGs8=;
 b=BpgcO2AfhHk/Z3e1zqbtb2SUIMP0bT1aI+5+bsp3P8CdIB7HqTF0CXsMVp5+elrYQJ35FqFJ
 8Bsr1QBZFC07SG3Vg1jSyNPdcY38/8Ep7A7NeN/jQAERWB0kmIpk5ibNdbcgcAlESRYN2AMB
 3oMq/spw+AAYk+aXfZnkzJ+CaEU=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 602c4a042d3aa2c7080bfb45 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Feb 2021 22:41:08
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 79977C433C6; Tue, 16 Feb 2021 22:41:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D6587C433CA;
        Tue, 16 Feb 2021 22:41:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Feb 2021 14:41:07 -0800
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] nl80211: Commands for FILS discovery and unsolicited
 broadcast probe response
In-Reply-To: <9d9cc5bc50629090375b185a3af2546e506c22d9.camel@sipsolutions.net>
References: <20210120005229.32582-1-alokad@codeaurora.org>
 <20210120005229.32582-2-alokad@codeaurora.org>
 <ca7281ce-70bb-d1e2-3ec2-f07d91145c04@broadcom.com>
 <430f10a576b8490f73827f800c87f58c@codeaurora.org>
 (sfid-20210125_225531_667698_384A7632)
 <9d9cc5bc50629090375b185a3af2546e506c22d9.camel@sipsolutions.net>
Message-ID: <2fbdef8397607839c73fab66dd05c3c5@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-02-12 01:33, Johannes Berg wrote:
> On Mon, 2021-01-25 at 13:52 -0800, Aloka Dixit wrote:
>> 
>> FILS discovery and especially unsolicited probe response templates are
>> big. Sometimes send_and_recv() returns error due to memory
>> unavailability during wpa_driver_nl80211_set_ap() depending on how 
>> many
>> interfaces, which elements are added.
> 
> What? Where do you get errors from? Netlink even supports vmalloc now, 
> I
> believe, so the kernel really shouldn't care?
> 
The error was shown on hostapd side during attribute building when
16 interfaces were added on one radio and unsolicited broadcast
probe response feature was enabled.
It was resolved with a separate command for this feature instead of
being a part of NL80211_CMD_START_AP.

>> Moving these to separate commands
>> resolves this issue along with more control over the time interval
>> during run-time.
> 
> I tend to agree with Arend though, we have NL80211_CMD_SET_BEACON and
> since NL80211_CMD_NEW_BEACON was renamed to NL80211_CMD_START_AP to 
> more
> accurately say what it does, I think generalizing "AP modifications" by
> renaming NL80211_CMD_SET_BEACON to NL80211_CMD_UPDATE_AP (or such) 
> would
> make a lot of sense.
> 
> Let's not conflate the two issues here.
> 
> 1) memory issues - need to understand better
> 
> 2) update is needed - I'd say SET_BEACON/UPDATE_AP would be a better 
> way
>    than pulling everything into separate commands. Updates can be
>    partial too, after all, if you include only the changed attributes,
>    and that might even address case 1? I.e. why wouldn't userspace be
>    able to do UPDATE_AP multiple times, just like with your patch it
>    would do NL80211_CMD_SET_FILS_DISCOVERY
>    and NL80211_CMD_SET_UNSOL_BCAST_PROBE_RESP?
> 
> 
> Also, technically this constitutes an API break. One that perhaps 
> nobody
> cares about yet, but surely somebody already has hostapd versions that
> use NL80211_ATTR_FILS_DISCOVERY or NL80211_ATTR_UNSOL_BCAST_PROBE_RESP?
> After all, you don't want to tell me you never tested this code ;-)
> 
> johannes

I myself added the hostapd changes corresponding to the original kernel 
code,
This patch-set doesn't remove these attributes so, if accepted,
current hostapd calls will become no-op but won't break any other
functionality until I send the next version for separate commands for 
hostapd.

On a different note, a line was missed in nl80211_fils_discovery_policy
definition from my side in the original change so included it in this
patch-set.
Should I send a separate patch for that while we discuss regarding the 
separate
command?
Thanks.
