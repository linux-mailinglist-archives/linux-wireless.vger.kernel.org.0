Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DC9319AC0
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Feb 2021 08:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBLHo2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Feb 2021 02:44:28 -0500
Received: from so15.mailgun.net ([198.61.254.15]:14994 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229875AbhBLHoB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Feb 2021 02:44:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613115822; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=LDoAUfbUTIjS2lFBCekC02HTmp2Bvakc1GmRUWKV17A=; b=RBZM9uvE75LXWU3PY70R6iOAtgvXhZ/E1frt3QwWQbTbbZOFBC8pI8jUTpcod7a8WdPuvOGi
 IJNbmr1pAMoA9/uT2Ulj1/ZlB6gM6L88BieO9gzrCc7svkApYbquon86INBeYfjJe/A3iyCu
 Eh1XUzFK8wU4F+Ezl+SnFRUel4I=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60263191e3df861f4bc34c7d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Feb 2021 07:43:13
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A2387C43462; Fri, 12 Feb 2021 07:43:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 24DFAC433ED;
        Fri, 12 Feb 2021 07:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24DFAC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: wireless wiki: ath11k missing in drivers page
References: <CAM+r-RhxY4TA4zPm6e6ah9RWdBY67J=5oRS3+=+EQMomKa10QQ@mail.gmail.com>
        <CA+icZUUM8cPUvwVRFqodZxNs=4pVaBJGCWu6mL=9T5tym_OmeA@mail.gmail.com>
        <CA+icZUX7+bOgqPTtwNjXO4PCvjAm9T7akWvDxV47QPMR2auiSQ@mail.gmail.com>
Date:   Fri, 12 Feb 2021 09:43:09 +0200
In-Reply-To: <CA+icZUX7+bOgqPTtwNjXO4PCvjAm9T7akWvDxV47QPMR2auiSQ@mail.gmail.com>
        (Sedat Dilek's message of "Tue, 5 Jan 2021 14:40:36 +0100")
Message-ID: <87blcpspde.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sedat Dilek <sedat.dilek@gmail.com> writes:

> On Sun, Jan 3, 2021 at 1:50 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>
>> Hi,
>>
>> recently someone asked about issues with ath11k devices.
>>
>> So, I checked the wireless wiki pages.
>>
>> In the drivers overview [1] ath10k is listed and linked [2] but not ath11k.
>> Smart enough I found [3].
>>
>> Can you or someone else add the link to athk11 in [1]?
>>
>> Thanks.
>>
>> Regards,
>> - Sedat -
>>
>> [1] https://wireless.wiki.kernel.org/en/users/drivers
>> [2] https://wireless.wiki.kernel.org/en/users/drivers/ath10k
>> [3] https://wireless.wiki.kernel.org/en/users/drivers/ath11k
>
> Thanks to whomever fixed the drivers overview page.

Thanks from my side as well. I updated the entry now, for example ath11k
does not support IBSS.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
