Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0155AA811
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 08:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbiIBGdC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 02:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbiIBGdB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 02:33:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37721B3B37
        for <linux-wireless@vger.kernel.org>; Thu,  1 Sep 2022 23:33:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5727B829EA
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 06:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0B2C433D7;
        Fri,  2 Sep 2022 06:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662100377;
        bh=KjnZ1meSyoCIWwZ1JHVVLS1Crez+SqnBEMPQzuyoFVc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=m2J+M6hpZthuewplv0LsxqI8dolHNsKLyscqJBXUb8KympwWn2rKT6mXHVvGIH9lD
         qRFrONHMyBxeK4UT/+u5dN2vobYnrXKTET+aAAiDzSb8q4GCX+YVMgGOi0VQngGsa8
         4deMw6geyjxKZYZGlh/cyyQDl3mNL2uEkIguT8zHp+ND/ErA7R+8vasLKIJrcqeIbL
         hytiRImNKCFh/smnwbdEJEcTPgYzmYVaQ6SKBDzWl0W/CSMPmBeSkcxKzSFnh4OmAo
         r+aGz0A8WSc28VULICA4ljBVC75W8Ny8dXaTPc53reFhS2fGluX9IxslD5xP7WGU4k
         R8JbYT4m/8SqA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 3/9] rtw89: coex: Add logic to parsing rtl8852c firmware type ctrl report
References: <20220725023509.43114-1-pkshih@realtek.com>
        <20220725023509.43114-4-pkshih@realtek.com>
Date:   Fri, 02 Sep 2022 09:32:53 +0300
In-Reply-To: <20220725023509.43114-4-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Mon, 25 Jul 2022 10:35:03 +0800")
Message-ID: <87tu5qb816.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Ching-Te Ku <ku920601@realtek.com>
>
> Add a part of logic to parse type of ctrl report from firmware, and
> remove Bluetooth packet counter count from driver, the feature was
> moved to firmware at rtl8852c.
>
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw89/coex.c     | 44 +++++++++++--
>  drivers/net/wireless/realtek/rtw89/core.h     | 63 +++++++++++++++++--
>  drivers/net/wireless/realtek/rtw89/rtw8852c.c | 18 +-----
>  3 files changed, 98 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
> index f9c67aa1570dd..020b2628ef2c4 100644
> --- a/drivers/net/wireless/realtek/rtw89/coex.c
> +++ b/drivers/net/wireless/realtek/rtw89/coex.c
> @@ -876,7 +876,9 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
>  	struct rtw89_btc_dm *dm = &btc->dm;
>  	struct rtw89_btc_rpt_cmn_info *pcinfo = NULL;
>  	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
> -	struct rtw89_btc_fbtc_rpt_ctrl *prpt = NULL;
> +	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
> +	struct rtw89_btc_fbtc_rpt_ctrl *prpt;
> +	struct rtw89_btc_fbtc_rpt_ctrl_v1 *prpt_v1;
>  	struct rtw89_btc_fbtc_cysta *pcysta_le32 = NULL;
>  	struct rtw89_btc_fbtc_cysta_cpu pcysta[1];
>  	struct rtw89_btc_prpt *btc_prpt = NULL;
> @@ -907,8 +909,13 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
>  	switch (rpt_type) {
>  	case BTC_RPT_TYPE_CTRL:
>  		pcinfo = &pfwinfo->rpt_ctrl.cinfo;
> -		pfinfo = (u8 *)(&pfwinfo->rpt_ctrl.finfo);
> -		pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo);
> +		if (chip->chip_id == RTL8852A) {
> +			pfinfo = (u8 *)(&pfwinfo->rpt_ctrl.finfo);
> +			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo);
> +		} else {
> +			pfinfo = (u8 *)(&pfwinfo->rpt_ctrl.finfo_v1);
> +			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo_v1);
> +		}

That u8 cast is not really pretty, shouldn't pfinfo be a void pointer
and then all these casts could be avoided? But of course that's not
introduced by this patch so need to resend the patch because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
