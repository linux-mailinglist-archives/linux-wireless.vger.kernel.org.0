Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE241CD9ED
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 14:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgEKMdI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 08:33:08 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:63390 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727019AbgEKMdH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 08:33:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589200387; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=RfkZZdm4+9xPZMaooBJAUM5yHqUuxllDLzV8gnGuH2Y=;
 b=aQ+noHuyRKUlRWIh2NF1XZOuylz4xeAj8AJhAFwNWmSJ7b4V5XTqrEW5SVdTWJbLOQ/evJKe
 6CEr3DrA5rLjSXvBKUKKcODMF/H3NtAL+BWAjS8EzQEz2t6dRxIN5b8RfSVhIZ43QOnLlosO
 uAsiS0J9zZLb931fxLtYD9mI1XY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb94602.7f5a2cdb2b58-smtp-out-n05;
 Mon, 11 May 2020 12:33:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 417D8C43636; Mon, 11 May 2020 12:33:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B6C25C432C2;
        Mon, 11 May 2020 12:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B6C25C432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath10k: Remove msdu from idr when management pkt send
 fails
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1588667015-25490-1-git-send-email-pillair@codeaurora.org>
References: <1588667015-25490-1-git-send-email-pillair@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200511123305.417D8C43636@smtp.codeaurora.org>
Date:   Mon, 11 May 2020 12:33:05 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rakesh Pillai <pillair@codeaurora.org> wrote:

> Currently when the sending of any management pkt
> via wmi command fails, the packet is being unmapped
> freed in the error handling. But the idr entry added,
> which is used to track these packet is not getting removed.
> 
> Hence, during unload, in wmi cleanup, all the entries
> in IDR are removed and the corresponding buffer is
> attempted to be freed. This can cause a situation where
> one packet is attempted to be freed twice.
> 
> Fix this error by rmeoving the msdu from the idr
> list when the sending of a management packet over
> wmi fails.
> 
> Tested HW: WCN3990
> Tested FW: WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
> 
> Fixes: 1807da49733e ("ath10k: wmi: add management tx by reference support over wmi")
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

c730c477176a ath10k: Remove msdu from idr when management pkt send fails

-- 
https://patchwork.kernel.org/patch/11528409/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
