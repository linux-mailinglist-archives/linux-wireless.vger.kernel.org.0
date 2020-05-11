Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7AE1CDA25
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 14:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbgEKMid (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 08:38:33 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:39827 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729343AbgEKMid (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 08:38:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589200712; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=6zHthPA67U2sDfggdSKZPI6MNAUGMdP3o7kYKcHGj6w=;
 b=vGNP1SGXqe/JCtbZZ8lELwl6zz1Q1lsElqXc2sqDJuMp0CHCXtuuzBqbU3hSyQ+fSj4mNji2
 xh/oB2MRzNVIdb2DysxZfqhnKIZr25r3h3A8zRIlgT40ppIqlvFxM7StDvBao4HZb7KzIdkf
 XFAg1Up/UvUvxKpqAi6+o7E21vg=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb9473d.7f9bb04d8c38-smtp-out-n01;
 Mon, 11 May 2020 12:38:21 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 39658C433CB; Mon, 11 May 2020 12:38:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DAC52C433BA;
        Mon, 11 May 2020 12:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DAC52C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Remove experimental tag from ath10k Kconfig
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200507055324.15564-1-govinds@codeaurora.org>
References: <20200507055324.15564-1-govinds@codeaurora.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200511123821.39658C433CB@smtp.codeaurora.org>
Date:   Mon, 11 May 2020 12:38:21 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Govind Singh <govinds@codeaurora.org> wrote:

> ath10k(sdio/snoc) is no longer experimental. Remove experimental tag for
> SDIO/SNOC from ath10k Kconfig.
> 
> Signed-off-by: Govind Singh <govinds@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

4d0f3604c4d1 ath10k: remove experimental tag from SDIO and SNOC busses in Kconfig

-- 
https://patchwork.kernel.org/patch/11532477/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
