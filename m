Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960AF2CC539
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Dec 2020 19:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389433AbgLBScu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Dec 2020 13:32:50 -0500
Received: from a2.mail.mailgun.net ([198.61.254.61]:10564 "EHLO
        a2.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389394AbgLBScu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Dec 2020 13:32:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606933949; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=z4ex2xWHM9oo1+cfgsv89wcMjpIcCFP5kDE4fNik8iM=; b=SiGZ4rlAVmsolVky5qAY7kNQeEtvls1Aaky0PeWqujQCrjdmzEun9EuqCrWGmShOmY09QiS8
 oRHlVkVR6E4UpJMBFq4c8CQ9V0ezCey9QJHb8jbCjCE4/gyqQXjfTNFwBD60cA9UckYdj1Nu
 lRkWyrQXVkF9j5LA5+9CWMeIjjg=
X-Mailgun-Sending-Ip: 198.61.254.61
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5fc7dda04a918fcc07841b43 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Dec 2020 18:32:00
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 02001C43461; Wed,  2 Dec 2020 18:32:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 698C4C433C6;
        Wed,  2 Dec 2020 18:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 698C4C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rakesh Pillai <pillair@codeaurora.org>,
        Abhishek Kumar <kuabhs@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>
Subject: Re: [PATCH v3] ath10k: Fix the parsing error in service available event
References: <1605501291-23040-1-git-send-email-pillair@codeaurora.org>
        <CAD=FV=Xnk-VeZKy3vzr4VZNW+OogfwEAjU-QVHQRYD-yix8LPQ@mail.gmail.com>
Date:   Wed, 02 Dec 2020 20:31:55 +0200
In-Reply-To: <CAD=FV=Xnk-VeZKy3vzr4VZNW+OogfwEAjU-QVHQRYD-yix8LPQ@mail.gmail.com>
        (Doug Anderson's message of "Fri, 20 Nov 2020 16:26:07 -0800")
Message-ID: <87a6uwhxes.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Doug Anderson <dianders@chromium.org> writes:

> Hi,
>
> On Sun, Nov 15, 2020 at 8:35 PM Rakesh Pillai <pillair@codeaurora.org> wrote:
>>
>> The wmi service available event has been
>> extended to contain extra 128 bit for new services
>> to be indicated by firmware.
>>
>> Currently the presence of any optional TLVs in
>> the wmi service available event leads to a parsing
>> error with the below error message:
>> ath10k_snoc 18800000.wifi: failed to parse svc_avail tlv: -71
>>
>> The wmi service available event parsing should
>> not return error for the newly added optional TLV.
>> Fix this parsing for service available event message.
>>
>> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2-00720-QCAHLSWMTPL-1
>>
>> Fixes: cea19a6ce8bf ("ath10k: add WMI_SERVICE_AVAILABLE_EVENT support")
>> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
>> ---
>> Changes from v2:
>> - Add code documentation explaining the necessity of variable
>>   initialization for the logic to work.
>> ---
>>  drivers/net/wireless/ath/ath10k/wmi-tlv.c | 4 +++-
>>  drivers/net/wireless/ath/ath10k/wmi.c     | 9 +++++++--
>>  drivers/net/wireless/ath/ath10k/wmi.h     | 1 +
>>  3 files changed, 11 insertions(+), 3 deletions(-)
>
> This looks nice to me now.  I will let Kalle decide what to do about
> the checkpatch issue that Abhishek found (ignore, fix himself, or
> request another spin).

Currently ath10k uses mixed of both comment styles and I have disabled
that patchwork check in my ath10k-check script. I should finally try to
unify that and make all ath10k comments to use the networking style,
patches very welcome :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
