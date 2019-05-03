Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C2B12BF5
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 13:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfECLDd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 07:03:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49826 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfECLDc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 07:03:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D31CB60E5A; Fri,  3 May 2019 11:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556881411;
        bh=QiWQC5Cw/I7zN32clX1qVF56tHXWG/KLtrCwSfSjk2A=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aQZruRakTnaSSW4Cyi1MCIozbl39Ihrq4wUdl5dZvhb74HyNsBCSKJdhoRECxFqwh
         o26jg7IePrDDo8EafX4JurCPx6K5FKrcknj1PRyavL2evKrFaei3R2qmjxVqMnEWkY
         wMv4XUPr3HTskI0yY+QS4GR9PCCp86lccJGF87cY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AFEE860E57;
        Fri,  3 May 2019 11:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556881411;
        bh=QiWQC5Cw/I7zN32clX1qVF56tHXWG/KLtrCwSfSjk2A=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aQZruRakTnaSSW4Cyi1MCIozbl39Ihrq4wUdl5dZvhb74HyNsBCSKJdhoRECxFqwh
         o26jg7IePrDDo8EafX4JurCPx6K5FKrcknj1PRyavL2evKrFaei3R2qmjxVqMnEWkY
         wMv4XUPr3HTskI0yY+QS4GR9PCCp86lccJGF87cY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AFEE860E57
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/6] rtw88: add license for Makefile
References: <1556879502-16211-1-git-send-email-yhchuang@realtek.com>
        <1556879502-16211-2-git-send-email-yhchuang@realtek.com>
Date:   Fri, 03 May 2019 14:03:28 +0300
In-Reply-To: <1556879502-16211-2-git-send-email-yhchuang@realtek.com>
        (yhchuang@realtek.com's message of "Fri, 3 May 2019 18:31:37 +0800")
Message-ID: <87v9yrkdfj.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> Add missing license for Makefile
>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wireless/realtek/rtw88/Makefile
> index da5e36e..74cd066 100644
> --- a/drivers/net/wireless/realtek/rtw88/Makefile
> +++ b/drivers/net/wireless/realtek/rtw88/Makefile
> @@ -1,3 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0

Other files in the driver are "GPL-2.0 OR BSD-3-Clause", why not
Makefile? I prefer that the whole driver has the same license, keeps
things simple.

-- 
Kalle Valo
