Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF8B2C2AB0
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Nov 2020 16:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389372AbgKXPCY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Nov 2020 10:02:24 -0500
Received: from z5.mailgun.us ([104.130.96.5]:40831 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389251AbgKXPCY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Nov 2020 10:02:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606230143; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=8dA2xS9wFm8NNFfJRPXAUn6SNur2KR7mi0p7OqQ6FHs=;
 b=wmI+Q+94k1oOgSS9kB+/NX9vkKhsPhyGRVZowLuD4q60M30FVP//zjhq0fbz1pmR5sFQ9UwC
 0J80MaYdCbB5msfqabZ53ggBUf1JPDMWhni/lgYxA2n5IKmZK/yXISrl4OOd85ZIuC8wrrZm
 ckNzGpOd0+yNBURlRJ0oUj2wJjo=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5fbd20220c9500dc7b91996f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 24 Nov 2020 15:00:50
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CA88EC43463; Tue, 24 Nov 2020 15:00:50 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4FA71C43460;
        Tue, 24 Nov 2020 15:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FA71C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmfmac: fix error return code in
 brcmf_cfg80211_connect()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1605248896-16812-1-git-send-email-zhangchangzhong@huawei.com>
References: <1605248896-16812-1-git-send-email-zhangchangzhong@huawei.com>
To:     Zhang Changzhong <zhangchangzhong@huawei.com>
Cc:     <arend.vanspriel@broadcom.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <chi-hsien.lin@cypress.com>,
        <wright.feng@cypress.com>, <davem@davemloft.net>,
        <kuba@kernel.org>, <stanley.hsu@cypress.com>,
        <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201124150050.CA88EC43463@smtp.codeaurora.org>
Date:   Tue, 24 Nov 2020 15:00:50 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zhang Changzhong <zhangchangzhong@huawei.com> wrote:

> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: 3b1e0a7bdfee ("brcmfmac: add support for SAE authentication offload")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
> Reviewed-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>

Patch applied to wireless-drivers-next.git, thanks.

37ff144d29ac brcmfmac: fix error return code in brcmf_cfg80211_connect()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1605248896-16812-1-git-send-email-zhangchangzhong@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

