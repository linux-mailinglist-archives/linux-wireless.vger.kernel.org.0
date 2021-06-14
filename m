Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3A33A6A14
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jun 2021 17:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbhFNP2P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Jun 2021 11:28:15 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:19906 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbhFNP2M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Jun 2021 11:28:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623684369; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=3+IT44PTPvc+qOY7Ekz20Fwe84qXj+9/gdT5cBAqBkM=; b=hrbFo1vQj4ryrC/Wf7/A71UAzl9tYe74fQKUqlYD1vNy9ycEO/lwr5j+qEtOn4d5OMUE0a2N
 tQ+/nUdSlYX/FsrkwgUqxhwow4sYEP0kyURJfoy5BV8llO1Z/XGSNONpVjycWS28qf5VWLGq
 KgEK+TKC/Ixn9Mww6bYp+6AZ0+M=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60c7750cb6ccaab7531064e7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Jun 2021 15:26:04
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F2B19C4323A; Mon, 14 Jun 2021 15:26:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ECB9AC43217;
        Mon, 14 Jun 2021 15:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ECB9AC43217
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org, benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH v6 01/12] wcn36xx: Return result of set_power_params in suspend
References: <20210605011140.2004643-2-bryan.odonoghue@linaro.org>
        <20210614151850.9DCE7C433D3@smtp.codeaurora.org>
Date:   Mon, 14 Jun 2021 18:25:54 +0300
In-Reply-To: <20210614151850.9DCE7C433D3@smtp.codeaurora.org> (Kalle Valo's
        message of "Mon, 14 Jun 2021 15:18:50 +0000 (UTC)")
Message-ID: <87mtrsmprx.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:
>
>> wcn36xx_smd_set_power_params() can return an error. For the purposes of
>> entering into suspend we need the suspend() function to trap and report
>> errors up the stack.
>> 
>> First step in this process is reporting the existing result code for
>> wcn36xx_smd_set_power_params().
>> 
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Tested-by: Benjamin Li <benl@squareup.com>
>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>
> 12 patches applied to ath-next branch of ath.git, thanks.
>
> ba4e967379f0 wcn36xx: Return result of set_power_params in suspend
> f2f49601067b wcn36xx: Run suspend for the first ieee80211_vif
> 5478c41fce5d wcn36xx: Add ipv4 ARP offload support in suspend
> 6feb634f4d9f wcn36xx: Do not flush indication queue on suspend/resume
> c7a61af55976 wcn36xx: Add ipv6 address tracking
> 1456223c4684 wcn36xx: Add ipv6 namespace offload in suspend
> 8974e5917b31 wcn36xx: Add set_rekey_data callback
> 6693f7675c9b wcn36xx: Add GTK offload to WoWLAN path
> bedf1169bcae wcn36xx: Add GTK offload info to WoWLAN resume
> 60f0078b1ebd wcn36xx: Add Host suspend indication support
> ebe7c1a6635f wcn36xx: Add host resume request support
> 1e2e8ee95734 wcn36xx: Enable WOWLAN flags

BTW, I'm not sure about CONFIG_IPV6 checks but they looked minor so I
applied these anyway. But can you check them anyway and send a followup
patch if my hunch is correct?

main.c:#if IS_ENABLED(CONFIG_IPV6)
main.c:#if IS_ENABLED(CONFIG_IPV6)

These two look ok.

smd.c:#if IS_ENABLED(CONFIG_IPV6)
wcn36xx.h:#if IS_ENABLED(CONFIG_IPV6)

But these two seem unnecessary, at least I was not able to find anything
which would require these. Although I didn't have time to do a build
test so of course I might have missed something.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
