Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15A8EF42E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 12:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfD3K0h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 06:26:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34824 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfD3K0h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 06:26:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D73B960364; Tue, 30 Apr 2019 10:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556619996;
        bh=sgiLu3f+W3ECwwR60iT9KF37xl0ExLR1aYqfc4yZinc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nfMQQPPwpZQIzvHhB4wppPFJwzR/to07q6KpW8j+h68gpjSA7vFA1YZ/+e+kZ6mFD
         cFuIOFl+KpRCgxePLTTlr15PGjdYA3Qzh3Uwt7icg8YHtw4SKyMcKfjjOLpo+9R/dI
         wx5esYMjTA5ztka9vbBOCOw3/oMP6zy1l1DdTamU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D0E560364;
        Tue, 30 Apr 2019 10:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556619991;
        bh=sgiLu3f+W3ECwwR60iT9KF37xl0ExLR1aYqfc4yZinc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=SQMrHhkrIsPRP0d9gqNzAlUr889kuoPQSSJQo325L7vE4fQOWb7hJiYud8hGeutCn
         LoB2MPi9Au9po8YJXO+xIpPDKV5wQJnRDRDYSg5PEpXSDiOjpH5xXqSFNC6HMS51hr
         Dr5sFC6nE9Mqx9ToiKej9uksl5RT3Sjfl2guw/Kg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D0E560364
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
Date:   Tue, 30 Apr 2019 13:26:26 +0300
In-Reply-To: <1555653004-1795-10-git-send-email-yhchuang@realtek.com>
        (yhchuang@realtek.com's message of "Fri, 19 Apr 2019 13:49:59 +0800")
Message-ID: <87d0l3rdpp.fsf@kamboji.qca.qualcomm.com>
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

> +static struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8822b[] = {
> +	{0x0086,
> +	 RTW_PWR_CUT_ALL_MSK,
> +	 RTW_PWR_INTF_SDIO_MSK,
> +	 RTW_PWR_ADDR_SDIO,
> +	 RTW_PWR_CMD_WRITE, BIT(0), 0},

I see lots of arrays like this which are not const. I think they should
be const.

-- 
Kalle Valo
