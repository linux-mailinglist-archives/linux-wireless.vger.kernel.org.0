Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EE4204DC3
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 11:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbgFWJU6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 05:20:58 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:19340 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731938AbgFWJU6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 05:20:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592904057; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=4pK2GVfsk9GrjgEBOBXaz11LGQLDCrNuIsbj/wlPZBk=; b=nUFWLILLCdZ0ks7tuANuF8znutme1GWBwSaw09feolQj5pf+6wuYGf+Ds9Lm00RMFtXc+IdI
 5LlXzQAYlvsr5pz+Plly1ONZOUp/DGJW5UE/yTkG2Fr9zpJpbPr0DSljyiZj4XWcCTAkzZd2
 zV1uEogXE/e/CUEvB///c+Vx/DM=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5ef1c9745866879c7685158b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 09:20:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3CC77C43395; Tue, 23 Jun 2020 09:20:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 907CCC433CA;
        Tue, 23 Jun 2020 09:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 907CCC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Reto Schneider <code@reto-schneider.ch>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/3] rtl8192cu: Fix deadlock
References: <20200622132113.14508-1-code@reto-schneider.ch>
        <20200622132113.14508-2-code@reto-schneider.ch>
        <6f1000a0-7a0a-36c9-21a3-1ea39175d051@lwfinger.net>
Date:   Tue, 23 Jun 2020 12:20:46 +0300
In-Reply-To: <6f1000a0-7a0a-36c9-21a3-1ea39175d051@lwfinger.net> (Larry
        Finger's message of "Mon, 22 Jun 2020 13:01:26 -0500")
Message-ID: <87k0zydtox.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> On 6/22/20 8:21 AM, Reto Schneider wrote:
>> Prevent code from calling itself indirectly, causing the driver to hang
>> and consume 100% CPU.
>>
>> Without this fix, the following script can bring down a single CPU
>> system:
>> ```
>> while true; do
>>    rmmod rtl8192cu
>>    modprobe rtl8192cu
>> done
>> ```
>>
>> Signed-off-by: Reto Schneider <code@reto-schneider.ch>
>
> I have one small comment. Patches for the rtlwifi family of drivers
> have patch subjects of the form [PATCH] rtlwifi: rtl8192cu: blah blah.
> I'll let Kalle decide if he wants ignore my comment, manually change
> the subjects, or request a V2. Otherwise all 3 patches are OK.

I can fix the titles during commit.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
