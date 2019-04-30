Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA783F6EF
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 13:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbfD3Lx4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 07:53:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33524 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730755AbfD3Lxw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 07:53:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DE8B760275; Tue, 30 Apr 2019 11:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556625231;
        bh=CfteeqjY3WO9GZonMvHIfyw0q1QkbOlK7+nLFbFOS+Q=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fB+H2tpujES8IZYZKspm0+Q47org92Z8CYjfYEB/fPx1s9uq352IbQQxHqTzq9sGC
         JC/69enZyGog7E0QVkNh12OmDlQNXolXnin3hdwNTR9RV4TVhd6bsm20DgXrarert/
         f4nP6FpTWHI/kWs4Fjzof+gWXVtBB2mfhS+JFEjM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01C8C60275;
        Tue, 30 Apr 2019 11:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556625231;
        bh=CfteeqjY3WO9GZonMvHIfyw0q1QkbOlK7+nLFbFOS+Q=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fB+H2tpujES8IZYZKspm0+Q47org92Z8CYjfYEB/fPx1s9uq352IbQQxHqTzq9sGC
         JC/69enZyGog7E0QVkNh12OmDlQNXolXnin3hdwNTR9RV4TVhd6bsm20DgXrarert/
         f4nP6FpTWHI/kWs4Fjzof+gWXVtBB2mfhS+JFEjM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01C8C60275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        <pkshih@realtek.com>, <tehuang@realtek.com>,
        <Larry.Finger@lwfinger.net>, <sgruszka@redhat.com>,
        <briannorris@chromium.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v9 12/14] rtw88: Kconfig & Makefile
References: <1555653004-1795-1-git-send-email-yhchuang@realtek.com>
        <1555653004-1795-13-git-send-email-yhchuang@realtek.com>
Date:   Tue, 30 Apr 2019 14:53:46 +0300
In-Reply-To: <1555653004-1795-13-git-send-email-yhchuang@realtek.com>
        (yhchuang@realtek.com's message of "Fri, 19 Apr 2019 13:50:02 +0800")
Message-ID: <87r29jpv3p.fsf@kamboji.qca.qualcomm.com>
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
> Kconfig & Makefile for Realtek 802.11ac wireless network chips
>
> Reviewed-by: Stanislaw Gruszka <sgruszka@redhat.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

[...]

> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtw88/Makefile
> @@ -0,0 +1,20 @@
> +obj-$(CONFIG_RTW88_CORE)	+= rtw88.o
> +rtw88-y += main.o \
> +	   mac80211.o \
> +	   util.o \
> +	   debug.o \
> +	   tx.o \
> +	   rx.o \
> +	   mac.o \
> +	   phy.o \
> +	   efuse.o \
> +	   fw.o \
> +	   ps.o \
> +	   sec.o \
> +	   regd.o
> +
> +rtw88-$(CONFIG_RTW88_8822BE)	+= rtw8822b.o rtw8822b_table.o
> +rtw88-$(CONFIG_RTW88_8822CE)	+= rtw8822c.o rtw8822c_table.o
> +
> +obj-$(CONFIG_RTW88_PCI)		+= rtwpci.o
> +rtwpci-objs			:= pci.o

Please add an SPDX tag also for the makefile.
-- 
Kalle Valo
