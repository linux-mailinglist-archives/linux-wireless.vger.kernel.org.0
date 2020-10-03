Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0896F282320
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Oct 2020 11:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgJCJaU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Oct 2020 05:30:20 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:43572 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbgJCJaU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Oct 2020 05:30:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601717419; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=FzIU36C+hDT4BtAfB8saeMh3Wpo/oBl9snORYDlntFo=;
 b=aXk39uWX4iT5US5Sr0tpLMOtrQMVd3Ls6tVTG2tH8gDppNGV+Crpzj+TWURXyhlRM580UTGK
 WZhvU8ffepNICZzyJijY+K9fZlIedt6kUgCdSQNL6UtuCrk5T2WL0btao7OwYizzdq4hd8G6
 kT0zv2Dv4zHy9oLVfuZh/b66HYA=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f7844aaad37af35ec84938d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 03 Oct 2020 09:30:18
 GMT
Sender: rmanohar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D037CC433CA; Sat,  3 Oct 2020 09:30:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B91FC433C8;
        Sat,  3 Oct 2020 09:30:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 03 Oct 2020 02:30:18 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] cfg80211: add support to configure HE MCS for beacon rate
In-Reply-To: <f44add4463a8b171e8e207517f3ceae0542d23e2.camel@sipsolutions.net>
References: <1600143587-25327-1-git-send-email-rmanohar@codeaurora.org>
 <f44add4463a8b171e8e207517f3ceae0542d23e2.camel@sipsolutions.net>
Message-ID: <aaa10d95575451d02ce4b71ece457217@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-18 05:05, Johannes Berg wrote:
> On Mon, 2020-09-14 at 21:19 -0700, Rajkumar Manoharan wrote:
>> This allows an option to configure a single HE MCS beacon tx rate.
> 
> This breaks the ap_beacon_rate_legacy2 hwsim test but I'm not sure why,
> please check.
> 
Ah... Thanks for reporting... Hostapd has to clear VHT/HE rates while 
setting
legacy beacon tx rate. Otherwise the default he_mcs is filled and 
causing hwsim failure.
Posted a fix[1] for review.

Rajkumar

[1] 
http://patchwork.ozlabs.org/project/hostap/patch/1601717108-1030-1-git-send-email-rmanohar@codeaurora.org/
