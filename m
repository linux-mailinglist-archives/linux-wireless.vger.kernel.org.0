Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7913A83161
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2019 14:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfHFMdi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Aug 2019 08:33:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57284 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfHFMdi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Aug 2019 08:33:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D6CDE60D35; Tue,  6 Aug 2019 12:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565094817;
        bh=fKIaZhTX3joWN/20xXLvuH91VOTbWFA4x6ESaQPvtRA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=cDvCRRSJXsQErmB+bo/5zkrkRgwfNFyj6EZ5OfNkJ6RLCThzHa1ajQBdCh2TEA1Qw
         rR/b+qS2Chkaie2QJC24MzKE64y1ntMixgqA37KgYdvtqUhPr2hSi4XqYWyb/zL3Yf
         l9Ekjop02PDOgYQ6EbdpTbbOOZdBJeF0Gr8oekdI=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E6AB260ADE;
        Tue,  6 Aug 2019 12:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565094817;
        bh=fKIaZhTX3joWN/20xXLvuH91VOTbWFA4x6ESaQPvtRA=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=IXFSK5Su5Qt/AtSQWId3QOaKQgDYrS3ISKzOXQxG8Ku/3cUoRK1cWYood4r6oN7Et
         mwyzT9TailZNq4N3J/ECgcxBAdaA0SkbbCDDoVKwzVB/VM7/2nJR7ZDoWB9pSN5IlX
         nFJwYBDvODZ6BLg1ndqvD99JpTZEveZfzzmQqjiw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6AB260ADE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rsi: fix for sdio interface setup in 9116
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1563964641-9413-1-git-send-email-ganapathirajukondraju@gmail.com>
References: <1563964641-9413-1-git-send-email-ganapathirajukondraju@gmail.com>
To:     ganapathirajukondraju@gmail.com
Cc:     linux-wireless@vger.kernel.org,
        Rishikesh Basu <rishikesh.basu@redpinesignals.com>,
        ganapathi.kondraju@redpinesignals.com,
        krishna.pedda@redpinesignals.com, narasimha.a@redpinesignals.com,
        Ganapathi Kondraju <ganapathirajukondraju@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190806123337.D6CDE60D35@smtp.codeaurora.org>
Date:   Tue,  6 Aug 2019 12:33:37 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ganapathirajukondraju@gmail.com wrote:

> From: Ganapathi Kondraju <ganapathirajukondraju@gmail.com>
> 
> Issue: RS-9116 Card is not responding after firmware got loaded.
> 
> Root cause: After firmware got loaded, we need to reset the program
> counter and few device specific registers. Those registers were not
> resetted properly.
> 
> Fix: Properly resetting those registers.
> 
> Signed-off-by: Ganapathi Kondraju <ganapathirajukondraju@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

8f9af6309b84 rsi: fix for sdio interface setup in 9116

-- 
https://patchwork.kernel.org/patch/11056571/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

