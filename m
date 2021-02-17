Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2356C31D3F2
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Feb 2021 03:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhBQC35 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Feb 2021 21:29:57 -0500
Received: from z11.mailgun.us ([104.130.96.11]:11496 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhBQC35 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Feb 2021 21:29:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613528972; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=yYdgIAo1Ezv+KQtwbN1C/nqqV5mWYRPAN6dyt7pEHfM=;
 b=PT3SPo4qb4ubUj/G5pmK3xgUYaVTeiaNIzB7D2n8IJUIonA1KxRIHTEijd1hjEdQcrhyO++i
 6zUy+jJ3zshsUCrvw2xbSmFiK3eeW/NFFQgneWYR+ww6MpH7fYEK5D6YCAJpOS29l/pSrTse
 cMx2Yl0bMEGE0mAc5MccT8LpPqc=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 602c7f6706bddda9dfdf2c66 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Feb 2021 02:28:55
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8858BC433ED; Wed, 17 Feb 2021 02:28:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4834C433CA;
        Wed, 17 Feb 2021 02:28:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 17 Feb 2021 07:58:53 +0530
From:   akolli@codeaurora.org
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>,
        linux-wireless@vger.kernel.org, kvalo=codeaurora.org@codeaurora.org
Subject: Re: [PATCH 06/11] ath11k: add static window support for register
 access
In-Reply-To: <87czx0q7vy.fsf@codeaurora.org>
References: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
 <1612946530-28504-7-git-send-email-akolli@codeaurora.org>
 <87czx0q7vy.fsf@codeaurora.org>
Message-ID: <c8b8ce58aacef47cdce6398afd53eb54@codeaurora.org>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-02-16 22:15, Kalle Valo wrote:
> Anilkumar Kolli <akolli@codeaurora.org> writes:
> 
>> From: Karthikeyan Periyasamy <periyasa@codeaurora.org>
>> 
>> Three window slots can be configure. First window slot
>> dedicate for dynamic selection and remaining two slots
>> dedicate for static selection. To optimise the window
>> selection, frequent registers (UMAC, CE) are configure
>> in static window slot. so that we minimise the window
>> selection. Other registers are configure in dynamic window
>> slot. Get the window start address from the respective
>> offset and access the read/write register.
>> 
>> Tested-on: QCN9074 hw1.0 PCI 
>> WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1
>> 
>> Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
> 
> Patches 6-10 are missing Anil's s-o-b. Anil, can I add them? If you
> agree, please reply to this mail and include your s-o-b in the reply.

Sure Kalle, please add my s-o-b.
Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>

Thanks
Anil
