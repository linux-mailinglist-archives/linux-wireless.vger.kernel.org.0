Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79BD6189AEE
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2020 12:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCRLpy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Mar 2020 07:45:54 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:60708 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbgCRLpy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Mar 2020 07:45:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584531953; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=VQBMQtJTp2nFFQCefMoBGwuo5ohvM/mnENFxFvogrKM=;
 b=Txgo5h5DdQHfV4/YnKis9GJUXN/Q3snWuPGZHO9RWoY4w/vA+C33Qzs6CIdxuKd4thVTkKUE
 CYAMw35vR1V8q7XQmuQ6pmVg6FevI7GD0eqqJ9xuyaruJ602jt7xVJXTxKkHe4la9oGH6D6m
 KLIJjC2MYv59mUrZu4C8vYidI2E=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7209eb.7f952826d500-smtp-out-n03;
 Wed, 18 Mar 2020 11:45:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D455BC433D2; Wed, 18 Mar 2020 11:45:46 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F6CCC433CB;
        Wed, 18 Mar 2020 11:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F6CCC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] ath11k: Supporting RX ring backpressure HTT event and
 stats handling
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1584350920-20688-1-git-send-email-srirrama@codeaurora.org>
References: <1584350920-20688-1-git-send-email-srirrama@codeaurora.org>
To:     Sriram R <srirrama@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sriram R <srirrama@codeaurora.org>,
        Vikas Patel <vikpatel@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200318114546.D455BC433D2@smtp.codeaurora.org>
Date:   Wed, 18 Mar 2020 11:45:46 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sriram R <srirrama@codeaurora.org> wrote:

> The Firmware sends HTT event to host whenever there is a
> backpressure on RX rings, Handling such event and dumping
> info on the console under the "ATH11K_DBG_DP_HTT"  debug level.
> 
> Fetching RX ring backpressure histogram from FW via htt_stats debugfs.
> 
>  #echo "24" > /sys/kernel/debug/ath11k/ipq8074/macX/htt_stats_type
>  #cat /sys/kernel/debug/ath11k/ipq8074/macX/htt_stats
> 
> Signed-off-by: Vikas Patel <vikpatel@codeaurora.org>
> Signed-off-by: Sriram R <srirrama@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

678e8414bf4e ath11k: Supporting RX ring backpressure HTT event and stats handling

-- 
https://patchwork.kernel.org/patch/11440011/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
