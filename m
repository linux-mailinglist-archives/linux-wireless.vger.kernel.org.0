Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C767187B06
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 09:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgCQIQM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 04:16:12 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:60415 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbgCQIQM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 04:16:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584432972; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=xPKV1WCCUrpfT2hzGNvcQ17Fga6qcOoLugyPN58ekIs=;
 b=NN7iK762fB/t57vSKzfPh05wLR2Fa2V/2lC9v0ZPQ3JVJjdKjKI4U6yJyCThO9on530vcgpk
 YrFDBMM2vVpXl4nPjcOMNElIW4dNnAbZLR6yxbwBML3QWX0jHO6KKBZWNV540ICYWSUS1eJr
 wJENYQGvJ6t5EeI7VWrHCFdM3pg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e708746.7fdba56203e8-smtp-out-n01;
 Tue, 17 Mar 2020 08:16:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 425FDC433CB; Tue, 17 Mar 2020 08:16:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ABA7CC433D2;
        Tue, 17 Mar 2020 08:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ABA7CC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCHv3 1/2] ath11k: Configure hash based reo destination ring
 selection
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1584350864-20622-2-git-send-email-srirrama@codeaurora.org>
References: <1584350864-20622-2-git-send-email-srirrama@codeaurora.org>
To:     Sriram R <srirrama@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sriram R <srirrama@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200317081605.425FDC433CB@smtp.codeaurora.org>
Date:   Tue, 17 Mar 2020 08:16:05 +0000 (UTC)
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

Failed to apply, please rebase.

error: patch failed: drivers/net/wireless/ath/ath11k/wmi.h:4620
error: drivers/net/wireless/ath/ath11k/wmi.h: patch does not apply
stg import: Diff does not apply cleanly

2 patches set to Changes Requested.

11439997 [PATCHv3,1/2] ath11k: Configure hash based reo destination ring selection
11440005 [PATCHv3,2/2] ath11k: Perform per-msdu rx processing

-- 
https://patchwork.kernel.org/patch/11439997/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
