Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16A9551574
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jun 2022 12:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbiFTKJj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jun 2022 06:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241038AbiFTKJb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jun 2022 06:09:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B74A1A2
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jun 2022 03:09:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 121D060B4F
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jun 2022 10:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE130C3411B;
        Mon, 20 Jun 2022 10:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655719768;
        bh=PcWnzxKXurY/S7CLoCEqYgYsh1h8oaTylIgznJ6gdLw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HzNFiCbZ8gh13SGgRxqieVqVSKPUkKH/P9sEIGwHllnI28dB/tojMBQCCdWRFm8W0
         xnIxHdBP+Dad4xVksl6hMCCmebSDStsLl+IUg8PGyCvZkj85r8FPRLKr1AkZRmpcFR
         cov3q4McnZiZ5HyaS/e3hgHFaRk5sctNAziW/X3niCwzhSADpHwu5Esop/0x9QHFF3
         kNyzSHxQf9aqt9Ebd3nMdwTIciwAkR4/EwLZ8TTWpWOOrzzvhb3c1pOtuytRThs6yb
         sM+nV/zQTAX+CLg4jK5u1hde6AVUc3VcyaU7wbXNH8BLjpbuiv1R0V71fIDR4kSudu
         PJVr6QHvu+g4g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: Re: [PATCH 13/13] rtw89: prohibit mac80211 chanctx ops without HW scan
References: <20220617084954.61261-1-pkshih@realtek.com>
        <20220617084954.61261-14-pkshih@realtek.com>
Date:   Mon, 20 Jun 2022 13:09:24 +0300
In-Reply-To: <20220617084954.61261-14-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 17 Jun 2022 16:49:54 +0800")
Message-ID: <877d5bprxn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
>
> If a chip is configured to support mac80211 chanctx ops, we avoid
> using older FW that does not support HW scan to make mac80211 stack
> handle scanning as expected.
>
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw89/fw.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
> index 0e12629f789c3..a47451dc9d81d 100644
> --- a/drivers/net/wireless/realtek/rtw89/fw.c
> +++ b/drivers/net/wireless/realtek/rtw89/fw.c
> @@ -250,6 +250,7 @@ static void rtw89_fw_recognize_features(struct rtw89_dev *rtwdev)
>  
>  int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
>  {
> +	const struct rtw89_chip_info *chip = rtwdev->chip;
>  	int ret;
>  
>  	ret = __rtw89_fw_recognize(rtwdev, RTW89_FW_NORMAL);
> @@ -261,6 +262,13 @@ int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
>  
>  	rtw89_fw_recognize_features(rtwdev);
>  
> +	if (chip->support_chanctx_num != 0 &&
> +	    !RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw)) {
> +		rtw89_err(rtwdev,
> +			  "require newer FW to support HW scan for chanctx\n");
> +		return -ENOENT;
> +	}

So if the user has not update the firmware a kernel upgrade will break
their internet? That's not good, we should not break existing setups. So
what firmware version is required?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
