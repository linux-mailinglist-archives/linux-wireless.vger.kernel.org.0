Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BF541AB3A
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 10:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239699AbhI1Ixv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 04:53:51 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:34454 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239721AbhI1Ixu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 04:53:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632819131; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=5SQVtzjt0jc8NiRFpkDOSCJnSjman+hLzxIoWiptXgo=;
 b=AUtsJexr+Purw25oDZQVUUA6YnPdD/j+WaBT8Z2aHam8hs0VoCNBqlppUvQLdZyp+15vBtck
 2wCdm9TfpDWT7+nu5gGmuMwJCjJHxC9+Dn7O52EyuoUknGp0qs3y1iuWNmlQhLzS6pKf+GdX
 5BvTouD5dYs300lzbLJLQlGj2pc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6152d7ba1abbf21d340eabb9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 08:52:10
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7200AC4338F; Tue, 28 Sep 2021 08:52:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E641CC43460;
        Tue, 28 Sep 2021 08:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E641CC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath11k: add support for setting fixed HE rate/gi/ltf
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210721173615.75637-1-jouni@codeaurora.org>
References: <20210721173615.75637-1-jouni@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Miles Hu <milehu@codeaurora.org>,
        Aloka Dixit <alokad@codeaurora.org>,
        Lavanya Suresh <lavaks@codeaurora.org>,
        Pradeep Chitrapu <pradeepc@codeaurora.org>,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210928085209.7200AC4338F@smtp.codeaurora.org>
Date:   Tue, 28 Sep 2021 08:52:09 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> wrote:

> Support setting fixed HE rate/gi/ltf values that we are now able to send
> to the kernel using nl80211. The added code is reusing parts of the
> existing code path already used for HT/VHT. The new helpers are
> symmetric to how we do it for HT/VHT.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00235-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Miles Hu <milehu@codeaurora.org>
> Co-developed-by: Aloka Dixit <alokad@codeaurora.org>
> Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
> Co-developed-by: Lavanya Suresh <lavaks@codeaurora.org>
> Signed-off-by: Lavanya Suresh <lavaks@codeaurora.org>
> Co-developed-by: Pradeep Chitrapu <pradeepc@codeaurora.org>
> Signed-off-by: Pradeep Chitrapu <pradeepc@codeaurora.org>
> Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

61fe43e7216d ath11k: add support for setting fixed HE rate/gi/ltf
f552d6fd2f27 ath11k: add support for 80P80 and 160 MHz bandwidth

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210721173615.75637-1-jouni@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

