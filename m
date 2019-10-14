Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24E48D5F1F
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 11:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbfJNJjm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 05:39:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38334 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfJNJjl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 05:39:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7C1D560721; Mon, 14 Oct 2019 09:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571045980;
        bh=+YQzRdkur0OXTzwnmOHFuNByodN9Go3AWHfTeE1xRG0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AnozJoYefObj3qjME8SfS9M9Xar9XhmJfXSaY/14SgxikgGPwRJjne3Z3bSS20OBi
         kZ1uNwbqivqBEc/U38pJbPwE/DDfS/NS7/5ActdxT6OeNVnaTkUGI3hXSFIHJoc4xW
         8DzvCE33BjQLvJ+PhjnXbVnOLRaPyljWQTKQLF9A=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5C9C0602E0;
        Mon, 14 Oct 2019 09:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571045980;
        bh=+YQzRdkur0OXTzwnmOHFuNByodN9Go3AWHfTeE1xRG0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AnozJoYefObj3qjME8SfS9M9Xar9XhmJfXSaY/14SgxikgGPwRJjne3Z3bSS20OBi
         kZ1uNwbqivqBEc/U38pJbPwE/DDfS/NS7/5ActdxT6OeNVnaTkUGI3hXSFIHJoc4xW
         8DzvCE33BjQLvJ+PhjnXbVnOLRaPyljWQTKQLF9A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C9C0602E0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: Re: [PATCH 05/10] rtw88: update regulatory settings implementaion
References: <20191008082101.2494-1-yhchuang@realtek.com>
        <20191008082101.2494-6-yhchuang@realtek.com>
Date:   Mon, 14 Oct 2019 12:39:37 +0300
In-Reply-To: <20191008082101.2494-6-yhchuang@realtek.com> (yhchuang's message
        of "Tue, 8 Oct 2019 16:20:56 +0800")
Message-ID: <87r23ffyxy.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

> From: Tzu-En Huang <tehuang@realtek.com>
>
> There are two kinds of country/regulatory efuse settings
> for Realtek's chipset, one is worldwide and the other is
> a specific country. For the chipset with the country setting
> being a specific country, driver needs to ensure that the
> setting will not be modified when connecting to an AP.
>
> For the chipset with the country setting is worldwide,
> driver will follow the NL80211_REGDOM_SET_BY_COUNTRY_IE
> regulatory notification from the mac80211 stack.
>
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/main.c |  9 +++-
>  drivers/net/wireless/realtek/rtw88/main.h |  2 +
>  drivers/net/wireless/realtek/rtw88/regd.c | 61 +++++++++++++++++++----
>  3 files changed, 59 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
> index 570b2e358be4..edd490c507b5 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -21,14 +21,17 @@ EXPORT_SYMBOL(rtw_fw_lps_deep_mode);
>  bool rtw_bf_support = true;
>  unsigned int rtw_debug_mask;
>  EXPORT_SYMBOL(rtw_debug_mask);
> +bool rtw_allow_user_reg_set;
>  
>  module_param_named(lps_deep_mode, rtw_fw_lps_deep_mode, uint, 0644);
>  module_param_named(support_bf, rtw_bf_support, bool, 0644);
>  module_param_named(debug_mask, rtw_debug_mask, uint, 0644);
> +module_param_named(allow_user_reg_set, rtw_allow_user_reg_set, bool, 0644);
>  
>  MODULE_PARM_DESC(lps_deep_mode, "Deeper PS mode. If 0, deep PS is disabled");
>  MODULE_PARM_DESC(support_bf, "Set Y to enable beamformee support");
>  MODULE_PARM_DESC(debug_mask, "Debugging mask");
> +MODULE_PARM_DESC(allow_user_reg_set, "Set Y to allow regulatory settings from user");

Why the module parameter?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
