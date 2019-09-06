Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B71A1ABA74
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2019 16:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394073AbfIFOOD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Sep 2019 10:14:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48120 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731142AbfIFOOD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Sep 2019 10:14:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5AFDB611BE; Fri,  6 Sep 2019 14:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567779242;
        bh=3ruqwPYWVSYqYOsjQ64IZ3mnFFhJcbOC6J9E06sf3bo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=JnloefoCEofMRpOJLt3NOydkjbnVKdAe/JZfNvP12iV3eTyVYDOUC3SluJ2Xj4TUT
         ulEUtw7BqGgNnh6PsE776gGdzKt8UtObOyTD9UqzGSb9tomZYT95Ei1nVZi9cbVzWB
         v7DeAPto1Px0l4MIPxcaS0azDZtSvvlpnFg7oRdE=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 522E46115B;
        Fri,  6 Sep 2019 14:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567779241;
        bh=3ruqwPYWVSYqYOsjQ64IZ3mnFFhJcbOC6J9E06sf3bo=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=jg1K+GVnOLs9rqBcjGM2veO8FdUlQk7du7eY/b1pUpv4ohMMb2O0lzIJDPNxJISjF
         QzaKqyDW/uekniRgP11/PqYig4WFoAm6KAtLHr/sFyGiSfhVHlrsx/3EJ26NS2aT2G
         8iCeYzS1I7npvNquw9NTQr1QrszxAShTIzV6FApA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 522E46115B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1] hostap: use %*ph to print small buffer
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190904174321.76826-1-andriy.shevchenko@linux.intel.com>
References: <20190904174321.76826-1-andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jouni Malinen <j@w1.fi>, linux-wireless@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190906141402.5AFDB611BE@smtp.codeaurora.org>
Date:   Fri,  6 Sep 2019 14:14:02 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Use %*ph format to print small buffer as hex string.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied to wireless-drivers-next.git, thanks.

290890df5a8a hostap: use %*ph to print small buffer

-- 
https://patchwork.kernel.org/patch/11131157/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

