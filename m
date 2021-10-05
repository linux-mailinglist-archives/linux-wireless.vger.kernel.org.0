Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9662B421DF1
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Oct 2021 07:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhJEFbD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Oct 2021 01:31:03 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:25284 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhJEFbC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Oct 2021 01:31:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633411752; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=6ce4ZLocXNIebnQxqQexJSCBOuU2PJudwfUbJzA8ZQ4=;
 b=uzliy7Ojyq4DFBlAQ2yLDbfe+xAqpSx9NaFI7fRfGNdn0u6sr94Sx3a3+lsnG0EzEUf3SDZ7
 0VV2TcX+/Q9dZGUC1L2ax5L32cc1NkwAXMruRMZoFqPJs7ms1UwbwAMyembOgmsh//44sXu0
 E1jfvMlTrAShNPBSC4JGsC1CqtA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 615be29787540061e6f760ca (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 05 Oct 2021 05:28:54
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D8E27C4360D; Tue,  5 Oct 2021 05:28:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6007FC4338F;
        Tue,  5 Oct 2021 05:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 6007FC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] rtw88: refine fw_crash debugfs to show non-zero while
 triggering
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211001082301.4805-1-pkshih@realtek.com>
References: <20211001082301.4805-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20211005052854.D8E27C4360D@smtp.codeaurora.org>
Date:   Tue,  5 Oct 2021 05:28:54 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> The usage of fw_crash debugfs is to write 1 to it to trigger fw crash
> simulation and to read from it to check the state. When zero is read,
> it is supposed to mean fw crash/restart process is done. Then, some
> test plans can be designed for crash/restart.
> e.g.
> step 1. trigger fw crash simulation
> step 2. poll the state until zero is read
> step 3. check connection by ping test
> 
> However, in certain connection cases, triggering fw crash simulation
> will take a while. If the state is queried too early before restart
> begins processing, it may mistakenly think restart process has been
> done. If some tests are started at this time, something unexpected
> might happen due to the follow-up restart process.
> 
> To avoid that, let fw_crash also show non-zero when a simulation
> is still triggering.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

6cd4b59ddb1a rtw88: refine fw_crash debugfs to show non-zero while triggering

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211001082301.4805-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

