Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D785935B298
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 11:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhDKJUT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 05:20:19 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:21797 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhDKJUS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 05:20:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618132802; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=yFX0YTYRwAO65mrjE8v6C9HZtJuOVjhWKvnTFuKbz5U=;
 b=mLdEnnA4q2B1KUHWDxJGxoZjqL6VsimYepXh7NHSVcGrSJBXel/abGJHEPUy9NazieAwIl7H
 QNyg7RFzl1ZjZez32Y+meJKRHitbwXqh8rKmVKKlpkvZQFC00Zyvp7oSepHFIQM+HnUaHtVV
 dmdldU/+maAY8qrhCef34mDLALU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6072bf3787ce1fbb56bf47f3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 11 Apr 2021 09:19:51
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2B01AC433CA; Sun, 11 Apr 2021 09:19:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5C9F0C433C6;
        Sun, 11 Apr 2021 09:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C9F0C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 6/7] rtw88: 8822c: add CFO tracking
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210319054218.3319-7-pkshih@realtek.com>
References: <20210319054218.3319-7-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <ku920601@realtek.com>, <phhuang@realtek.com>,
        <shaofu@realtek.com>, <steventing@realtek.com>,
        <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210411091951.2B01AC433CA@smtp.codeaurora.org>
Date:   Sun, 11 Apr 2021 09:19:51 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> Add CFO tracking mechanism to mitigate the effect of oscillator
> frequency discrepancy.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

What's CFO? I need to understand the commit log, so please write it so that any
engineer working with wireless understands it.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210319054218.3319-7-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

