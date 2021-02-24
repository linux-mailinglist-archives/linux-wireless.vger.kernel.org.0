Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2757323773
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Feb 2021 07:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhBXGiS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Feb 2021 01:38:18 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:14067 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233944AbhBXGiQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Feb 2021 01:38:16 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614148674; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=HPlQwYoasGiwBsNoBgjlIhI+/XefNECDMYSjLW/cDuU=;
 b=ne2SCguw5mQMVTUejeG6PKnLFQuNqQnSpGPNrPMPLBta+Cpp+mgFwVfozTrpbMIbLIC4ilr8
 WuuUshIkzSbgzrHqN4GFgt3e86+DHZXtKwJLAKsdxmboA/Db4ABf7vsWlzwTZhC4c9pEa7TF
 cxGb8U4zaVBZln5lmhrPOxNo9ho=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6035f4032a8ee88ea564d737 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Feb 2021 06:36:51
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 15883C433CA; Wed, 24 Feb 2021 06:36:51 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE70AC433C6;
        Wed, 24 Feb 2021 06:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE70AC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] MAINTAINERS: update for mwifiex driver maintainers
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1613998184-20047-1-git-send-email-sharvari.harisangam@nxp.com>
References: <1613998184-20047-1-git-send-email-sharvari.harisangam@nxp.com>
To:     Sharvari Harisangam <sharvari.harisangam@nxp.com>
Cc:     linux-wireless@vger.kernel.org,
        Rakesh Parmar <rakesh.parmar@nxp.com>,
        Cathy Luo <xiaohua.luo@nxp.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Pali Rohar <pali@kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210224063651.15883C433CA@smtp.codeaurora.org>
Date:   Wed, 24 Feb 2021 06:36:51 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sharvari Harisangam <sharvari.harisangam@nxp.com> wrote:

> Add Sharvari Harisangam to Maintainer list.
> Replace Ganapathi Bhat's email id in Maintainer list.
> 
> Signed-off-by: Rakesh Parmar <rakesh.parmar@nxp.com>
> Signed-off-by: Sharvari Harisangam <sharvari.harisangam@nxp.com>
> Acked-by: Ganapathi Bhat <ganapathi.bhat@nxp.com>

Patch applied to wireless-drivers.git, thanks.

9aa940047ae8 MAINTAINERS: update for mwifiex driver maintainers

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1613998184-20047-1-git-send-email-sharvari.harisangam@nxp.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

