Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9316BD829
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2019 08:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404692AbfIYGMy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Sep 2019 02:12:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41336 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404606AbfIYGMy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Sep 2019 02:12:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8F93560E73; Wed, 25 Sep 2019 06:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569391973;
        bh=uYHSBx1k83QXHX/8PikNbwZgJt2w0Odf8Mt2PJ5HL1E=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=cQap2bZgdAyV+QgvMJ5PUajCsl91dTQGd0AOTaKrDViQ/XHm2TWOm4dk9os57DhQm
         BbC9JGf8s5XuZpJSBHxGx9qbqIPK5x7z5WamEb/7C9TljQEpWXzs9JK/qB6/a2e32s
         nrk8CODqTDvBGmQjq3o490cCs2knEZLuJeoPDL1s=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B878660A00;
        Wed, 25 Sep 2019 06:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569391973;
        bh=uYHSBx1k83QXHX/8PikNbwZgJt2w0Odf8Mt2PJ5HL1E=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=mCSGNO2Pw9B71D3N1AjT1g1/jdViaAkkeV0xW1dVYcvEalTF7w310PVMHk83HQFnM
         1HdVhCq2PMugxYJx/m5mNuc9moiKgjrKj112TOa/ZeTFK06PyUkci5zJ4cKzbjPuNB
         quQeGhLh9OfCg5Hx7VHsRtrWBNlgk/wj0F+1oi9o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B878660A00
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wil6210: use after free in wil_netif_rx_any()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190921060145.GD18726@mwanda>
References: <20190921060145.GD18726@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Maya Erez <merez@codeaurora.org>,
        Dedy Lansky <dlansky@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190925061253.8F93560E73@smtp.codeaurora.org>
Date:   Wed, 25 Sep 2019 06:12:53 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The debug code dereferences "skb" to print "skb->len" so we have to
> print the message before we free "skb".
> 
> Fixes: f99fe49ff372 ("wil6210: add wil_netif_rx() helper function")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch applied to wireless-drivers.git, thanks.

2b481835cf4e wil6210: use after free in wil_netif_rx_any()

-- 
https://patchwork.kernel.org/patch/11155359/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

