Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020C4273C43
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 09:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbgIVHp7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 03:45:59 -0400
Received: from z5.mailgun.us ([104.130.96.5]:44514 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730066AbgIVHp7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 03:45:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600760758; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=/Q0IKlekSxFI/LNySz/8mlfVQ1aH2i7zmdmrDurMb9o=;
 b=NN6aFvxjchLSy4tvZEhUsE44OSRLUoi+zuVG0w0aPhuvfguy4GSspGZlcLfg9FiZD0nN9DKe
 qIoKlpw6vBc2wblGuhFQcIpIT2EE9jcr8ri6dHy0zRCcK6U11xmG8Vj6Cc8FyVVR+s/SUHga
 PmVVVT3MueSi/BXOse1XgHcrD1A=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f69ab71d19dddf2f9dfda41 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Sep 2020 07:44:49
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C2BDCC433C8; Tue, 22 Sep 2020 07:44:48 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 521D7C433CB;
        Tue, 22 Sep 2020 07:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 521D7C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: remove redundant num_keep_alive_pattern
 assignment
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1600361190-22047-1-git-send-email-kvalo@codeaurora.org>
References: <1600361190-22047-1-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200922074448.C2BDCC433C8@smtp.codeaurora.org>
Date:   Tue, 22 Sep 2020 07:44:48 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> There were two asignments to num_keep_alive_pattern, remove the first one which is wrong.
> 
> No functional changes. Compile tested only.
> 
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

9883c0d075f1 ath11k: remove redundant num_keep_alive_pattern assignment

-- 
https://patchwork.kernel.org/patch/11782897/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

