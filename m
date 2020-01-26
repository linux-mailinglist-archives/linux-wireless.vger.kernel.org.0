Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDB2149A3A
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 11:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgAZKrq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 05:47:46 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:37332 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726571AbgAZKrq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 05:47:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580035666; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=2O8zLfV7rAwzFVtEWeEfx2Rpl7f5pgq20+SPZSzKyeo=;
 b=bWuWN9QCP/ssdr/iu2zacFJZlE8u8lL+SCpDF4VjoNd0TjwRSCDrQpl/dURqDczFLDRX3TO0
 fZpcPeBdmz9GeZiNDwDM2LkKDg0hSliQ15o0q7h6ShJPzG8MzileEOTHkgx7LIhHMM1gFDwl
 3tgomxD9DFQa7FvUucKs2OTIlrk=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2d6e51.7fc276b7b228-smtp-out-n03;
 Sun, 26 Jan 2020 10:47:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 078C8C43383; Sun, 26 Jan 2020 10:47:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 92F70C433CB;
        Sun, 26 Jan 2020 10:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92F70C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4] ath11k: Add missing pdev rx rate stats
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1578570530-32038-1-git-send-email-bperumal@codeaurora.org>
References: <1578570530-32038-1-git-send-email-bperumal@codeaurora.org>
To:     Bhagavathi Perumal S <bperumal@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Bhagavathi Perumal S <bperumal@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200126104745.078C8C43383@smtp.codeaurora.org>
Date:   Sun, 26 Jan 2020 10:47:45 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bhagavathi Perumal S <bperumal@codeaurora.org> wrote:

> This adds missing rx rate info stats like pilot evm,
> per chain rssi, per user ul ppdu and mpdu counts and
> ul ofdma rate info etc.
> 
> And add null checks for memory alloc failures.
> 
> Signed-off-by: Bhagavathi Perumal S <bperumal@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

875603b3de9f ath11k: Add missing pdev rx rate stats

-- 
https://patchwork.kernel.org/patch/11325519/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
