Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13C4265D1D
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 11:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbgIKJ61 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 05:58:27 -0400
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:56294
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgIKJ6W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 05:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599818302;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=H4MAw2NobB/wUDJshgFbvYlVviXMNE1xDKuFZSJWn/s=;
        b=X6r4WZOQPUtNYTvJ7AjuOg+cytnJFnheTbaSpXhcuN0DIGPqq6Q8Y1UJjmQO3ELj
        wLDn/Agd1zwuEHf4jM2CQq7d1bYoA2C0hlu5gyx1mMqzEHcL8f/O8Z90A4MFUFNHA1v
        5YEh2dbwez4Jj68o6FcCpZ7piA5RRNzbiNPslzRA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599818302;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=H4MAw2NobB/wUDJshgFbvYlVviXMNE1xDKuFZSJWn/s=;
        b=VyPqByxr4pvBvY2fp+GvTO9y0INoZz2fJ0a2pLvFS4oIS5FfnXB7HOVaMIAtU4xG
        6qiWhhFkTiLXfZzIpuPgD2DXpD+QU3FzSiYRJoel8QHv7VUZL2pgrX2tC1fv7QMoB2H
        9cM2rGvHFD65ZkFb7fJ7uPU85zzMpneCB0Zx2TrE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A31EFC433F0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix link error when CONFIG_REMOTEPROC is disabled
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <0101017476e38f40-c4168ac4-c00a-4220-a032-fe17e4a157cb-000000@us-west-2.amazonses.com>
References: <0101017476e38f40-c4168ac4-c00a-4220-a032-fe17e4a157cb-000000@us-west-2.amazonses.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-ID: <010101747c9a0246-3bcecbf7-7609-4bce-9e0f-90ca364ba937-000000@us-west-2.amazonses.com>
Date:   Fri, 11 Sep 2020 09:58:22 +0000
X-SES-Outgoing: 2020.09.11-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> If CONFIG_REMOTEPROC was disabled the linking failed with:
> 
> ERROR: modpost: "rproc_get_by_phandle" [drivers/net/wireless/ath/ath11k/ath11k.ko] undefined!
> 
> Compile tested only.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 1ff8ed786d5d ("ath11k: use remoteproc only with AHB devices")
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

5c0ec012ca7f ath11k: fix link error when CONFIG_REMOTEPROC is disabled

-- 
https://patchwork.kernel.org/patch/11766849/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

