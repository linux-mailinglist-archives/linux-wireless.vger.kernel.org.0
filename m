Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D357D193F5C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 13:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgCZM4p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 08:56:45 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:64764 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728187AbgCZM4p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 08:56:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585227404; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=A7Jy2EkPuwu+F4+Sy9G8Cbw1f367pXRHDz6wpS/DUUg=; b=KvK9YGALS0sH39Uqkpc3EEG/PuhWWvslGI2taBF27uoRkwoBMwJqsAbjQ6OPmwbp7d0EveoO
 U/YqK9ekuIF48wtqFn6BByBBx7BE8AI1xuax/loUZEl8XD744SwG1yJKJzeCm7MmI1x6Xdv5
 DtTxyjzWJb5gFTCn5vn0y29Urog=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7ca68a.7f94bbe4c7a0-smtp-out-n05;
 Thu, 26 Mar 2020 12:56:42 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A6597C433D2; Thu, 26 Mar 2020 12:56:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E31CCC43636;
        Thu, 26 Mar 2020 12:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E31CCC43636
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 01/12] mac80211: implement Operating Mode Notification extended NSS support
References: <20200326120042.578777-1-luca@coelho.fi>
        <20200326120042.578777-2-luca@coelho.fi>
Date:   Thu, 26 Mar 2020 14:56:37 +0200
In-Reply-To: <20200326120042.578777-2-luca@coelho.fi> (Luca Coelho's message
        of "Thu, 26 Mar 2020 14:00:31 +0200")
Message-ID: <87o8sjp94q.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> Somehow we missed this for a long time, but similar to the extended
> NSS support in VHT capabilities, we need to have this in Operating
> Mode notification.
>
> Implement it by
>  * parsing the 160/80+80 bit there and setting the bandwidth
>    appropriately
>  * having callers of ieee80211_get_vht_max_nss() pass in the current
>    max NSS value as received in the operating mode notification in
>    order to modify it appropriately depending on the extended NSS
>    bits.
>
> This updates all drivers that use it, i.e. only iwlwifi/mvm.
>
> Change-Id: I4e8c25d3288441759c2793247197229f0696a37d

All patches have Change-Id tag.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
