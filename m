Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1825B5013
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 16:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfIQOMc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 10:12:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50930 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfIQOMc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 10:12:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D98F86133A; Tue, 17 Sep 2019 14:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568729551;
        bh=kD4bbMc4g8WH+jV85zr2te+dC+OYHVAzpLQmpSpMSlk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VCcRgQmV7D1Mzqj1GAuVDTh/06VHZE9bZHX1WObXFvyOQC1ZMjj7fDlkfwopPL4KV
         094YpLF/Soimoi7qljuLlWpwIZm6oxLhqxPDH4I49S1QmoBu+g+FpZrZdbKZF5/XAm
         S6hPEK/3fDe43yBVZRxWrseO8nhJuGbVuLcZdNNE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8304960790;
        Tue, 17 Sep 2019 14:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568729551;
        bh=kD4bbMc4g8WH+jV85zr2te+dC+OYHVAzpLQmpSpMSlk=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=QbGkNIE9zQFJGmZWVIs8tzo/JpGubl6MxXGNcHJZK7LzZzV7nLq6AbX1ts9QoKigN
         YvcktSlbrIzX7xMlFhjHZuZ5HUQ+JUdBfY+2QEpRWYu3y41UwDAl0TMp4dmJFBaEq5
         mEuBrML0Tlx6BOH/P25Psj7HG2LxNp8ZD6rljMaU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8304960790
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: fix latency issue for QCA988x
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1567046712-23057-1-git-send-email-miaoqing@codeaurora.org>
References: <1567046712-23057-1-git-send-email-miaoqing@codeaurora.org>
To:     Miaoqing Pan <miaoqing@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Miaoqing Pan <miaoqing@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190917141231.D98F86133A@smtp.codeaurora.org>
Date:   Tue, 17 Sep 2019 14:12:31 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Miaoqing Pan <miaoqing@codeaurora.org> wrote:

> Bad latency is found on QCA988x, the issue was introduced by
> commit 4504f0e5b571 ("ath10k: sdio: workaround firmware UART
> pin configuration bug"). If uart_pin_workaround is false, this
> change will set uart pin even if uart_print is false.
> 
> Tested HW: QCA9880
> Tested FW: 10.2.4-1.0-00037
> 
> Fixes: 4504f0e5b571 ("ath10k: sdio: workaround firmware UART pin configuration bug")
> Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

1340cc631bd0 ath10k: fix latency issue for QCA988x

-- 
https://patchwork.kernel.org/patch/11122193/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

