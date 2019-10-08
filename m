Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F0CCFDF0
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 17:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfJHPm5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 11:42:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33014 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfJHPm5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 11:42:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6B9CD6119D; Tue,  8 Oct 2019 15:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570549375;
        bh=PtXv/2PG6+HWdTsnqs6llorLWiI9qSK6Mjw3frrEvdU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=pGJZiCJetnit4uFq4GfRFyROzFHSWIhBwt/qxAwlivWc94A7dc6BzZrWg7g0riB5c
         3bCtxc8RyXrRZVodle2EGZk4DklhswwxE1eSjmoHhzvaE85I/Fw3MI1SBPO1ofREYC
         pUErT++2JGg4cttTjBNbhszBVzH0/o1hZ4ORR12s=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B58D061ADB;
        Tue,  8 Oct 2019 15:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570549375;
        bh=PtXv/2PG6+HWdTsnqs6llorLWiI9qSK6Mjw3frrEvdU=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=WF+BvjbczkSra7F7qLXxhbe0xA1TwPJ4MSUSWXDR5ytPA9DnHK8nO547bgjuDhjBp
         O5vbv9uTnpFMeYjYbJ7lCB1QWA/JDp4JU4Eyp4fau3b6IXyZFy9xwsj2LYNsZJ+lY/
         WJ7AXekaFOJixje2MwyjlQX5r3BsJZ9mdGC2jryc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B58D061ADB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Fix an && vs || typo
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191007085003.GB3865@mwanda>
References: <20191007085003.GB3865@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Govind Singh <govinds@codeaurora.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191008154255.6B9CD6119D@smtp.codeaurora.org>
Date:   Tue,  8 Oct 2019 15:42:55 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The kernel will Oops later in the function if either of these pointers
> is NULL so clearly || was intended instead of &&.
> 
> Fixes: 3f14b73c3843 ("ath10k: Enable MSA region dump support for WCN3990")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Sorry, Colin was faster :)

https://patchwork.kernel.org/patch/11174955/

Patch set to Rejected.

-- 
https://patchwork.kernel.org/patch/11176991/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

