Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDF02705E7
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 22:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgIRUCf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 16:02:35 -0400
Received: from so254-54.mailgun.net ([198.61.254.54]:44751 "EHLO
        so254-54.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgIRUCe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 16:02:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600459354; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=WX55SdmlaYi0LcCP7mQq8vImMerEBt+6G/ZMeYl0iXw=;
 b=jvKExkKgpBG1kFxOLaWUP4o1/he8kBzt2MVVHpjgETejeT31M3Jr4IDMbSXAz1Rp1Cu0Etg9
 lYj83LV/mq66cEAbiju1t8a+Vty9kczoOwcK/RD7irbf2oAjx/gOu4A4zWvNvOat84pFj4vn
 EaxuVxcXQBDfrkEVJ1C0vilxLoo=
X-Mailgun-Sending-Ip: 198.61.254.54
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f65121c2131f7663a48f638 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Sep 2020 20:01:32
 GMT
Sender: rmanohar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 52E16C433C8; Fri, 18 Sep 2020 20:01:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1A760C433CA;
        Fri, 18 Sep 2020 20:01:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Sep 2020 13:01:32 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] iw: support HE rate configuration in 6 GHz band
In-Reply-To: <8a3380b3d3f12610e8cf4c6d51f5a33fed7b85c6.camel@sipsolutions.net>
References: <1600276451-3259-1-git-send-email-rmanohar@codeaurora.org>
 <cff3474685590bbc9663f970bb0a4a10143d3913.camel@sipsolutions.net>
 <fe2b37ecbe10eb1ceb2b25eaabb76efa@codeaurora.org>
 <8a3380b3d3f12610e8cf4c6d51f5a33fed7b85c6.camel@sipsolutions.net>
Message-ID: <0fe60ead4260aea18a6e2ce8c6e6387f@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-18 12:19, Johannes Berg wrote:
> On Fri, 2020-09-18 at 11:49 -0700, Rajkumar Manoharan wrote:
>> On 2020-09-18 04:25, Johannes Berg wrote:
>> > On Wed, 2020-09-16 at 10:14 -0700, Rajkumar Manoharan wrote:
>> > > Allow HE-MCS, HE-GI, HE-LTF in 6 GHz band as well and allow only
>> > > MCS rates in 6 GHz.
>> >
>> > This doesn't apply at all, please respin.
>> >
>> My bad. Forgot to mention that this change depends on "iw: add HE
>> rate/gi/ltf support".
>> 
>> https://patchwork.kernel.org/patch/11364395/
> 
> Oh. But can I apply that? I think the kernel bits weren't there? But I
> get confused with John's patch series'...
> 
The kernel bits are available in mac80211-next. Thought you sync 
nl80211.h from -next tree.
If so, you can apply John's patch as well as mine.

https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git/commit/include/uapi/linux/nl80211.h?id=eb89a6a6b7a1af2d9c8d83ee44fa67700d6337e7

Sorry if I confused you further. :)

Rajkumar
