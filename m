Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8E8322248
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Feb 2021 23:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhBVWmJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Feb 2021 17:42:09 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:62272 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231723AbhBVWlz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Feb 2021 17:41:55 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614033706; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=hFjUAOZ7u63AI9ublwtyX5L63eqbhEid0wjw6PbzIbY=;
 b=Ix5BuVoIPdd2Oiq65aPYCIdj5SRgp5qPoE/RR280y7ZPSq2aNbzGXJc5xRHFO9IUqeUYvz2R
 WBolyl0Ht0ZXsXA/hPMj0OvXswRQ7zqGff0w6DjYxuLX3d8s5lapEIUO8VKEVvL88oM6khZC
 Q8VLqHdTi7hrRHGGerp8JyZe8G0=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 603432fee87943df306edb4b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Feb 2021 22:41:02
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A7ADCC433ED; Mon, 22 Feb 2021 22:41:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 595F8C433C6;
        Mon, 22 Feb 2021 22:41:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Feb 2021 14:41:01 -0800
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH V7 0/4] mac80211: add multiple bssid support
In-Reply-To: <c3b48c141c763e0cc1beb74482cd0bb4fbc546aa.camel@sipsolutions.net>
References: <20210120005120.32424-1-alokad@codeaurora.org>
 (sfid-20210120_015542_749517_52354F67)
 <c3b48c141c763e0cc1beb74482cd0bb4fbc546aa.camel@sipsolutions.net>
Message-ID: <64f490e2a559a0ed33c59d0fc7326582@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-02-12 01:59, Johannes Berg wrote:
> Hi,
> 
>> John Crispin (4):
>>   nl80211: add basic multiple bssid support
>>   mac80211: add multiple bssid support to interface handling
>>   mac80211: add multiple bssid/EMA support to beacon handling
>>   mac80211: CSA on non-transmitting interfaces
> 
> As much as I hate to send this back to you ...
> 
> I don't understand how you can not have an nl80211 feature flag for AP-
> side multi-BSSID support, yet have a mac80211-level feature flag?
> 
> For STA side we could get away with it because we present all the BSSes
> in cfg80211's scan results, and even a version of wpa_supplicant that's
> not aware of multi-BSSID should be able to pick one of the non-
> transmitting BSSes and connect to it.
> 
> But here? I don't understand how that'd be possible.
> 

Will add nl80211 feature flags for MBSSID and EMA.

> Also, are the interface limits (# of AP interfaces) even sufficient, or
> should there be different limits for non-transmitting? I could imagine
> that it'd be easier to have more interfaces if they're 
> non-transmitting,
> since then you don't have to deal with more beacons but only more MAC
> addresses.
> 

This implementation allows a single MBSSID-set, so only one transmitting
interface per wiphy.
Even if non-transmitting don't have beacons associated, drivers will 
have
limit depending on contexts allocated for other interface 
characteristics.
Hence these limits are accepted using 'max_num_vaps' and
'max_profile_periodicity'.

> So from that POV this seems rather lacking the necessary bits to be 
> able
> to confidently use it from userspace?
> 
> johannes

Next version will have feature flags as well as max VAPs and profile
periodicity exposed to application.

