Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7ABF1598D7
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 19:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbgBKSjQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 13:39:16 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:15593 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728725AbgBKSjP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 13:39:15 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Feb 2020 13:38:14 EST
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581446355; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=yJcTulT8Z96YZ2+BRi4Ga1uRyNu89N4laYsZNUsZTK8=;
 b=PMHZ/JFJtK74TmiE0+JN39ciWkRhxKdGZo4eSfFfH7SyX/grCsCXKQ7y675BTTILYNFA1LHD
 iq4U93o29Ws0wtUqWEtGdgQO3DDFODm98E/qQMrqDrbWijv1h+/A8ECzQeWdwKK6Q+MDgp4d
 Gf3EkbTooi98nnkIarcNTMfVx90=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e42f3a3.7ff1324ec538-smtp-out-n02;
 Tue, 11 Feb 2020 18:34:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6AECFC4479D; Tue, 11 Feb 2020 18:34:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1662AC43383;
        Tue, 11 Feb 2020 18:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1662AC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix parsing PPDU_CTRL type in pktlog
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1580886959-8436-1-git-send-email-akolli@codeaurora.org>
References: <1580886959-8436-1-git-send-email-akolli@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200211183411.6AECFC4479D@smtp.codeaurora.org>
Date:   Tue, 11 Feb 2020 18:34:11 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> wrote:

> PPDU_CTRL type is missing in current pktlog dumps.
> PPDU_CTRL is sent on CE5 with len 2560 bytes, current
> driver ignores the payload len greter than 2048.
> PPDU_CTRL of 2560 bytes is sent in two fragments of len 2028
> and 532 bytes, but firmware reports pkt header has length as 2560
> for both of the fragments.
> 
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

443d2ee758ac ath11k: fix parsing PPDU_CTRL type in pktlog

-- 
https://patchwork.kernel.org/patch/11365851/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
