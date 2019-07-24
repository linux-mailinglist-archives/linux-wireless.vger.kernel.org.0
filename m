Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB0FD72D58
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 13:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfGXLXF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 07:23:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34848 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfGXLXF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 07:23:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7DDF960909; Wed, 24 Jul 2019 11:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563967384;
        bh=7xvzidbz6f6PnQwcm5w5sgSgmFxlWi2HS9D/bvmliDo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=jUEHjMqb9FoZlOvhOz5PGhCIdz1HAHaJZhX14MvsRxB4EL499pqVaPuZMNfHimw4/
         detqbf5L4j3nacF/639QsvHwNiM9xgJHlXoYah96ZlXFskq+petB2A2emWVcrjvPFM
         2yz798/KKuhJM+/PKVtVcbV96n+zOcTkDNbNmv7M=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F1FDC60734;
        Wed, 24 Jul 2019 11:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563967383;
        bh=7xvzidbz6f6PnQwcm5w5sgSgmFxlWi2HS9D/bvmliDo=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=C+earYBORtatRP+1I/m2VclvOY/79qXhX46bC3sX2yV7eQSoontpGVrAC3PbLUAXs
         G0b0CMVDjtaC1ztt1R7UiC/dwDXEMK8+BtekOxr4uxYEWzCYxXhvZhK2XB9embQ4jZ
         uhO63Pa35PIFvwHP6Yfb7OmZvsb7Xo+owR6vmq2Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F1FDC60734
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH] rtw88: use txpwr_lmt_cfg_pair struct, not arrays
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190713013232.215138-1-briannorris@chromium.org>
References: <20190713013232.215138-1-briannorris@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     <linux-wireless@vger.kernel.org>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190724112304.7DDF960909@smtp.codeaurora.org>
Date:   Wed, 24 Jul 2019 11:23:04 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> wrote:

> We're just trusting that these tables are of the right dimensions, when
> we could do better by just using the struct directly. Let's expose the
> struct txpwr_lmt_cfg_pair instead.
> 
> The table changes were made by using some Vim macros, so that should
> help prevent any translation mistakes along the way.
> 
> Remaining work: get the 'void *data' out of the generic struct
> rtw_table; all of these tables really deserve to be their own data
> structure, with proper type fields.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

To me this looks like a clear improvement and I'm inclined to apply it. Tony,
what do you think?

-- 
https://patchwork.kernel.org/patch/11042813/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

