Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992F22FA46A
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jan 2021 16:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405668AbhARPTQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jan 2021 10:19:16 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:12356 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405634AbhARPSu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jan 2021 10:18:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610983111; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=bKU8OpEtzRhRQCN/kxvAQW3ptB9i0ZzlwbatxoPrygk=; b=IBiGqujrCh4uFK14vG3CwAadVo6zfyZqLybwzMrW69Z6NZD114WJmXsxONxojBSzuvx06vxj
 mG4LlITK5+65Z5bLZkqex26jGGi1Fg5RzFD3dsEatSHqmvfTjIxnki3yV8yb5C+NPTwsW8Qs
 sYYYmg2Cxgu0HbjHeBqVbHm0UX8=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6005a6bf02b2f1cb1af34bd6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Jan 2021 15:18:23
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 31004C43461; Mon, 18 Jan 2021 15:18:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E3236C433CA;
        Mon, 18 Jan 2021 15:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3236C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH for v5.11 11/12] iwlwifi: pcie: use jiffies for memory read spin time limit
References: <20210115110558.1248847-1-luca@coelho.fi>
        <iwlwifi.20210115130253.621c948b1fad.I3ee9f4bc4e74a0c9125d42fb7c35cd80df4698a1@changeid>
        <875z3ugtsd.fsf@codeaurora.org>
Date:   Mon, 18 Jan 2021 17:18:19 +0200
In-Reply-To: <875z3ugtsd.fsf@codeaurora.org> (Kalle Valo's message of "Mon, 18
        Jan 2021 17:16:02 +0200")
Message-ID: <871reigtok.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Luca Coelho <luca@coelho.fi> writes:
>
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> There's no reason to use ktime_get() since we don't need any better
>> precision than jiffies, and since we no longer disable interrupts
>> around this code (when grabbing NIC access), jiffies will work fine.
>> Use jiffies instead of ktime_get().
>>
>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>
> What bug does this fix? After reading the commit log to me this looks
> like more like cleanup and is better for -next.

Ah, this is a dependency for patch 12. I'll mention this in the commit
log, but please correct me if I have misunderstood.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
