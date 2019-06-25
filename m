Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8590352246
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 06:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfFYEqY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 00:46:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51364 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfFYEqX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 00:46:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E2451607CA; Tue, 25 Jun 2019 04:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561437982;
        bh=U5k4cI3MuVtgRW12kDLuKDXPjAbog3w1aocE7aEHUgc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VR4NzvXDIBf58JSF9t5OGjHOQNcN5fI5cXISUZZoDVL8Dy5RSrR4RaPc2x9JolGP1
         9yS6Gwa1ZIwK4MKxeoxawOouTodutHkKoSs4elwD/LDlzvkLgZ/BvQg9+/ZEIDj5DW
         xKgDWHh7dqmNYpMmQJrY9HOhC/5mC4y/F70k2cdw=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E9A6F606DC;
        Tue, 25 Jun 2019 04:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561437982;
        bh=U5k4cI3MuVtgRW12kDLuKDXPjAbog3w1aocE7aEHUgc=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=o6Y57xZhJyNXW4+M/9sstpEwLdRTfsmE4StPSnkuuySy6LfIZTdhBAKGDjx+aui+o
         H/4wBv3u5MUy6hqaYSYDm6J0NST/eNvUVFq1pdl7ODnDrHKeJKwsBL2xS9KejKb+YD
         J/gn6JJOoO3Id2X6M4ncIM/pPLZx4O19mgoGfkdk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9A6F606DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mwifiex: drop 'set_consistent_dma_mask' log message
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190604172858.107084-1-briannorris@chromium.org>
References: <20190604172858.107084-1-briannorris@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625044622.E2451607CA@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 04:46:22 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> wrote:

> This message is pointless.
> 
> While we're at it, include the error code in the error message, which is
> not pointless.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-drivers-next.git, thanks.

f7369179ad32 mwifiex: drop 'set_consistent_dma_mask' log message

-- 
https://patchwork.kernel.org/patch/10975823/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

