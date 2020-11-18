Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8263C2B82CA
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Nov 2020 18:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgKRRQC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Nov 2020 12:16:02 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:52003 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbgKRRQB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Nov 2020 12:16:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605719760; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Qwb7+Z0qTFHABo6HkPNQB09jo+POFlAbgIBYxxd3DtA=; b=hRKAnRrfesx/GA0FUFfq85KVVgUJclAeFQ3MMcvvFKu19YoKjcLB4ESPq3PKdyYBKB0DgbMY
 SR4L2NQKRL8+pLRVioz2pUN4Du8R7HQP0PQ/oaFwyd/kgXYB48wgSrW+rqL0N6/9wdbpZyQw
 qA18D0Z+3yRKbu9iN2HNfTFot3U=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5fb556c0eb04c00160058560 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 18 Nov 2020 17:15:43
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C9E76C43460; Wed, 18 Nov 2020 17:15:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE464C433C6;
        Wed, 18 Nov 2020 17:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE464C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 5/6] ath9k: make relay callbacks const
References: <20201118165320.26829-1-jani.nikula@intel.com>
        <20201118165320.26829-5-jani.nikula@intel.com>
        <87y2iyvbpr.fsf@codeaurora.org>
Date:   Wed, 18 Nov 2020 19:15:39 +0200
In-Reply-To: <87y2iyvbpr.fsf@codeaurora.org> (Kalle Valo's message of "Wed, 18
        Nov 2020 19:03:44 +0200")
Message-ID: <87eekqvb5w.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Jani Nikula <jani.nikula@intel.com> writes:
>
>> Now that relay_open() accepts const callbacks, make relay callbacks
>> const.
>>
>> Cc: Kalle Valo <kvalo@codeaurora.org>
>> Cc: QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
>> Cc: linux-wireless@vger.kernel.org
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> Can I take this to my ath tree or what's the plan?

Ah, saw patch 1 only now. So I assume this goes via some other tree:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
