Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8427A255A4B
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 14:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgH1MfH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 08:35:07 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:26582 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729437AbgH1MfA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 08:35:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598618099; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=CtdehU9Dr6QeodTigewvzpJbkUFQjJ5NNP1mR5H4580=; b=vMtVf9B1T5saQHyIMIbnOyCkP2Shz0Od5PF8Yu5J4fYC7lFD9HNGq5y9jjahEnoXTXAk2YpN
 pmQB1kGvxw5iiG7dRTMKeSW7ZJf70ion1Wdagt4RDfF7whbp7l9NwHIKBRuDSp1oetHPpTMJ
 itp13s6sKZWxqqm2fyhzDKP+MI0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f48f9e3c6eb6037971eb90f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 28 Aug 2020 12:34:43
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EDE9FC433A0; Fri, 28 Aug 2020 12:34:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43BDEC43391;
        Fri, 28 Aug 2020 12:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43BDEC43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 15/15] rtlwifi: Remove temporary definition of RT_TRACE
References: <20200723204244.24457-16-Larry.Finger@lwfinger.net>
        <20200827094217.72A9BC433CB@smtp.codeaurora.org>
        <8cc0d79f-ec95-b7a2-1ac1-c20c06dd62ab@lwfinger.net>
Date:   Fri, 28 Aug 2020 15:34:39 +0300
In-Reply-To: <8cc0d79f-ec95-b7a2-1ac1-c20c06dd62ab@lwfinger.net> (Larry
        Finger's message of "Thu, 27 Aug 2020 13:31:06 -0500")
Message-ID: <87pn7b7xuo.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> On 8/27/20 4:42 AM, Kalle Valo wrote:
>> Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>
>>> A definition of this macro was kept until all drivers had been converted.
>>> It can now be deleted.
>>>
>>> This change also renames _rtl_dbg_trace() to _rtl_dbg_out().
>>>
>>> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> Dropping patch 15 due to the reported build error, please resubmit that
>> separately.
>>
>> Patch set to Changes Requested.
>
> It turns out that patch 14 is also wrong. Please drop it as well.
>
> Would you prefer just those 2 or a v3 for all 15?

I can apply patches 1-13, but can't do it now as patchwork is down. But
please do send patches 14-15 as v3.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
