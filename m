Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB8C368195
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Apr 2021 15:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbhDVNjA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Apr 2021 09:39:00 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:11284 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbhDVNjA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Apr 2021 09:39:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619098705; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ijTwzAYvPRtSmBlbgnXvl1Cy4ekcewnzng7Vy6iRf7w=;
 b=W//HmjY/ngUojlMdFtxEOC+bdh/k5C7mmZanBuDJNrWy5aSXbIyPaPejauvc891GosqvVs5n
 Bn36NkVkkyOeALeYwKL3dCfhAO0PQuO6iqGZqzC2/4QSFlsUih9XQiGsAtXIcFRvendMLCFt
 3gWFGDkZQpV0LyKTlKLi59u4PLw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60817c5187ce1fbb5651ca1f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 22 Apr 2021 13:38:25
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 65F7DC4338A; Thu, 22 Apr 2021 13:38:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 17E76C433D3;
        Thu, 22 Apr 2021 13:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17E76C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ath9k: Fix error check in ath9k_hw_read_revisions() for
 PCI
 devices
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210326180819.142480-1-toke@redhat.com>
References: <20210326180819.142480-1-toke@redhat.com>
To:     =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210422133824.65F7DC4338A@smtp.codeaurora.org>
Date:   Thu, 22 Apr 2021 13:38:24 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke Høiland-Jørgensen <toke@redhat.com> wrote:

> When the error check in ath9k_hw_read_revisions() was added, it checked for
> -EIO which is what ath9k_regread() in the ath9k_htc driver uses. However,
> for plain ath9k, the register read function uses ioread32(), which just
> returns -1 on error. So if such a read fails, it still gets passed through
> and ends up as a weird mac revision in the log output.
> 
> Fix this by changing ath9k_regread() to return -1 on error like ioread32()
> does, and fix the error check to look for that instead of -EIO.
> 
> Fixes: 2f90c7e5d094 ("ath9k: Check for errors when reading SREV register")
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

7dd9a40fd6e0 ath9k: Fix error check in ath9k_hw_read_revisions() for PCI devices

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210326180819.142480-1-toke@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

