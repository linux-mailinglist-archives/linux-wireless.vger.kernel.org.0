Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDFBE2A12
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2019 07:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437595AbfJXFp6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Oct 2019 01:45:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52286 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437581AbfJXFp6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Oct 2019 01:45:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 987AC60DAF; Thu, 24 Oct 2019 05:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571895957;
        bh=b+wN2ExQTIwm5D2dOgL0ZAXg/8iD7MdmUOlH0dgL9ec=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Ih+n//Xej5zyTvTh7iJwj2hivnx0l6PnkDz2jr9vS+FErPFRMovfRuqESmibJyNt0
         ve2AXclFPnUL4pgsRX4puDe/+4BET5y1HmyN4+iQ2lfhDK4YzvB73lV/lh2A6CB/mQ
         kysB+NG5r9rtr06m3ffXtJVX3wi+AUcVSTxr5RnE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (unknown [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D66A60DA9;
        Thu, 24 Oct 2019 05:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571895957;
        bh=b+wN2ExQTIwm5D2dOgL0ZAXg/8iD7MdmUOlH0dgL9ec=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=dFXezjRoHdxCQfNBWVV09fdT//DHAGDKcfP1SXUnVqWS0G0GQJos37XTYLBrr+dzd
         fzWCqNAaKqfu9Z8JH459P5FGbYXjkXwrgXjU20DSZk/IDTFq2sIR55A4r1y1tfXlCh
         9Pa0hlFO89i0bmeN/1P7LYNlAvOPcupPI4JSB31Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D66A60DA9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] bcma: fix block comment style
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191021180513.2106-1-tuxomega1@gmail.com>
References: <20191021180513.2106-1-tuxomega1@gmail.com>
To:     Yadav Lamichhane <tuxomega1@gmail.com>
Cc:     tuxomega1@gmail.com, zajec5@gmail.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191024054557.987AC60DAF@smtp.codeaurora.org>
Date:   Thu, 24 Oct 2019 05:45:57 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yadav Lamichhane <tuxomega1@gmail.com> wrote:

> Fix a coding style issue.
> 
> Signed-off-by: Yadav Lamichhane <tuxomega1@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

844e9d7c60a4 bcma: fix block comment style

-- 
https://patchwork.kernel.org/patch/11202833/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

