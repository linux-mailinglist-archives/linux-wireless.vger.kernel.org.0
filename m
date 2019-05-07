Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95589164D2
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2019 15:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfEGNla (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 May 2019 09:41:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48960 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfEGNla (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 May 2019 09:41:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5B15160A42; Tue,  7 May 2019 13:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557236489;
        bh=FmtOBj15yEEN4Mu9EvYeEpeDuQcBV/VEGj0TeLFgiYQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=iayM0GzNYDUQM+VD+6lPEFq1Ddp+qsE4XEPUrAumzOJ1kucd0o5zoaQNENK+d0+CG
         T6MdSPBpsSo5JFpuwyHEFmt9jidCk/CUAfpFj6RX7hEQsA3Xu2W7rYQo1aZC+8lgCm
         bOB0VUV6oO9OopnaNy3uCkh5sor49lRuj6asq7+E=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC8CE608FC;
        Tue,  7 May 2019 13:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557236488;
        bh=FmtOBj15yEEN4Mu9EvYeEpeDuQcBV/VEGj0TeLFgiYQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=VK1yeoMQtk5BNncZ8wIMIxQ7A/dR9H7YZRtrjgW039dMmiqphFEpYCvOZZnBWgmjf
         7eisJSFK4DMy7CZlOvrGX6FHFVMmeHD2rcq/fG6rBAq35Jz8sBZjszBZhjZtkZ1V9l
         bkjJDF2cqnKes8lTIu/mO9B+j5CExcxCvANyyy7A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC8CE608FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Modify CE4 src buffer entries to 2048 for WCN3990
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190302043605.27626-1-govinds@codeaurora.org>
References: <20190302043605.27626-1-govinds@codeaurora.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190507134129.5B15160A42@smtp.codeaurora.org>
Date:   Tue,  7 May 2019 13:41:29 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Govind Singh <govinds@codeaurora.org> wrote:

> CE4 is host to target HTT tx pipe, tx completion are not served
> on time when CPU is loaded and this cause ce src ring full condition
> due to less no of src buffer entries.
> 
> To mitigate the issue increase CE4 src buffer entries to 2048.
> 
> Testing:
>         Tested on QCS404 platform(WCN3990 HW)
>         Tested FW: WLAN.HL.3.1-00784-QCAHLSWMTPLZ-1
> 
> Signed-off-by: Govind Singh <govinds@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

889ab61d9dc1 ath10k: Modify CE4 src buffer entries to 2048 for WCN3990

-- 
https://patchwork.kernel.org/patch/10836431/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

