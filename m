Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CF6532050
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 03:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiEXBlb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 21:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiEXBl3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 21:41:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8151FCF9
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 18:41:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44E63B8171A
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 01:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAED4C385A9;
        Tue, 24 May 2022 01:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653356484;
        bh=4dy72oYg9k2X8H32D5/XCxRKxkXr4YsMmwLk3aY3qds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BOXjkTv6EM81k0wUe2I7OaRVqVqivWC0UYIZYyNEdejtZ7lWyRFL2Pqk7WiFL+baP
         JfxN5oFJsIG1g6JoQrm5a273QGJFyGXABww+4QiifMjAMxw86FXto2QVS8ApPKK4m6
         Oy7IHNhJAxLFLM0wjJrdkH659ejneIfXOnnKfKOxQIsdi6N2C13jzGr1wGtoHXqxTw
         mADjF5+pDOf09KNpctjo5eDBqmNhxYyvnD3tARdHCnQURRMB7ivAXCgaBTOQpkbd8P
         j33njnv4ceU6wBIMY5mFdb9OCC9BhCSJ2e3j4t4Np+W9dEXHr0UC0D5wkxbBTBTDHo
         AVTN07gWqPP1g==
Date:   Mon, 23 May 2022 18:41:23 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH net-next] rtlwifi: 8192de: correct checking of IQK
 reload
Message-ID: <20220523184123.4b22fd72@kernel.org>
In-Reply-To: <20220524003750.3989-1-pkshih@realtek.com>
References: <20220524003750.3989-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 24 May 2022 08:37:50 +0800 Ping-Ke Shih wrote:
> This mistake is existing since initial commit, and I recall the vendor
> driver to find correctness.
> 
> Fixes: ee3db469dd31 ("wifi: rtlwifi: remove always-true condition pointed out by GCC 12")

Not fair, I did not break this code. My change did not alter 
the functionality.

> Cc: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> This patch should go through net-next tree, because this one is going to fix
> "wifi: rtlwifi: remove always-true condition pointed out by GCC 12" that only
> exits in that tree.

If you want it to go via net-next you must CC netdev@.

But I don't see any reason to rush it, AFAICS the code was added in
2011 - commit 7274a8c22980 ("rtlwifi: rtl8192de: Merge phy routines")
or so. We waited 11 years to notice, we can wait a few weeks for the 
patch to propagate thru wireless tree.

> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
> index 15e6a6aded319..f6ff32658863d 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
> @@ -2386,7 +2386,10 @@ void rtl92d_phy_reload_iqk_setting(struct ieee80211_hw *hw, u8 channel)
>  			rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD,
>  				"Just Read IQK Matrix reg for channel:%d....\n",
>  				channel);
> -			_rtl92d_phy_patha_fill_iqk_matrix(hw, true,
> +			if ((rtlphy->iqk_matrix[indexforchannel].
> +			     value[0][0] != 0)
> +				/*&&(regea4 != 0) */)

Please don't add the extra brackets around the condition
and the commented out code back in.

> +				_rtl92d_phy_patha_fill_iqk_matrix(hw, true,
>  					rtlphy->iqk_matrix[
>  					indexforchannel].value,	0,
>  					(rtlphy->iqk_matrix[
