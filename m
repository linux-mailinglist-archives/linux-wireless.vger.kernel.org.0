Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AB5312FBA
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 11:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhBHKyq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 05:54:46 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:52326 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232528AbhBHKvs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 05:51:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612781481; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=KtM7VoW7VuYLh8mE6mIoG6cvClQKfNgx9ZSv4DzOQpc=;
 b=go/YJ6gC6gwOWX4f97vOaaImA8IcFh/hSo1qhX2Vo4iFVtv8YvjjJpf1bsooVLy/KOVlzT5x
 IC+5DbspmXTEXy9GP2YdFBU2s3amQGB3MCjvBjcFhS3IluOT+TFtuDdKLspc5mlcIQ6Bz7yp
 aA80yogHh6FX/v/dxWSPQLqm318=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60211779e4842e9128fe97d6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Feb 2021 10:50:33
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2850AC433C6; Mon,  8 Feb 2021 10:50:32 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A2A0C433C6;
        Mon,  8 Feb 2021 10:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A2A0C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/8] rtw88: add dynamic rrsr configuration
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210115092405.8081-2-pkshih@realtek.com>
References: <20210115092405.8081-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <phhuang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210208105032.2850AC433C6@smtp.codeaurora.org>
Date:   Mon,  8 Feb 2021 10:50:32 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> Register rrsr determines the response rate we send.
> In field tests, using rate higher than current tx rate could lead
> to difficulty for the receiving end to receive management/control
> frames. Calculate current modulation level by tx rate then cross out
> rate higher than those.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Based on the discussion I understood there will be v5. But let me know
if I misunderstood.

8 patches set to Changes Requested.

12021961 [v4,1/8] rtw88: add dynamic rrsr configuration
12021963 [v4,2/8] rtw88: add rts condition
12021965 [v4,3/8] rtw88: add napi support
12021967 [v4,4/8] rtw88: replace tx tasklet with work queue
12021969 [v4,5/8] rtw88: 8822c: update MAC/BB parameter tables to v60
12022005 [v4,6/8] rtw88: 8822c: update RF_A parameter tables to v60
12022001 [v4,7/8] rtw88: 8822c: update RF_B (1/2) parameter tables to v60
12022003 [v4,8/8] rtw88: 8822c: update RF_B (2/2) parameter tables to v60

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210115092405.8081-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

