Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD5043E0AE
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 14:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhJ1MTH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 08:19:07 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:57074 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhJ1MTG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 08:19:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635423400; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=wU9RNitlNZLGFR1Voyrwgjs5+Li02k45DiGW4IhE+0s=; b=C0NEt5Vx3crPYb/SWTCOo8d56peDwoX6yEDLVrry2cK/DXUxY1Nlt76Od3+/PTTUobs36Y3T
 xAF/lT1NkfPz6U9WTj55KFOA4J5gW94WGwtccnyoqptJ0OeEmcvOAVbljZBYAvLbbzhDb8DL
 AvrHHW7SqnD0MuQbRHf1J9N7/y8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 617a94a2ff3eb667a778ae45 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 Oct 2021 12:16:34
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F29F2C4360D; Thu, 28 Oct 2021 12:16:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 72052C4338F;
        Thu, 28 Oct 2021 12:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 72052C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath11k: enable power save in station mode
References: <20211011190625.4463-1-cjhuang@codeaurora.org>
        <163471767994.28889.7719435262601379113.kvalo@codeaurora.org>
Date:   Thu, 28 Oct 2021 15:16:28 +0300
In-Reply-To: <163471767994.28889.7719435262601379113.kvalo@codeaurora.org>
        (Kalle Valo's message of "Wed, 20 Oct 2021 08:14:45 +0000 (UTC)")
Message-ID: <871r455opv.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Carl Huang <cjhuang@codeaurora.org> wrote:
>
>> Enable power save in station mode.
>> 
>> Run "iw dev wls1 set power_save off",  check there is no NULL Data frame
>> from sniffer. Run "iw dev wls1 set power_save on", check there is NULL
>> Data frame from sniffer.
>> 
>> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>> 
>> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
>
> Fails to apply, please rebase on top of ath.git master branch.
>
> error: patch failed: drivers/net/wireless/ath/ath11k/mac.c:883
> error: drivers/net/wireless/ath/ath11k/mac.c: patch does not apply
> stg import: Diff does not apply cleanly
>
> Patch set to Changes Requested.

I'll rebase the patch and submit v2.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
