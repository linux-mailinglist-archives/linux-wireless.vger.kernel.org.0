Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B282C12E8
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Nov 2020 19:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390418AbgKWSHo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Nov 2020 13:07:44 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:36733 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732632AbgKWSHo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Nov 2020 13:07:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606154863; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=TEeWWkx6iSTomD5gjI37LyqW1V98ds5vHL9u51ph4zo=;
 b=CMn6vm/4AJujdk0fD2L1KFrJp4GPERPV8lUnAPPc1JINCgvGqzNssJlcqD8xFYsN62P8V+qG
 PbBPDwBnNr1uJn25sEgnaMWOyCST+xEVZMm5BPhFwpg82kkjPGZiKe2JxAkeZ7PZ4v+duN0w
 yM/rl8LrJwJee0oN8Gf1Jr+2YLI=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5fbbfa694146c5eefd6d121b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Nov 2020 18:07:37
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 94A24C43461; Mon, 23 Nov 2020 18:07:36 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3670AC433ED;
        Mon, 23 Nov 2020 18:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3670AC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: add target IRAM recovery feature support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1604657442-23674-1-git-send-email-vnaralas@codeaurora.org>
References: <1604657442-23674-1-git-send-email-vnaralas@codeaurora.org>
To:     Venkateswara Naralasetty <vnaralas@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201123180736.94A24C43461@smtp.codeaurora.org>
Date:   Mon, 23 Nov 2020 18:07:36 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Venkateswara Naralasetty <vnaralas@codeaurora.org> wrote:

> This target IRAM recovery feature support is to copy target
> IRAM contents available at ATH10K_MEM_REGION_TYPE_REG to host
> memory for back up after firmware loaded. Target IRAM contents
> are copied to wmi memory chunks allocated for the
> WMI_IRAM_RECOVERY_HOST_MEM_REQ_ID and provide the wmi chunks
> address to the firmware through wmi init command.
> 
> If firmware detects andy IRAM corruption through periodic
> checksum validation, It will download the IRAM contents back
> from the provided wmi memory chunks address using hif_memcpy.
> 
> This IRAM recovery feature prevent target assert in case of
> unexpected target IRAM corruptions.
> 
> This patch also introduce a new feature flag 'iram-recovery' for
> backward compatibility.
> 
> Tested-on: QCA9888 10.4-3.9.0.2-00094
> 
> Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

9af7c32ceca8 ath10k: add target IRAM recovery feature support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1604657442-23674-1-git-send-email-vnaralas@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

