Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CBC1D7842
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2020 14:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgERMQO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 May 2020 08:16:14 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:29198 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727835AbgERMQO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 May 2020 08:16:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589804173; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=WU2XiHMVKEdgrhiuizPTWDTr4q6FrBe+3g+FWSoAluM=;
 b=uecfYKTERisvE3Dw/nY26PKIQBvXIh8MiKuc9xtzr8LMNFG442Stcju69RyrEdw9mlNyLIYL
 icfj7EMDTNrR70RlcxcnSPvC9pj/tAdGk+rTBm+b7Mky1E2vPJ3cFC0yBf1iZfZtuKp+PY33
 Sq56roakWC+SHOuxHKNJF9j4PDc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec27c70.7f33dcb6fdf8-smtp-out-n02;
 Mon, 18 May 2020 12:15:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E2B76C43637; Mon, 18 May 2020 12:15:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 777DCC432C2;
        Mon, 18 May 2020 12:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 777DCC432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtlwifi: Fix a double free in _rtl_usb_tx_urb_setup()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200513093951.GD347693@mwanda>
References: <20200513093951.GD347693@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200518121543.E2B76C43637@smtp.codeaurora.org>
Date:   Mon, 18 May 2020 12:15:43 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> Seven years ago we tried to fix a leak but actually introduced a double
> free instead.  It was an understandable mistake because the code was a
> bit confusing and the free was done in the wrong place.  The "skb"
> pointer is freed in both _rtl_usb_tx_urb_setup() and _rtl_usb_transmit().
> The free belongs _rtl_usb_transmit() instead of _rtl_usb_tx_urb_setup()
> and I've cleaned the code up a bit to hopefully make it more clear.
> 
> Fixes: 36ef0b473fbf ("rtlwifi: usb: add missing freeing of skbuff")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch applied to wireless-drivers-next.git, thanks.

beb12813bc75 rtlwifi: Fix a double free in _rtl_usb_tx_urb_setup()

-- 
https://patchwork.kernel.org/patch/11545535/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
