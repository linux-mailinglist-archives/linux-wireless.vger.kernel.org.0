Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A13A31496C
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 08:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBIHX5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 02:23:57 -0500
Received: from so15.mailgun.net ([198.61.254.15]:35708 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230223AbhBIHXr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 02:23:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612855409; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=HktpW15XiJz9MDgowFxfcyIb7IZPnlAbacfGYBTq+d4=; b=isD8Bv8jfYmP15ppH0zuJApb1tOLu4TE/i0vUbG1kf5KfDzMkhxPDM4E7PCJ0AoxKhtYSlGy
 WUdooUW0niY75uLbo14kThE/u/ppJ/MJBQln8SfTefaVdzerszp2KoUKZrZRH3oCseQco+Z4
 ln06sTpR5WDnyn7LDTzFVEUKAkI=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60223844e3df861f4b449261 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Feb 2021 07:22:44
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0061BC433C6; Tue,  9 Feb 2021 07:22:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 15990C433C6;
        Tue,  9 Feb 2021 07:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15990C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Peter Oh <peter.oh@eero.com>
Cc:     Karthikeyan Periyasamy <periyasa@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] ath11k: Update tx descriptor search index properly
References: <1612410960-9120-1-git-send-email-periyasa@codeaurora.org>
        <e6d1aaea-8410-3cfb-3308-4722ca8e91ea@eero.com>
Date:   Tue, 09 Feb 2021 09:22:39 +0200
In-Reply-To: <e6d1aaea-8410-3cfb-3308-4722ca8e91ea@eero.com> (Peter Oh's
        message of "Wed, 3 Feb 2021 22:10:26 -0800")
Message-ID: <87k0rhvh6o.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Peter Oh <peter.oh@eero.com> writes:

> On 2/3/21 7:56 PM, Karthikeyan Periyasamy wrote:
>> Tx descriptor search index field should be updated with hw peer id
>> and not by AST Hash as per the HW/FW recommendation. Incorrect search
>> index causes throughput degradation in all scenario for all the
>> platforms. so updated the search index field with hw peer id, which
>> is a common change applicable for all the platforms. Also no need of these
>> configuration for non station type. seen 10% throughput increase in WDS
>> traffic with this change.
>>
>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01492-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
>
> Thank you for the details.

BTW after you have reviewed the patch, and you think the patch is ok,
you could reply with:

Reviewed-by: Peter Oh <peter.oh@eero.com>

Patchwork automatically picks up that and then it would be an indication
for me that the patch is ready to be applied. I like the Reviewed-by tag
a lot as then I can see that others have also reviewed the patch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
