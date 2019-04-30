Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5C35F439
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 12:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfD3Ka7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 06:30:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36676 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfD3Ka7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 06:30:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A38C360A0A; Tue, 30 Apr 2019 10:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556620258;
        bh=OHFK+3LvAn758odhINGQwIGuMIr08ybddY+Q0TweAho=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YPCy0nIf/uDnCBi5BUDG9z7vzQYJZtU7U0xbERePiiKqLgCR6PAWDs+gWpYbS+j0H
         Tt95fkp+QGNG0oZlzmNELe/SKVvDbGurqBLY8JrMFLh/m4f+zPDO3XF5+6egVzGxk9
         qYAuM1R3sIpCohrG3sKEvhjx1ejcByH7C7v9f0ZY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A9B166074F;
        Tue, 30 Apr 2019 10:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556620257;
        bh=OHFK+3LvAn758odhINGQwIGuMIr08ybddY+Q0TweAho=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=XRsAxHsjOWoZMMLgW7j+pc0adLLm1ezKLQgQ+RbYgSnZxyJquUeHP0y1HtQMay8Ix
         TVopsxivt4QYPdU67hkuMjvPgjEZnpAx+hBrsb0WQr964ixbsUNVjyVXebPM4+SCtQ
         z+q42PIejfXgG2556rVtX3cfJgWMquQ7NShKGGVM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A9B166074F
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
Date:   Tue, 30 Apr 2019 13:30:53 +0300
In-Reply-To: <1555653004-1795-2-git-send-email-yhchuang@realtek.com>
        (yhchuang@realtek.com's message of "Fri, 19 Apr 2019 13:49:51 +0800")
Message-ID: <878svrrdia.fsf@kamboji.qca.qualcomm.com>
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

> +static inline bool rtw_flag_check(struct rtw_dev *rtwdev, enum rtw_flags flag)
> +{
> +	return test_bit(flag, rtwdev->flags);
> +}
> +
> +static inline void rtw_flag_clear(struct rtw_dev *rtwdev, enum rtw_flags flag)
> +{
> +	clear_bit(flag, rtwdev->flags);
> +}
> +
> +static inline void rtw_flag_set(struct rtw_dev *rtwdev, enum rtw_flags flag)
> +{
> +	set_bit(flag, rtwdev->flags);
> +}

In upstream we don't usually like these kind of abstractions, they just
hide what the code does.

-- 
Kalle Valo
