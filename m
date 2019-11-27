Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E14F10B2A8
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 16:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfK0Psb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 10:48:31 -0500
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:50932
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbfK0Psb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 10:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574869710;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=pzRruOwd1ze/PptjNjX3dTKuWCUaUGYGq/k4eGP1+kU=;
        b=UT0Lfj9YTtfqI5jrAZ9XAIgEaY26cfVszPQe5GoTTDBmeyiB8Iv3vcAbs40KduMk
        9DvhytSK4fxzRK3qQ4qT5jHTPd4AljstSPb+xnkLr5IXBVzMOt6ZvOyCnOQJQawrzYp
        Of1jGIAL2QhgWkC1OwoUBbhoCJvnfrzCktyMHSbs=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574869710;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=pzRruOwd1ze/PptjNjX3dTKuWCUaUGYGq/k4eGP1+kU=;
        b=DZT4fNySik8AEzZpu7CTlqttPR6OvfGNToZkfkDTtahCOZZuSN1JAjdQ4pCe2KiP
        zcFY24wRlmUV+69MKg40QhPe6ktzArSZTX9ZEX3QP86oTx2S9kuZtTzv9gGHrBPyGwD
        XCImsEDMkWjG4h91ZXkq3crpRF4rwiXMkKpZ+z9g=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8ADFC447A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: move non-fatal warn logs to dbg level
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <0101016ea2aee542-7e69e860-2ad6-4897-959f-e934f1a459bb-000000@us-west-2.amazonses.com>
References: <0101016ea2aee542-7e69e860-2ad6-4897-959f-e934f1a459bb-000000@us-west-2.amazonses.com>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016ead8cb636-991010d3-6f67-49b4-8541-671290d350d1-000000@us-west-2.amazonses.com>
Date:   Wed, 27 Nov 2019 15:48:30 +0000
X-SES-Outgoing: 2019.11.27-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Govind Singh <govinds@codeaurora.org> wrote:

> During driver load below warn logs are printed in the console if
> firmware doesn't support some optional HTC services, ex:pktlog.
> It is likely some older fw version may not support PKTLOG HTC
> service as legacy fw uses HTC DATA service  for pktlog.
> Move this log to debug level to remove un-necessary warn message
> on console.
> 
> htc.c:803:  ath10k_warn(ar, "unsupported HTC service id: %d\n",
> htc.c:881:  ath10k_warn(ar, "unsupported HTC service id: %d\n",
> 
> Signed-off-by: Govind Singh <govinds@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

ef39ac1b0d9f ath10k: move non-fatal warn logs to dbg level

-- 
https://patchwork.kernel.org/patch/11260371/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

