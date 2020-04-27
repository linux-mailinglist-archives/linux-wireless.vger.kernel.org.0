Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59AC1B9656
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 06:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgD0E4s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 00:56:48 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:59439 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726172AbgD0E4s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 00:56:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587963407; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=bbOspBw2xPvQwAg9X7ORHUjI3DShyr/l7NDN5B7MWTM=;
 b=Fdtduca2b8Q45E/SVjBfk1IpK/tV7qHQ57bhFIoylEDFc6GP729LQu3f0+kHzh+s7eSo7WO/
 hwGsWw/ylfIWHaS5bxQj9fo20uWhth+M4JbI70k2EHLsnAF6s858NoSW42Jn79SiFOK9faAx
 HQmv5U4dSsFyh9iiTmrVDCcnl3I=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea665fa.7f2e20d08730-smtp-out-n05;
 Mon, 27 Apr 2020 04:56:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 23998C433F2; Mon, 27 Apr 2020 04:56:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B9F65C433CB;
        Mon, 27 Apr 2020 04:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B9F65C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix reo flush send
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1587552378-4884-1-git-send-email-periyasa@codeaurora.org>
References: <1587552378-4884-1-git-send-email-periyasa@codeaurora.org>
To:     Karthikeyan Periyasamy <periyasa@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200427045626.23998C433F2@smtp.codeaurora.org>
Date:   Mon, 27 Apr 2020 04:56:26 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Periyasamy <periyasa@codeaurora.org> wrote:

> we are sending the reo flush command for the deleted peer
> tid after the ageout period reaches 1 second. This handling
> causes reo ring get full when more than 128 clients are
> disconnected continuously. so added the count for flush list
> and reo flush command is triggered after the list count reaches
> the threshold value, it is configured as 64 (half of the reo ring).
> This will avoid the situation where reo ring get full.
> 
> Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

5cb899dd5ba4 ath11k: fix reo flush send

-- 
https://patchwork.kernel.org/patch/11503445/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
