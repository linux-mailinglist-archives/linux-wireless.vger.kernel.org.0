Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 125BB1830FD
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 14:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgCLNOh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 09:14:37 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:17778 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgCLNOh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 09:14:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584018877; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=SoH0yQcxDHFiJFhsJNIffECfxW1nEMcJUlizyxrOJNA=;
 b=XXH2iv3nAhwCo0HdBmkVbAYdyM0aRj9bbt7n5TAL3vIgN1Nj/16KbWc4rPT2DzD7D1CW150i
 Yh9qEBDtvdY0LmD+eJJf9PZh4REjBHz7h1J3fwZvApVy7FFQGF2QrpYWI6Um/KjHv8ke1cEQ
 +JuQdjdzenxt9xi9qSrVnxu18Q0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6a35ae.7f1b007e5ab0-smtp-out-n02;
 Thu, 12 Mar 2020 13:14:22 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 75958C432C2; Thu, 12 Mar 2020 13:14:22 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C6B27C433BA;
        Thu, 12 Mar 2020 13:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6B27C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCHv2] ath11k: Supporting RX ring backpressure HTT event and
 stats handling
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1581909128-14861-1-git-send-email-srirrama@codeaurora.org>
References: <1581909128-14861-1-git-send-email-srirrama@codeaurora.org>
To:     Sriram R <srirrama@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Vikas Patel <vikpatel@codeaurora.org>,
        Sriram R <srirrama@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200312131422.75958C432C2@smtp.codeaurora.org>
Date:   Thu, 12 Mar 2020 13:14:22 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sriram R <srirrama@codeaurora.org> wrote:

> From: Vikas Patel <vikpatel@codeaurora.org>
> 
> The Firmware sends HTT event to host whenever there is a
> backpressure on RX rings, Handling such event and dumping
> info on the console under the "ATH11K_DBG_DP_HTT"  debug level.
> 
> Fetching RX ring backpressure histogram from FW via htt_stats debugfs.
> 
>  #echo "24" > /sys/kernel/debug/ath11k/macX/htt_stats_type
>  #cat /sys/kernel/debug/ath11k/macX/htt_stats
> 
> Signed-off-by: Vikas Patel <vikpatel@codeaurora.org>
> Signed-off-by: Sriram R <srirrama@codeaurora.org>

Fails to apply, please rebase.

error: patch failed: drivers/net/wireless/ath/ath11k/dp_rx.c:1330
error: drivers/net/wireless/ath/ath11k/dp_rx.c: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11385041/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
