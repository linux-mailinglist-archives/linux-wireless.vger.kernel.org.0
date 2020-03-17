Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6CC21879C6
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 07:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgCQGkO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 02:40:14 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:36933 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbgCQGkN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 02:40:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584427213; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=jywGZJcestaSZXPGh+GJCU3zZIU2uEmEwfN/OfwKZes=;
 b=mbzSzQu1XmU1YPCHTjndIfpJJWvfUHDoY5nL4i8tHwISmiOCvBynlRFIz9cLOXAw7GBd2jzB
 NPU8D1pamAuteJ/zUYwr/EJy6HGm8KgnNpdlM5750EnPh1RBrjo+SNDehxzoDpiI8r4e3j7B
 55Ss7KFhFOsQ2lYYRcrl63JFJbM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7070c6.7f580ef35a08-smtp-out-n02;
 Tue, 17 Mar 2020 06:40:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A1AEBC432C2; Tue, 17 Mar 2020 06:40:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C19C0C433D2;
        Tue, 17 Mar 2020 06:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C19C0C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] ath11k: set queue_len to 4096
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200211122605.13002-2-john@phrozen.org>
References: <20200211122605.13002-2-john@phrozen.org>
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200317064005.A1AEBC432C2@smtp.codeaurora.org>
Date:   Tue, 17 Mar 2020 06:40:05 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> wrote:

> The driver currently does not use wake_txq_queue. This leads to the
> tx_queue_len being defaulted to 1000. Setting this parameter will
> change the queue_len to 4096 which is more fitting for HE.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

107560d847e6 ath11k: set queue_len to 4096

-- 
https://patchwork.kernel.org/patch/11375351/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
