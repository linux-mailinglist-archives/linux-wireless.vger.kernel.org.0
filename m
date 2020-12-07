Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C752D159C
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Dec 2020 17:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbgLGQJF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Dec 2020 11:09:05 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:45546 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgLGQJC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Dec 2020 11:09:02 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607357321; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ayMX2pSlVAjFV/Ex8M3i3qu7uBXiStC+HQOdAwSsw0w=;
 b=AK5fgKJev56z8c+XjWtPM1e7TowzHU0VE32BLAwZgMiKTazDJ88+4Q6xcL4uafABhwSXdxLU
 YRfZs0cq1QOt4GPIvlaSY16yp8/fQx6SNV2mIRYKthBzrsBTOnFJ+Ap7K2JuYxbW+202YUmF
 keXvFdt4jk1EcPatkHYN18hgUFI=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5fce536ceb348d1ba2610840 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 07 Dec 2020 16:08:12
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EB1BFC43462; Mon,  7 Dec 2020 16:08:11 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 63934C433C6;
        Mon,  7 Dec 2020 16:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63934C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: fix a check patch warning
 returnNonBoolInBooleanFunction of sdio.c
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1606103240-9868-1-git-send-email-wgong@codeaurora.org>
References: <1606103240-9868-1-git-send-email-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong@codeaurora.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201207160811.EB1BFC43462@smtp.codeaurora.org>
Date:   Mon,  7 Dec 2020 16:08:11 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> cppcheck possible warnings: (new ones prefixed by >>, may not real problems)
> drivers/net/wireless/ath/ath10k/sdio.c:2234:2:
> warning: Non-boolean value returned from function returning bool [returnNonBoolInBooleanFunction]
> return param & HI_OPTION_SDIO_CRASH_DUMP_ENHANCEMENT_FW;
> 
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00049
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

7f881a721716 ath10k: fix a check patch warning returnNonBoolInBooleanFunction of sdio.c

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1606103240-9868-1-git-send-email-wgong@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

