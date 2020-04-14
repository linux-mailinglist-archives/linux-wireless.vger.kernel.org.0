Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416441A763E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 10:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436921AbgDNIen (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 04:34:43 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:60454 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436916AbgDNIem (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 04:34:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586853281; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=iFv7k08Dlhr80ZdaxkE6z172EbEM/WIxA+wyTAMKZ7I=;
 b=uWDSphxYGySPpIrHhJtb/A/geiAF/Z1AgCLIAYHi7CPyNiGJrte/h59/DZ6mEC2d3YqVdnDk
 22YwLHJ0nOTQ2sxH7SycQahJxex387nAHIiZ+a584g+QHeJir5sisrWpaZIJ3RKOvD6+WBgj
 fKz90NuZl4Fq+GJWG2Uuq7QRCyw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e95759f.7fc814a61df8-smtp-out-n01;
 Tue, 14 Apr 2020 08:34:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 16E1AC433BA; Tue, 14 Apr 2020 08:34:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C89E5C433CB;
        Tue, 14 Apr 2020 08:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C89E5C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: rx path optimizations
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1586421797-885-1-git-send-email-mpubbise@codeaurora.org>
References: <1586421797-885-1-git-send-email-mpubbise@codeaurora.org>
To:     Manikanta Pubbisetty <mpubbise@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200414083439.16E1AC433BA@smtp.codeaurora.org>
Date:   Tue, 14 Apr 2020 08:34:39 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <mpubbise@codeaurora.org> wrote:

> During RX, accessing the reo dest ring descriptor directly is consuming
> a lot of CPU cycles. Accessing the descriptor after copying it locally
> has improved CPU usage by around ~10-15% while measuring throughput
> in RX DBTC test cases(all radios are involved in the throughput
> measurement).
> 
> HW tested: IPQ8074
> 
> Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

7395fb496577 ath11k: rx path optimizations

-- 
https://patchwork.kernel.org/patch/11481425/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
