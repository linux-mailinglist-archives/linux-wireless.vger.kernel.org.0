Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7C024821D
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Aug 2020 11:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHRJm2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Aug 2020 05:42:28 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:54797 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726370AbgHRJm0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Aug 2020 05:42:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597743746; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=zywCuUoQVpjCOujz3hIRjv6x5IQaS95Tmn16d3ZXhxc=;
 b=CKXT55ZJ5uJVMIdj+MwxBDvoyAh7gnQIgXbju6VAJppY5HPLiQ6c6blwbSGCngJ9/V76cMvu
 7EDJamE0v6TTHnaKN29YG+gG6WSmoPuW5tgKTh41EP1NgPpIL4ctcFcG9+WFuviL0L/gWIns
 0+CBfjtryoGT8EPu/FKB4RwFEoA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f3ba27f2f4952907d7b2cd6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 09:42:23
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F07A3C43387; Tue, 18 Aug 2020 09:42:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DD58BC433CA;
        Tue, 18 Aug 2020 09:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD58BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: move enable_pll_clk call to ath10k_core_start()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1597421745-4329-1-git-send-email-kvalo@codeaurora.org>
References: <1597421745-4329-1-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200818094222.F07A3C43387@smtp.codeaurora.org>
Date:   Tue, 18 Aug 2020 09:42:22 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> There's no reason to have call for enable_pll_clk in ath10k_bmi_start(), move
> it to ath10k_core_start() instead. This way it's possible to call
> ath10k_bmi_start() from sdio.c during firmware dump creation. And also the
> function call is more visible when it's in core.c.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

ad0dc0426468 ath10k: move enable_pll_clk call to ath10k_core_start()

-- 
https://patchwork.kernel.org/patch/11714755/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

