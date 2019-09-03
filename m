Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB43A69EC
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 15:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbfICNer (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 09:34:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47864 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfICNer (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 09:34:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9B4F6607F4; Tue,  3 Sep 2019 13:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567517686;
        bh=FRKQRb2ax3LZZInVItmIvek50AeqKRpuTNTkS6OYlMI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=YFpdfSHQDDlGEWkabmv2/k4k22rP+7BEq1xew5Mq2E/lTeEhDjj1UeQc5liQw2xro
         A1rjfSMqKv+GEb+L1ZPZvAyfa22Jaaw2bTsFJpkgkiE+FVJ9UwKWdAiMlXFrqKHErm
         OSUrP/HuoYbN/hY7WDHuytnJI8snDgU8+kUmuLQ4=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C80860592;
        Tue,  3 Sep 2019 13:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567517686;
        bh=FRKQRb2ax3LZZInVItmIvek50AeqKRpuTNTkS6OYlMI=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=URr3gLLwWs9edhfxBs24epcI7ii3IfdNP0wwKd28r/uCTgrogYOIVANoJm76XBSZ6
         pJQjZd65VG2bnE2wlV9b0Al5gadatN19y9pQucZOYGtW6t722iE9tmOow+vLzofYGA
         m6E0G5UaicKIrTIkbkayV1tsZNU0A0fjcxRAar6o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C80860592
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] rtlwifi: rtl8821ae: Fix incorrect returned values
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190903011813.13946-2-Larry.Finger@lwfinger.net>
References: <20190903011813.13946-2-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190903133446.9B4F6607F4@smtp.codeaurora.org>
Date:   Tue,  3 Sep 2019 13:34:46 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> wrote:

> In commit bd421dab7515 ("rtlwifi: rtl8821ae: Convert macros that set
> descriptor"), all the routines that get fields from a descriptor
> were changed to return signed integer values. This is incorrect for the
> routines that get the entire 32-bit word. In this case, an unsigned
> quantity is required.
> 
> Fixes: bd421dab7515 ("rtlwifi: rtl8821ae: Convert macros that set descriptor")
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

3 patches applied to wireless-drivers-next.git, thanks.

3bf404b470f9 rtlwifi: rtl8821ae: Fix incorrect returned values
38fcdcbd3def rtlwifi: rtl8188ee: Fix incorrect returned values
fe025ef7d066 rtlwifi: rtl8192ce: Fix incorrect returned values

-- 
https://patchwork.kernel.org/patch/11127097/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

