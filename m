Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3101F511057
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 06:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242049AbiD0FBc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 01:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238018AbiD0FBc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 01:01:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C296E8EE
        for <linux-wireless@vger.kernel.org>; Tue, 26 Apr 2022 21:58:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B9A4B82489
        for <linux-wireless@vger.kernel.org>; Wed, 27 Apr 2022 04:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFDBC385A7;
        Wed, 27 Apr 2022 04:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651035499;
        bh=Ts2XD2XsA73WLoBZTjEFo55IHoMaLFjcRnd0f858bnE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=NssHRyF/bau6XIVo6yYSC3qxFTbfjaaqHgQZGub63MR05UJXgZjkDIDETxgIg/pj5
         7dKiKq8QXfUEp2qrcL9wOBZ6ZV8//O1nmcsQ2O+orfSroY1XWpjLbIUsWLQNgRq/iI
         KI28wTAyhP3OYckyvOXG+O2vsedeqESP+Fg/HYL4k+9dCqybNgunECpAJI3sZ3HH7n
         gQFvYhXaQDauhg6pxFvGoIbcvkULfICWT5xTxaB33bKaZywr6G/Hi+FrnDODEhO2qy
         PBP4kNPdkUSe1+BBzudkDYsSxUt2b2reV6cAu/LnlNsIB70S8Ac8a4vdjlPgZQXQ20
         JyfKYchaYYZwA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: use the correct bit in the REG_HCI_OPT_CTRL
 register
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <YmLAzuyPr0P4Y6BP@ns.kevlo.org>
References: <YmLAzuyPr0P4Y6BP@ns.kevlo.org>
To:     Kevin Lo <kevlo@kevlo.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165103549637.18987.9142437749277361997.kvalo@kernel.org>
Date:   Wed, 27 Apr 2022 04:58:18 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kevin Lo <kevlo@kevlo.org> wrote:

> Write the BIT_USB_SUS_DIS bit rather than BIT_BT_DIG_CLK_EN to the
> REG_HCI_OPT_CTRL register for fixing failure to PCIe power on.
> 
> Signed-off-by: Kevin Lo <kevlo@kevlo.org>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
> index d1678aed9d9c..caf2603da2d6 100644
> --- a/drivers/net/wireless/realtek/rtw88/mac.c
> +++ b/drivers/net/wireless/realtek/rtw88/mac.c
> @@ -75,7 +75,7 @@ static int rtw_mac_pre_system_cfg(struct rtw_dev *rtwdev)
>  
>  	switch (rtw_hci_type(rtwdev)) {
>  	case RTW_HCI_TYPE_PCIE:
> -		rtw_write32_set(rtwdev, REG_HCI_OPT_CTRL, BIT_BT_DIG_CLK_EN);
> +		rtw_write32_set(rtwdev, REG_HCI_OPT_CTRL, BIT_USB_SUS_DIS);
>  		break;
>  	case RTW_HCI_TYPE_USB:
>  		break;

Patch applied to wireless-next.git, thanks.

fc6234d7e2e3 rtw88: use the correct bit in the REG_HCI_OPT_CTRL register

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/YmLAzuyPr0P4Y6BP@ns.kevlo.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

