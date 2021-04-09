Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706DD35A5CB
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 20:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhDISb1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 14:31:27 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:48699 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbhDISb0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 14:31:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617993074; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=l7DuZBcH6S8G0I8co4o9/uDuuMSudE7sOrUgkCoEiTg=;
 b=i1VTCdokJmGCDqW8KFiauplJP3jc427Jnh7NAuGhPkhsBhtK4yviduZTLGQPtfr1cnezeEwD
 Wmi/kOEeOb6L+p0FIFsjFK0VZnvrh7ptV+F/WNky5reran9AdW2KS/XkJ6+gjtCuxgV7QHqS
 OQkzCn9cwolPhxH7ijxIkAWQEqY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60709d6a8807bcde1d16e942 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 09 Apr 2021 18:31:06
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 18EB3C433C6; Fri,  9 Apr 2021 18:31:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 66837C433CA;
        Fri,  9 Apr 2021 18:31:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 09 Apr 2021 11:31:04 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v9 0/4] Multiple BSSID support
In-Reply-To: <cb1325ad538c3bf385b5bdadf03cfbf9f4afa390.camel@sipsolutions.net>
References: <20210310182604.8858-1-alokad@codeaurora.org>
 (sfid-20210310_192727_681722_4BC25758)
 <cb1325ad538c3bf385b5bdadf03cfbf9f4afa390.camel@sipsolutions.net>
Message-ID: <2427e22bdd9e34aec0667a78dd8d6537@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-04-08 05:17, Johannes Berg wrote:
> On Wed, 2021-03-10 at 10:26 -0800, Aloka Dixit wrote:
>> This patchset adds support for multiple BSSID and
>> enhanced multi-BSSID advertisements.
>> 
>> This version modifies only nl80211 patch (1/4) which describes
>> the difference.
>> 
>> John Crispin (4):
>>   nl80211: add basic multiple bssid support
>>   mac80211: add multiple bssid support to interface handling
>>   mac80211: add multiple bssid/EMA support to beacon handling
>>   mac80211: CSA on non-transmitting interfaces
> 
> Also, can we have hwsim support for proper testing? Seems with all the
> logic in mac80211 to give you the right beacons etc. that should be
> really simple?
> 
> johannes

Sure, will add hwsim tests.

BTW, do you see value in replacing all occurrences
of *_multiple_bssid_* with *_mbssid_* (also in new
nl80211 attributes).
Most lines needed to be split because of 80 character
boundary, so this replacement will make that code
look cleaner. I have avoided it till now to reduce
number of changes between versions.
Thanks.
