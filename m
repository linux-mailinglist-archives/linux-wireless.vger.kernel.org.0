Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEDB12509F
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 19:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfLRS2K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 13:28:10 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:59298 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726939AbfLRS2K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 13:28:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576693689; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=sBgdu0oX/ieard+ijl4C1NKIkagCdydQz0NW7DN9JjU=;
 b=AgBK//CR2GHATfAVlzsqfH+mvUwQG55W531kijRbP0RQi7oc+p3vpsnPy4xrrh96m3g4tWYO
 JDvkqWSPupC0YBClidhc47a+iE2Vt5/6OZvrfSGaCg88W5fiNPcQsDJqgc38GwrOmVEXZdsp
 KcZQ0LNUFm/cRzMhIMwHZESJ2SA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa6fb3.7f70b308e458-smtp-out-n03;
 Wed, 18 Dec 2019 18:28:03 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5DD4EC4479C; Wed, 18 Dec 2019 18:28:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 332ACC433CB;
        Wed, 18 Dec 2019 18:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 332ACC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmsmac: Remove always false 'channel < 0' statement
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191127054358.GA59549@LGEARND20B15>
References: <20191127054358.GA59549@LGEARND20B15>
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     arend.vanspriel@broadcom.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@cypress.com,
        wright.feng@cypress.com, davem@davemloft.net,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, austindh.kim@gmail.com
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218182802.5DD4EC4479C@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 18:28:02 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Austin Kim <austindh.kim@gmail.com> wrote:

> As 'channel' is declared as u16, the following expression is always false.
>    channel < 0
> 
> So we can remove unnecessary 'always false' statement.
> 
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

37bc6c72f5b7 brcmsmac: Remove always false 'channel < 0' statement

-- 
https://patchwork.kernel.org/patch/11263483/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
