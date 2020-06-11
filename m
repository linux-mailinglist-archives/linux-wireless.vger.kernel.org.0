Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5221F612E
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2020 07:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgFKFHK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jun 2020 01:07:10 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:42214 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgFKFHK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jun 2020 01:07:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591852029; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=MLzuc527nOZ4RjiTl/mqCkmqHJlOK1Ioo2ULuHrkMEY=;
 b=UZ31pSsmWnK3OtthbDmQurz7aRsa9eSUXV8yLo9sQM+hibax5RJj4LdqZWtGS8+wuxrl/N5+
 5Ep4OzZ26QPTzv+/3QzUvIYyacAeDk95Pmud3Oi67vVly/sQVrWcEg3S8YB196HINh2Km2cu
 +uW22vGKTOrdYBaXMSo9nYxtCJI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-east-1.postgun.com with SMTP id
 5ee1bbee567385e8e7c67e53 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Jun 2020 05:06:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C203DC433C6; Thu, 11 Jun 2020 05:06:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 577B4C433CA;
        Thu, 11 Jun 2020 05:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 577B4C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: build HE 6 GHz capability
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1591057888-2862-1-git-send-email-rmanohar@codeaurora.org>
References: <1591057888-2862-1-git-send-email-rmanohar@codeaurora.org>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200611050653.C203DC433C6@smtp.codeaurora.org>
Date:   Thu, 11 Jun 2020 05:06:53 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rajkumar Manoharan <rmanohar@codeaurora.org> wrote:

> Build 6 GHz band capability from HT and VHT capabilities reported
> by firmware.
> 
> Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

f28b7b78aad3 ath11k: build HE 6 GHz capability

-- 
https://patchwork.kernel.org/patch/11582795/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

