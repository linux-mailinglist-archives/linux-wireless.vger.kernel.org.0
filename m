Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13C6072E40
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 13:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387398AbfGXLzU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 07:55:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54476 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbfGXLzU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 07:55:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EFD0860364; Wed, 24 Jul 2019 11:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563969319;
        bh=onm9HPj24AD1ihS73jneKePG8d2JbFVHLwQgbDJjBqQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZhcDszRrk8RDZuvutSXHnI6S6QahMcBzk+VdI5x0BRWw9CTnjM44YaKxrQnx8ygZn
         LRpQW7V0x2u/Qlkd25/7Bsuvrng21IIPxOcgweNSfbnkVe2LWEJTUCi6NhVkD/Vkeg
         ugQMcYUFKmcrXMkDFwQcsyibDzJa57HRJG8o4pqw=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D9FE60237;
        Wed, 24 Jul 2019 11:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563969318;
        bh=onm9HPj24AD1ihS73jneKePG8d2JbFVHLwQgbDJjBqQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=eia9oKJ6qQ0Wiy0YBh/kuo4ngjdp3Cq4j/mtmj/vxj5i7VEbDZBSZ6JhK9zTiuxZs
         JhavC1XozlmRoUIt6UmvDSS9188V7zGOHWi7/3nP+t6ilf3O0aU6WZ+m1dbt6lqsYY
         ELEbncB73onkZaptXsPsriITKbQXauMx7RLUYffw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D9FE60237
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtlwifi: remove assignment to itself
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190723031023.6777-1-pkshih@realtek.com>
References: <20190723031023.6777-1-pkshih@realtek.com>
To:     <pkshih@realtek.com>
Cc:     <dcb314@hotmail.com>, <Larry.Finger@lwfinger.net>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190724115518.EFD0860364@smtp.codeaurora.org>
Date:   Wed, 24 Jul 2019 11:55:18 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<pkshih@realtek.com> wrote:

> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> Module parameters of 'sw_crypto' and 'disable_watchdog' are false by
> default. If new value is desired, we can do it during inserting module,
> assignment existing in source code is not reasonable.
> 
> Reported-by: David Binderman <dcb314@hotmail.com>
> CC: Larry Finger <Larry.Finger@lwfinger.net>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

b43d6c8e8d7f rtlwifi: remove assignment to itself

-- 
https://patchwork.kernel.org/patch/11053745/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

