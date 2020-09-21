Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1255327253A
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 15:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgIUNRj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 09:17:39 -0400
Received: from z5.mailgun.us ([104.130.96.5]:52326 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgIUNRj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 09:17:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600694258; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=2g72kPt9OcZMXFVc64ZbSJhzSolKXz2DphnakeRJZzU=;
 b=DzvmF0EZgjEYn5t+V1MYxNcrVaOXoSu/Dlh42G81D/UJf95qg9EQHdgkLRRBW5RrA3JxEFk4
 KRs2E2lkxDtjyDrmne/uxCABLmQO8aVLe5DvgF3dbg4MoyAf8T+X5Sz9UIj05H4a3ccYssWA
 xCFmNZaIHE3ffTR/tTIWt1N25fM=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f68a7f26b1937bb653bdd33 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Sep 2020 13:17:38
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 351FCC433CA; Mon, 21 Sep 2020 13:17:38 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2E2DCC433C8;
        Mon, 21 Sep 2020 13:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2E2DCC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 1/7] wcn36xx: Functionally decompose
 wcn36xx_smd_config_sta()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200910150631.2178970-2-bryan.odonoghue@linaro.org>
References: <20200910150631.2178970-2-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200921131738.351FCC433CA@smtp.codeaurora.org>
Date:   Mon, 21 Sep 2020 13:17:38 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> This commit functionally decomposes wcn36xx_smd_config_sta into a clearly
> defined wcn36xx_smd_config_sta_v0 and wcn36xx_smd_config_sta_v1 path.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

7 patches applied to ath-next branch of ath.git, thanks.

fe784c28fee1 wcn36xx: Functionally decompose wcn36xx_smd_config_sta()
9e212908b547 wcn36xx: Move wcn36xx_smd_set_sta_params() inside wcn36xx_smd_config_bss()
683693102072 wcn36xx: Move BSS parameter setup to wcn36xx_smd_set_bss_params()
7656d1798556 wcn36xx: Update wcn36xx_smd_config_bss_v1() to operate internally
1cdab0f89663 wcn36xx: Add wcn36xx_smd_config_bss_v0
5a7b60ad56d7 wcn36xx: Convert to using wcn36xx_smd_config_bss_v0()
d1e11d5f2167 wcn36xx: Remove dead code in wcn36xx_smd_config_bss()

-- 
https://patchwork.kernel.org/patch/11768939/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

