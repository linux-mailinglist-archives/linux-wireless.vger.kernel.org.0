Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0C7445202
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 04:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbfFNCwa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 22:52:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53814 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfFNCwa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jun 2019 22:52:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E8A4360265; Fri, 14 Jun 2019 02:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560480749;
        bh=2OzfHTsmEblGt2xfngsU6cjMNpk0syI/s5QaZz/HSWo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FjR0r/DfQVcYKNL+6WZtlpleYpeA4q5TMuxbTMLA65fbuv3KMhBQFTkQkIOdPVuVD
         f7g4CKwjlRsuzkd5Qvj5bvJAVRqsdc8TcQ0PcfFYbB2fK13pBlGmTEy5mZJYIdSya6
         Mg9CbGhOTM3354lVgyHqJgwLN6N9kl9AQVWfwhso=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 4156E60265;
        Fri, 14 Jun 2019 02:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560480749;
        bh=2OzfHTsmEblGt2xfngsU6cjMNpk0syI/s5QaZz/HSWo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FjR0r/DfQVcYKNL+6WZtlpleYpeA4q5TMuxbTMLA65fbuv3KMhBQFTkQkIOdPVuVD
         f7g4CKwjlRsuzkd5Qvj5bvJAVRqsdc8TcQ0PcfFYbB2fK13pBlGmTEy5mZJYIdSya6
         Mg9CbGhOTM3354lVgyHqJgwLN6N9kl9AQVWfwhso=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Jun 2019 10:52:29 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Zhi Chen <zhichen@codeaurora.org>
Subject: Re: [PATCH v2] mac80211: remove warning message
In-Reply-To: <bbfd69ccb4289ba3f1767c1066f61ee1@codeaurora.org>
References: <1557824507-17668-1-git-send-email-yiboz@codeaurora.org>
 <7c92f5cf51eaec1d5449698d90f5b6c5ca6c2bea.camel@sipsolutions.net>
 <ccb48284f0d96e72f4c041e12c943f0a@codeaurora.org>
 <e2a6596b99085541a5886c0d0d6393c849ac2d57.camel@sipsolutions.net>
 <34f72d5db336b9898618bf1c5c15ec41094d7d06.camel@perches.com>
 <4d013893-3302-14f0-c957-b3771f4b6b82@candelatech.com>
 <8eacb8e107c854b64a0c6116fca9731ddd99dcac.camel@sipsolutions.net>
 <730d3664-488d-7d57-04d5-1a57e91fa070@candelatech.com>
 <ea87337c24666355059488b42d97ee22711ce7b8.camel@sipsolutions.net>
 <bbfd69ccb4289ba3f1767c1066f61ee1@codeaurora.org>
Message-ID: <143d044082b54b2be41ba3760390d97f@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-05-20 21:56, Yibo Zhao wrote:
> On 2019-05-15 02:57, Johannes Berg wrote:
>> On Tue, 2019-05-14 at 11:54 -0700, Ben Greear wrote:
>>> 
>>> Here is the info I have in my commit that changed this to 
>>> WARN_ON_ONCE.
>>> I never posted it because I had to hack ath10k to get to this state, 
>>> so maybe
>>> this is not a valid case to debug.
>>> 
>>> 
>>> Maybe Yibo Zhao has a better example.
>>> 
>>>      mac80211: don't spam kernel logs when chantx is null.
>>> 
>>>      I set up ath10k to be chandef based again in order to test
>>>      WDS.  My WDS stations are not very functional yet, and
>>>      when ethtool stats are queried, there is a WARN_ON splat
>>>      generated.  Change this to WARN_ON_ONCE so that there is
>>>      less kernel spam.
>> 
>> I'm totally fine with WARN_ON_ONCE, FWIW.
>> 
>> Sounds like different bugs though. You're talking about WDS here, and
>> Yibo was talking about something with AP interfaces prematurely
>> accepting frames or so.
> 
> Yes, they might be different bugs that hit the same point. Looks like
> others found this too many warnings issue as well. Then I believe
> WARN_ON_ONCE() seems to be our solution for now.
> 
Hi Johannes,

May I know if it is fine that WARN_ON_ONCE() to be applied in kernel in 
the future? If a separate patch for it is needed, please let me know so 
that I can raise a new one.

>> 
>> johannes

-- 
Yibo
