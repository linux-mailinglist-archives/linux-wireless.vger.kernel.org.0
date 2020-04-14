Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5383C1A763A
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 10:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436914AbgDNIdG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 04:33:06 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:17620 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436826AbgDNIco (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 04:32:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586853163; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=yybpWX6QG5dlwS8f7kE0RNoF5r7wnbLsdsQBhUiK1/s=;
 b=tHMHORBdjMxk+WDda+auU8sAkODcaBxYoJk1CpRU/BkzDn9pusiUA+2IunBXUx9SfTrO2p9M
 wqVa0ERF6zTlIaV6xjm2njndXEVMXiwCXWyYuJSJwFjL1lw7vsyopGy9faAmcjb8UYSqLr6x
 k9KuCb9K2GUCumll9aiSXw6q1pA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e95751b.7f2108429b90-smtp-out-n04;
 Tue, 14 Apr 2020 08:32:27 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5E99CC433BA; Tue, 14 Apr 2020 08:32:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DD87DC433CB;
        Tue, 14 Apr 2020 08:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD87DC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fix TWT radio count
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200408174117.22957-1-alokad@codeaurora.org>
References: <20200408174117.22957-1-alokad@codeaurora.org>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Aloka Dixit <alokad@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200414083227.5E99CC433BA@smtp.codeaurora.org>
Date:   Tue, 14 Apr 2020 08:32:27 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <alokad@codeaurora.org> wrote:

> TWT feature fails on radio2 because physical device count is
> hardcoded to 2. Set value dynamically.
> 
> Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

a3baa8f08419 ath11k: Fix TWT radio count

-- 
https://patchwork.kernel.org/patch/11480581/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
