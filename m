Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CADEC3018
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 11:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387598AbfJAJW6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 05:22:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44292 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfJAJW5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 05:22:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F2CB961213; Tue,  1 Oct 2019 09:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569921777;
        bh=2GPCgxJFWvTJTBPLUO3sxHcM0k0BS4pT6uBGryxTSbw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=FTBPbRknR6o7hA5YoX1CeFViiVzHB6ao7Lc7Dl7X4XOtw09yumFxrbAWuhR8Fw8WW
         iOZ17MpRbJj8eQ8kVTl2CIKPUcxv81FPRKXGwTMnoc3E9aDjaUyfaPqoVnDicnKaBW
         tehd7isHX38QiB8zDNt7XNXod7tG9ZJe7zG/ONnQ=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AAFAE60A30;
        Tue,  1 Oct 2019 09:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569921775;
        bh=2GPCgxJFWvTJTBPLUO3sxHcM0k0BS4pT6uBGryxTSbw=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=QGFoZi/6RYJGw5XxKUbERfLtUV5LdNv8hURkks8M8gLVwp+kUnxg53D7Bive5xG2c
         ytZbamstYfXea9rObKBHSMyySK2OTPZ2jCHkCvcze6P6BgvmExcTGL4Xx8XxSscyaZ
         Dj2wBXq8JZFT9r+YL6UDg/EKTAQ2ug7JgD30YY/s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AAFAE60A30
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] mwifiex: use 'total_ie_len' in
 mwifiex_update_bss_desc_with_ie()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190615001321.241808-2-briannorris@chromium.org>
References: <20190615001321.241808-2-briannorris@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Brian Norris <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191001092256.F2CB961213@smtp.codeaurora.org>
Date:   Tue,  1 Oct 2019 09:22:56 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> wrote:

> This is clearer than copy/pasting the magic number '+ 2' around, and it
> even saves the need for one existing comment.
> 
> Cc: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Takashi Iwai <tiwai@suse.de>

Patch applied to wireless-drivers-next.git, thanks.

0a3ce169476f mwifiex: use 'total_ie_len' in mwifiex_update_bss_desc_with_ie()

-- 
https://patchwork.kernel.org/patch/10996893/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

