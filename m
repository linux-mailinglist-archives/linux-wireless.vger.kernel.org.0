Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC27D2D3BF0
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 08:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgLIHGD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 02:06:03 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:29478 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgLIHF7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 02:05:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607497534; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=7wmmuMsk5n7Lj4AxYEHZblpC5NONpaiZYbnOFW6cHOU=;
 b=gcIfeirnBI7wHvlGB68w87W1370rx94Afq3ij6XGIxSRRgFwzOluj6vraa/QOXkuzFtOxP4x
 ZqhLP9BVi/5VEi/FXPtoaSNR8vCrJSep35WXmbbWu1t5NQ/zarEoL/5v/ZBo5Aguls6xDJaU
 IDV25oks+nsUUcvRpsKDrhcAHmU=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5fd0773dd5b4c78a8ff5b8ed (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 09 Dec 2020 07:05:33
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CCCA4C43461; Wed,  9 Dec 2020 07:05:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76FD9C433C6;
        Wed,  9 Dec 2020 07:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76FD9C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/5] ath9k_htc: adhere to the DONT_REORDER transmit flag
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201104061823.197407-6-Mathy.Vanhoef@kuleuven.be>
References: <20201104061823.197407-6-Mathy.Vanhoef@kuleuven.be>
To:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com,
        Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201209070533.CCCA4C43461@smtp.codeaurora.org>
Date:   Wed,  9 Dec 2020 07:05:33 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be> wrote:

> Assure that frames with the fixed order flag are not reordered
> relative to each other. This is accomplished by transmitting them
> using a fixed priority independent of their QoS field.
> 
> Signed-off-by: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

8a71f34bb251 ath9k_htc: adhere to the DONT_REORDER transmit flag

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201104061823.197407-6-Mathy.Vanhoef@kuleuven.be/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

