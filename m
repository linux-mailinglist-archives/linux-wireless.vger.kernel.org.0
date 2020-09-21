Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C5827252F
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 15:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgIUNQP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 09:16:15 -0400
Received: from z5.mailgun.us ([104.130.96.5]:52326 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbgIUNQP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 09:16:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600694174; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=iIWiOK2wx0+silSekHoOZ48o1IvbTXiNHiNwRfn/e4U=;
 b=L/0k3q5W0fWmyHvrvWn0NBOaB35xL8aTzPqWIV2hk8ssQ+fsL6ohCYe+95/aazec6IQk14/c
 RxsAwCDFSmHvSVfHsXbRwBtj5FLIwZWx8OxNNjAMeTXaBpah9BBtvjzRo4lyQXrkh64Javq+
 3qHuYmZjJlAvnaE8MybcFSBwP+M=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f68a74e0566e2dcd7e77ac3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Sep 2020 13:14:54
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E49CEC433FE; Mon, 21 Sep 2020 13:14:53 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 21AF2C43382;
        Mon, 21 Sep 2020 13:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 21AF2C43382
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 1/7] wcn36xx: Add wcn36xx_set_default_rates_v1
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200910150552.2178882-2-bryan.odonoghue@linaro.org>
References: <20200910150552.2178882-2-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200921131453.E49CEC433FE@smtp.codeaurora.org>
Date:   Mon, 21 Sep 2020 13:14:53 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> Add a routine to set some additional default parameters associated with the
> V1 data structure.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

7 patches applied to ath-next branch of ath.git, thanks.

c84515bd8f1c wcn36xx: Add wcn36xx_set_default_rates_v1
21ba284ca9f0 wcn36xx: Add wcn36xx_smd_set_sta_default_vht_params()
5a3b4ae1f32f wcn36xx: Add wcn36xx_smd_set_sta_default_ht_ldpc_params()
287c9310eab8 wcn36xx: Add wcn36xx_smd_set_sta_vht_params()
17801df251e8 wcn36xx: Add wcn36xx_smd_set_sta_ht_ldpc_params()
5a32029ad022 wcn36xx: Add wcn36xx_smd_set_bss_vht_params()
c05a8bd80c17 wcn36xx: Add wrapper function wcn36xx_smd_set_sta_params_v1()

-- 
https://patchwork.kernel.org/patch/11768067/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

