Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4F9306F9A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jan 2021 08:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhA1He0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jan 2021 02:34:26 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:60336 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbhA1Hb4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jan 2021 02:31:56 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611819097; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=3UQYDSoOS9pMxODiH1PAyl7ABGpw/hk66ZH3BbOb1Pw=;
 b=uYDl83GnrPJrO8+xwaM8oJ6q54jO1G+IJHVcnJIiwWRNr1vrKIvtx1Vu+xe2vSaJNIdBSm8S
 WdZ5HcuCv96cG9chw0k/DCrWfn1uw+BjMfaQubU4qOY1DmJxEcUMwvZHnyRyAqTkaWw2dReA
 1/2Bo1k0z6p/mDz/JYCyxnMVEgQ=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6012682dfb02735e8cc4ac85 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 Jan 2021 07:30:53
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 18CC3C433C6; Thu, 28 Jan 2021 07:30:53 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 24BFBC433CA;
        Thu, 28 Jan 2021 07:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24BFBC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-drivers] mt76: dma: fix a possible memory leak in
 mt76_add_fragment()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <4f9dd73407da88b2a552517ce8db242d86bf4d5c.1611616130.git.lorenzo@kernel.org>
References: <4f9dd73407da88b2a552517ce8db242d86bf4d5c.1611616130.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210128073053.18CC3C433C6@smtp.codeaurora.org>
Date:   Thu, 28 Jan 2021 07:30:53 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix a memory leak in mt76_add_fragment routine returning the buffer
> to the page_frag_cache when we receive a new fragment and the
> skb_shared_info frag array is full.
> 
> Fixes: b102f0c522cf6 ("mt76: fix array overflow on receiving too many fragments for a packet")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Acked-by: Felix Fietkau <nbd@nbd.name>

Patch applied to wireless-drivers.git, thanks.

93a1d4791c10 mt76: dma: fix a possible memory leak in mt76_add_fragment()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/4f9dd73407da88b2a552517ce8db242d86bf4d5c.1611616130.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

