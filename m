Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138FD3A7B86
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 12:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhFOKNm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 06:13:42 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:58968 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhFOKNl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 06:13:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623751897; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=dM+rT4E8kvhSQ3XqvTxEolQ8Qn2/02mGOb9Z5VpJ4/I=;
 b=TH3kP3nJqjJKHzJerTBz4lrWzojmNTg9Qdti4xhEEdS+9qO5a/e0sa5HwNG1jyH1waz/de9m
 xdeWycan1xjkf5F6fHuBspBBmBYX7R22ZikFOd9QbFeWtRQNvLJAc93w3wVPYg2F8kudXMWZ
 iFPGhZhHnFb7aKNg4Od4dfbW3C8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 60c87cc98491191eb32cef7c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 10:11:21
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D987DC4338A; Tue, 15 Jun 2021 10:11:21 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8887C433D3;
        Tue, 15 Jun 2021 10:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8887C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: ssb: sdio: Don't overwrite const buffer if block_write fails
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210515210252.318be2ba@wiggum>
References: <20210515210252.318be2ba@wiggum>
To:     Michael =?utf-8?b?QsO8c2No?= <m@bues.ch>
Cc:     linux-wireless@vger.kernel.org,
        Albert Herranz <albert_herranz@yahoo.es>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615101121.D987DC4338A@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 10:11:21 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Michael Büsch <m@bues.ch> wrote:

> It doesn't make sense to clobber the const driver-side buffer, if a
> write-to-device attempt failed. All other SSB variants (PCI, PCMCIA and SoC)
> also don't corrupt the buffer on any failure in block_write.
> Therefore, remove this memset from the SDIO variant.
> 
> Signed-off-by: Michael Büsch <m@bues.ch>
> Cc: stable@vger.kernel.org

Patch applied to wireless-drivers-next.git, thanks.

47ec636f7a25 ssb: sdio: Don't overwrite const buffer if block_write fails

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210515210252.318be2ba@wiggum/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

