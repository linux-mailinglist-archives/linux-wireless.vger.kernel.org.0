Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B860F712
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 13:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbfD3Lsv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 07:48:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53592 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729800AbfD3Lsu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 07:48:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CC9B46044E; Tue, 30 Apr 2019 11:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556624930;
        bh=YMdQrgOWXRWj+xQxFauMEUP9g2WmtgYi2qRDnZAjh58=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hMGueTkbKOglv+98TdsO/2XOj41eXezmO+qj4+rcWruUg0WB5w6JW3ezemktSOSR9
         5Li9K6mt308PN5w4VO+mP3shEi04AbUZUS39bD7PxZzd2uJMd0S96tE2CYlAuKb+Gy
         TxA7gnOCG5/f3M2q2MNd5ALNWMkXzayyw62MilE4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 708F36044E;
        Tue, 30 Apr 2019 11:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556624927;
        bh=YMdQrgOWXRWj+xQxFauMEUP9g2WmtgYi2qRDnZAjh58=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RAB9lOhMlafSGKHGzDaS9bim5lV7V7ZlRUjIBfkVe/P1j0yJK6pOUVNl1kyYoAaCs
         G1kTrc7f8df5RU1Uix92+Nx+JzNSzjwwkWgPQbGp39clktmMxJtXQw2gC24Q/6K7QF
         IfpMlS6cEfVcssNeq3yESghK/zUIft5Wh6sr31/A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 708F36044E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        <pkshih@realtek.com>, <tehuang@realtek.com>,
        <Larry.Finger@lwfinger.net>, <sgruszka@redhat.com>,
        <briannorris@chromium.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v9 05/14] rtw88: mac files
References: <1555653004-1795-1-git-send-email-yhchuang@realtek.com>
        <1555653004-1795-6-git-send-email-yhchuang@realtek.com>
Date:   Tue, 30 Apr 2019 14:48:43 +0300
In-Reply-To: <1555653004-1795-6-git-send-email-yhchuang@realtek.com>
        (yhchuang@realtek.com's message of "Fri, 19 Apr 2019 13:49:55 +0800")
Message-ID: <87v9yvpvc4.fsf@kamboji.qca.qualcomm.com>
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
> mac files for Realtek 802.11ac wireless network chips
>
> Reviewed-by: Stanislaw Gruszka <sgruszka@redhat.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

[...]

> +static int rtw_pwr_cmd_polling(struct rtw_dev *rtwdev,
> +			       struct rtw_pwr_seq_cmd *cmd)
> +{
> +	u8 value;
> +	u8 flag = 0;
> +	u32 offset;
> +	u32 cnt = RTW_PWR_POLLING_CNT;
> +
> +	if (cmd->base == RTW_PWR_ADDR_SDIO)
> +		offset = cmd->offset | SDIO_LOCAL_OFFSET;
> +	else
> +		offset = cmd->offset;
> +
> +	do {
> +		cnt--;
> +		value = rtw_read8(rtwdev, offset);
> +		value &= cmd->mask;
> +		if (value == (cmd->value & cmd->mask))
> +			return 0;
> +		if (cnt == 0) {
> +			if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_PCIE &&
> +			    flag == 0) {
> +				value = rtw_read8(rtwdev, REG_SYS_PW_CTRL);
> +				value |= BIT(3);
> +				rtw_write8(rtwdev, REG_SYS_PW_CTRL, value);
> +				value &= ~BIT(3);
> +				rtw_write8(rtwdev, REG_SYS_PW_CTRL, value);
> +				cnt = RTW_PWR_POLLING_CNT;
> +				flag = 1;
> +			} else {
> +				return -EBUSY;
> +			}
> +		} else {
> +			udelay(50);
> +		}
> +	} while (1);

Never ending loops in kernel are dangerous. I would add some kind of
fail safe to "while (1)", for example max number of loops or some time
based limit.

-- 
Kalle Valo
