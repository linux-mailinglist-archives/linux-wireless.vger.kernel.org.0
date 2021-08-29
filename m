Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2263FA9DF
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Aug 2021 09:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbhH2HNr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Aug 2021 03:13:47 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:12685 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbhH2HNr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Aug 2021 03:13:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630221175; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=FNTXCKRZ6QWHP58SXxTBmeCnaFBJrEltg7Nggl0o4HM=;
 b=MLOF7yJunXe1Ptn6v0oVL9vIeAnVxp4xoBs+99qiTt6xcWrot0d4C4sSBv9yDhBykFNA02ZH
 Lc/eAVyjc6/vsGbsyfn9Zl7gFUgU1IsGeLBCs0Ccu6BW//6jNHMTLo/rdtJdC23+Wnbztu6I
 0cmvf/35j+eVkR5QdJR7f6lm25E=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 612b33524d644b7d1c688978 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 29 Aug 2021 07:12:18
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 81794C4338F; Sun, 29 Aug 2021 07:12:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A8A83C43460;
        Sun, 29 Aug 2021 07:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A8A83C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath9k: fix OOB read ar9300_eeprom_restore_internal
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <YM3xKsQJ0Hw2hjrc@Zekuns-MBP-16.fios-router.home>
References: <YM3xKsQJ0Hw2hjrc@Zekuns-MBP-16.fios-router.home>
To:     Zekun Shen <bruceshenzk@gmail.com>
Cc:     bruceshenzk@gmail.com, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210829071218.81794C4338F@smtp.codeaurora.org>
Date:   Sun, 29 Aug 2021 07:12:18 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zekun Shen <bruceshenzk@gmail.com> wrote:

> Bad header can have large length field which can cause OOB.
> cptr is the last bytes for read, and the eeprom is parsed
> from high to low address. The OOB, triggered by the condition
> length > cptr could cause memory error with a read on
> negative index.
> 
> There are some sanity check around length, but it is not
> compared with cptr (the remaining bytes). Here, the
> corrupted/bad EEPROM can cause panic.
> 
> I was able to reproduce the crash, but I cannot find the
> log and the reproducer now. After I applied the patch, the
> bug is no longer reproducible.
> 
> Signed-off-by: Zekun Shen <bruceshenzk@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

23151b9ae79e ath9k: fix OOB read ar9300_eeprom_restore_internal

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/YM3xKsQJ0Hw2hjrc@Zekuns-MBP-16.fios-router.home/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

