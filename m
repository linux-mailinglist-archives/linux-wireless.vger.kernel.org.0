Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB865224F
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 06:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfFYEvy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 00:51:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54066 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfFYEvy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 00:51:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2671D60867; Tue, 25 Jun 2019 04:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561438314;
        bh=THhmAPAMqY3GTGGmk1pvN1MzoPwrTPUnyYObzAaklm4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=TxRER5iPA47zyUKw88p4BExHbiF/13mzZjk6+KlGPemX33ncj9dCn5UOuMfYyZ7WR
         Cg5cGD41eZLyvRu/ZgWYvcTh93QPYYzVonw0O9qP18v26c0A6rINU9bhFzRUkOheRq
         2Vs8u/0PjRiLI3j6YMUP6jTrcHE2ipJvEbD2FBrs=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49043602F4;
        Tue, 25 Jun 2019 04:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561438313;
        bh=THhmAPAMqY3GTGGmk1pvN1MzoPwrTPUnyYObzAaklm4=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=oea9h+VIhyl2vWMcRK6L8kfpql/p/6pp2mCfhkjw0996+bIdKahtzg70fRWhLi8xb
         l+VpAAumBGRUEVX5hmo/JrJwX5rGOZ5dmb4Tqk6V8gR9NSEUAKnFR85D/GNnWEyPqK
         pCBR3yP0W7TPYBhih6jmg52cnoNM9KrNPi8E+onw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49043602F4
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
Message-Id: <20190625045154.2671D60867@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 04:51:53 +0000 (UTC)
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

This depends on:

63d7ef36103d mwifiex: Don't abort on small, spec-compliant vendor IEs

Patch set to Awaiting Upstream.

-- 
https://patchwork.kernel.org/patch/10996893/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

