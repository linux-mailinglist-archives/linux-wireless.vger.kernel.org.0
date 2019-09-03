Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B37CA6A6D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 15:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfICNwQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 09:52:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59294 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbfICNwQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 09:52:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A052560878; Tue,  3 Sep 2019 13:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567518735;
        bh=mU5Z0XEhHaYA24ducmb3V/8wh8mFYozJt7ceVgcFlpU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=bfFa64sVQVpNarGh/ilpMCvlJXqw17yGyCawsJL8Jby5fafQCQNSEEdWxOBFChGfJ
         2jC8A4Z6NM/TOaki3QrwxX8ihfZs6kO0rcIvmLbmFzNJZd+QifYlyEtjn73yEMA6Qn
         csRKsIjPQ4T1CMwOCl+7L6NZu6SrsmvWmeopuldA=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0BFF6076A;
        Tue,  3 Sep 2019 13:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567518733;
        bh=mU5Z0XEhHaYA24ducmb3V/8wh8mFYozJt7ceVgcFlpU=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=i0YgikAuQ+M3/AtAJD/HQolYntrysV3cUpbf9vL8r/WWFecOjDQABWUkNZoqCLSLD
         8t54OZQFcrdEN2B1Dwjxg5AqQ4KDQig4khtr5+IVaFsDuiAsCTxvIqlIDvcuXjWott
         WG9O1Lns/DmsTP2/LZb6smA6O7L5xM6v5+fHnbw4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0BFF6076A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5.3] rt2x00: clear up IV's on key removal
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1566564483-31088-1-git-send-email-sgruszka@redhat.com>
References: <1566564483-31088-1-git-send-email-sgruszka@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Daniel Golle <daniel@makrotopia.org>,
        =?utf-8?q?Tomislav_Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Mathias Kresin <dev@kresin.me>, Emil Karlson <jekarl@iki.fi>,
        Fredrik Noring <noring@nocrew.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190903135215.A052560878@smtp.codeaurora.org>
Date:   Tue,  3 Sep 2019 13:52:14 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> wrote:

> After looking at code I realized that my previous fix
> 95844124385e ("rt2x00: clear IV's on start to fix AP mode regression")
> was incomplete. We can still have wrong IV's after re-keyring.
> To fix that, clear up IV's also on key removal.
> 
> Fixes: 710e6cc1595e ("rt2800: do not nullify initialization vector data")
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
> tested-by: Emil Karlson <jekarl@iki.fi>

Patch applied to wireless-drivers.git, thanks.

14d5e14c8a6c rt2x00: clear up IV's on key removal

-- 
https://patchwork.kernel.org/patch/11111605/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

