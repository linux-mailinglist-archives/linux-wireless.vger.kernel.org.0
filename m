Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97B432AF81
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Mar 2021 04:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbhCCAZ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Mar 2021 19:25:29 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:20672 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382143AbhCBI42 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Mar 2021 03:56:28 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614675360; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=8krkIsgp68wHhS+liGQXlnkyDDn+zrlQACVVaDV4MCQ=; b=T7pizLZ8OIsV4mUGkM74PHZlSC96svS0Y9Lw1qAV8gG+nLwSY9pmDVih8Y9pkdTYMbkLBFZr
 HPYkAqPGXxdCcCeWwQUz6QDLn2Snjry5BfriDp7kNAitdOimoFjebzc/LoW6wiE6fh24zhOj
 aX8b6mTtgi31oLfTe6FzYGYSHjo=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 603df6939d2570c9febc02a0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Mar 2021 08:25:55
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B4A91C433CA; Tue,  2 Mar 2021 08:25:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D34CBC43461;
        Tue,  2 Mar 2021 08:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D34CBC43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "Coelho\, Luciano" <luciano.coelho@intel.com>
Cc:     "pierre-louis.bossart\@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Berg\, Johannes" <johannes.berg@intel.com>,
        "davem\@davemloft.net" <davem@davemloft.net>,
        "kuba\@kernel.org" <kuba@kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] iwlwifi: fix ARCH=i386 compilation warnings
References: <20210302011640.1276636-1-pierre-louis.bossart@linux.intel.com>
        <87k0qq85bj.fsf@codeaurora.org>
        <d8437a2c23aa2217233a55222c6968d1ce887bf2.camel@intel.com>
Date:   Tue, 02 Mar 2021 10:25:49 +0200
In-Reply-To: <d8437a2c23aa2217233a55222c6968d1ce887bf2.camel@intel.com>
        (Luciano Coelho's message of "Tue, 2 Mar 2021 07:24:22 +0000")
Message-ID: <87ft1e7yia.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Coelho, Luciano" <luciano.coelho@intel.com> writes:

> On Tue, 2021-03-02 at 07:58 +0200, Kalle Valo wrote:
>> Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> writes:
>> 
>> > An unsigned long variable should rely on '%lu' format strings, not '%zd'
>> > 
>> > Fixes: a1a6a4cf49ece ("iwlwifi: pnvm: implement reading PNVM from UEFI")
>> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> > ---
>> > warnings found with v5.12-rc1 and next-20210301
>> 
>> Luca, can I take this to wireless-drivers?
>
> Yes, please.
>
> Acked-by: Luca Coelho <luciano.coelho@intel.com>

Thansk. I don't see this in patchwork yet (I guess vger is slow again)
so I cannot assign it to me at the moment, will do it later.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
