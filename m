Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6C253785F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 May 2022 12:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbiE3Jfl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 May 2022 05:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiE3JfV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 May 2022 05:35:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EC37036E
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 02:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CEAEB80CA6
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 09:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FDDC385B8;
        Mon, 30 May 2022 09:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653903316;
        bh=bZiGfkf7SkwyCungVRxoHKH7Uvo091FOLFTnCLh8jbc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=EJ3ZH8vlYfPcuPemOzOmNc+bq4a9CjO4KQy8/omvo/1l/OeVzQJj5BdB2e6flQHrn
         tuJXsOgLvA5wNeQ/UhLDf8QRUSXV8LS1d0FCfOYrnQ2XrfXzYF9P/aKtCedHjOmNh9
         MePnZpr23u7n1FxjfSwhsjyXJ9D8DOxdHNcM39SoKzdrrybzUxoiQ58HmUE/yuUY9F
         YSto/iYIrzGrrj9ot9Is9OX+Xvoe0RV1f3mcOo+SGb080idZJr4Oie7ACa9XEY8i5J
         oFfiy3PkwJ066YIAGSuinbUYyZag50yAbRM9PEt2NlVSVd0ioDVl7j3npBJGbbRu3K
         bMaghur8c6qyg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: Re: [PATCH 6/6] rtw89: support MULTI_BSSID and correct BSSID mask of H2C
References: <20220520071731.38563-1-pkshih@realtek.com>
        <20220520071731.38563-7-pkshih@realtek.com>
Date:   Mon, 30 May 2022 12:35:12 +0300
In-Reply-To: <20220520071731.38563-7-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 20 May 2022 15:17:31 +0800")
Message-ID: <87bkvfuzvz.fsf@kernel.org>
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

> The BSSID mask of H2C is used to match BSSID of receiving packets.
> Normally, we set six bits BSSID mask to exactly match BSSID of packets
> sent by target AP. After we support multiple BSSID, it could connect a
> nontransmitted BSSID, so we can only match first five bytes of BSSID.
> That means we could possibly receive other AP's packets if only the last
> byte of BSSID is different from target AP.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw89/cam.c  | 9 +++++++++
>  drivers/net/wireless/realtek/rtw89/cam.h  | 5 +++++
>  drivers/net/wireless/realtek/rtw89/core.c | 1 +
>  3 files changed, 15 insertions(+)
>
> diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
> index 8a26adeb23fb2..b211ed2ea0722 100644
> --- a/drivers/net/wireless/realtek/rtw89/cam.c
> +++ b/drivers/net/wireless/realtek/rtw89/cam.c
> @@ -599,14 +599,23 @@ int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
>  int rtw89_cam_fill_bssid_cam_info(struct rtw89_dev *rtwdev,
>  				  struct rtw89_vif *rtwvif, u8 *cmd)
>  {
> +#define BSSID_MATCH_ALL GENMASK(5, 0)
> +#define BSSID_MATCH_5_BYTES GENMASK(4, 0)

Please define these elsewhere, like in the beginning of the file or
something. And please add RTW89_ prefix.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
