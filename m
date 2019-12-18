Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6114124604
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 12:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLRLoe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 06:44:34 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:12113 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbfLRLoe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 06:44:34 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576669474; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=6n8uBLBguZLcx/AsdK+gdhMJRD1dnVw0mQoehxHz7No=;
 b=kGBCP0O7sqbSxB8znPZd+sI0vYTibSp/ML6UTMnaiRlssSdJrYEsaxyc1rxhY1Yv3NazsNKz
 fxVmXgzb9/5gLZBEhzi0v4OoQyw8q7pWDnEiP1UiGnrKu6Nc4I8g39DYJ+j9RtijlwvzPrDr
 aIexxXa6o7DHOqGVJS/ETl/hnTY=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa111e.7fcfd61366c0-smtp-out-n02;
 Wed, 18 Dec 2019 11:44:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 04CA1C433CB; Wed, 18 Dec 2019 11:44:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A8853C43383;
        Wed, 18 Dec 2019 11:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8853C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V3 8/9] ath11k: optimise ath11k_dp_tx_completion_handler
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191213153839.12372-9-john@phrozen.org>
References: <20191213153839.12372-9-john@phrozen.org>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218114430.04CA1C433CB@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 11:44:30 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> wrote:

> the current code does 4 memcpys for each completion frame.
> 1) duplicate the desc
> 2 + 3) inside kfifo insertion
> 4) kfifo remove
> 
> The code simply drops the kfifo and uses a trivial ring buffer. This
> requires a single memcpy for insertion. There is no removal needed as
> we can simply use the inserted data for processing. As the code runs
> inside the NAPI context it is atomic and there is no need for most of
> the locking.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

This had a new warning, fixed in the pending branch:

drivers/net/wireless/ath/ath11k/dp_tx.c:441: line over 90 characters

-- 
https://patchwork.kernel.org/patch/11290755/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
