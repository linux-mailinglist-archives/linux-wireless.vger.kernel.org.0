Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1893DA6A0C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 15:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfICNiL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 09:38:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50560 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfICNiL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 09:38:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 56175607EB; Tue,  3 Sep 2019 13:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567517890;
        bh=/IIAX28ybymPI/d9nKwEudqgSJsDn9fKIihspf4kSbQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=UQNXHCCBivXTF5pjjKKNDZTCKrDsTBiazTwFlALMM4qi6D21BIDoT4DWD8nLmlM+Q
         zkKteZOhSII8aM73Cy3sGCPFOINWUzq8Uxc7dHCy1vFinf9R2rwUVmuLQJV77snEhw
         CTYaOOSHSj0W/OK//lZvDgIqSDUPjFrQNLz0lJQU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F5316025A;
        Tue,  3 Sep 2019 13:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567517889;
        bh=/IIAX28ybymPI/d9nKwEudqgSJsDn9fKIihspf4kSbQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=H0DEDnV8ysmtJNkTpNZokvcwULQFizARdxwrZ2svNKMYXuphsnYh7to4LLG0gVkjD
         pgf5TOl4AnCmoibZ+yB1e4MEQFmmbIFzpMnn8Z1tx6vFM/cRDf9/C8/tX4ngfzt83o
         SCcPnlO5s4JJVErc69CGK24BTLHM4P91OnKE3m/I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F5316025A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] bcma: remove two unused variables
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190809085308.69748-1-yuehaibing@huawei.com>
References: <20190809085308.69748-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <zajec5@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190903133810.56175607EB@smtp.codeaurora.org>
Date:   Tue,  3 Sep 2019 13:38:10 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> wrote:

> drivers/bcma/driver_mips.c:70:18: warning:
>  ipsflag_irq_shift defined but not used [-Wunused-const-variable=]
> drivers/bcma/driver_mips.c:62:18: warning:
>  ipsflag_irq_mask defined but not used [-Wunused-const-variable=]
> 
> They are never used, so can be removed.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied to wireless-drivers-next.git, thanks.

0a60e0aa495f bcma: remove two unused variables

-- 
https://patchwork.kernel.org/patch/11085683/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

