Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC6C35224B
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 06:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfFYErU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 00:47:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52292 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbfFYErT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 00:47:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D4309609CD; Tue, 25 Jun 2019 04:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561438038;
        bh=Z3E9i9WQZO3l8XG3WT5iPFtUbX84LafoXhE9VjPQ2Nc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Pe8/z9SU0VajPqMT5niWDq92Df4ki7Wk+aR4NAyABoq/HPNEmfGvXavznqQSDk7c3
         alMNOloFbtFEHSuIEJyOdf2zHPtQiT8NbRMJmfolPi5h0HzhkV+5gAAFsC7YOSXjTt
         yoXU+0r+KcCsP8a5q7UEvqbz78Be1vL2vBaS7LeI=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D69E0606DC;
        Tue, 25 Jun 2019 04:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561438038;
        bh=Z3E9i9WQZO3l8XG3WT5iPFtUbX84LafoXhE9VjPQ2Nc=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=S804yuX/TuDTj4R8iINEtlNUBwuQcgzMpwnMzZu6ccABxI4bcfQ2x4k+tvkHnzqw0
         qD6WL6ROfgyj4IlB05jdhwPbbnbY67EVuzIdLipMKrF2hDMJA4KiZpbjSaie20dmtj
         rB5QMfJ909V/TB6tHgfwUbAJNzLbzWrwueu6SMco=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D69E0606DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 09/11] mwifiex: update set_mac_address logic
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1560352331-16898-1-git-send-email-gbhat@marvell.com>
References: <1560352331-16898-1-git-send-email-gbhat@marvell.com>
To:     Ganapathi Bhat <gbhat@marvell.com>
Cc:     <linux-wireless@vger.kernel.org>, Cathy Luo <cluo@marvell.com>,
        Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Sharvari Harisangam <sharvari@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625044718.D4309609CD@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 04:47:18 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ganapathi Bhat <gbhat@marvell.com> wrote:

> From: Sharvari Harisangam <sharvari@marvell.com>
> 
> In set_mac_address, driver check for interfaces with same bss_type
> For first STA entry, this would return 3 interfaces since all priv's have
> bss_type as 0 due to kzalloc. Thus mac address gets changed for STA
> unexpected. This patch adds check for first STA and avoids mac address
> change. This patch also adds mac_address change for p2p based on bss_num
> type.
> 
> Signed-off-by: Sharvari Harisangam <sharvari@marvell.com>
> Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>

Patch applied to wireless-drivers-next.git, thanks.

7afb94da3cd8 mwifiex: update set_mac_address logic

-- 
https://patchwork.kernel.org/patch/10990209/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

