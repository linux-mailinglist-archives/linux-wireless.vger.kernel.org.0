Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD183124406
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 11:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLRKMf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 05:12:35 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:62582 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbfLRKMf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 05:12:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576663955; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=MYBjK0EB6uxWlrDf2EdJWdB3BIabJ0S3eRvn7HHYhLA=;
 b=gDsVpmZDYUPVaVu01AyWqLJj2Q8i+9xrApOUjgDayB6lKqa8bqpB1Cr8OV0qD5yeyZJGl+I4
 WuL3yXa4Jxq/7VTJwjGtSEtmdkfaDihGccj49Oehhb+gAAzBO6VaN4VxsfLjlK/XZpZbtwP8
 sGw1cBtz+aa2dy7ltyuV4E829zA=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df9fb91.7f7a4dd94ed8-smtp-out-n01;
 Wed, 18 Dec 2019 10:12:33 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C12EFC4479F; Wed, 18 Dec 2019 10:12:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: yiboz)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 60A4FC4479C;
        Wed, 18 Dec 2019 10:12:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 18 Dec 2019 18:12:32 +0800
From:   yiboz@codeaurora.org
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH 2/4] mac80211: fix issue in loop scenario
In-Reply-To: <94471b2381bee394f9708eae8ba47129f3facd03.camel@sipsolutions.net>
References: <1576221593-1086-1-git-send-email-yiboz@codeaurora.org>
 <1576221593-1086-3-git-send-email-yiboz@codeaurora.org>
 (sfid-20191213_082426_564220_0827923D)
 <94471b2381bee394f9708eae8ba47129f3facd03.camel@sipsolutions.net>
Message-ID: <6f092bd44cfc581a219bd0f0506cc636@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

在 2019-12-13 17:56，Johannes Berg 写道：
> On Fri, 2019-12-13 at 15:19 +0800, Yibo Zhao wrote:
>> In a loop txqs dequeue scenario, if the first txq in the rbtree gets
>> removed from rbtree immediately in the ieee80211_return_txq(), the
>> loop will break soon in the ieee80211_next_txq() due to schedule_pos
>> not leading to the second txq in the rbtree. Thus update schedule_pos
>> to previous node once the node of schedule_pos is either removed from
>> rbtree or move to other location in rbtree due to airtime update.
> 
> For my understanding - this is a fix to the first patch in the series?
> 
> I guess you didn't squash it because that's Toke's patch or something?
> 
> I tend to think you still should, and annotate the changes, but I 
> wanted
> to understand it first.

Hi Johannes,

Yes, this is a fix to the first patch. Actually, the rest of two patches 
are also serve the same. So, are you suggesting to merge them to the 
first patch?

Previouly, I had added Toke's signature in this patch but Toke advised 
to delete it. I feel a little bit confused about how to handle it. 
Appreciate any detail guide.
> 
> johannes
