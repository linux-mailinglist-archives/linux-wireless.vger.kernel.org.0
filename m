Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205932F12B2
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jan 2021 13:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbhAKM7d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jan 2021 07:59:33 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:46409 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbhAKM7d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jan 2021 07:59:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610369948; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=51so1pNcEfZqyTn9Oqk5ULNkVPY0wtdUCjQk7jSWces=; b=dUH9uOlUGxNY5KOd42CY3jml855tiIAFjYLZPKhi1pUO/DEiwmKg5HqwX5cpZsK/ihVvOp1R
 AYYdr3FLvnkXbq7UMnBqm0ePsJs/KYAwhclanwP4XFGXM4keIbctu4xRjLzvHypEolanJQ2j
 MJht8vY17aKG7OkrlMGPGWtrWZQ=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ffc4b7b415a6293c5a7a492 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 12:58:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8BD3DC43461; Mon, 11 Jan 2021 12:58:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 23B22C433CA;
        Mon, 11 Jan 2021 12:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23B22C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH V2 00/18] rtw89: add Realtek 802.11ax driver
References: <20210104091817.15966-1-pkshih@realtek.com>
Date:   Mon, 11 Jan 2021 14:58:32 +0200
In-Reply-To: <20210104091817.15966-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Mon, 4 Jan 2021 17:17:59 +0800")
Message-ID: <87bldvtytj.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> This driver named rtw89, which is the next generation of rtw88, supports
> Realtek 8852AE 802.11ax 2x2 chip whose new features are OFDMA, DBCC,
> Spatial reuse, TWT and BSS coloring; now some of them aren't implemented
> though.
>
> The chip architecture is entirely different from the chips supported by
> rtw88 like RTL8822CE 802.11ac chip. First of all, register address ranges
> are totally redefined, so it's impossible to reuse register definition. To
> communicate with firmware, new H2C/C2H format is proposed. In order to have
> better utilization, TX DMA flow is changed to two stages DMA. To provide
> rich RX status information, additional RX PPDU packets are added.

Thanks for the good introduction. Do note that currently there are two
new drivers before rtw89, so reviewing this will most likely take some
time.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
