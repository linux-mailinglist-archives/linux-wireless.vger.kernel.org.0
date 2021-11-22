Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB865458938
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 07:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhKVGP0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 01:15:26 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:38162 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhKVGPY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 01:15:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637561538; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=xU29svS3KQVWTEWMWOraYsY3lGEx0wZPSFXBuu5q/ns=;
 b=JGbiPlQGjhfbtUtQLCfPL9adv7qs+iBJykbqJARN4GsO3ia5JXrxC3SRKpcDtOiBeVfGXJHN
 jQO3snacFm7Gj2c04pEBI7Um05L+vW9nktyDC+poHUIdeEnlzfMi+Og250yy/zodTorzCLtv
 GW4Hd9u/ZYs4Cs+MWNyEJNhJ1KU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 619b34a2d8e58e6de1d08259 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Nov 2021 06:11:46
 GMT
Sender: vjakkam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6EC55C4360D; Mon, 22 Nov 2021 06:11:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: vjakkam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2268BC4338F;
        Mon, 22 Nov 2021 06:11:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Nov 2021 11:41:45 +0530
From:   vjakkam@codeaurora.org
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] nl80211: Indicate SA Query procedures offload for AP SME
 device
In-Reply-To: <1dd3525ee437ff2ccf18b455851692338af342fa.camel@sipsolutions.net>
References: <1634210331-9001-1-git-send-email-vjakkam@codeaurora.org>
 <612e80125878bae6fccbb72701381832a8a6029c.camel@sipsolutions.net>
 <5a1f654e3406e99c816afbc762519fea@codeaurora.org>
 <69995d6c767edcea15ef7645fabc0e39c0dc7960.camel@sipsolutions.net>
 <7c5b87329c58ac2b68329573f587f8d7@codeaurora.org>
 <1dd3525ee437ff2ccf18b455851692338af342fa.camel@sipsolutions.net>
Message-ID: <db3cb409449c5aad18e5ade28a1ca2a7@codeaurora.org>
X-Sender: vjakkam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-10-25 13:58, Johannes Berg wrote:
> On Mon, 2021-10-25 at 13:57 +0530, vjakkam@codeaurora.org wrote:
>> On 2021-10-22 18:59, Johannes Berg wrote:
>> > On Fri, 2021-10-22 at 18:56 +0530, vjakkam@codeaurora.org wrote:
>> > > >
>> > > > So how's that going to work with older hostapd? It'll be offloaded, and
>> > > > then hostapd doesn't know, so it's still going to disconnect them?
>> > > >
>> > > > So should be that hostapd also opts in to this driver behaviour?
>> > >
>> > > yes, we have to update hostapd also with new implementation based on
>> > > the
>> > > feature flag.
>> >
>> > That wasn't my question. My question was what happens if you have a
>> > hostapd that's *not* updated?>
>> >
>> > johannes
>> 
>> Apologies for not clear answer in my previous reply.
>> Yes, If hostapd is not updated, it's going to disconnect the STAs.
>> 
>> We should update hostapd also to opt in this driver behavior.
> 
> That would also mean the driver opts in and asks the firmware to 
> offload
> only if hostapd did, right?
> 
> johannes

Yeah, Thanks for the comments.
I will upload v2 patch with suggested changes.
