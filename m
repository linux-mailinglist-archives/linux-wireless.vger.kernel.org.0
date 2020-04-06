Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5FB119F9F8
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 18:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgDFQPt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 12:15:49 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:47218 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728907AbgDFQPt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 12:15:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586189748; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=R+Q0VQ+Lxe495OE3/cv8b8RjoRexBxIsVjg2HvlPqtc=;
 b=qmjZ22P/jrapvvo2lU1rnQrJycRb8acQuFr47PN+Hlkm3APIxIVEnpzuikIZHSdNGvjLFhE3
 GGyoQODAiAGwaVS7XxBPVKCqZYl6FgFnkJTsuzoAIB31W6olshuUEV+G++2it1ZEN2uMgG1X
 AY0fBmdT6Jwetjjf0Q5TQ6qBEww=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8b559d.7feb33db66c0-smtp-out-n02;
 Mon, 06 Apr 2020 16:15:25 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3CBFAC43636; Mon,  6 Apr 2020 16:15:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 87BD3C433D2;
        Mon,  6 Apr 2020 16:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87BD3C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Fix the race condition in firmware dump work queue
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1585213077-28439-1-git-send-email-mkenna@codeaurora.org>
References: <1585213077-28439-1-git-send-email-mkenna@codeaurora.org>
To:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>,
        Govindaraj Saminathan <gsamin@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200406161524.3CBFAC43636@smtp.codeaurora.org>
Date:   Mon,  6 Apr 2020 16:15:24 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maharaja Kennadyrajan <mkenna@codeaurora.org> wrote:

> There is a race condition, when the user writes 'hw-restart' and
> 'hard' in the simulate_fw_crash debugfs file without any delay.
> In the above scenario, the firmware dump work queue(scheduled by
> 'hard') should be handled gracefully, while the target is in the
> 'hw-restart'.
> 
> Tested HW: QCA9984
> Tested FW: 10.4-3.9.0.2-00044
> 
> Co-developed-by: Govindaraj Saminathan <gsamin@codeaurora.org>
> Signed-off-by: Govindaraj Saminathan <gsamin@codeaurora.org>
> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

3d1c60460fb2 ath10k: Fix the race condition in firmware dump work queue

-- 
https://patchwork.kernel.org/patch/11459703/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
