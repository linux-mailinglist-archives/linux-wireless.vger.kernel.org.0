Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2F4360FC8
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 18:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbhDOQFJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 12:05:09 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:20408 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbhDOQFI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 12:05:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618502685; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=4E2s8oryTBXf1UCWo/s+gPkmUGJYu7btSYm+HkBY2Jc=; b=ORPx9cOC4vIGz1iLGHGK9NcMrDvqA9Tz+WyURjicXGEMZuBQzre1yHMHg5cDf3k9vm5md+lX
 IpYKHoKajTvVuo2Fb3lA/7+kWZ47vJVT8z4E7U9HU3TtUSwgzQBF81AP88aVJGdZ2Y2zDjye
 4IxUBWZYxeWsQN+qMWJ9hBtAr2M=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 607864149a9ff96d95892d0f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 15 Apr 2021 16:04:36
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4B7A3C43463; Thu, 15 Apr 2021 16:04:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A568C433ED;
        Thu, 15 Apr 2021 16:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A568C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     jikos@kernel.org, hdegoede@redhat.com, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH for -next] iwlwifi: pcie: don't enable BHs with IRQs disabled
References: <iwlwifi.20210415164821.d0f2edda1651.I75f762e0bed38914d1300ea198b86dd449b4b206@changeid>
        <bab37babea4f2972ef222e1dcaff7ab966ab15a8.camel@coelho.fi>
Date:   Thu, 15 Apr 2021 19:04:32 +0300
In-Reply-To: <bab37babea4f2972ef222e1dcaff7ab966ab15a8.camel@coelho.fi> (Luca
        Coelho's message of "Thu, 15 Apr 2021 16:52:35 +0300")
Message-ID: <875z0nlejz.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> On Thu, 2021-04-15 at 16:48 +0300, Luca Coelho wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>> 
>> After the fix from Jiri that disabled local IRQs instead of
>> just BHs (necessary to fix an issue with submitting a command
>> with IRQs already disabled), there was still a situation in
>> which we could deep in there enable BHs, if the device config
>> sets the apmg_wake_up_wa configuration, which is true on all
>> 7000 series devices.
>> 
>> To fix that, but not require reverting commit 1ed08f6fb5ae
>> ("iwlwifi: remove flags argument for nic_access"), split up
>> nic access into a version with BH manipulation to use most
>> of the time, and without it for this specific case where the
>> local IRQs are already disabled.
>> 
>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>> ---
>
> Kalle, I'm going to assign this one to you too, but this time for -next
> and not for -fixes.
>
> This is related to the fix Jiri made, but to avoid some conflicts and a
> broken v5.13-rc, we want to get it into v5.13 if still possible.
>
> So can you please take this on top of my latest pull request?
> Additionally, can you tag it for stable?

Will do.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
