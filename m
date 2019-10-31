Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F02D2EAB43
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 09:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfJaIDi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Oct 2019 04:03:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41396 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfJaIDi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Oct 2019 04:03:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 68CF0603A3; Thu, 31 Oct 2019 08:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572509017;
        bh=GXZKkSgbLserAJ5AghFiHbNpQe5oW8diunr6MlEBTIg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=cPFm6ubB0zWfq+6Jl+eK4K7ekk2bhP96upTZvQagC9qfywUj9RuzRe59gia6Q6Nas
         ekSG3h7rwXc8DMooiuYsrqJpnc4vc2KyI+7RUMDWdaOo+fU2jVAc8G4bAIteT/VTjK
         K1oxD2vfZ4Ihnw9D2l0uaIa17dtw4DeHcYP5YmQ8=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 465686079C;
        Thu, 31 Oct 2019 08:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572509016;
        bh=GXZKkSgbLserAJ5AghFiHbNpQe5oW8diunr6MlEBTIg=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=HFck4I8bk8ABRD4m7aM84txC0vRSmYgUjwMVZJQrP8JjwhnedsBWZhMrtKLGPCqRf
         cKcwTtaeFPzT/YmZP0TyQMXDbQtgpfZfivMZglPmeIHcIhnH7bpiEIIfh75GUnvvlF
         UYQHP1MKLS9oNGR5pARR82Y7tcQkB4hsjvofZfho=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 465686079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] rtw88: fix sparse warnings for DPK
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191025083200.20245-2-yhchuang@realtek.com>
References: <20191025083200.20245-2-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191031080337.68CF0603A3@smtp.codeaurora.org>
Date:   Thu, 31 Oct 2019 08:03:37 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> sparse warnings:
>     drivers/net/wireless/realtek/rtw88/rtw8822c.c:2871:6: sparse:
> sparse: symbol 'rtw8822c_dpk_cal_coef1' was not declared. Should it be
> static?
>     drivers/net/wireless/realtek/rtw88/rtw8822c.c:3112:6: sparse:
> sparse: symbol 'rtw8822c_dpk_track' was not declared. Should it be
> static?
> 
> Fixes: 5227c2ee453d ("rtw88: 8822c: add SW DPK support")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

2 patches applied to wireless-drivers-next.git, thanks.

1f592108bbd0 rtw88: fix sparse warnings for DPK
a969cf42e5fe rtw88: fix sparse warnings for power tracking

-- 
https://patchwork.kernel.org/patch/11211691/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

