Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A634F13BA6B
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 08:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgAOHks (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 02:40:48 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:64704 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbgAOHks (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 02:40:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579074047; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=ZdGbrm9v1PsnbuITIu0oiR/1DgzctAFZVd9crSlWywE=; b=XCJSDhyy+o6UigmFX0JlV4MVRtQG+7SK9ZwJstRbmLx5JUPtn70PZHSGPTwsglH6/Zf4+lR3
 WzxFIEeKBNOSNgcWA7b6FqVFsYNLoU52+jhzZGuY8iRFaCVcKwgWS3qpu2NFINARt1vvSVrY
 eHha3zZJWlZzRPNfu1dQIUsiVN0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1ec1fa.7f79c196cf48-smtp-out-n01;
 Wed, 15 Jan 2020 07:40:42 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 20FE7C4479C; Wed, 15 Jan 2020 07:40:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F035EC433CB;
        Wed, 15 Jan 2020 07:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F035EC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Orr Mazor <orr.mazor@tandemg.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] subsystem: Fix radar event during another phy CAC
References: <20191222145449.15792-1-Orr.Mazor@tandemg.com>
Date:   Wed, 15 Jan 2020 09:40:37 +0200
In-Reply-To: <20191222145449.15792-1-Orr.Mazor@tandemg.com> (Orr Mazor's
        message of "Sun, 22 Dec 2019 14:55:31 +0000")
Message-ID: <87d0bl1822.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Orr Mazor <orr.mazor@tandemg.com> writes:

> In case a radar event of CAC_FINISHED or RADAR_DETECTED
> happens during another phy is during CAC we might need
> to cancel that CAC.
> If we got a radar in a channel that another phy is now
> doing CAC on then the CAC should be canceled.
> If, for example, 2 phys doing CAC on the same channels,
> or on comptable channels, once on of them will finish his CAC
> the other might need to cancel his CAC, since it is no
> longer relevant.
>
> To fix that the commit adds an callback and implement it in mac80211
> to end CAC.
> This commit also adds a call to said callback if after a radar
> event we see the cac is no longer relevant
>
> Signed-off-by: Orr Mazor <Orr.Mazor@tandemg.com>

The title prefix should be "cfg80211: ", not "subsystem: ".

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
