Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8DAF441
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 12:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfD3Kcl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 06:32:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38586 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfD3Kck (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 06:32:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C31E460A42; Tue, 30 Apr 2019 10:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556620360;
        bh=mWz99WL+ZPvyIA8VjV9W1rcfRjjhPovy3vH8Vhk3CD8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Ufr/ueqeeUsfLlVsJT1v+lttuNeDVZzHu4AQIXG+38MpX6FLtg5Q7xpEE+gw/yB3o
         fiF9pCAnHFEsiqG/mnMfAMShYbALocMpCDtUP6IyMWorQHUWGsI6+lOCV63c7WULlP
         0yUFtR08tLY3MJD/svvI+5Kx6V5RGxNAjmaFTq/0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0C3E6074F;
        Tue, 30 Apr 2019 10:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556620359;
        bh=mWz99WL+ZPvyIA8VjV9W1rcfRjjhPovy3vH8Vhk3CD8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kt3msL3pWYApZ8HUPJe+LHeDmQDKAfrzB/I9beK614LCwmwZ/U/ZsmhenMO5TG8wV
         6NTbeMiPjHUt/Cr0wDAElWFPgL3aAYhpYkX2SeEA/CiztbkY0lqsi7cD2s73VPWkTE
         3KTfHJ5FISpTNuW8YZAL5pEDGxT1oqnruMhMSepM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0C3E6074F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        <pkshih@realtek.com>, <tehuang@realtek.com>,
        <Larry.Finger@lwfinger.net>, <sgruszka@redhat.com>,
        <briannorris@chromium.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v9 01/14] rtw88: main files
References: <1555653004-1795-1-git-send-email-yhchuang@realtek.com>
        <1555653004-1795-2-git-send-email-yhchuang@realtek.com>
Date:   Tue, 30 Apr 2019 13:32:34 +0300
In-Reply-To: <1555653004-1795-2-git-send-email-yhchuang@realtek.com>
        (yhchuang@realtek.com's message of "Fri, 19 Apr 2019 13:49:51 +0800")
Message-ID: <874l6frdfh.fsf@kamboji.qca.qualcomm.com>
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
> main files for Realtek 802.11ac wireless network chips
>
> Reviewed-by: Stanislaw Gruszka <sgruszka@redhat.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

[...]

> +static bool rtw_fw_support_lps;
> +unsigned int rtw_debug_mask;
> +EXPORT_SYMBOL(rtw_debug_mask);
> +
> +module_param_named(support_lps, rtw_fw_support_lps, bool, 0644);
> +module_param_named(debug_mask, rtw_debug_mask, uint, 0644);
> +
> +MODULE_PARM_DESC(support_lps, "Set Y to enable LPS support");

Not everyone (myself included) do not know what LPS means, please spell
it out in the description.

-- 
Kalle Valo
