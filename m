Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36D24F83B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 14:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfD3MGo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 08:06:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48334 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbfD3MGo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 08:06:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 909D360A33; Tue, 30 Apr 2019 12:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556626003;
        bh=Zeq0deBxI+dBbROq1TfXW3jvO23eYoq/t/9A7pLdiaA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=MIaPL03bMtTC5+blAPrWOlMpmoH+TrkPEhoBKm4kszjaVQXomd8Dz5rM+hYluPgOx
         QgekOXg63OYCzmJYiHYgA6+tHoq3aDb4oEJYWBjFYVXycHp18qzxQu3b+dj9bBH0E/
         N8pc0YNgy2ErJ2CDBxHdLon9UVa+MgQ8lVlfjY/Q=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E9C9960275;
        Tue, 30 Apr 2019 12:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556626003;
        bh=Zeq0deBxI+dBbROq1TfXW3jvO23eYoq/t/9A7pLdiaA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=MIaPL03bMtTC5+blAPrWOlMpmoH+TrkPEhoBKm4kszjaVQXomd8Dz5rM+hYluPgOx
         QgekOXg63OYCzmJYiHYgA6+tHoq3aDb4oEJYWBjFYVXycHp18qzxQu3b+dj9bBH0E/
         N8pc0YNgy2ErJ2CDBxHdLon9UVa+MgQ8lVlfjY/Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9C9960275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        <pkshih@realtek.com>, <tehuang@realtek.com>,
        <Larry.Finger@lwfinger.net>, <sgruszka@redhat.com>,
        <briannorris@chromium.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v9 09/14] rtw88: chip files
References: <1555653004-1795-1-git-send-email-yhchuang@realtek.com>
        <1555653004-1795-10-git-send-email-yhchuang@realtek.com>
Date:   Tue, 30 Apr 2019 15:06:38 +0300
In-Reply-To: <1555653004-1795-10-git-send-email-yhchuang@realtek.com>
        (yhchuang@realtek.com's message of "Fri, 19 Apr 2019 13:49:59 +0800")
Message-ID: <87k1fbpui9.fsf@kamboji.qca.qualcomm.com>
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
> chip files Realtek 802.11ac wireless network chips
> 8822B & 8822C series files
>
> Reviewed-by: Stanislaw Gruszka <sgruszka@redhat.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

[...]

> +static void rtw8822be_efuse_parsing(struct rtw_efuse *efuse,
> +				    struct rtw8822b_efuse *map)
> +{
> +	ether_addr_copy(efuse->addr, map->e.mac_addr);
> +}

Looks like a quite useless function and just confuses the code.

-- 
Kalle Valo
