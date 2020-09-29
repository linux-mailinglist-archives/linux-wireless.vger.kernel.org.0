Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EFF27D6C8
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 21:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgI2TVv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 15:21:51 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:33836 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgI2TVu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 15:21:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601407309; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=/Phs9NbIUOOCfknVOkl1iLhdlZLD7xoGpbNDoruL528=;
 b=EChtc8bHfVQmk7fNqPgxFBuo52D48jOiabUYkb4lgmCU/79yEQLYSX3L2pIEKo4bsBmBg+sr
 XzSRgtYU2JLKmj3TnssfUkD7x6axe+evrwUafvwtnHFojUSMFKhH/nyiiPOpiZv3tOAA69Fc
 pHkqaBQOphPibXFaeFjMGEGPUak=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f73894d9025c3a797583810 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Sep 2020 19:21:49
 GMT
Sender: kathirve=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 09EA0C433C8; Tue, 29 Sep 2020 19:21:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kathirve)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B1A03C433F1;
        Tue, 29 Sep 2020 19:21:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 30 Sep 2020 00:51:48 +0530
From:   kathirve@codeaurora.org
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath11k: removing the ath11k debugfs dir properly
In-Reply-To: <20200924161623.ED696C433F1@smtp.codeaurora.org>
References: <1600885519-29535-1-git-send-email-kathirve@codeaurora.org>
 <20200924161623.ED696C433F1@smtp.codeaurora.org>
Message-ID: <86f81823eb5ea6bd2f9c4bf91763da75@codeaurora.org>
X-Sender: kathirve@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Please ignore this patch

Thanks
Karthikeyan


On 2020-09-24 21:46, Kalle Valo wrote:
> Karthikeyan Kathirvel <kathirve@codeaurora.org> wrote:
> 
>> ath11k_debug_pdev_destroy was not called for proper cleaning of debug
>> files when destroying the pdev, this results in not removing the 
>> ath11k
>> directory in debugfs folder even after rmmod of ath11k. So when next
>> time doing insmod of ath11k prevents creating another ath11k 
>> directory,
>> hence causing ipq8074_2 to get created in parent dir of debugfs.
>> 
>> Signed-off-by: Karthikeyan Kathirvel <kathirve@codeaurora.org>
> 
> Fails to apply, please rebase. Also Tested-on missing.
> 
> error: patch failed: drivers/net/wireless/ath/ath11k/debug.c:973
> error: drivers/net/wireless/ath/ath11k/debug.c: patch does not apply
> stg import: Diff does not apply cleanly
> 
> Patch set to Changes Requested.
