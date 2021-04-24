Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7E336A034
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Apr 2021 10:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbhDXIh1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Apr 2021 04:37:27 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:61641 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbhDXIhX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Apr 2021 04:37:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619253397; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=0YpOJ0nbALKSDDgtlfinFrWB8Fco5Pa1+7Ify9meDKw=; b=ous05QKfWwvuryf9hWNF+N8JUxqgF9d8ig18uUq7amXsmqUecD4rmwLNpW+tIy8G8laiUabo
 vqdDz/f3yKWf4TUQvSuYwm34dfiWt+yrf1uINWAG/TlNZ3PFe2rb99QX7RlRgv6mD3aF6Q9L
 qi8xD/JJduV6WGiWvCXunl9ccb4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6083d86603cfff345236f099 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 24 Apr 2021 08:35:50
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 96EAAC43460; Sat, 24 Apr 2021 08:35:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AFB9AC433D3;
        Sat, 24 Apr 2021 08:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AFB9AC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: Re: [PATCH 0/3] mt7921 runtime-pm fixes
References: <cover.1619187875.git.lorenzo@kernel.org>
        <af4e6186-9c40-26c4-42bf-4b247d1befaa@nbd.name>
Date:   Sat, 24 Apr 2021 11:35:44 +0300
In-Reply-To: <af4e6186-9c40-26c4-42bf-4b247d1befaa@nbd.name> (Felix Fietkau's
        message of "Fri, 23 Apr 2021 16:43:43 +0200")
Message-ID: <8735vgjd0f.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2021-04-23 16:27, Lorenzo Bianconi wrote:
>> This series contains three mt7921 fixes introduce with new runtime-pm rework
>> 
>> Lorenzo Bianconi (3):
>>   mt76: mt7921: fix possible AOOB issue in mt7921_mcu_tx_rate_report
>>   mt76: connac: do not schedule wake_work if the runtime-pm is disabled
>>   mt76: connac: do not schedule mac_work if the device is not running
> For the series:
> Reviewed-by: Felix Fietkau <nbd@nbd.name>
>
> Kalle, could you please take these patches directly, they're all
> regression fixes.

Ok, I assigned this series to me on patchwork.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
