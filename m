Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9526842B5F6
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Oct 2021 07:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhJMFtC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Oct 2021 01:49:02 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:24842 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhJMFtB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Oct 2021 01:49:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634104019; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=VOPrxynumB6b47FT0sSGzcrQ1ZMDOUMXyA7FszpPedI=;
 b=R01+F2NKZtxypVQSGXZNaFkC+CokZQYo5IXVxM/QuUnTOVGXAMCkpTNKr9RHE7YVL0DIl3wo
 2he3Up+6eJH8GUMRrdGvaX3dqCX6Pa0Z0Mt/EJeOCbCdRbLBRbpLuIJKGUy1QcNMADuUR7cC
 yIZsaEROU8/ZgW2+9Im5imX0mZM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 616672bf4ccc4cf2c755b246 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 13 Oct 2021 05:46:39
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D3337C43616; Wed, 13 Oct 2021 05:46:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 50DC6C4338F;
        Wed, 13 Oct 2021 05:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 50DC6C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1] ath9k: support DT ieee80211-freq-limit property to
 limit
 channels
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211009212847.1781986-1-chunkeey@gmail.com>
References: <20211009212847.1781986-1-chunkeey@gmail.com>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163410398503.12797.17577790204303949652.kvalo@codeaurora.org>
Date:   Wed, 13 Oct 2021 05:46:38 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> wrote:

> The common DT property can be used to limit the available channels
> but ath9k has to manually call wiphy_read_of_freq_limits().
> 
> I would have put this into ath9k_of_init(). But it didn't work there.
> The reason is that in ath9k_of_init() the channels and bands are not yet
> registered in the wiphy struct. So there isn't any channel to flag as
> disabled.
> 
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

03469e79fee9 ath9k: support DT ieee80211-freq-limit property to limit channels

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211009212847.1781986-1-chunkeey@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

