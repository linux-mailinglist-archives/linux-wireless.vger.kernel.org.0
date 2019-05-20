Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 179A7238F9
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 15:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbfETN44 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 09:56:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34472 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfETN44 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 09:56:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0A489611CE; Mon, 20 May 2019 13:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558360615;
        bh=lpzkQhinW+CdE25UU6vfCZ3VEc/mSbUJunMa0yH8T5s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JKcQyElwaI7wbLWVWImvpOnu1joBYw36xjYUSudFiD/noouYIcZAWqsMlhryKlHCV
         NMqcsgqxzME6wQFvfapbWpFwAO1bHN2TJpTD6gkH6t1z3PU7Ir9/r7t7rG0SsL9w75
         DOvDrJLxv1FMdkN3uUzoHdAhxitbmqF/KpTY1dWk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9A6B2608D4;
        Mon, 20 May 2019 13:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558360612;
        bh=lpzkQhinW+CdE25UU6vfCZ3VEc/mSbUJunMa0yH8T5s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QyI6EFyC2jURPnStsICFWd1yeggqoqz7a/uzXQharivrl+6S5tQnXKzUTdIoyjzwE
         nbec4VFr4oDvh18pVKeVYKMF11riOvCKmSspPU/L74D627/AV0zDcUWAdGLIo54ylW
         kovjqkPyga01sCJMqy9EvSLStnHAAkgPMoiHC+Hc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 May 2019 21:56:52 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Zhi Chen <zhichen@codeaurora.org>
Subject: Re: [PATCH v2] mac80211: remove warning message
In-Reply-To: <ea87337c24666355059488b42d97ee22711ce7b8.camel@sipsolutions.net>
References: <1557824507-17668-1-git-send-email-yiboz@codeaurora.org>
 <7c92f5cf51eaec1d5449698d90f5b6c5ca6c2bea.camel@sipsolutions.net>
 <ccb48284f0d96e72f4c041e12c943f0a@codeaurora.org>
 <e2a6596b99085541a5886c0d0d6393c849ac2d57.camel@sipsolutions.net>
 <34f72d5db336b9898618bf1c5c15ec41094d7d06.camel@perches.com>
 <4d013893-3302-14f0-c957-b3771f4b6b82@candelatech.com>
 <8eacb8e107c854b64a0c6116fca9731ddd99dcac.camel@sipsolutions.net>
 <730d3664-488d-7d57-04d5-1a57e91fa070@candelatech.com>
 <ea87337c24666355059488b42d97ee22711ce7b8.camel@sipsolutions.net>
Message-ID: <bbfd69ccb4289ba3f1767c1066f61ee1@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-05-15 02:57, Johannes Berg wrote:
> On Tue, 2019-05-14 at 11:54 -0700, Ben Greear wrote:
>> 
>> Here is the info I have in my commit that changed this to 
>> WARN_ON_ONCE.
>> I never posted it because I had to hack ath10k to get to this state, 
>> so maybe
>> this is not a valid case to debug.
>> 
>> 
>> Maybe Yibo Zhao has a better example.
>> 
>>      mac80211: don't spam kernel logs when chantx is null.
>> 
>>      I set up ath10k to be chandef based again in order to test
>>      WDS.  My WDS stations are not very functional yet, and
>>      when ethtool stats are queried, there is a WARN_ON splat
>>      generated.  Change this to WARN_ON_ONCE so that there is
>>      less kernel spam.
> 
> I'm totally fine with WARN_ON_ONCE, FWIW.
> 
> Sounds like different bugs though. You're talking about WDS here, and
> Yibo was talking about something with AP interfaces prematurely
> accepting frames or so.

Yes, they might be different bugs that hit the same point. Looks like 
others found this too many warnings issue as well. Then I believe 
WARN_ON_ONCE() seems to be our solution for now.

> 
> johannes

-- 
Yibo
