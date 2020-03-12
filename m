Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA0381830F3
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 14:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgCLNNM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 09:13:12 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:17778 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgCLNNM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 09:13:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584018791; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=sp/8obL+bhnREsmyOeW5ju8x5iMeFqwv51tjor1PSX8=;
 b=A6wlH9YjSn8xhs2Z2vJExLYJB7YmaFlC3nwImqkMln5c4RN0OpM82+3DrcbscsHZhMTHk1kt
 MyI6CBe5bxONTuIMVyBeRnWDJrsbVq/wvN8uDyxWsbueJR+Tw/blJCQ+8Sf5YuZ0QJpdkYaR
 jb9EVaM33ePMM3tiJXs4HZL7HjI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6a3564.7f52d9ace6f8-smtp-out-n01;
 Thu, 12 Mar 2020 13:13:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7D828C43636; Thu, 12 Mar 2020 13:13:08 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1C4C9C433CB;
        Thu, 12 Mar 2020 13:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C4C9C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCHv2 1/2] ath11k: Configure hash based reo destination ring
 selection
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1581908873-14749-2-git-send-email-srirrama@codeaurora.org>
References: <1581908873-14749-2-git-send-email-srirrama@codeaurora.org>
To:     Sriram R <srirrama@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sriram R <srirrama@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200312131308.7D828C43636@smtp.codeaurora.org>
Date:   Thu, 12 Mar 2020 13:13:08 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sriram R <srirrama@codeaurora.org> wrote:

> Current implementation of pdev based reo destination ring
> selection is replaced by hash based ring selection so as to
> ensure all the available rings are utilized for better performance.
> 
> The 4 reo destination rings are selected by the HW based on the
> hash value computed from the received packet based on the 5 tuple
> {ip src/ip dst/src port/dst port/protocol}. Out of the 32 hash values
> used by the hw, the driver assigns 8 values per reo destination ring
> to each of the 4 reo destination rings.
> 
> Signed-off-by: Sriram R <srirrama@codeaurora.org>

I had some problems in the pending branch and these fail to apply
now. Please fix the two warnings I reported and rebase.

error: patch failed: drivers/net/wireless/ath/ath11k/hal.h:850
error: drivers/net/wireless/ath/ath11k/hal.h: patch does not apply
stg import: Diff does not apply cleanly

2 patches set to Changes Requested.

11385031 [PATCHv2,1/2] ath11k: Configure hash based reo destination ring selection
11385033 [PATCHv2,2/2] ath11k: Perform per-msdu rx processing

-- 
https://patchwork.kernel.org/patch/11385031/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
