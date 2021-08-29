Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0038E3FA9DE
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Aug 2021 09:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbhH2HNl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Aug 2021 03:13:41 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55535 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234733AbhH2HNl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Aug 2021 03:13:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630221169; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=XURRjWT7HCcJ0+x0NBR/pNfKdWc/Eef8Bji3peHuyhg=;
 b=uRD0ChlxB5T4rIvGXncqC2yxayiPQG6cBTcipaOLqy6al3PgHpZGGjEqUa0uKxa4n7pi6JRI
 bEferRYZ/oKhTcC4F36SV87UghVeEVONFMKSqtqbabPtbiN+ju7V46dpy1RZOmeQCXFDnmXW
 MSlExpV32T9/Xy7ZWhpE3fKzDZY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 612b336a6fc2cf7ad9de6023 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 29 Aug 2021 07:12:42
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B0FA5C43460; Sun, 29 Aug 2021 07:12:41 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A0348C4338F;
        Sun, 29 Aug 2021 07:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A0348C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath9k: fix sleeping in atomic context
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1628481916-15030-1-git-send-email-miaoqing@codeaurora.org>
References: <1628481916-15030-1-git-send-email-miaoqing@codeaurora.org>
To:     Miaoqing Pan <miaoqing@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com,
        dan.carpenter@oracle.com, linux-gpio@vger.kernel.org,
        Miaoqing Pan <miaoqing@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210829071241.B0FA5C43460@smtp.codeaurora.org>
Date:   Sun, 29 Aug 2021 07:12:41 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Miaoqing Pan <miaoqing@codeaurora.org> wrote:

> The problem is that gpio_free() can sleep and the cfg_soc() can be
> called with spinlocks held. One problematic call tree is:
> 
> --> ath_reset_internal() takes &sc->sc_pcu_lock spin lock
>    --> ath9k_hw_reset()
>       --> ath9k_hw_gpio_request_in()
>          --> ath9k_hw_gpio_request()
>             --> ath9k_hw_gpio_cfg_soc()
> 
> Remove gpio_free(), use error message instead, so we should make sure
> there is no GPIO conflict.
> 
> Also remove ath9k_hw_gpio_free() from ath9k_hw_apply_gpio_override(),
> as gpio_mask will never be set for SOC chips.
> 
> Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

7c48662b9d56 ath9k: fix sleeping in atomic context

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1628481916-15030-1-git-send-email-miaoqing@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

