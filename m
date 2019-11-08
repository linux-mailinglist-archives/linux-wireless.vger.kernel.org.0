Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C70F425C
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 09:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfKHIow (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 03:44:52 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38492 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfKHIow (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 03:44:52 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C010F60909; Fri,  8 Nov 2019 08:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573202691;
        bh=q2mJk7VwXyoKNejkLtZeKiAGzvIXEYJAYn1LqGhZmVI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=nkRuvK4rRMhiqCQtOztttWGGy0+cPy87DtryHJ/GfHcU6FQZodcLjMjBo2sDiaXpi
         UOa36dypk3aAdPq+0v+oPnqAs8ElJqHz4BMQP97HkazsY5H4sf8lsRu92SYJZFequy
         TcprPnN0ufhcC5kBvuPnknSutMi1gPHYi4ATw1yI=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 81AF9606FB;
        Fri,  8 Nov 2019 08:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573202691;
        bh=q2mJk7VwXyoKNejkLtZeKiAGzvIXEYJAYn1LqGhZmVI=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=CfmtE3lkHZqLI+Jyxe5InNcD0EJsGBu+cxhqSuvRXX+50iJ5SjCZ0i4thJ4zVEm4W
         xbRkp7vqrSgLVc2i6NtIaG/tMdr2c7YoQESGBObH6AQ00pZV0BCfsFIoGHvwPA8iR8
         2LPmJ6LcymzLjRhTGZzWQgepJo52VXdE8S/e4DMw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 81AF9606FB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: fix potential issue of peer stats allocation
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1572486133-23516-1-git-send-email-zhichen@codeaurora.org>
References: <1572486133-23516-1-git-send-email-zhichen@codeaurora.org>
To:     Zhi Chen <zhichen@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Zhi Chen <zhichen@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191108084451.C010F60909@smtp.codeaurora.org>
Date:   Fri,  8 Nov 2019 08:44:51 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zhi Chen <zhichen@codeaurora.org> wrote:

> STA number was not restored if OOM happened.
> 
> Tested: QCA9984 with firmware ver 10.4-3.9.0.1-00018
> Signed-off-by: Zhi Chen <zhichen@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

402838a05def ath10k: fix potential issue of peer stats allocation

-- 
https://patchwork.kernel.org/patch/11220555/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

