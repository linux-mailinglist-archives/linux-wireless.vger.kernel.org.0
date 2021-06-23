Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593503B1FD7
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jun 2021 19:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFWRty (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Jun 2021 13:49:54 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:39003 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWRts (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Jun 2021 13:49:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624470451; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=XT8Ko6yy0PNJNz7ioL4pbH4GfH/fI3sW79fcaRJI7xs=;
 b=qN5AyYcutbyEIW+mmBzY/h6jOYGpUGo4VQZd4gwt8Tr52jKSwcUQ08fz02dk87tQWud5swpY
 IITq7zcAvyDbcoXvqHOJpXq4I1GkB7MsnKrs2Pye22LSpo1ciO4bEp3FMB0nJXKbSNWvBLX4
 uznslzYu8qShkYVhu+M9QsfQKCg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60d373a75e3e57240b5bb36f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Jun 2021 17:47:19
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ABFCEC43460; Wed, 23 Jun 2021 17:47:18 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CC519C43460;
        Wed, 23 Jun 2021 17:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC519C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: fix c2h memory leak
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210621103023.41928-1-pkshih@realtek.com>
References: <20210621103023.41928-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <phhuang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210623174718.ABFCEC43460@smtp.codeaurora.org>
Date:   Wed, 23 Jun 2021 17:47:18 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> Fix erroneous code that leads to unreferenced objects. During H2C
> operations, some functions returned without freeing the memory that only
> the function have access to. Release these objects when they're no longer
> needed to avoid potentially memory leaks.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Failed to apply, please rebase:

Recorded preimage for 'drivers/net/wireless/realtek/rtw88/coex.c'
error: Failed to merge in the changes.
hint: Use 'git am --show-current-patch' to see the failed patch
Applying: rtw88: fix c2h memory leak
Using index info to reconstruct a base tree...
M	drivers/net/wireless/realtek/rtw88/coex.c
M	drivers/net/wireless/realtek/rtw88/fw.c
M	drivers/net/wireless/realtek/rtw88/main.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/realtek/rtw88/main.c
Auto-merging drivers/net/wireless/realtek/rtw88/fw.c
Auto-merging drivers/net/wireless/realtek/rtw88/coex.c
CONFLICT (content): Merge conflict in drivers/net/wireless/realtek/rtw88/coex.c
Patch failed at 0001 rtw88: fix c2h memory leak

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210621103023.41928-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

