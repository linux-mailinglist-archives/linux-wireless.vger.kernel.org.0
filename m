Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 496B2F927
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 14:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfD3Mps (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 08:45:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50194 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfD3Mpr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 08:45:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BD01B608CE; Tue, 30 Apr 2019 12:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556628346;
        bh=OGiex3GDZHEnZFPIwAzt/9Cq76d0yKJu/+fGYYhEUYU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bP8fvG5Lfp/QRHusJhhLo/FvfZfbXlafTkJvmdo+mvyz2Gh2wds0+HaHySJBgJ/oA
         xix20lhB0EUVNFWoN88fEEW47yWpNTkA5wdfUS/JBE8hs5BxgsPEEGq5VDR8khE0UP
         QUu/4JdokrrLwPYvuDJw5nAEi6R1fvCP/WR5559k=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D569360769;
        Tue, 30 Apr 2019 12:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556628346;
        bh=OGiex3GDZHEnZFPIwAzt/9Cq76d0yKJu/+fGYYhEUYU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bP8fvG5Lfp/QRHusJhhLo/FvfZfbXlafTkJvmdo+mvyz2Gh2wds0+HaHySJBgJ/oA
         xix20lhB0EUVNFWoN88fEEW47yWpNTkA5wdfUS/JBE8hs5BxgsPEEGq5VDR8khE0UP
         QUu/4JdokrrLwPYvuDJw5nAEi6R1fvCP/WR5559k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D569360769
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        <pkshih@realtek.com>, <tehuang@realtek.com>,
        <Larry.Finger@lwfinger.net>, <sgruszka@redhat.com>,
        <briannorris@chromium.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v9 04/14] rtw88: trx files
References: <1555653004-1795-1-git-send-email-yhchuang@realtek.com>
        <1555653004-1795-5-git-send-email-yhchuang@realtek.com>
Date:   Tue, 30 Apr 2019 15:45:40 +0300
In-Reply-To: <1555653004-1795-5-git-send-email-yhchuang@realtek.com>
        (yhchuang@realtek.com's message of "Fri, 19 Apr 2019 13:49:54 +0800")
Message-ID: <87bm0npsp7.fsf@kamboji.qca.qualcomm.com>
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
> trx files for Realtek 802.11ac wireless network chips
>
> Reviewed-by: Stanislaw Gruszka <sgruszka@redhat.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

[...]

> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtw88/rx.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> +/* Copyright(c) 2018-2019  Realtek Corporation
> + */
> +
> +#ifndef __RTW_RX_H_
> +#define __RTW_RX_H_
> +
> +#define GET_RX_DESC_PHYST(rxdesc)                                              \
> +	le32_get_bits(*((__le32 *)(rxdesc) + 0x00), BIT(26))
> +#define GET_RX_DESC_ICV_ERR(rxdesc)                                            \
> +	le32_get_bits(*((__le32 *)(rxdesc) + 0x00), BIT(15))
> +#define GET_RX_DESC_CRC32(rxdesc)                                              \
> +	le32_get_bits(*((__le32 *)(rxdesc) + 0x00), BIT(14))
> +#define GET_RX_DESC_SWDEC(rxdesc)                                              \
> +	le32_get_bits(*((__le32 *)(rxdesc) + 0x00), BIT(27))
> +#define GET_RX_DESC_C2H(rxdesc)                                                \
> +	le32_get_bits(*((__le32 *)(rxdesc) + 0x02), BIT(28))
> +#define GET_RX_DESC_PKT_LEN(rxdesc)                                            \
> +	le32_get_bits(*((__le32 *)(rxdesc) + 0x00), GENMASK(13, 0))
> +#define GET_RX_DESC_DRV_INFO_SIZE(rxdesc)                                      \
> +	le32_get_bits(*((__le32 *)(rxdesc) + 0x00), GENMASK(19, 16))
> +#define GET_RX_DESC_SHIFT(rxdesc)                                              \
> +	le32_get_bits(*((__le32 *)(rxdesc) + 0x00), GENMASK(25, 24))
> +#define GET_RX_DESC_RX_RATE(rxdesc)                                            \
> +	le32_get_bits(*((__le32 *)(rxdesc) + 0x03), GENMASK(6, 0))
> +#define GET_RX_DESC_MACID(rxdesc)                                              \
> +	le32_get_bits(*((__le32 *)(rxdesc) + 0x01), GENMASK(6, 0))
> +#define GET_RX_DESC_PPDU_CNT(rxdesc)                                           \
> +	le32_get_bits(*((__le32 *)(rxdesc) + 0x02), GENMASK(30, 29))
> +#define GET_RX_DESC_TSFL(rxdesc)                                               \
> +	le32_get_bits(*((__le32 *)(rxdesc) + 0x05), GENMASK(31, 0))

I'm not really fond of these "byte macros" or whatever they should be
called, you use these a lot in rtw88 but I have seen the same usage also
other drivers. The upstream way of doing this is to create a struct,
which also acts as a documentation, and you can pass it around different
functions. And the GENMASK()s are defined close the struct.

Also you could change these defines to static inline functions, which
take the struct as a pointer, and that you get type checking from the
compiler. And that way you would get rid of that ugly casting as well.

-- 
Kalle Valo
