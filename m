Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1265032378E
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Feb 2021 07:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhBXGyQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Feb 2021 01:54:16 -0500
Received: from z11.mailgun.us ([104.130.96.11]:63816 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230386AbhBXGyO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Feb 2021 01:54:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614149630; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=MHS+FWRAMrdC80h0tzPcGk54lO0X0VMJLwQu1YDgv9I=;
 b=k4yKdFRrwi81/aDDvXbeREHoWbs8m13WrlAyAwy8NbA665FPNeUBfRQTYqxAK3n/7L5a/NHS
 bqhbzb7snibL77ChF+y0amdrfrBa7c1lRoHv8V6NU0CXRBYiPzZ6i7r0yiW4jzcQtYn+UwyT
 L/hVjJo4ZeE/411Po17fe4VDUXM=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6035f7e3090a774287983925 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Feb 2021 06:53:23
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 67BBBC433ED; Wed, 24 Feb 2021 06:53:23 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B9A9C433CA;
        Wed, 24 Feb 2021 06:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B9A9C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix potential wmi_mgmt_tx_queue race condition
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1613630709-704-1-git-send-email-miaoqing@codeaurora.org>
References: <1613630709-704-1-git-send-email-miaoqing@codeaurora.org>
To:     Miaoqing Pan <miaoqing@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Miaoqing Pan <miaoqing@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210224065323.67BBBC433ED@smtp.codeaurora.org>
Date:   Wed, 24 Feb 2021 06:53:23 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Miaoqing Pan <miaoqing@codeaurora.org> wrote:

> There is a potential race condition between skb_queue_len()
> and skb_queue_tail(), the former may get old value before
> updated by the latter.
> 
> So use skb_queue_len_lockless() instead. And also use '>=',
> in case we queue a few SKBs simultaneously.
> 
> Found while discussing a similar fix for ath10k:
> https://patchwork.kernel.org/project/linux-wireless/patch/1608515579-1066-1-git-send-email-miaoqing@codeaurora.org/
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

3808a18043a8 ath11k: fix potential wmi_mgmt_tx_queue race condition

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1613630709-704-1-git-send-email-miaoqing@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

