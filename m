Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227BC52F90A
	for <lists+linux-wireless@lfdr.de>; Sat, 21 May 2022 07:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353898AbiEUFxG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 May 2022 01:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348003AbiEUFxG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 May 2022 01:53:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BEF195BE0
        for <linux-wireless@vger.kernel.org>; Fri, 20 May 2022 22:53:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1A766090C
        for <linux-wireless@vger.kernel.org>; Sat, 21 May 2022 05:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72668C385AA;
        Sat, 21 May 2022 05:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653112384;
        bh=vJKmSh5WZ8dXLCLJvcjtmFpNGAOZmJxwXJpODM9EzD8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=qf8ulcuUGFsjmhpeM+HeXQiBddPSOiKOq9RhYiYcW9i2MirTq7E80FeI60NkJgeId
         FsCCyk3ZF/7fwdaf8A+xXMTx8N7Qul2cYDlC6ZTeo8cjXi/eB4SJlJ0inMS/PbFNX/
         E2WJyfQmjSTovzYBvj0VMamKYGAbHeUAZYaYMdxdMQFotqv6xYOu9hbYTblOh3mxdK
         7qCWoxGVHYY4RRN8pFJ1VWxkyaGzeuaIZKKzhD7+x4gUds0nVxycRTXhwCce1pao88
         aKpWnYqEJ36mgT7Hk9h+4ghLyCrgFV23NhYj8F3VkcAH/nNsD5Nj+Plft3g4eOnS9l
         S/gvflGPzcOOw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH 1/4] rtw88: Fix Sparse warning for rtw8822b
References: <20220520184528.4078-1-Larry.Finger@lwfinger.net>
        <20220520184528.4078-2-Larry.Finger@lwfinger.net>
Date:   Sat, 21 May 2022 08:52:58 +0300
In-Reply-To: <20220520184528.4078-2-Larry.Finger@lwfinger.net> (Larry Finger's
        message of "Fri, 20 May 2022 13:45:25 -0500")
Message-ID: <87mtfbwhxh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> Sparse lists the following for rtw88:
>
>   CHECK   drivers/net/wireless/realtek/rtw88/rtw8822b.c
> drivers/net/wireless/realtek/rtw88/rtw8822b.c:2500:22: warning: symbol 'rtw8822b_hw_spec' was not declared. Should it be static?
>
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

It's good to try to make title's unique, so maybe something like this:

rtw88: make rtw8822b_hw_spec static

> ---
>  drivers/net/wireless/realtek/rtw88/rtw8822b.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
> index dccd722b8e62..60c4e75df035 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
> @@ -2497,7 +2497,7 @@ static struct rtw_hw_reg_offset rtw8822b_edcca_th[] = {
>  	[EDCCA_TH_H2L_IDX] = {{.addr = 0x8a4, .mask = MASKBYTE1}, .offset = 0},
>  };
>  
> -struct rtw_chip_info rtw8822b_hw_spec = {
> +static struct rtw_chip_info rtw8822b_hw_spec = {

This should be static const to make sure it's not modified.

Similar comments for other patches in this patchset.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
