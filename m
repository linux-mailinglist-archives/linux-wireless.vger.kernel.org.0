Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5884B3A7EC0
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 15:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFONNy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 09:13:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62375 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230268AbhFONNv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 09:13:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623762707; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=pk+1GWuddeuPwpLigg8U6jyX5vPbohEBKNDLt5gnSNg=;
 b=dajF4WaRpjgTOtyplzVWeRjW9jBNeBOOxeVcqle1RaT26WcZy2ZWAENtYY9VSyTW8HwWw8EB
 P7tabcx7iQbLMvRlfPGUd+ilnf1jCKprtQEdivMNcKeY11RvPMiO0NWOE/fTmmw1qvBVSYKB
 AlaNh9cbzvNcNSMqtirtOWyu+hg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60c8a6fce570c05619c8e656 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 13:11:24
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0E473C433F1; Tue, 15 Jun 2021 13:11:24 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4732BC433D3;
        Tue, 15 Jun 2021 13:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4732BC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [07/11] libertas_tf: Fix wrong function name in comments
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210517050141.61488-8-shenyang39@huawei.com>
References: <20210517050141.61488-8-shenyang39@huawei.com>
To:     Yang Shen <shenyang39@huawei.com>
Cc:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Yang Shen" <shenyang39@huawei.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615131124.0E473C433F1@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 13:11:24 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yang Shen <shenyang39@huawei.com> wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/net/wireless/marvell/libertas_tf/if_usb.c:56: warning: expecting prototype for if_usb_wrike_bulk_callback(). Prototype was for if_usb_write_bulk_callback() instead
> 
> Signed-off-by: Yang Shen <shenyang39@huawei.com>

4 patches applied to wireless-drivers-next.git, thanks.

30657b8ee459 libertas_tf: Fix wrong function name in comments
9a0fb9502f0d rtlwifi: Fix wrong function name in comments
c707db1b2e7b rsi: Fix missing function name in comments
c3b67ea3d97a wlcore: Fix missing function name in comments

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210517050141.61488-8-shenyang39@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

