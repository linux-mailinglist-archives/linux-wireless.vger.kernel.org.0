Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E921083179
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2019 14:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfHFMgp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Aug 2019 08:36:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60352 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfHFMgp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Aug 2019 08:36:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3A9A3609EF; Tue,  6 Aug 2019 12:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565095004;
        bh=DjTxZTKANQMZ7zd2J27huQzkh/d41y29X49vtaXH11A=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=GqM/RM9Tp4ITnaHXyCo3umAmDYldPRTCEGM93BlBsVsAQ/uWI71+5iYro235nJH6u
         GVB5XtJpktpBC2+OSlfD0/bIVn6oJRKzY9dNryR/3iFYXJ2AFICSL4zWX5EHg4ZqYC
         8A6r6o88H8FZ2f4TLIWNnV5AG9/ybjWJXpDUu+bA=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D89B60590;
        Tue,  6 Aug 2019 12:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565095003;
        bh=DjTxZTKANQMZ7zd2J27huQzkh/d41y29X49vtaXH11A=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=PJJoZ94rqlh44rWuGKAZt9dMY/4b1fcaJbk3T09UCY+di+HVf7ve5yNNL487nZy1W
         FVu2v5ddE/Z9f3o4qWebfuoBNw3wFcD5r40uB+Ptd35Juhfm44lpHqXw6W3STgGK/C
         6MPZA93UI5yYuAr7j5mTaw9hEMF8qsQcpcGbsIHc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D89B60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rsi: fix for sdio reset card issue
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1564051910-20136-1-git-send-email-ganapathirajukondraju@gmail.com>
References: <1564051910-20136-1-git-send-email-ganapathirajukondraju@gmail.com>
To:     Ganapathi Kondraju <ganapathirajukondraju@gmail.com>
Cc:     linux-wireless@vger.kernel.org, rishikesh.basu@redpinesignals.com,
        krishna.pedda@redpinesignals.com, narasimha.a@redpinesignals.com,
        srinivas.chappidi@redpinesignals.com,
        Ganapathi Kondraju <ganapathirajukondraju@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190806123644.3A9A3609EF@smtp.codeaurora.org>
Date:   Tue,  6 Aug 2019 12:36:44 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ganapathi Kondraju <ganapathirajukondraju@gmail.com> wrote:

> Issue: While removing and inserting the driver module, observed driver
> loading is not successful.
> 
> Root cause: Card is not resetted completely without issuing cmd5.
> 
> Fix: Issued cmd5 properly.
> 
> Signed-off-by: Ganapathi Kondraju <ganapathirajukondraju@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

dfc7a8f7c857 rsi: fix for sdio reset card issue

-- 
https://patchwork.kernel.org/patch/11058603/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

