Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A204440D61C
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 11:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbhIPJ0T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 05:26:19 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36306 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236228AbhIPJ0K (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 05:26:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631784289; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=IPhXCKvdXm+Nl0Ww0FI4Vofwz04YQUSCYLkPUwkNMWQ=;
 b=jauaeRyHlThi/4SIZzBfW8qOXOoc1pWGenuKyYeJyQ2AamjZFtBi/Y7JJimDcrcAxiXkqko6
 RNNo8rjXLK5LC/xZd8kcKs5elkl4v4niq3mSSjIO6QaF9Sk8aLDL+MLO4Yyz7AKZP93maGYY
 d1WOFyEuw8w3TbrO4jUmvFzx9jI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 61430d61507800c88066cd1d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Sep 2021 09:24:49
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 21E5BC43460; Thu, 16 Sep 2021 09:24:48 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7ADD7C43460;
        Thu, 16 Sep 2021 09:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 7ADD7C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] ath11k: Rename atf_config to flag1 in
 target_resource_config
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210720214922.118078-1-jouni@codeaurora.org>
References: <20210720214922.118078-1-jouni@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210916092448.21E5BC43460@smtp.codeaurora.org>
Date:   Thu, 16 Sep 2021 09:24:48 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> wrote:

> The flag's purpose is not only meant for ATF configs. Rename atf_config
> to flag1, so it can be used for future purposes.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

3 patches applied to ath-next branch of ath.git, thanks.

7e9fb2418a4c ath11k: Rename atf_config to flag1 in target_resource_config
9b4dd38b46cf ath11k: add support in survey dump with bss_chan_info
feab5bb8f1d4 ath11k: Align bss_chan_info structure with firmware

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210720214922.118078-1-jouni@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

